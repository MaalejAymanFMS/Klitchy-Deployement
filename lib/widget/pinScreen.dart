import 'package:flutter/material.dart';

import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/views/gestion_de_table.dart';
import 'package:klitchyapp/views/kitchen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/locator.dart';
import '../viewmodels/pin_screen_interactor.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String pin = '';
  int filledCircles = 0;
  final interactor = getIt<PinScreenInteractor>();

  void addPin(String digit) {
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

    return SingleChildScrollView(
      child: Card(
        color: AppColors.tertiaryColor,
        elevation: 8.0,
        margin: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: deviceSize.width * 0.22,
          height: deviceSize.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter personal PIN:',
                style: TextStyle(fontSize: 20.fSize, color: AppColors.lightColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < 4; i++)
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 30.h,
                      height: 30.v,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < filledCircles
                            ? AppColors.greenColor
                            : AppColors.lightColor,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20.v),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 1; i <= 3; i++) keyboardButton('$i'),
                  ],
                ),
              ),
              SizedBox(height: deviceSize.height * 0.01),
              Container(
                // margin: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 4; i <= 6; i++) keyboardButton('$i'),
                  ],
                ),
              ),
              SizedBox(height: deviceSize.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 7; i <= 9; i++) keyboardButton('$i'),
                ],
              ),
              SizedBox(height: deviceSize.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i <=0; i++) keyboardButton('$i'),
                ],
              ),
              SizedBox(height: deviceSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print(pin);
                      // TODOO impliments services
                      final response = await interactor.retrieve(pin);
                      if (response.email!.isNotEmpty) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final email = prefs.getString("email");
                        final password = prefs.getString("password");
                        final role = prefs.getString("role");
                        Map<String, dynamic> body = {
                          "usr": email,
                          "pwd": password,
                        };
                        final login = await interactor.login(body);
                        if (login.message == "Logged In") {
                          if(role == "waiter") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GestionDeTable()));
                          } else if(role == "kitchen"){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KitchenScreen()));
                          }
                        }
                      }

                      print(pin);
                    },
                    child: Text('Confirm',
                        style: TextStyle(
                            fontSize: 20.fSize, color: AppColors.dark01Color)),
                  ),
                  SizedBox(width: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      removePin();
                    },
                    child: Text('Delete',
                        style: TextStyle(
                            fontSize: 20.fSize, color: AppColors.dark01Color)),
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
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightColor,
          padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 20.v),
          textStyle: TextStyle(fontSize: 30.fSize, fontWeight: FontWeight.bold)),
      onPressed: () => addPin(label),
      child: Text(label,
          style: TextStyle(fontSize: 30.fSize, color: AppColors.dark01Color)),
    );
  }
}
