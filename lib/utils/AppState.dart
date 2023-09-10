import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  //toggle the drawer
  bool _isWidgetEnabled = false;

  bool get isWidgetEnabled => _isWidgetEnabled;

  void toggleWidget() {
    _isWidgetEnabled = !_isWidgetEnabled;
    notifyListeners();
  }
  //number of tables
  int _numberOfTables = 0;
  int get  numberOfTables => _numberOfTables;
  void addTable() {
    _numberOfTables += 1;
    notifyListeners();
  }
  void deleteTable() {
    _numberOfTables -= 1;
    notifyListeners();
  }

}