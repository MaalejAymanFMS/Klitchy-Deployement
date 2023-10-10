import 'package:flutter/material.dart';
import 'package:klitchyapp/views/gestion_de_table.dart';
import 'package:klitchyapp/views/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isUserLogin = false;
  late Future<bool> fetchPrefs;

  Future<bool> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isUserLogin = prefs.getBool("isLoggedIn")!;
    });
    return true;
  }
  @override
  void initState() {
    super.initState();
    fetchPrefs = getPrefs();
  }


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => isUserLogin ? const GestionDeTable() : const HomePage()),
      );
    });

    final deviceSize = MediaQuery.of(context).size;
    print(deviceSize.width);
    return FutureBuilder<bool>(
      future: fetchPrefs,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Row(
                children: [
                  Image.asset(
                    '../assets/images/splashScreen.png',
                    fit: BoxFit.cover,
                    width: deviceSize.width,
                    height: deviceSize.height,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

