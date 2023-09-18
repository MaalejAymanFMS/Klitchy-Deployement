import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import 'chair.dart';
import 'dinner_table.dart';

class TableFour extends StatelessWidget {
  const TableFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256.h,
      height: 141.v,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chair(270),
            SizedBox(height: 5.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chair(180),
                SizedBox(width: 5.h),
                DinnerTable(4),
                SizedBox(width: 5.h),
                Chair(0),
              ],
            ),
            SizedBox(height: 5.v),
            Chair(90),
          ],
        ),
      ),
    );
  }
}