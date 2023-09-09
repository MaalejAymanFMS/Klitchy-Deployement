import 'package:flutter/material.dart';
import 'package:klitchyapp/views/homePage.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a delay of 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to your main screen after the splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    final deviceSize = MediaQuery.of(context).size;
    print(deviceSize.width);
    return Scaffold(
     
      body: Center(
        child: Row(
          children: [
            Image.asset('../assets/images/splashScreen.png',
        fit: BoxFit.cover,
        width: deviceSize.width,
        height: deviceSize.height,
        ),
          ],
        ),
        
      ),
    );
  }
}
