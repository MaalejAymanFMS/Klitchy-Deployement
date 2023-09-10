import 'package:flutter/material.dart';

class WaiterTag extends StatelessWidget {
  final Color backgroundColor;
  final String image;
  final String name;
  const WaiterTag(this.backgroundColor, this.image,this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(39),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10,),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Image.asset("assets/images/$image"),
          ),
          SizedBox(width: 30,),
          Text(name),
        ],
      ),
    );
  }
}
