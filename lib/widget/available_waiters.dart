import 'package:flutter/material.dart';
import 'package:klitchyapp/widget/waiter_tag.dart';

import '../config/app_colors.dart';

class AvailableWaiters extends StatelessWidget {
  final int tablesNumber;

  const AvailableWaiters(this.tablesNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Available waiters",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            Text("$tablesNumber Tables",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondaryTextColor))
          ],
        ),
        SizedBox(width: 200,),
        WaiterTag(AppColors.secondaryTextColor, "JK.png", "Jamel K."),
        SizedBox(width: 50,),
        WaiterTag(AppColors.secondaryTextColor, "SA.png", "Samira A."),
        SizedBox(width: 50,),
        WaiterTag(AppColors.secondaryTextColor, "MH.png", "Maheb H."),
      ],
    );
  }
}
