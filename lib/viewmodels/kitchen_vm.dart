import 'package:flutter/material.dart';
import 'package:klitchyapp/models/kitchenOrders.dart';
import 'package:klitchyapp/viewmodels/kitchen_interactor.dart';
import 'package:klitchyapp/views/kitchen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KitchenVM extends StatefulWidget {
  const KitchenVM({super.key});

  @override
  State<KitchenVM> createState() => KitchenVMState();
}

class KitchenVMState extends State<KitchenVM> implements KitchenInteractor {
  @override
  Widget build(BuildContext context) {
    return KitchenScreen();
  }

  @override
  Future<List<Order>> fetchOrder() async {
    final response = await http.get(
      Uri.parse(
          'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order?fields=["name","table","table_description"]&limit_page_length=10'),
      headers: {'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'},
    );

    if (response.statusCode == 200) {
      fetchInProgressOrders();
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> orderData = data['data'];

      final List<String> orderNames =
          List<String>.from(orderData.map((order) => order['name'] as String));

      for (var orderName in orderNames) {
        final orderResponse = await http.get(
          Uri.parse(
              'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order/$orderName'),
          headers: {'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'},
        );

        if (orderResponse.statusCode == 200) {
          final jsonBody = json.decode(orderResponse.body);
          final dataDetails = jsonBody['data'];

          final List<EntryItem> entryItems =
              (dataDetails['entry_items'] as List<dynamic>).map((item) {
            return EntryItem(
              itemName: item['item_name'] as String,
              amount: item['amount'] as double,
              quantity: item['qty'] as int,
              notes: item['notes'] as String,
            );
          }).toList();

          final order = Order(
            status: "toStart",
            tableNumber: dataDetails['table_description'] as String,
            name: dataDetails['name'] as String,
            items: entryItems,
          );
            postOrder(order);
          
        } else {
          throw Exception(
              'Failed to fetch order details: ${orderResponse.statusCode}');
        }
      }
      return orders;
    } else {
      throw Exception('Failed to fetch order names: ${response.statusCode}');
    }
  }

  @override
  Future<void> startOrder(String id) async {
    String url = 'https://prime-verified-pug.ngrok-free.app/api/orders/$id/';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46',
    };

    Map<String, String> requestBody = {
      'order_id': id,
      'status_kds': 'progress',
    };

    String requestBodyJson = json.encode(requestBody);

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: requestBodyJson,
    );
    if (response.statusCode == 201) {
      final orderResponse = await http.get(
        Uri.parse(
            'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order/$id'),
        headers: {'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'},
      );

      if (orderResponse.statusCode == 200) {
        final jsonBody = json.decode(orderResponse.body);
        final dataDetails = jsonBody['data'];

        final List<EntryItem> entryItems =
            (dataDetails['entry_items'] as List<dynamic>).map((item) {
          return EntryItem(
            itemName: item['item_name'] as String,
            amount: item['amount'] as double,
            quantity: item['qty'] as int,
            notes: item['notes'] as String,
          );
        }).toList();

        final order = Order(
          status: "progress",
          tableNumber: dataDetails['table_description'] as String,
          items: entryItems,
        );

        inPrgressOrders.add(order);
        print('POST request was successful: ${response.body}');
      } else {
        print('POST request failed with status: ${response.statusCode}');
      }
    } else {
      print('POST request was failed: ${response.body}');
    }

    // Handle any exceptions
  }

  @override
  Future<void> fetchInProgressOrders() async {
    Set<Order> uniqueOrders = <Order>{};
    final response = await http.get(
      Uri.parse(
          'https://prime-verified-pug.ngrok-free.app/orders/orders-by-status/pending/'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if (data.containsKey('orders') && data['orders'] is List<dynamic>) {
        final List<dynamic> ordersData = data['orders'] as List<dynamic>;

        for (final orderData in ordersData) {
          if (orderData is Map<String, dynamic>) {
            final order_id = orderData['order_id'] as String?;
            if (order_id != null) {
              final orderResponse = await http.get(
                Uri.parse(
                    'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order/$order_id'),
                headers: {
                  'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'
                },
              );

              if (orderResponse.statusCode == 200) {
                final Map<String, dynamic> orderData =
                    json.decode(orderResponse.body) as Map<String, dynamic>;
                final itemsList =
                    (orderData['data']['entry_items'] as List<dynamic>?)
                        ?.map((item) => EntryItem(
                              itemName: item['item_name'] as String? ?? "",
                              amount:
                                  (item['amount'] as num?)?.toDouble() ?? 0.0,
                              quantity: (item['qty'] as num?)?.toInt() ?? 0,
                              notes: item['notes'] as String? ?? "",
                            ))
                        .toList();

                final order = Order(
                  status: "progress",
                  name: order_id,
                  tableNumber:
                      orderData['data']['table_description'] as String? ?? "",
                  items: itemsList,
                );
                uniqueOrders.add(order);
                inPrgressOrders = uniqueOrders.toList();
              } else {
                throw Exception(
                    'Failed to fetch order details: ${orderResponse.statusCode}');
              }
            }
          }
        }
      }
    } else {
      throw Exception('Failed to fetch order names: ${response.statusCode}');
    }
  }

  @override
  Future<void> updateStatusOrder(String id) async {
    print(id);
    String url = 'https://prime-verified-pug.ngrok-free.app/api/orders/$id/';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46',
    };

    Map<String, String> requestBody = {
      'order_id': id,
      'status_kds': 'preparing',
    };

    String requestBodyJson = json.encode(requestBody);

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      final orderResponse = await http.get(
        Uri.parse(
            'https://erpnext-141144-0.cloudclusters.net/api/resource/Table%20Order/$id'),
        headers: {'Authorization': 'token 82ad2e094492b3a:f24396cdd3d1c46'},
      );

      if (orderResponse.statusCode == 200) {
        final jsonBody = json.decode(orderResponse.body);
        final dataDetails = jsonBody['data'];

        final List<EntryItem> entryItems =
            (dataDetails['entry_items'] as List<dynamic>).map((item) {
          return EntryItem(
            itemName: item['item_name'] as String,
            amount: item['amount'] as double,
            quantity: item['qty'] as int,
            notes: item['notes'] as String,
          );
        }).toList();

        final order = Order(
          status: "done",
          tableNumber: dataDetails['table_description'] as String,
          items: entryItems,
        );
        inPrgressOrders.remove(order);

        finishedOrders.add(order);

        print(order);
      } else {
        print('Failed to update order: ${response.statusCode}');
      }
    }
  }

  void postOrder(Order order) async {
    final url =
        Uri.parse('https://prime-verified-pug.ngrok-free.app/api/orders/');
    final data = {"order_id": order.name, "status_kds": "wannaStart"};

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
orders.add(order);
      print("POST request successful!");
    } else {
      print(
          "Failed to make the POST request. Status code: ${response}");
    }
  }
}
