import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/viewmodels/room_interactor.dart';
import 'package:klitchyapp/widget/entry_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_keyboard_2/virtual_keyboard_2.dart';

import '../../config/app_colors.dart';
import '../../utils/locator.dart';
import '../custom_button.dart';

class Rooms extends StatefulWidget {
  final Function() onTap;
  final int numberOfRooms;
  final TextEditingController roomNameControllr;
  final Function(String) onIdChanged;


  const Rooms(this.onTap, this.numberOfRooms, this.roomNameControllr, this.onIdChanged,
      {super.key});

  @override
  RoomsState createState() => RoomsState();
}

class RoomsState extends State<Rooms> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final interactor = getIt<RoomInteractor>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                "Rooms",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.fSize),
              ),
              Text(
                "${widget.numberOfRooms} rooms",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondaryTextColor, fontSize: 15.fSize),
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
                      title: Text("Rooms form", style: TextStyle(fontSize: 15.fSize),),
                      content: SizedBox(
                          height: 550.v,
                          child: Form(
                            key: _formkey,
                            child: Column(children: [
                              EntryField(
                                label: "Room name",
                                hintText: "name",
                                controller: widget.roomNameControllr,
                              ),
                              SizedBox(
                                height: 70.v,
                              ),
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CustomButton(
                                      text: "add room",
                                      onTap: () async {
                                        if (_formkey.currentState!.validate()) {
                                          _formkey.currentState!.save();
                                          setState(() => _isLoading = true);
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          Map<String, dynamic> body = {
                                            "owner": "pos@gameprod.com", // we need to change this with the email of the current waiter
                                            "idx": 0,
                                            "docstatus": 0,
                                            "type": "Room",
                                            "description": widget.roomNameControllr.text,
                                            "room_description": widget.roomNameControllr.text,
                                            "current_user": prefs.getString("email"), // we need to change this with the email of the current waiter
                                            "doctype": "Restaurant Object"
                                          };
                                          final response =
                                              await interactor.addRoom(body);
                                          if (response.data.name!.isNotEmpty) {
                                            widget.onIdChanged(response.data.name!);
                                            widget.onTap();
                                            setState(() => _isLoading = false);
                                            Navigator.pop(context);
                                          } else {
                                            setState(() => _isLoading = false);
                                          }
                                        }
                                      }),
                              const Spacer(),
                              Container(
                                color: AppColors.itemsColor,
                                child: VirtualKeyboard(
                                    height: 300.v,
                                    textColor: Colors.white,
                                    type: VirtualKeyboardType.Alphanumeric,
                                    textController: widget.roomNameControllr),
                              ),
                              SizedBox(
                                height: 20.v,
                              )
                            ]),
                          )),
                    );
                  });
            },
            child: Icon(Icons.add, color: Colors.white, size: 30.fSize,),
          ),
        ],
      ),
    );
  }
}
