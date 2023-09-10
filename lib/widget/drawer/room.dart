import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  const Room({super.key});

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
              Text("Rooms", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text("online", style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
