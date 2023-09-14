import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';
class OrderComponent extends StatelessWidget {
  int number;
  final String name;
  final double price;
  OrderComponent({Key? key, required this.number, required this.name, required this.price}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, order, child) {
        return
        SizedBox(
          width: 379.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 58.h,
                height: 58.v,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Image.asset("assets/images/shawarma.png"),
              ),
              SizedBox(width: 30.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$number X $name",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text(
                    "No tomato, extra spicy",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryTextColor),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "${totalPrice()} TND",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        )
        ;
      }
    );
  }

  double totalPrice() {
    return price * number;
  }
}
