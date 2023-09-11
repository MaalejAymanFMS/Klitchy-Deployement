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
      height: 272,
      decoration: BoxDecoration(
        color: AppColors.itemsColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.remove_circle_outline,
                    color: AppColors.pink,
                  ),
                  Text(
                    "Discount",
                    style: TextStyle(color: AppColors.pink),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.add_card_outlined,
                    color: AppColors.turquoise,
                  ),
                  Text(
                    "Add amount",
                    style: TextStyle(color: AppColors.turquoise),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text("Subtotal"),
              Spacer(),
              Text("0.00 TND"),
            ],
          ),
          Row(
            children: [
              Text("TVA 19%"),
              Spacer(),
              Text("0.00 TND"),
            ],
          ),
          Row(
            children: [
              Text("Total"),
              Spacer(),
              Text("0.00 TND"),
            ],
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
