library right_drawer;

import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/widget/right_drawer/buttom_component.dart';
import 'package:klitchyapp/widget/right_drawer/table_tag.dart';
import 'package:provider/provider.dart';

import '../utils/AppState.dart';
class RightDrawer extends StatefulWidget {
  const RightDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}


class _RightDrawerState extends State<RightDrawer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return SizedBox(
      width: 383.h,
      height: 887.v,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.v),
        child: Column(
          children: [
            TableTag(),
            appState.orders.isNotEmpty
                ? Column(
                    children: [
                      const Text(
                        "Items",
                        style: TextStyle(color: Colors.white),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children:
                          appState.orders.map((order) => order).toList()
                        ),
                      ),
                    ],
                  )
                : Text("asba"),
            Spacer(),
            ButtomComponent()
          ],
        ),
      ),
    );
  }
}
