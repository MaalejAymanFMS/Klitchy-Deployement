import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/items.dart' as itm;
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/items/item_categorie.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';
import '../models/categories.dart';
import '../utils/AppState.dart';
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
  List<itm.Item> listItems = [];
  bool click = false;
  Future<void> fetchCategories() async {
    try {
      final categorieResponse = await interactor.retrieveCategories();
      setState(() {
        listCategories = categorieResponse.data!;
      });
    } catch (e) {
      debugPrint("catched error: $e");
    }
  }

  void fetchItems(Map<String, dynamic> params) async {
    try {
      debugPrint("$params");
      final itemResponse = await interactor.retrieveItems(params);
      debugPrint("${itemResponse.data![0].itemName}");
      appState.clickOpenCategorie(itemResponse.data!);
      setState(() {
        click = true;
        listItems = appState.categorieClicked;
      });
    } catch(e) {
      debugPrint("catched error: $e");
    }
  }
  late AppState appState;

  @override
  void initState() {
    appState = Provider.of<AppState>(context, listen: false);
    fetchCategories();
    super.initState();
  }

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
                return ItemCategorie(name: listCategories[index].name!, color: Colors.blueGrey, numberOfItems: 14, onTap: fetchItems,);
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
                return Item(name: listItems[index].itemName!,price : listItems[index].standardRate!,stock: 14, image: listItems[index].image!,);
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
