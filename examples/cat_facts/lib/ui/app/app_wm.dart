// Copyright (c) 2019-present, SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/storage/app/app_storage.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class AppWidgetModel extends WidgetModel {
  AppWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._appStorage,
  ) : super(baseDependencies);

  final AppStorage _appStorage;

  StreamedState<AppTheme> get theme => _appStorage.appTheme;
}

AppWidgetModel createAppWidgetModel(BuildContext context) {
  return AppWidgetModel(
    const WidgetModelDependencies(),
    context.read<AppStorage>(),
  );
}
