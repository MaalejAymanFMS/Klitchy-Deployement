import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/user.dart';
import 'package:klitchyapp/viewmodels/pin_screen_interactor.dart';
import 'package:klitchyapp/widget/pinScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
class PinScreenVM extends StatefulWidget {
  const PinScreenVM({super.key});

  @override
  State<PinScreenVM> createState() => PinScreenVMState();
}

class PinScreenVMState extends State<PinScreenVM> implements PinScreenInteractor{

  @override
  Widget build(BuildContext context) {
    return PinScreen();
  }

  @override
  Future<User> retrieve(String pin) async {
    final response = await http
        .get(Uri.parse("https://prime-verified-pug.ngrok-free.app//user/get_user_by_pin/$pin"),
        headers:{
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "OPTIONS, GET, POST",
"Access-Control-Allow-Credentials": "true",
"Access-Control-Allow-Headers": "Content-Type, Depth, User-Agent, X-File-Size, X-Requested-With, If-Modified-Since, X-File-Name, Cache-Control"
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = User.fromJson(jsonResponse);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data.token!);
      prefs.setString('email', data.email!);
      prefs.setString('password', data.password!);
      print(prefs.getString("email"));
      print(prefs.getString("password"));

      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = User.fromJson(jsonResponse);
      return data;
    }

  }


  @override
  Future<Login> login(Map<String, dynamic> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",

    };
    final response = await http
        .post(Uri.parse("$baseUrl/method/login"),
        headers: headers, body: json.encode(body));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = Login.fromJson(jsonResponse);
      prefs.setBool("isLoggedIn", true);
      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = Login.fromJson(jsonResponse);
      return data;
    }

  }

}
