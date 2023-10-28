import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/custom_button.dart';

import '../../config/app_colors.dart';

class ButtomComponent extends StatefulWidget {
  final Function() onTap;
  final AppState appState;
  const ButtomComponent({
    super.key,
    required this.onTap,
    required this.appState,
  });

  @override
  State<ButtomComponent> createState() => _ButtomComponentState();
}

class _ButtomComponentState extends State<ButtomComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 383.h,
      height: 252.v,
      decoration: BoxDecoration(
        color: AppColors.itemsColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textItems,
                      fontSize: 15.fSize),
                ),
                const Spacer(),
                Text(
                  "${widget.appState.subtotal.toStringAsFixed(3)} TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textItems,
                      fontSize: 15.fSize),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "TVA 7%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textItems,
                      fontSize: 15.fSize),
                ),
                const Spacer(),
                Text(
                  "${widget.appState.tva.toStringAsFixed(3)} TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textItems,
                      fontSize: 15.fSize),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.fSize),
                ),
                const Spacer(),
                Text(
                  "${widget.appState.total} TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textItems,
                      fontSize: 15.fSize),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.onTap();
                },
                child: Container(
                  width: 191.5.h,
                  height: 70.v,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1.h,
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                        size: 30.fSize,
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Text(
                        "Send to kitchen",
                        style: TextStyle(color: AppColors.whiteColor, fontSize: 20.fSize),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.appState.checkout) {
                    widget.appState.switchCheckoutOrder();
                  } else {
                    widget.appState.switchCheckout();
                  }
                },
                child: Container(
                  width: 191.5.h,
                  height: 70.v,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1.h,
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_card_outlined,
                        color: AppColors.whiteColor,
                        size: 30.fSize,
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Text(
                        "Payment",
                        style: TextStyle(
                            color: AppColors.whiteColor, fontSize: 20.fSize),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
