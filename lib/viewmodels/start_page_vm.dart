import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/tables.dart' as tb;
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/viewmodels/start_page_interractor.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/views/StartPageUI.dart';

import '../utils/constants.dart';
class StartPageVM extends StatefulWidget {
  final String name;
  final String id;
  final AppState appState;
  const StartPageVM({Key? key, required this.name,required this.id, required this.appState}) : super(key: key);

  @override
  StartPageVMState createState() => StartPageVMState();
}

class StartPageVMState extends State<StartPageVM> implements StartPageInterractor {

  @override
  Widget build(BuildContext context) {
    return StartPageUI(name: widget.name, id: widget.id, appState: widget.appState,);
  }

  @override
  Future<tb.AddTable> addTable(Map<String, dynamic> body) async {
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };
    final response = await http
        .post(Uri.parse("$baseUrl/resource/Restaurant%20Object"),
        headers: headers, body: json.encode(body));
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = tb.AddTable.fromJson(jsonResponse);
      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = tb.AddTable.fromJson(jsonResponse);
      return data;
    }
  }

  @override
  Future<tb.ListTables> retrieveListOfTables(Map<String, dynamic> params) async {
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };

    final Uri uri = Uri.parse("$baseUrl/resource/Restaurant%20Object");

    final filters = params['filters'];
    final filtersJson = json.encode(filters);

    final Map<String, String> queryParams = {
      "fields": json.encode(params['fields']),
      "filters": filtersJson,
    };

    final response = await http.get(uri.replace(queryParameters: queryParams), headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = tb.ListTables.fromJson(jsonResponse);
      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = tb.ListTables.fromJson(jsonResponse);
      return data;
    }
  }

  @override
  Future<tb.DeleteTable> deleteTable(String id) async {
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };
    final response = await http
        .delete(Uri.parse("$baseUrl/resource/Restaurant%20Object/$id"),
        headers: headers);
    print(response.statusCode);

    if (response.statusCode == 202) {
      final jsonResponse = json.decode(response.body);
      final data = tb.DeleteTable.fromJson(jsonResponse);
      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = tb.DeleteTable.fromJson(jsonResponse);
      return data;
    }
  }
}