import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/tables.dart' as tb;
import 'package:klitchyapp/viewmodels/start_page_interractor.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/views/StartPageUI.dart';

import '../utils/constants.dart';
class StartPageVM extends StatefulWidget {
  const StartPageVM({Key? key}) : super(key: key);

  @override
  StartPageVMState createState() => StartPageVMState();
}

class StartPageVMState extends State<StartPageVM> implements StartPageInterractor {

  @override
  Widget build(BuildContext context) {
    return const StartPageUI();
  }

  @override
  Future<tb.Table> addTable(Map<String, dynamic> body) async {
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };
    final response = await http
        .post(Uri.parse("$baseUrl/api/login"),
        headers: headers, body: json.encode(body));
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = tb.Table.fromJson(jsonResponse);
      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = tb.Table.fromJson(jsonResponse);
      return data;
    }
  }
}