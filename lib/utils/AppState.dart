import 'package:flutter/material.dart';
import 'package:klitchyapp/widget/order_component.dart';
class AppState extends ChangeNotifier {
  //toggle the drawer
  bool _isWidgetEnabled = true;

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


  //orders
  List<OrderComponent> _orders = [];
  List<OrderComponent> get orders => _orders;
  void addOrder(int number, OrderComponent orderWidget) {
    if (number > 0) {
      final existingWidgetIndex = _orders.indexWhere(
            (widget) =>
        widget.name == orderWidget.name &&
            widget.price == orderWidget.price,
      );
      if (existingWidgetIndex != -1) {
        _orders.elementAt(existingWidgetIndex).number = number;
      } else {
        _orders.add(orderWidget);
      }
      notifyListeners();
    }
  }

  void deleteOrder(int number, OrderComponent orderWidget) {
    final existingWidgetIndex = _orders.indexWhere(
          (widget) =>
      widget.name == orderWidget.name &&
          widget.price == orderWidget.price,
    );
    if (existingWidgetIndex != -1 && number > 0 ) {
      _orders.elementAt(existingWidgetIndex).number = number;
    } else {
      _orders.removeAt(existingWidgetIndex);
    }
    notifyListeners();
  }

}