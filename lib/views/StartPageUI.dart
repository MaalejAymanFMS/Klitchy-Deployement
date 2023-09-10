import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../widget/custom_button.dart';
import '../widget/tables/table_4.dart';
import '../widget/tables/table_8.dart';

class StartPageUI extends StatefulWidget {
  const StartPageUI({Key? key}) : super(key: key);

  @override
  StartPageUIState createState() => StartPageUIState();
}

class StartPageUIState extends State<StartPageUI> {
  final List<Widget> _newTables = [];
  final List<Widget> _gridChildren =
      List.generate(5 * 4, (index) => Container());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Container(
            height: 150 * 5,
            width: 260 * 4,
            decoration: const BoxDecoration(
              color: Color(0xFF0E1227),
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 260 / 150,
              ),
              itemCount: 5 * 4,
              itemBuilder: (BuildContext context, int index) {
                Widget widget = _gridChildren[index];
                return GestureDetector(
                  onDoubleTap: () => _handleDelete(index),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("Table menu"),
                            content: Container(
                                height: 300,
                                child: Column(children: [
                                  Text("table number: ${index + 1}"),
                                  const Spacer(),
                                  CustomButton(
                                    text: "add order",
                                  ),
                                ])),
                            actions: [
                              InkWell(
                                  onTap: () {
                                    _handleDelete(index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("delete"))
                            ],
                          );
                        });
                  },
                  child: SizedBox(
                    width: 260,
                    height: 260,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 125 , // Center horizontally
                          top: 70,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ),
                        DragTarget<Widget>(
                          builder: (BuildContext context,
                              List<Widget?> accepted, List<dynamic> rejected) {
                            return widget;
                          },
                          onWillAccept: (data) => data is Widget,
                          onAccept: (data) {
                            _handleAccept(data, index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 20,),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DraggableTable(TableFour(),
                    onDraggableCanceled: (widget) =>
                        _handleDragCancelled(widget)),
                const SizedBox(height: 100,),
                DraggableTable(TableEight(90),
                    onDraggableCanceled: (widget) =>
                        _handleDragCancelled(widget)),
                const SizedBox(height: 100,),
                DraggableTable(TableEight(0),
                    onDraggableCanceled: (widget) =>
                        _handleDragCancelled(widget)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleAccept(Widget data, int index) {
    setState(() {
      _gridChildren[index] = data;
    });
  }

  void _handleDragCancelled(Widget widget) {
    setState(() {
      _newTables.add(widget);
    });
  }

  void _handleDelete(int index) {
    setState(() {
      _gridChildren[index] = Container();
    });
  }
}

class DraggableTable extends StatelessWidget {
  final Widget child;
  final Function(Widget) onDraggableCanceled;

  const DraggableTable(this.child, {required this.onDraggableCanceled});

  @override
  Widget build(BuildContext context) {
    return Draggable<Widget>(
      data: child,
      feedback: child,
      childWhenDragging: Container(),
      child: GestureDetector(
        onTap: () {
          onDraggableCanceled(child);
        },
        child: child,
      ),
    );
  }
}
