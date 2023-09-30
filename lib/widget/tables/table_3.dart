import 'package:flutter/material.dart';
import 'chair.dart';
import 'dinner_table.dart';

class TableThree extends StatelessWidget {
  final String? id;
  final String? name;
  final double rotation;
  const TableThree(
      {Key? key,
        this.id,
        this.name,required this.rotation,})
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
              // Chair(270),
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
      ),
    );
  }
}