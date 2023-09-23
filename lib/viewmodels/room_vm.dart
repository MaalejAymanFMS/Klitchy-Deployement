import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/rooms.dart';
import 'package:klitchyapp/viewmodels/room_interactor.dart';
import 'package:klitchyapp/widget/drawer/rooms.dart' as RM;
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
class RoomVM extends StatefulWidget {
  final Function() onTap;
  final int numberOfRooms;
  final TextEditingController roomNameControllr;

  const RoomVM(this.onTap, this.numberOfRooms, this.roomNameControllr,
      {super.key});

  @override
  RoomVMState createState() => RoomVMState();
}

class RoomVMState extends State<RoomVM> implements RoomInteractor{
  @override
  Widget build(BuildContext context) {
    return RM.Rooms(widget.onTap, widget.numberOfRooms, widget.roomNameControllr);
  }

  @override
  Future<Rooms> addRoom(Map<String, dynamic> body) async {
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };
    final response = await http.post(
      Uri.parse("$baseUrl/resource/Restaurant%20Object"),
      headers: headers,
      body: json.encode(body),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = Rooms.fromJson(jsonResponse);
      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = Rooms.fromJson(jsonResponse);
      return data;
    }
  }

  @override
  Future<ListRooms> getAllRooms(Map<String, dynamic> params) async {
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };

    final Uri uri = Uri.parse("$baseUrl/resource/Restaurant%20Object");

    // final filters = params['filters'];
    // final filtersJson = json.encode(filters);

    final Map<String, String> queryParams = {
      "fields": json.encode(params['fields']),
      // "filters": filtersJson,
    };

    final response = await http.get(uri.replace(queryParameters: queryParams), headers: headers);
    print(response.statusCode);
    print(uri.replace(queryParameters: queryParams));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = ListRooms.fromJson(jsonResponse);
      return data;
    } else {
      final jsonResponse = json.decode(response.body);
      final data = ListRooms.fromJson(jsonResponse);
      return data;
    }
  }
}
