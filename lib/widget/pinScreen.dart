import 'package:flutter/material.dart';

import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/views/gestion_de_table.dart';


class PinScreen extends StatefulWidget {
  
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String pin = '';
  int filledCircles = 0;

  void addPin (String digit) {
    setState(() {
      if (pin.length < 4) {
        pin += digit;
        filledCircles = pin.length;
      }
    });
  }

  void removePin() {
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

    return Card(
      color: AppColors.tertiaryColor,
      elevation: 8.0,
      margin: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: deviceSize.width * 0.2,
        height: deviceSize.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter personal PIN:',
              style: TextStyle(fontSize: 20, color: AppColors.lightColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < filledCircles
                          ? AppColors.greenColor
                          : AppColors.lightColor,
                    ),
                    child: Center(child: Text(pin.length > i ? '*' : '')),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < 4; i++)
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < filledCircles
                            ? AppColors.greenColor
                            : AppColors.lightColor,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Row(
    
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    for (int i = 1; i <= 3; i++) keyboardButton('$i'),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
    
                  children: <Widget>[
                    for (int i = 4; i <= 6; i++) keyboardButton('$i'),
    
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 7; i <= 9; i++) keyboardButton('$i'),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODOO impliments services
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GestionDeTable() ));
    
                      print(pin);
                      
                    },
                    child: const Text('Confirm', style: const TextStyle(fontSize: 20, color: AppColors.dark01Color)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: const Text('Delete', style: const TextStyle(fontSize: 20, color: AppColors.dark01Color)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget keyboardButton(String label) {
    return ElevatedButton(
      onPressed: () => addPin(label),
      child: Text(label, style: const TextStyle(fontSize: 30, color: AppColors.dark01Color)),

    );
  }
}
