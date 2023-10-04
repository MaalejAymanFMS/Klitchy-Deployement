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
  final String? tableId;
  const RightDrawer({
    this.tableId,
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
            TableTag(appState,widget.tableId),
            Expanded(
              child: appState.orders.isNotEmpty
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Items",
                      style: TextStyle(color: Colors.white),
                    ),
                    Column(
                      children: appState.orders.map((order) {
                        return InkWell(
                          onTap: () {
                            showOrderDetails(order, appState);
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
            const ButtomComponent(),
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