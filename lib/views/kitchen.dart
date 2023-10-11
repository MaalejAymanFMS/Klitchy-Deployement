import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

bool isDone = false;
List<Order> orders = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KitchenScreen(),
    );
  }
}

class Order {
  final String? tableNumber;
  final List<EntryItem>? items;

  Order({
    this.tableNumber,
    this.items,
  });
}

class EntryItem {
  String itemName;
  double amount;
  int quantity;
  String notes;

  EntryItem({
    required this.itemName,
    required this.amount,
    required this.quantity,
    required this.notes,
  });
}

class AppState extends ChangeNotifier {
  int nbreCmd = 0;
  int nbreInprog = 0;
  int nbreDone = 0;
  Order? selectedOrder;

  void updateIsDone(bool value) {
    isDone = value;
    notifyListeners();
  }

  void incrementNbreCmd() {
    nbreCmd++;
    notifyListeners();
  }

  void incrementNbreInprog() {
    nbreInprog++;
    notifyListeners();
  }

  void decreaseNbreInprog() {
    nbreInprog--;
    notifyListeners();
  }

  int totalnbreCmd(int orderListLength) {
    notifyListeners();
    return orderListLength;
  }

  void incrementNbreDone() {
    nbreDone++;
    notifyListeners();
  }

  void setSelectedOrder(Order order) {
    selectedOrder = order;
    notifyListeners();
  }


}

class KitchenScreen extends StatefulWidget {
  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  Future<List<Order>> fetchOrder() async {
    final response = await http.get(
      Uri.parse(
          'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order?fields=["name","table","table_description"]'),
      headers: {'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> orderData = data['data'];

      final List<String> orderNames =
          List<String>.from(orderData.map((order) => order['name'] as String));

      final List<Order> orders = [];

      for (var orderName in orderNames) {
        final orderResponse = await http.get(
          Uri.parse(
              'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order/$orderName'),
          headers: {'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'},
        );

        if (orderResponse.statusCode == 200) {
          final jsonBody = json.decode(orderResponse.body);
          final dataDetails = jsonBody['data'];

          final List<EntryItem> entryItems =
              (dataDetails['entry_items'] as List<dynamic>).map((item) {
            return EntryItem(
              itemName: item['item_name'] as String,
              amount: item['amount'] as double,
              quantity: item['qty'] as int,
              notes: item['notes'] as String,
            );
          }).toList();

          final order = Order(
            tableNumber: dataDetails['table_description'] as String,
            items: entryItems,
          );

          orders.add(order);
        } else {
          throw Exception(
              'Failed to fetch order details: ${orderResponse.statusCode}');
        }
      }
      return orders;
    } else {
      throw Exception('Failed to fetch order names: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: fetchOrder(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Order> orders = snapshot.data ?? [];

          return ChangeNotifierProvider<AppState>(
            create: (context) => AppState(),
            child: MaterialApp(
              home: Scaffold(
                body: OrderList(
                  orders: orders,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class OrderList extends StatefulWidget {
  final List<Order> orders;

  OrderList({
    required this.orders,
  });

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
 void removeOrder(int index) {
    setState(() {
      widget.orders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CountBox(title: "Commands"),
                          CountBox(title: "In progress"),
                          CountBox(title: "Done"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: widget.orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              isDone = false;
                              if (!isDone) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final order = widget.orders[index];
                                    return AlertDialog(
                                      title: Text(
                                          'Order Details of table ${order.tableNumber}'),
                                      content: Container(
                                        width: double.maxFinite,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: order.items!
                                                .map((item) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Item Name: ${item.itemName}'),
                                                  Text('Notes: ${item.notes}'),
                                                  Divider(),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OrderCard(
                                
                                ordersList: widget.orders,
                                appState: appState,
                                order: widget.orders[index],
                                index: widget.orders.indexOf(widget.orders[index]),
                                 removeOrder: () => removeOrder(widget.orders.indexOf(widget.orders[index])),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              MyDrawer(),
            ],
          ),
        );
      },
    );
  }
}

class OrderCard extends StatefulWidget {
  final AppState appState;
  final Order order;
  final int index;
  final List<Order> ordersList;
   final VoidCallback removeOrder;

  const OrderCard({
    required this.appState,
    required this.order,
    required this.index,
    required this.ordersList,
    required this.removeOrder,
  });

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String buttonLabel = 'Start';
  bool isButtonEnabled = true;



  @override
  Widget build(BuildContext context) {
    Color buttonColor = Colors.green;

    if (buttonLabel == 'Finish') {
      buttonColor = Colors.red;
    }

    return Card(
      color: AppColors.secondaryTextColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Order of table : ${widget.order.tableNumber}"),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            final appState =
                                Provider.of<AppState>(context, listen: false);
                            setState(() {
                              if (buttonLabel == 'Start') {
                                isDone = false;
                                buttonLabel = 'Finish';
                                appState.incrementNbreInprog();
                                appState.setSelectedOrder(
                                    widget.order);
                              } else if (buttonLabel == 'Finish') {
                               widget.removeOrder();
                                
                                appState.incrementNbreDone();
                                appState.decreaseNbreInprog();
                                appState.updateIsDone(true);
                              }
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        buttonLabel,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.order.items!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(widget.order.items![index].quantity.toString() +
                            " x "),
                        Text(widget.order.items![index].itemName),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountBox extends StatefulWidget {
  final String title;

  CountBox({required this.title});

  @override
  _CountBoxState createState() => _CountBoxState();
}

class _CountBoxState extends State<CountBox> {
  @override
  Widget build(BuildContext context) {
    String countText = '';
    final appState = Provider.of<AppState>(context);

    if (widget.title == "Commands") {
      countText = "${orders.length} ${widget.title}";
    } else if (widget.title == "In progress") {
      countText = "${appState.nbreInprog} ${widget.title}";
    } else if (widget.title == "Done") {
      countText = "${appState.nbreDone} ${widget.title}";
    }

    return Container(
      width: 150.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: AppColors.tertiaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          countText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final selectedOrder = appState.selectedOrder;
    final deviceSize = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: deviceSize.height * 0.1,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.blueColor,
              ),
              child: Text(
                'Order list ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          if (selectedOrder != null) ...[
            ListTile(
              title: Text('Selected Order Items: ${selectedOrder.tableNumber}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedOrder.items!
                    .map(
                      (item) => Text("\n " +
                          item.quantity.toString() +
                          " x " +
                          item.itemName +
                          "\n " +
                          item.notes),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
