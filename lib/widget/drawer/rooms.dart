import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/entry_field.dart';

import '../../config/app_colors.dart';
import '../custom_button.dart';

class Rooms extends StatelessWidget {
  final Function() onTap;
  final int numberOfRooms;
  final TextEditingController roomNameControllr;

  const Rooms(this.onTap, this.numberOfRooms,this.roomNameControllr, {super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text(
                "Rooms",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "$numberOfRooms rooms",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondaryTextColor),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("Rooms form"),
                      content: SizedBox(
                          height: 300.v,
                          child: Column(children: [
                            EntryField(
                              label: "Room name",
                              hintText: "name",
                              controller: roomNameControllr,
                            ),
                            const Spacer(),
                            CustomButton(
                              text: "add room",
                              onTap: () {
                                onTap();
                                Navigator.pop(context);
                              }
                            ),
                          ])),
                    );
                  });
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
