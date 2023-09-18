import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import '../../config/app_colors.dart';

class Rooms extends StatelessWidget {
  final Function() onTap;
  final int numberOfRooms;

  const Rooms(this.onTap, this.numberOfRooms, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text(
                "Rooms",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "$numberOfRooms rooms",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondaryTextColor),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
