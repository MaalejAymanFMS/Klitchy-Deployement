import 'package:flutter/material.dart';
import 'package:klitchyapp/widget/pinScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
       child: Container(
        child: PinScreen(),
       ),
      ),
    );
  }
}