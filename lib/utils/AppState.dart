import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isWidgetEnabled = false;

  bool get isWidgetEnabled => _isWidgetEnabled;

  void toggleWidget() {
    _isWidgetEnabled = !_isWidgetEnabled;
    notifyListeners();
  }
}