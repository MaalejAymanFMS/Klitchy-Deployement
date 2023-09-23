import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import '../../config/app_colors.dart';

class Room extends StatelessWidget {
  final String title;
  final String id;

  const Room(this.title, this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Image.asset("assets/images/logo.png"),
          ),
          SizedBox(
            width: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
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
                  const Text("online",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.secondaryTextColor)),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}
