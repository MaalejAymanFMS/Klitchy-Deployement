import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';

import '../config/app_colors.dart';

class CurrentWaiter extends StatelessWidget {
  const CurrentWaiter({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAdaptiveDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => Dialog(
            insetPadding: EdgeInsets.only(
              left: MediaQuery.of(context)
                  .size
                  .width -
                  400.h,
              right: 180.h,
              top: 70.v,
              bottom: MediaQuery.of(context)
                  .size
                  .height - 130.v
            ),
            alignment: Alignment.bottomRight,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: 200.h,
              height: 100.v,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  ListTile(
                    dense: true,
                    // onTap: () async {
                    //   await Navigator.pushNamed(
                    //       context,
                    //       PageRoutes.modifyProfile);
                    //   getPrefs();
                    // },
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: 17.fSize, fontWeight: FontWeight.bold)
                    ),
                    trailing: Icon(Icons.logout, size: 30.fSize, color: AppColors.redColor,),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        width: 200.h,
        height: 50.v,
        child: Row(
          children: [
            CircleAvatar(
              child: Image.asset("assets/images/waiter.png"),
            ),
            SizedBox(
              width: 19.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dhea",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.fSize),
                ),
                Row(
                  children: [
                    Container(
                      width: 10.h,
                      height: 10.v,
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Text("Active Now",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColors.secondaryTextColor, fontSize: 15.fSize)),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.secondaryTextColor,
              size: 24.fSize,
            ),
          ],
        ),
      ),
    );
  }
}
