import 'package:flutter/material.dart';
import 'package:klitchyapp/widget/items/item.dart';
import 'package:klitchyapp/widget/items/item_categorie.dart';

import '../config/app_colors.dart';

class TableOrder extends StatefulWidget {
  const TableOrder({Key? key}) : super(key: key);

  @override
  TableOrderState createState() => TableOrderState();
}

class TableOrderState extends State<TableOrder> {
  List<Widget> listCategories = [
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
    const ItemCategorie(
        name: "Starters", color: Colors.blue, numberOfItems: 14),
  ];
  List<Widget> listItems = [
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
    const Item(name: "Soda", price: "4.5", stock: 10,),
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1117,
          height: 262,
          decoration: const BoxDecoration(
            color: Color(0xFF0E1227),
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 267 / 123),
            itemCount: listCategories.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < listCategories.length) {
                return listCategories[index];
              } else {
                return Container(); // Handle out of bounds index
              }
            },
          ),
        ),
        Spacer(),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find items in drinks",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "24 Variation",
              style: TextStyle(color: AppColors.secondaryTextColor),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 1120,
          height: 414,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 274 / 134,
            ),
            itemCount: listItems.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < listItems.length) {
                return listItems[index];
              } else {
                return Container(); // Handle out of bounds index
              }
            },
          ),
        ),
      ],
    );
  }
}
