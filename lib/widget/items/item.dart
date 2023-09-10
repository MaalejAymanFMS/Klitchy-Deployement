import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class Item extends StatefulWidget {
  final String name;
  final String price;
  final int stock;

  const Item({
    Key? key,
    required this.name,
    required this.price,
    required this.stock,
  }) : super(key: key);
  @override
  ItemState createState() => ItemState();
}

class ItemState extends State<Item> {
  int numberOfItems = 0;
  void handleMinus() {
    if(numberOfItems > 0) {
      setState(() {
        numberOfItems -= 1;
      });
    }
  }
  void handlePlus() {
    if(numberOfItems < widget.stock) {
      setState(() {
        numberOfItems += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 274,
      height: 134,
      decoration: BoxDecoration(
        color: AppColors.itemsColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "${widget.price} TND",
                style: const TextStyle(color: AppColors.secondaryTextColor),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.stock}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: InkWell(
                  onTap: () => handlePlus(),
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
                width: 28,
                height: 28,
                child: InkWell(
                  onTap: () => handleMinus(),
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
    );
  }
}
