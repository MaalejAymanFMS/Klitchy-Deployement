import 'package:flutter/material.dart';
import 'package:klitchyapp/widget/right_drawer/buttom_component.dart';
import 'package:klitchyapp/widget/right_drawer/table_tag.dart';
class RightDrawer extends StatelessWidget {
  const RightDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 303,
      height: 887,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            TableTag(),
            Spacer(),
            ButtomComponent()
          ],
        ),
      ),
    );
  }
}
