import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

class DinnerTable extends StatelessWidget {
  int personNumber;
  DinnerTable(this.personNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: personNumber == 8 ? 176.h : 59.h,
        height: 59.v,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
          color: const Color.fromRGBO(39, 45, 75, 1),
          border: Border.all(
            color: const Color.fromRGBO(124, 133, 175, 1),
            width: 1.h,
          ),
        ));
  }
}
