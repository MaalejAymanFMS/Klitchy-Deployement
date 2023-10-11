import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/views/gestion_de_table.dart';
import 'package:klitchyapp/views/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODOO add payement methos

class CheckoutScreen extends StatefulWidget {
  final AppState appState;
  const CheckoutScreen({Key? key, required this.appState}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double totalAmount = 0.0;
  double amountGiven = 0.0;
  String amountGivenString = "";
  double change = 0.0;
  bool isTapCommar = false;

  Future<int> payment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String url =
        'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order/${prefs.getString("orderId")}';

    final payload = json.encode({"status": "Invoiced"});
    print(prefs.getString("orderId"));
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          // Add any headers if needed
          'Content-Type': 'application/json',
          'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        print('Table Order status updated successfully');
        print("response.statusCode" + response.statusCode.toString());
        return response.statusCode;
      } else {
        print(
            'Failed to update Table Order status. Status code: ${response.statusCode}');
        return response.statusCode;
      }
    } catch (e) {
      print('Error: $e');
      return -1;
    }
  }

  void onNumberKeyPressed(String number) {
    setState(() {
      if (number == ".") {
        isTapCommar = true;
      }
      amountGivenString += number;
      amountGiven = double.parse(amountGivenString);
    });
  }

  void clearAmountGiven() {
    setState(() {
      isTapCommar = false;
      amountGiven = 0.0;
      amountGivenString = "";
    });
  }

  @override
  void initState() {
    totalAmount = widget.appState.total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF060C18), // Background color
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Amount: ${totalAmount.toStringAsFixed(3)} TND',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFf1eaff), // Font color
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Amount Given: ${amountGiven.toStringAsFixed(3)} TND',
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xFFf1eaff), // Font color
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //clear container

                  InkWell(
                    onTap: () => clearAmountGiven(),
                    child: Container(
                      height: deviceSize.height * 0.5,
                      width: deviceSize.width * 0.07,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryTextColor,
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Clear',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.dark01Color,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: deviceSize.height * 0.5,
                    width: deviceSize.width * 0.37,
                    alignment: Alignment.center, // Adjust the width as needed
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors
                          .secondaryTextColor, // Keypad background color
                      borderRadius: BorderRadius.circular(10.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.2),
                      //     blurRadius: 6.0,
                      //     spreadRadius: 2.0,
                      //   ),
                      // ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("1"),
                              child: Text(
                                '1',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("2"),
                              child: Text(
                                '2',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("3"),
                              child: Text(
                                '3',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: deviceSize.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("4"),
                              child: Text(
                                '4',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("5"),
                              child: Text(
                                '5',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("6"),
                              child: Text(
                                '6',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: deviceSize.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("7"),
                              child: Text(
                                '7',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("8"),
                              child: Text(
                                '8',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("9"),
                              child: Text(
                                '9',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                          ],
                        ),
                        SizedBox(height: deviceSize.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("0"),
                              child: Text(
                                '0',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () => onNumberKeyPressed("10"),
                              child: Text(
                                '10',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                            SizedBox(width: deviceSize.width * 0.020),
                            ElevatedButton(
                              onPressed: () {
                                if (!isTapCommar) onNumberKeyPressed(".");
                              },
                              child: Text(
                                ',',
                                style: TextStyle(
                                    color: AppColors.dark01Color,
                                    fontSize: deviceSize.width * 0.02),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryTextColor,
                                minimumSize: Size(deviceSize.width * 0.1,
                                    deviceSize.height * 0.07),
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // checkout containner
                  InkWell(
                    onTap: () async {
                      print(deviceSize.width);
                      // Handle the checkout logic here
                      change = amountGiven - totalAmount;
                      if (change >= 0) {
                        if (await payment() == 200) {
                          await payment();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    'Change: \$${change.toStringAsFixed(3)}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GestionDeTable()));
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('payment faild'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Insufficient amount given'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      height: deviceSize.height * 0.5,
                      width: deviceSize.width * 0.07,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryTextColor,
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.dark01Color,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberKey extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;

  NumberKey(this.number, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        number.toString(),
        style: TextStyle(fontSize: 24.0),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(60.0, 60.0),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
