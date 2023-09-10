import 'package:flutter/material.dart';
import 'package:klitchyapp/widget/waiter_tag.dart';

import '../config/app_colors.dart';

class AvailableWaiters extends StatelessWidget {
  final int tablesNumber;

  const AvailableWaiters(this.tablesNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
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
        WaiterTag(AppColors.secondaryTextColor, "JK.png", "Jamel K."),
        WaiterTag(AppColors.secondaryTextColor, "SA.png", "Samira A."),
        WaiterTag(AppColors.secondaryTextColor, "MH.png", "Maheb H."),
      ],
    );
  }
}
