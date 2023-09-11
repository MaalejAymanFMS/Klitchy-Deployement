import 'package:flutter/material.dart';
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
      width: 383,
      height: 252,
      decoration: BoxDecoration(
        color: AppColors.itemsColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 151.5,
                height: 41,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.pink,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Discount",
                      style: TextStyle(color: AppColors.pink),
                    )
                  ],
                ),
              ),
              Container(
                width: 151.5,
                height: 41,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_card_outlined,
                      color: AppColors.turquoise,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Add amount",
                      style: TextStyle(color: AppColors.turquoise),
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
                Text("Subtotal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),),
                Spacer(),
                Text("0.00 TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text("TVA 19%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),),
                Spacer(),
                Text("0.00 TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text("Total",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),),
                Spacer(),
                Text("0.00 TND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textItems),),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: CustomButton(
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
