import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/models/kitchenOrders.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/locator.dart';
import 'package:klitchyapp/viewmodels/kitchen_interactor.dart';
import 'package:klitchyapp/views/kitchen.dart';
import 'package:klitchyapp/widget/CountBox.dart';
import 'package:klitchyapp/widget/OrderCard.dart';
import 'package:klitchyapp/widget/drawer/kitchen.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  List<Order> orders;

  OrderList({
    required this.orders,
  });

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final interactor = getIt<KitchenInteractor>();
  int orderInProgressLenght = inPrgressOrders.length;
  int orderFinishLenght = finishedOrders.length;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    int index = 0;
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Row(
            children: [
              MyDrawer(),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CountBox(
                            appState: appState,
                            order: widget.orders,
                            title: "Commands",
                            orderLenght: orders.length,
                            orderInProgressLenght: orderInProgressLenght,
                            orderFinishLenght: orderFinishLenght,
                            getList: () {
                              orderInProgressLenght = widget.orders.length;
                              setState(() {
                                widget.orders = [];
                                widget.orders = orders;
                              });
                            },
                          ),
                          CountBox(
                            appState: appState,
                            order: widget.orders,
                            title: "In progress",
                            orderLenght: orders.length,
                            orderInProgressLenght: orderInProgressLenght,
                            orderFinishLenght: orderFinishLenght,
                            getList: () {
                              setState(() {
                                widget.orders = [];
                                widget.orders = inPrgressOrders;
                              });
                            },
                          ),
                          CountBox(
                            appState: appState,
                            order: widget.orders,
                            title: "Done",
                            orderLenght: orders.length,
                            orderInProgressLenght: orderInProgressLenght,
                            orderFinishLenght: orderFinishLenght,
                            getList: () {
                              setState(() {
                                widget.orders = [];
                                widget.orders = finishedOrders;
                              });
                            },
                          ),
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
                                    index = index;
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
                                            children: order.items!.map((item) {
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
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.green),
                                          ),
                                          onPressed: () async {
                                            await interactor
                                                .startOrder(order.name!);

                                            setState(() {
                                              orderInProgressLenght =
                                                  inPrgressOrders.length;
                                              appState.setSelectedOrder(order);
                                            });

                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Start Order'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // TODOO update the codez with get by status_kds to can get only inProg list and finishedOrder list wait CW
                                            await interactor
                                                .updateStatusOrder(order.name!);

                                            setState(() {
                                              orderInProgressLenght =
                                                  inPrgressOrders.length - 1;
                                              widget.orders = [];
                                              widget.orders = finishedOrders;
                                            });

                                            Navigator.of(context).pop();
                                          },
                                          child: Text('finish Order'),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              appState.setSelectedOrder(order);
                                            });
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
                                index:
                                    widget.orders.indexOf(widget.orders[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
