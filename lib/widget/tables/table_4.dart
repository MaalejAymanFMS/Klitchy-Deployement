import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import 'chair.dart';
import 'dinner_table.dart';

class TableFour extends StatelessWidget {
  final String? id;
  const TableFour(
      {Key? key,
        this.id,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128.h,
      height: 70.5.v,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chair(270),
            SizedBox(height: 2.5.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chair(180),
                SizedBox(width: 2.5.h),
                DinnerTable(4),
                SizedBox(width: 2.5.h),
                Chair(0),
              ],
            ),
            SizedBox(height: 2.5.v),
            Chair(90),
          ],
        ),
      ),
    );
  }
}