import 'package:flutter/material.dart';

import 'chair.dart';
import 'dinner_table.dart';

class TableFour extends StatelessWidget {
  const TableFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      height: 141,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chair(270),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chair(180),
                const SizedBox(width: 5),
                DinnerTable(4),
                const SizedBox(width: 5),
                Chair(0),
              ],
            ),
            const SizedBox(height: 5),
            Chair(90),
          ],
        ),
      ),
    );
  }
}