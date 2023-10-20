import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/views/gestion_de_table.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final token = prefs.getString("token");
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token'
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        print('Table Order status updated successfully');
        print("response.statusCode" + response.statusCode.toString());
        printTicket();
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

  void createInvoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const String url =
        'https://erpnext-141144-0.cloudclusters.net/api/resource/POS%20Invoice';
    try {
      final token = prefs.getString("token");
      Map<String, dynamic> body = {
        "docstatus": 1,
        "modified_by": prefs.getString("email"),//tetbaddel bel waiter
        "title": "Default Customer",
        "naming_series": "ACC-PSINV-.YYYY.-",
        "customer": "Defult Customer",
        "pos_profile": "Caissier",
        "is_pos": 1,
        "territory": "Tunisia",
        "currency": "TND",
        "conversion_rate": 1.0,
        "selling_price_list": "Standard Selling",
        "price_list_currency": "TND",
        "plc_conversion_rate": 1.0,
        "set_warehouse": "Stores - GP",
        "update_stock": 1,
        "base_total": 7.0,
        "base_net_total": 7.0,
        "total": 7.0,
        "net_total": 7.0,
        "apply_discount_on": "Grand Total",
        "additional_discount_percentage": 0.0,//this is the discount persentage (type réel)
        "base_grand_total": 7.0,
        "grand_total": 7.0,
        "rounded_total": 7.0,
        "base_paid_amount": 7.0,
        "paid_amount": 7.0,
        "base_change_amount": 0.0,
        "change_amount": 0.0,
        "account_for_change_amount": "Cash - GP",
        "write_off_account": "Sales - GP",
        "write_off_cost_center": "Main - GP",
        "status": "Consolidated",
        "debit_to": "Debtors - GP",
        "party_account_currency": "TND",
        "doctype": "POS Invoice",
        "items": widget.appState.entryItems
            .map((entryMap) => entryMap.toJson())
            .toList(),
        "payments": [
          {
            "owner": "caissier@gameprod.com",
            "modified_by": "caissier@gameprod.com",//tetbaddel
            "parent": "ACC-PSINV-2023-00016",
            "parentfield": "payments",
            "parenttype": "POS Invoice",
            "idx": 1,
            "docstatus": 1,
            "default": 0,
            "mode_of_payment": "Cash",
            "amount": 7.0,//tetbaddel
            "account": "Cash - GP",
            "type": "Cash",
            "base_amount": 7.0,//tetbaddel
            "doctype": "Sales Invoice Payment"
          }
        ]
      };
      final response = await http.post(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Authorization': '$token'
      }, body: body);
      if(response.statusCode == 200) {

      } else {
        print(
            'Failed to update Table Order status. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  void printTicket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final orderId = prefs.getString("orderId");
    String url =
        'https://erpnext-141144-0.cloudclusters.net/api/method/frappe.utils.print_format.download_pdf?doctype=Table%20Order&name=$orderId&no_letterhead=1&letterhead=No%20Letterhead&settings=%7B%7D&format=Order%20Account&_lang=en';
    try {
      final token = prefs.getString("token");
      final response = await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token'

      },);
      if(response.statusCode == 200) {
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async { // Use the alias
            return response.bodyBytes; // Pass the response body directly
          },
        );
      } else {
        print(
            'Failed to update Table Order status. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> _launchUrl(Uri url,String token) async {
    print("token: $token");
    if (!await launchUrl(url, webViewConfiguration: WebViewConfiguration(headers: {
      'Authorization': token
    }))) {
      throw Exception('Could not launch $url');
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
    print(amountGivenString);
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(255, 22, 26, 52),
                child: Column(
                  children: [
                    Container(
                      width: 460.h,
                      height: 86.v,
                      color: Color.fromARGB(255, 134, 137, 154),
                      child: Center(
                        child: Text(
                          'Total Amount: ${totalAmount.toStringAsFixed(3)} TND',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFf1eaff), // Font color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.01,
                    ),
                    Container(
                      width: deviceSize.width * 0.24,
                      height: deviceSize.height * 0.08,
                      color: Color.fromARGB(255, 134, 137, 154),
                      child: Center(
                        child: Text(
                          'Amount Given: ${amountGiven.toStringAsFixed(3)} TND',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xFFf1eaff), // Font color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: deviceSize.width * 0.1,
            ),
            Container(
              color: Color.fromARGB(255, 22, 26, 52),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => onNumberKeyPressed("1"),
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                          color: AppColors.dark01Color,
                                          fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondaryTextColor,
                                      minimumSize: Size(112.h, 77.v),
                                      padding: EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                  ),
                                  SizedBox(width: deviceSize.width * 0.011),
                                  ElevatedButton(
                                    onPressed: () => onNumberKeyPressed("2"),
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                          color: AppColors.dark01Color,
                                          fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondaryTextColor,
                                      minimumSize: Size(112.h, 77.v),
                                      padding: EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => onNumberKeyPressed("5"),
                                    child: Text(
                                      '5',
                                      style: TextStyle(
                                          color: AppColors.dark01Color,
                                          fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondaryTextColor,
                                      minimumSize: Size(112.h, 77.v),
                                      padding: EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                  ),
                                  SizedBox(width: deviceSize.width * 0.011),
                                  ElevatedButton(
                                    onPressed: () => onNumberKeyPressed("10"),
                                    child: Text(
                                      '10',
                                      style: TextStyle(
                                          color: AppColors.dark01Color,
                                          fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondaryTextColor,
                                      minimumSize: Size(112.h, 77.v),
                                      padding: EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => onNumberKeyPressed("20"),
                                    child: Text(
                                      '20',
                                      style: TextStyle(
                                          color: AppColors.dark01Color,
                                          fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondaryTextColor,
                                      minimumSize: Size(112.h, 77.v),
                                      padding: EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                  ),
                                  SizedBox(width: deviceSize.width * 0.011),
                                  ElevatedButton(
                                    onPressed: () => onNumberKeyPressed("50"),
                                    child: Text(
                                      '50',
                                      style: TextStyle(
                                          color: AppColors.dark01Color,
                                          fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondaryTextColor,
                                      minimumSize: Size(112.h, 77.v),
                                      padding: EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => clearAmountGiven(),
                        child: Container(
                          height: 77.v,
                          width: 235.h,
                          decoration: BoxDecoration(
                            color: AppColors.redColor,
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
                    ],
                  ),
                  //  SizedBox(width: deviceSize.width * 0.03),
                  Container(
                    //height: deviceSize.height * 0.4,
                    // width: deviceSize.width * 0.27,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      // Keypad background color
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
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("1"),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.011),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("2"),
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.011),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("3"),
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("4"),
                                child: Text(
                                  '4',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.011),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("5"),
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.011),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("6"),
                                child: Text(
                                  '6',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("7"),
                                child: Text(
                                  '7',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.01),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("8"),
                                child: Text(
                                  '8',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.011),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("9"),
                                child: Text(
                                  '9',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (!isTapCommar) {
                                    onNumberKeyPressed(".");
                                    isTapCommar = true;
                                  }
                                },
                                child: Text(
                                  ',',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      // AppColors.secondaryTextColor,
                                      AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.01),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("0"),
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.011),
                              ElevatedButton(
                                onPressed: () => onNumberKeyPressed("00"),
                                child: Text(
                                  '00',
                                  style: TextStyle(
                                      color: AppColors.dark01Color,
                                      fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryTextColor,
                                  minimumSize: Size(deviceSize.width * 0.072,
                                      deviceSize.height * 0.067),
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: deviceSize.height * 0.3,
                    width: deviceSize.width * 0.07,
                    child: InkWell(
                      onTap: () async {
                        change = amountGiven - totalAmount;
                        if (change >= 0) {
                          if (await payment() == 200) {
                            await payment();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Change: ${change.toStringAsFixed(3)} TND'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        widget.appState.switchCheckoutOrder();
                                        widget.appState.switchRoom();
                                        Navigator.pop(context);
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
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
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
