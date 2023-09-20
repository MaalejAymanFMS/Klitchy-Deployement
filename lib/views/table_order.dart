import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/items/item_categorie.dart';

import '../config/app_colors.dart';
import '../models/categories.dart';
import '../utils/locator.dart';
import '../viewmodels/table_order_interactor.dart';
import '../widget/items/item.dart';

class TableOrder extends StatefulWidget {
  const TableOrder({Key? key}) : super(key: key);

  @override
  TableOrderState createState() => TableOrderState();
}
class TableOrderState extends State<TableOrder> {
  final interactor = getIt<TableOrderInteractor>();
  List<Categorie> listCategories = [];
  Future<void> fetchCategories() async {
    try {
      final categorieResponse = await interactor.retrieveCategories();
      setState(() {
        listCategories = categorieResponse.data!;
      });
    } catch (e) {
      print("catched error: $e");
    }
  }
  @override
  void initState() {
    fetchCategories();
    super.initState();
  }
  // List<Widget> listCategories = [
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  //   const ItemCategorie(
  //       name: "Starters", color: Colors.blue, numberOfItems: 14),
  // ];
  List<Widget> listItems = [
    const Item(
      name: "Beef",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Chiken shawarma",
      price: 10.5,
      stock: 10,
    ),
    const Item(
      name: "Sandwish thon",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Sandwish shawarma",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Plat escalope",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Pizza neptune",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Pizza margarita",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Pizza turc",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Makloub escalope",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Makloub thon",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Mlewi",
      price: 4.5,
      stock: 10,
    ),
    const Item(
      name: "Sardina",
      price: 4.5,
      stock: 10,
    ),
  ];
  Color getRandomColor() {
    final random = Random();
    final r = random.nextInt(256);
    final g = random.nextInt(256);
    final b = random.nextInt(256);

    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1117.h,
          height: 262.v,
          decoration: const BoxDecoration(
            color: Color(0xFF0E1227),
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 267.h / 123.v),
            itemCount: listCategories.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < listCategories.length) {
                return ItemCategorie(name: listCategories[index].name!, color: getRandomColor(), numberOfItems: 14);
              } else {
                return Container();
              }
            },
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Find items in drinks",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: 10.v,
            ),
            const Text(
              "24 Variation",
              style: TextStyle(color: AppColors.secondaryTextColor),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 1120.h,
          height: 414.v,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 274.h / 134.v,
            ),
            itemCount: listItems.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < listItems.length) {
                return listItems[index];
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
