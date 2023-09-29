import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double totalAmount = 100.0;
  double amountGiven = 0.0;

  void onNumberKeyPressed(int number) {
    setState(() {
      amountGiven = amountGiven * 10 + number.toDouble();
    });
  }

  void clearAmountGiven() {
    setState(() {
      amountGiven = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Wrap with a Container to control appearance
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Text(
            'Amount Given: \$${amountGiven.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberKey(1, onPressed: () => onNumberKeyPressed(1)),
              NumberKey(2, onPressed: () => onNumberKeyPressed(2)),
              NumberKey(3, onPressed: () => onNumberKeyPressed(3)),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberKey(4, onPressed: () => onNumberKeyPressed(4)),
              NumberKey(5, onPressed: () => onNumberKeyPressed(5)),
              NumberKey(6, onPressed: () => onNumberKeyPressed(6)),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberKey(7, onPressed: () => onNumberKeyPressed(7)),
              NumberKey(8, onPressed: () => onNumberKeyPressed(8)),
              NumberKey(9, onPressed: () => onNumberKeyPressed(9)),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => clearAmountGiven(),
                child: Text('Clear'),
              ),
              NumberKey(0, onPressed: () => onNumberKeyPressed(0)),
              ElevatedButton(
                onPressed: () {
                  // Handle the checkout logic here
                  double change = amountGiven - totalAmount;
                  if (change >= 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Change: \$${change.toStringAsFixed(2)}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Insufficient amount given'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NumberKey extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;

  NumberKey(this.number, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        number.toString(),
        style: TextStyle(fontSize: 24.0),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(60.0, 60.0),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
