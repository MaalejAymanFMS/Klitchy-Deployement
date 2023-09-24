import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:virtual_keyboard_2/virtual_keyboard_2.dart';

class CustomKeyboardButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  CustomKeyboardButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 18), 
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, 
        onPrimary: Colors.white, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
        ),
        padding: EdgeInsets.all(10), 
        minimumSize: Size(50, 50), 
      ),
    );
  }
}

class WaiterWidget extends StatefulWidget {
  final String name;
  final String imageAsset;

  WaiterWidget({required this.name, required this.imageAsset});

  @override
  _WaiterWidgetState createState() => _WaiterWidgetState();
}

class _WaiterWidgetState extends State<WaiterWidget> {
  TextEditingController _textEditingController = TextEditingController();
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: Text('Enter your password ${widget.name}',style: TextStyle(color: AppColors.whiteColor) ,),
              backgroundColor: AppColors.primaryColor, 
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                
                  VirtualKeyboard(
                    height: 350,
                    textColor: Colors.white,
                    fontSize: 20,
                    type: VirtualKeyboardType.Alphanumeric,
                    textController: _textEditingController,
                  ),
                  Text(
                    _textEditingController.text,
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                      SizedBox(width: 15), 
                      CustomKeyboardButton(
                        text: 'Login',
                        onPressed: () {
                          print(_textEditingController.text);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Column(
        children: [
          Image.asset(
            widget.imageAsset,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(
            widget.name,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
