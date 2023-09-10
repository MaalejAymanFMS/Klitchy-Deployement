import 'package:flutter/material.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Text("Rooms", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("4 rooms", style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          Spacer(),
          Icon(Icons.add),
        ],
      ),
    );
  }
}
