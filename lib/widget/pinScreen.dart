import 'package:flutter/material.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String pin = '';
  int filledCircles = 0;

  void _addToPin(String digit) {
    setState(() {
      if (pin.length < 4) {
        pin += digit;
        filledCircles = pin.length;
      }
    });
  }

  void _removeFromPin() {
    setState(() {
      if (pin.isNotEmpty) {
        pin = pin.substring(0, pin.length - 1);
        filledCircles = pin.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: deviceSize.width * 0.2,
          height: deviceSize.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            const  Text(
                'Enter Your PIN:',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < 4; i++)
                    Container(
                      margin:const EdgeInsets.all(8.0),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < filledCircles ? Colors.green : Colors.grey,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 1; i <= 3; i++)
                      _buildCustomKeyboardButton('$i'),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 4; i <= 6; i++)
                      _buildCustomKeyboardButton('$i'),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 7; i <= 9; i++)
                      _buildCustomKeyboardButton('$i'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODOO

                    },
                    child: Text('Confirm'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      _removeFromPin();
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomKeyboardButton(String label) {
    return ElevatedButton(
      onPressed: () => _addToPin(label),
      child: Text(label, style: TextStyle(fontSize: 20)),
    );
  }
}
