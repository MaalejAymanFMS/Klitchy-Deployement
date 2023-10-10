import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/custom_button.dart';

import '../../config/app_colors.dart';

class ButtomComponent extends StatefulWidget {
  final Function() onTap;
  final AppState appState;
  const ButtomComponent({super.key, required this.onTap, required this.appState,});

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
          Row(
            children: [
              Container(
                width: 191.5.h,
                height: 41.v,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.h,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.pink,
                      size: 30.fSize,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    Text(
                      "Discount",
                      style: TextStyle(color: AppColors.pink, fontSize: 15.fSize),
                    )
                  ],
                ),
              ),
              Container(
                width: 191.5.h,
                height: 41.v,
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
                      color: AppColors.turquoise,
                      size: 30.fSize,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    Text(
                      "Add amount",
                      style: TextStyle(color: AppColors.turquoise, fontSize: 15.fSize),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems, fontSize: 15.fSize),
                ),
                const Spacer(),
                Text(
                  "${widget.appState.subtotal.toStringAsFixed(3)} TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems, fontSize: 15.fSize),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "TVA 19%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems, fontSize: 15.fSize),
                ),
                const Spacer(),
                Text(
                  "${widget.appState.tva.toStringAsFixed(3)} TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems, fontSize: 15.fSize),
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
                      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.fSize),
                ),
                const Spacer(),
                Text(
                  "${widget.appState.total} TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems, fontSize: 15.fSize),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 20.v),
            child: CustomButton(
              backgroundColor: AppColors.greenColor,
              icon: "assets/images/arrow_forward.png",
              text: "Start Orders",
              onTap: widget.onTap,
            ),
          )
        ],
      ),
    );
  }
}
