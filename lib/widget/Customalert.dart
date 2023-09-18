import 'package:flutter/material.dart';
import 'package:klitchyapp/views/gestion_de_table.dart';

class Customalert extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('title'),
      content: Text('message'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GestionDeTable() ));
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}