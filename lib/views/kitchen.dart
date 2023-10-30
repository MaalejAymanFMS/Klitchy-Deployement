import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/models/kitchenOrders.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/locator.dart';
import 'package:klitchyapp/viewmodels/kitchen_interactor.dart';
import 'package:klitchyapp/widget/orderList.dart';
import 'package:provider/provider.dart';


bool isDone = false;
List<Order> orders = [];
List<Order> inPrgressOrders = [];
List<Order> finishedOrders = [];

class KitchenScreen extends StatefulWidget {
  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {

  final interactor = getIt<KitchenInteractor>();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: interactor.fetchOrder(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Order> orders = snapshot.data ?? [];

          return ChangeNotifierProvider<AppState>(
            create: (context) => AppState(),
            child: MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  //toolbarHeight:
                  backgroundColor: AppColors.primaryColor,
                ),
                body: OrderList(
                  orders: orders,
              
                ),
              ),
              debugShowCheckedModeBanner: false,
            ),
          );
        }
      },
    );
  }
}
