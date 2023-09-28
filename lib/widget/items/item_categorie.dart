import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import '../../config/app_colors.dart';
import '../../utils/AppState.dart';

class ItemCategorie extends StatelessWidget {
  final String name;
  final Color color;
  final int numberOfItems;
  final Function(Map<String, dynamic> params) onTap;
  final bool isSelected;

  const ItemCategorie(
      {Key? key,
      required this.name,
      required this.color,
      required this.numberOfItems,
      required this.onTap,
      required this.isSelected,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, dynamic> params = {};
        if(name != "All Item Groups") {
           params = {
            "fields": ["item_name", "image", "standard_rate"],
            "filters": [["item_group", "LIKE", "%$name%"]],
            "limit_page_length": "None"
          };
        } else {
          params = {
            "fields": ["item_name", "image", "standard_rate"],
            "limit_page_length": "None"
          };
        }
        onTap(params);
      },
      child: Container(
        width: 267.h,
        height: 123.v,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$numberOfItems Items",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
