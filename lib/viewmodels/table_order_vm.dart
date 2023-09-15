import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/categories.dart';
import 'package:klitchyapp/viewmodels/table_order_interactor.dart';

import '../utils/constants.dart';
import '../views/table_order.dart';
import 'package:http/http.dart' as http;
class TablOrderPage extends StatefulWidget {
  const TablOrderPage({Key? key}) : super(key: key);

  @override
  TablOrderPageState createState() => TablOrderPageState();
}

class TablOrderPageState extends State<TablOrderPage> implements TableOrderInteractor {

  @override
  Widget build(BuildContext context) {
    return TableOrder();
  }

  @override
  Future<Categories> retrieveCategories() async {
    final headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization": "Token 82ad2e094492b3a:f24396cdd3d1c46"
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/resource/Item%20Group"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = Categories.fromJson(jsonResponse);
        print(data);
        return data;
      } else {
        print("HTTP request failed with status code ${response.statusCode}");
        return Categories(); // or handle the error in a different way
      }
    } catch (e) {
      print("An error occurred: $e");
      return Categories(); // or handle the error in a different way
    }
  }

}