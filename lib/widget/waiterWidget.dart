import 'package:flutter/material.dart';
import 'package:klitchyapp/widget/KeyboardWidget.dart';

class WaiterWidget extends StatelessWidget {
  final String name;
  final String imageAsset;

  WaiterWidget({required this.name, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: Text('Waiter Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  KeyboardWidget(),
                  Image.asset(
                    imageAsset,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(color: Colors.black), 
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: Column(
        children: [
          Image.asset(
            imageAsset,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(color: Colors.white), // Set text color
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}