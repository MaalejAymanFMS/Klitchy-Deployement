import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class TableTag extends StatefulWidget {
  const TableTag({super.key});

  @override
  State<TableTag> createState() => _TableTagState();
}

class _TableTagState extends State<TableTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 381,
      height: 94,
      decoration: BoxDecoration(
        color: AppColors.itemsColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: AppColors.primaryColor,
              width: 1,
            )),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Table 2",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Samira A.",
                        style: TextStyle(color: AppColors.secondaryTextColor),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.secondaryTextColor,
                )
              ],
            ),
          ),
          Container(
            width: 66,
            height: 94,
            decoration: BoxDecoration(
                border: Border.all(
              color: AppColors.primaryColor,
              width: 1,
            )),
            child: Image.asset(
              "assets/images/tag.png",
              color: AppColors.secondaryTextColor,
            ),
          ),
          Container(
            width: 66,
            height: 94,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            child: Image.asset(
              "assets/images/modify.png",
              color: AppColors.secondaryTextColor,
            ),
          ),
          Container(
            width: 66,
            height: 94,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1,
              ),
              color: AppColors.redColor,
            ),
            child: Image.asset(
              "assets/images/trash.png",
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
