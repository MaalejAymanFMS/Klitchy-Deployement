import 'package:flutter/material.dart';
import 'package:klitchyapp/models/orders.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../utils/AppState.dart';
import '../../utils/constants.dart';
import '../order_component.dart';

class Item extends StatefulWidget {
  final String name;
  final String code;
  final double price;
  final int stock;
  final String image;
  final AppState appState;

  const Item({
    Key? key,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
    required this.appState, required this.code,
  }) : super(key: key);

  @override
  ItemState createState() => ItemState();
}

class ItemState extends State<Item> {
  int numberOfItems = 0;

  void handleMinus() {
    if (numberOfItems > 0) {
      setState(() {
        numberOfItems -= 1;
      });
    }
  }

  void handlePlus() {
    if (numberOfItems < widget.stock) {
      setState(() {
        numberOfItems += 1;
      });
    }
  }
  void test() {
    int updatedNumberOfItems = 0;
    if (widget.appState.orders.isNotEmpty) {
      for (var i = 0; i < widget.appState.orders.length; i++) {
        if (widget.appState.orders[i].name == widget.name) {
          updatedNumberOfItems = widget.appState.orders[i].number;
          break;
        }
      }
    }
    setState(() {
      numberOfItems = updatedNumberOfItems;
    });
  }

  @override
  void didChangeDependencies() {
    test();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };
    return Container(
      width: 274.h,
      height: 134.v,
      decoration: BoxDecoration(
        color: AppColors.itemsColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 10.v,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.price} TND",
                      style:
                          const TextStyle(color: AppColors.secondaryTextColor),
                    ),
                    const SizedBox(
                      width: 65,
                    ),
                    Container(
                      width: 58.h,
                      height: 58.v,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: widget.image != "null image" &&
                              widget.image.isNotEmpty
                          ? Image.network(
                              "$baseUrlImage${widget.image}",
                              headers: headers,
                              fit: BoxFit.fill,
                            )
                          : Image.asset("assets/images/shawarma.png"),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 28.h,
                  height: 28.v,
                  child: InkWell(
                    onTap: () {
                      handlePlus();
                      appState.addOrder(
                        numberOfItems,
                        OrderComponent(
                          number: numberOfItems,
                          name: widget.name,
                          price: widget.price,
                          image: widget.image,
                        ),
                      );
                      appState.addEntryItem(numberOfItems.toDouble(), EntryItem(
                        identifier: "identifier",
                            parentfield: "entry_items",
                          parenttype: "Table Order",
                          item_code: widget.code,
                          status: "Attending",
                          notes: "",
                          qty: numberOfItems.toDouble(),
                          rate: widget.price,
                          price_list_rate: widget.price,
                          amount: numberOfItems * widget.price,
                          table_description: "${appState.choosenRoom["name"]} (Table)",
                          doctype: "Order Entry Item"
                      ));
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Spacer(),
                Text(
                  "$numberOfItems",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                // Spacer(),
                SizedBox(
                  width: 28.h,
                  height: 28.v,
                  child: InkWell(
                    onTap: () {
                      handleMinus();
                      appState.deleteOrder(
                        numberOfItems,
                        OrderComponent(
                          number: numberOfItems,
                          name: widget.name,
                          price: widget.price,
                          image: widget.image,
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
