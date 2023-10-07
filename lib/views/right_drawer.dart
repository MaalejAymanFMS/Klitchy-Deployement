library right_drawer;

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/orders.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/viewmodels/right_drawer_interractor.dart';
import 'package:klitchyapp/widget/custom_button.dart';
import 'package:klitchyapp/widget/right_drawer/buttom_component.dart';
import 'package:klitchyapp/widget/right_drawer/table_tag.dart';
import 'package:provider/provider.dart';
import 'package:virtual_keyboard_2/virtual_keyboard_2.dart';

import '../config/app_colors.dart';
import '../utils/AppState.dart';
import '../utils/locator.dart';
import '../widget/entry_field.dart';
import '../widget/order_component.dart';
class RightDrawer extends StatefulWidget {
  final String tableName;
  final String tableId;
  const RightDrawer({
    required this.tableName,
    required this.tableId,
    Key? key,
  }) : super(key: key);

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}


class _RightDrawerState extends State<RightDrawer> {
  final TextEditingController orderNote = TextEditingController();
  final interactor = getIt<RightDrawerInterractor>();
  late final AppState appState;
  List<EntryItem> orders = [];
  void fetchOrders() async{
    Map<String, dynamic> params = {
      "fields": ["name","table","table_description"],
      "filters": [
        ["table_description", "LIKE", "%${widget.tableId}%"],
      ]
    };
    var orderP1 = await interactor.retrieveTableOrderPart1(params);
    if(orderP1.dataP1!.isNotEmpty) {
      var orderP2 = await interactor.retrieveTableOrderPart2(
          orderP1.dataP1![0].name!);
      orders = orderP2.dataP2!.entryItems!;
      for (var order in orders) {
        appState.addOrder(
          order.qty as int,
          OrderComponent(
            number: order.qty! as int,
            name: order.item_name!,
            price: order.rate!,
            image: "",
            note: order.notes,
          ),
        );
      }
    }
  }

  void addOrders() async {
    print(appState.choosenRoom["id"]);
    print(widget.tableName);
    print(appState.choosenRoom["name"]);
    Map<String, dynamic> body = {
      // "data" : {
        "room": appState.choosenRoom["id"],
        "table": widget.tableName,
        "table_description": widget.tableId,
        "room_description": appState.choosenRoom["name"],
        "naming_series": "OR-.YYYY.-",
        "status": "Attending",
        "customer": "Defult Customer",
        "pos_profile": "Caissier",
        "selling_price_list": "Standard Selling",
        "company": "Jumpark",
        "doctype": "Table Order",
        "entry_items": appState.entryItems.map((entryMap) => entryMap.toJson()).toList(),
      // }
    };
    await interactor.addOrder(body);
  }
  @override
  void initState() {
    appState = Provider.of<AppState>(context, listen: false);
    fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<AppState>(context);
    return SizedBox(
      width: 383.h,
      height: 887.v,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.v),
        child: Column(
          children: [
            TableTag(appState,widget.tableName),
            Expanded(
              child: appState.orders.isNotEmpty
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Items",
                      style: TextStyle(color: Colors.white, fontSize: 15.fSize),
                    ),
                    Column(
                      children: appState.orders.map((order) {
                        return InkWell(
                          onTap: () {
                            if(appState.enabledNotes) {
                              showOrderDetails(order, appState);
                            }
                            if(appState.enabledDelete) {
                              print("delete enabled");
                              print(appState.orders);
                              appState.deleteOrder(order.number, order);
                            }
                          },
                          child: order,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
                  : const SizedBox(),
            ),
            ButtomComponent(onTap: addOrders,),
          ],
        ),
      ),
    );
  }
  void showOrderDetails(OrderComponent order, AppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(order.name),
          content: SizedBox(
            height: 550.v,
            child: Column(
              children: [
                EntryField(
                  label: "Note",
                  hintText: "note",
                  controller: orderNote,
                ),
                SizedBox(
                  height: 100.v,
                ),
                CustomButton(
                  text: "add note",
                  onTap: () {
                    appState.updateOrderNote(order.name, orderNote.text);
                    orderNote.clear();
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Container(
                  color: AppColors.itemsColor,
                  child: VirtualKeyboard(
                      height: 300.v,
                      textColor: Colors.white,
                      type: VirtualKeyboardType.Alphanumeric,
                      textController: orderNote),
                ),
                SizedBox(
                  height: 20.v,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                orderNote.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}