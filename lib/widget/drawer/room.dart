import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class Room extends StatelessWidget {
  final String title;
  const Room(this.title,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Image.asset("assets/images/logo.png"),
          ),
          SizedBox(width: 10,),
          Column(
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text("online", style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.secondaryTextColor)),
                ],
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}
