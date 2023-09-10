import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/widget/customSwitchButton.dart';
import 'package:klitchyapp/widget/pinScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isUserLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.primaryColor,
      body: Stack(

        alignment: Alignment.center,
        children: <Widget>[
    
  
          Positioned(
            top: 50.0,
            child: Image.asset(
              'assets/images/logo.png', 
              width: 100.0,
              height: 100.0, 
            ),
          ),

          // Switch Button with "USER LOGIN" and "PIN LOGIN" labels
          Positioned(
            top: 200.0,
            child: CustomSwitchButton(
              initialValue: isUserLogin,
              onChanged: (bool value) {
                setState(() {
                  isUserLogin = value;
                });
              },
            ),
          ),

         
          Positioned(
            top: 300.0, // Adjust vertical position as needed
            child: isUserLogin
                ? PinScreen()
                : PinScreen(),
          ),

          // Additional Widgets (if needed)
        ],
      ),
    );
  }
}
