import 'package:flutter/material.dart';
import 'package:klitchyapp/models/items.dart';
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

  void setNumberOfTables(int number) {
    _numberOfTables = number;
    notifyListeners();
  }
  void addTable() {
    _numberOfTables += 1;
    notifyListeners();
  }
  void deleteTable() {
    if(_numberOfTables > 0) {
      _numberOfTables -= 1;
      notifyListeners();
    }
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

  void deleteAllOrders() {
    for(var i = 0; i < _orders.length; i++) {
      _orders.elementAt(i).number = 0;
    }
    notifyListeners();
  }

  void updateOrderNote(String orderName, String newNote) {
    final orderToUpdate = _orders.firstWhere(
          (order) => order.name == orderName,
    );
    orderToUpdate.note = newNote;
    notifyListeners();
    }

  // categories
  List<Item> _categorieClicked = [];
  List<Item> get categorieClicked => _categorieClicked;

  void clickOpenCategorie(List<Item> list) {

    _categorieClicked = list;
    notifyListeners();
  }
  void clickCloseCategorie() {
    _categorieClicked = [];
    notifyListeners();
  }

  // room

  Map<String, dynamic> _choosenRoom = {};
  Map<String, dynamic> get choosenRoom => _choosenRoom;

  void chooseRoom(String name, String id) {
    _choosenRoom = {
      "name" : name,
      "id": id,
    };
    notifyListeners();
  }
}