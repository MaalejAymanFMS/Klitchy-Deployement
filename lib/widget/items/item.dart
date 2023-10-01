import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../utils/AppState.dart';
import '../order_component.dart';
class Item extends StatefulWidget {
  final String name;
  final double price;
  final int stock;
  final String image;

  const Item({
    Key? key,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
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

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
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
                            fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 2,
                      ),
                ),
                SizedBox(
                  height: 10.v,
                ),
                Text(
                  "${widget.price} TND",
                  style: const TextStyle(color: AppColors.secondaryTextColor),
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
                    onTap: () { handlePlus();

                    appState.addOrder(numberOfItems, OrderComponent(number: numberOfItems, name: widget.name, price: widget.price, image: widget.image,));
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Spacer(),
                Text(
                  "${numberOfItems}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                // Spacer(),
                SizedBox(
                  width: 28.h,
                  height: 28.v,
                  child: InkWell(
                    onTap: () { handleMinus();
                      appState.deleteOrder(numberOfItems, OrderComponent(number: numberOfItems, name: widget.name, price: widget.price, image: widget.image,));
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
