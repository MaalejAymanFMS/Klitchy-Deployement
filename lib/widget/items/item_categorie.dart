import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import '../../config/app_colors.dart';

class ItemCategorie extends StatelessWidget {
  final String name;
  final Color color;
  final int numberOfItems;

  const ItemCategorie(
      {Key? key,
      required this.name,
      required this.color,
      required this.numberOfItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              style: const TextStyle(color: AppColors.secondaryTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
