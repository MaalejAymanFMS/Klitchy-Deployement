import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klitchyapp/config/app_colors.dart';

bool isDone = false;

class Order {
  final int tableNumber;
  final List<EntryItem> items;
  final int quantity;
  bool isStarted = false;

  Order({
    required this.tableNumber,
    required this.items,
    required this.quantity,
  });
}

class EntryItem {
  String itemName;
  double amount;

  EntryItem({
    required this.itemName,
    required this.amount,
  });
}

class AppState extends ChangeNotifier {
  int nbreCmd = 0;
  int nbreInprog = 0;
  int nbreDone = 0;
  Order? selectedOrder; // Selected order

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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MaterialApp(
        home: Scaffold(
          body: OrderList(),
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  List<Order> orders = [
    Order(
      tableNumber: 1,
      quantity: 2,
      items: [
        EntryItem(itemName: 'Salad', amount: 10.0),
        EntryItem(itemName: 'Soda', amount: 2.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
      ],
    ),
    Order(
      tableNumber: 1,
      quantity: 2,
      items: [
        EntryItem(itemName: 'Salad', amount: 10.0),
        EntryItem(itemName: 'Soda', amount: 2.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
      ],
    ),
    Order(
      tableNumber: 1,
      quantity: 2,
      items: [
        EntryItem(itemName: 'Salad', amount: 10.0),
        EntryItem(itemName: 'Soda', amount: 2.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
      ],
    ),
    Order(
      tableNumber: 1,
      quantity: 2,
      items: [
        EntryItem(itemName: 'Salad', amount: 10.0),
        EntryItem(itemName: 'Soda', amount: 2.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
      ],
    ),
    Order(
      tableNumber: 1,
      quantity: 2,
      items: [
        EntryItem(itemName: 'Salad', amount: 10.0),
        EntryItem(itemName: 'Soda', amount: 2.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
      ],
    ),
    Order(
      tableNumber: 1,
      quantity: 2,
      items: [
        EntryItem(itemName: 'Salad', amount: 10.0),
        EntryItem(itemName: 'Soda', amount: 2.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
      ],
    ),
    Order(
      tableNumber: 1,
      quantity: 2,
      items: [
        EntryItem(itemName: 'Salad', amount: 10.0),
        EntryItem(itemName: 'Soda', amount: 2.0),
        EntryItem(itemName: 'Pizza', amount: 15.0),
      ],
    ),
    Order(
      tableNumber: 3,
      quantity: 1,
      items: [
        EntryItem(itemName: 'Burger', amount: 12.0),
        EntryItem(itemName: 'Fries', amount: 5.0),
      ],
    ),
    Order(
      tableNumber: 4,
      quantity: 4,
      items: [
        EntryItem(itemName: 'Pasta', amount: 14.0),
        EntryItem(itemName: 'Wine', amount: 8.0),
        EntryItem(itemName: 'Dessert', amount: 6.0),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                      crossAxisCount: 6,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          final appState = Provider.of<AppState>(context, listen: false);
                          isDone = false;
                          if (!isDone) {
                            
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Order Details'),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          OrderCard(
                                            order: orders[index],
                                          ),
                                        ],
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
                            order: orders[index],
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
  }
}

class OrderCard extends StatefulWidget {
  final Order order;

  OrderCard({
    required this.order,
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
      color: isDone ? Colors.black : AppColors.secondaryTextColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Order Items:'),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.order.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(widget.order.items[index].itemName),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        final appState = Provider.of<AppState>(context, listen: false);
                        setState(() {
                          if (buttonLabel == 'Start') {
                            isDone = false;
                            buttonLabel = 'Finish';
                            appState.incrementNbreInprog();
                            appState.setSelectedOrder(widget.order); // Set selected order here
                          } else if (buttonLabel == 'Finish') {
                            buttonLabel = 'Done';
                            appState.incrementNbreDone();
                            appState.decreaseNbreInprog();
                            appState.updateIsDone(true);
                            isButtonEnabled = false;
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
      countText = "${OrderList().orders.length} ${widget.title}";
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

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.blueColor,
            ),
            child: Text(
              'Order list',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          if (selectedOrder != null) ...[
            ListTile(
              title: Text('Selected Order Items:'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedOrder.items
                    .map(
                      (item) => Text(item.itemName),
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


