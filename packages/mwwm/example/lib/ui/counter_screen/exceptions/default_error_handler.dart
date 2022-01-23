import 'package:flutter/foundation.dart';
import 'package:mwwm/mwwm.dart';

/// Default error handler for [WidgetModelDependencies]
class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
}
