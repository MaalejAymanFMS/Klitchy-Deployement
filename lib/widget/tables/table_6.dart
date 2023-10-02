import 'package:flutter/material.dart';

import 'chair.dart';
import 'dinner_table.dart';

class TableSix extends StatelessWidget {
  final double rotation;
  final String? id;
  final String? name;
  const TableSix(
      {Key? key,
        required this.rotation,
        this.id,
      this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(rotation / 360),
      child: Container(
        width: 128,
        height: 70.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top row with 3 chairs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chair(270),
                  const SizedBox(width: 11),
                  Chair(270),
                  const SizedBox(width: 11),
                  Chair(270),
                ],
              ),
              const SizedBox(height: 2.5),
              // Table with 1 chair on the left, 1 chair on the right
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Chair(180),
                  // const SizedBox(width: 2.5),
                  DinnerTable(8),
                  // const SizedBox(width: 2.5),
                  // Chair(0),
                ],
              ),
              const SizedBox(height: 2.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chair(90),
                  const SizedBox(width: 11),
                  Chair(90),
                  const SizedBox(width: 11),
                  Chair(90),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}