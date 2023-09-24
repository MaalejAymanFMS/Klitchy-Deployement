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
      width: 128,
      height: 70.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chair(270),
            const SizedBox(height: 2.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chair(180),
                const SizedBox(width: 2.5),
                DinnerTable(4),
                const SizedBox(width: 2.5),
                Chair(0),
              ],
            ),
            const SizedBox(height: 2.5),
            Chair(90),
          ],
        ),
      ),
    );
  }
}