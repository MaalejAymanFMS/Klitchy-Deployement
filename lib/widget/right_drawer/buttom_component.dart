import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/custom_button.dart';

import '../../config/app_colors.dart';

class ButtomComponent extends StatefulWidget {
  const ButtomComponent({super.key});

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
                    const Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.pink,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    const Text(
                      "Discount",
                      style: TextStyle(color: AppColors.pink),
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
                    const Icon(
                      Icons.add_card_outlined,
                      color: AppColors.turquoise,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    const Text(
                      "Add amount",
                      style: TextStyle(color: AppColors.turquoise),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),
                ),
                Spacer(),
                Text(
                  "0.00 TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "TVA 19%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),
                ),
                Spacer(),
                Text(
                  "0.00 TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Spacer(),
                Text(
                  "0.00 TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 20.v),
            child: const CustomButton(
              backgroundColor: AppColors.greenColor,
              icon: "assets/images/arrow_forward.png",
              text: "Start Orders",
            ),
          )
        ],
      ),
    );
  }
}
