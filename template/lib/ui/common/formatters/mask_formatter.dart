/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/services.dart';

/// Копипаст с либы
class MaskTextInputFormatter extends TextInputFormatter {
  Map<int, String> _maskMap;
  List<int> _maskList;

  MaskTextInputFormatter(maskString, {escapeChar = "_"}) {
    assert(maskString != null);
    final entries = RegExp('[^$escapeChar]+')
        .allMatches(maskString)
        .map((match) => MapEntry<int, String>(match.start, match.group(0)));

    _maskMap = new Map.fromEntries(entries);
    _maskList = _maskMap.keys.toList();
  }

  String getEscapedString(String inputText) {
    _maskList.reversed
        .where((index) =>
            index < inputText.length && _substringIsMask(inputText, index))
        .forEach((index) {
      inputText = inputText.substring(0, index) +
          inputText.substring(index + _maskMap[index].length);
    });
    return inputText;
  }

  bool _substringIsMask(String inputText, int index) {
    try {
      return inputText.substring(index, index + _maskMap[index].length) ==
          _maskMap[index];
    } on RangeError {
      return false;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var escapedString = getEscapedString(newValue.text);
    var position = newValue.selection.baseOffset -
        (newValue.text.length - escapedString.length);

    _maskList.forEach((index) {
      if (escapedString.length > index) {
        escapedString = escapedString.substring(0, index) +
            _maskMap[index] +
            escapedString.substring(index);
        position += _maskMap[index].length;
      }
    });

    return newValue.copyWith(
        text: escapedString,
        selection: TextSelection.collapsed(offset: position));
  }
}
