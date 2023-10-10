import 'package:flutter/material.dart';

import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/views/gestion_de_table.dart';
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
                    ),
                ],
              ),
              const SizedBox(height: 20),
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
                        Map<String, dynamic> body = {
                          "usr": email,
                          "pwd": password,
                        };
                        final login = await interactor.login(body);
                        if (login.message == "Logged In") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GestionDeTable()));
                        }
                      }

                      print(pin);
                    },
                    child: const Text('Confirm',
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.dark01Color)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      removePin();
                    },
                    child: const Text('Delete',
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.dark01Color)),
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
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle:
              const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      onPressed: () => addPin(label),
      child: Text(label,
          style: const TextStyle(fontSize: 30, color: AppColors.dark01Color)),
    );
  }
}
