import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

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
      width: 383.h,
      height: 94.v,
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
                width: 1.h,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 137.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Table 2",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                        const Text(
                          "Samira A.",
                          style: TextStyle(color: AppColors.secondaryTextColor),
                        )
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.secondaryTextColor,
                )
              ],
            ),
          ),
          Container(
            width: 66.h,
            height: 94.v,
            decoration: BoxDecoration(
                border: Border.all(
              color: AppColors.primaryColor,
              width: 1.h,
            )),
            child: Image.asset(
              "assets/images/tag.png",
              color: AppColors.secondaryTextColor,
            ),
          ),
          Container(
            width: 66.h,
            height: 94.v,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.h,
              ),
            ),
            child: Image.asset(
              "assets/images/modify.png",
              color: AppColors.secondaryTextColor,
            ),
          ),
          Container(
            width: 66.h,
            height: 94.v,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.h,
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
