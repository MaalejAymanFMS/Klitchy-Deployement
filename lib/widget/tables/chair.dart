import 'package:flutter/material.dart';

class Chair extends StatelessWidget {
  double rotation;
   Chair(this.rotation,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 35,
        height: 36,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(rotation / 360),
                child: Container(
                    width: 35,
                    height: 36,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Color.fromRGBO(39, 45, 75, 1),
                    )),
              )),
          Positioned(
              top: 5,
              left: 4,
              child: Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(81, 87, 118, 1),
                    border: Border.all(
                      color: const Color.fromRGBO(124, 133, 175, 1),
                      width: 1,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(27, 27)),
                  ))),
          const Positioned(
              top: 12,
              left: 11,
              child: Text(
                'P1',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
        ]));
  }
}
