import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import '../config/app_colors.dart';

class CurrentWaiter extends StatelessWidget {
  const CurrentWaiter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.h,
      height: 50.v,
      child: Row(
        children: [
          CircleAvatar(
            child: Image.asset("assets/images/waiter.png"),
          ),
          SizedBox(
            width: 19.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Dhea",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Row(
                children: [
                  Container(
                    width: 10.h,
                    height: 10.v,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 5.h,
                  ),
                  const Text("Active Now",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.secondaryTextColor)),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.secondaryTextColor,
            size: 24,
          ),
        ],
      ),
    );
  }
}
