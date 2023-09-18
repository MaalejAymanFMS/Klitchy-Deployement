import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/Customalert.dart';
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
            top: 50.v,
            child: Image.asset(
              'assets/images/logo.png', 
              width: 100.h,
              height: 100.v,
            ),
          ),

          // Switch Button with "USER LOGIN" and "PIN LOGIN" labels
          Positioned(
            top: 200.v,
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
            top: 300.v,
            child: isUserLogin
                ? PinScreen()
                : Customalert(),
          ),
        ],
      ),
    );
  }
}
