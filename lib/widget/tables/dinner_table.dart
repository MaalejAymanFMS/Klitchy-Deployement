import 'package:flutter/material.dart';

class DinnerTable extends StatelessWidget {
  int personNumber;
  DinnerTable(this.personNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: personNumber == 8 ? 176 : 59,
        height: 59,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
          color: const Color.fromRGBO(39, 45, 75, 1),
          border: Border.all(
            color: const Color.fromRGBO(124, 133, 175, 1),
            width: 1,
          ),
        ));
  }
}
