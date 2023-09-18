import 'package:flutter/material.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/views/right_drawer.dart';
import 'package:klitchyapp/views/table_order.dart';
import 'package:provider/provider.dart';

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
  bool room = true;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Center(
      child: Row(
        children: [
          Container(
            height: 150.v * 5,
            width: 260.h * 4,
            decoration: const BoxDecoration(
              color: Color(0xFF0E1227),
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: room ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 260.h / 150.v,
              ),
              itemCount: 5 * 4,
              itemBuilder: (BuildContext context, int index) {
                Widget widget = _gridChildren[index];
                return GestureDetector(
                  onDoubleTap: () {
                    _handleDelete(index);
                    appState.deleteTable();
                  },
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Table menu"),
                            content: SizedBox(
                                height: 300.v,
                                child: Column(children: [
                                  Text("table number: ${index + 1}"),
                                  const Spacer(),
                                  CustomButton(
                                    text: "add order",
                                    onTap: () {
                                      setState(() {
                                        room = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ])),
                            actions: [
                              InkWell(
                                  onTap: () {
                                    _handleDelete(index);
                                    appState.deleteTable();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("delete"))
                            ],
                          );
                        });
                  },
                  child: SizedBox(
                    width: 260.h,
                    height: 260.v,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 125.h,
                          top: 70.v,
                          child: Container(
                            width: 10.h,
                            height: 10.v,
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
                            appState.addTable();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) : const TableOrder(),
          ),
          SizedBox(
            width: appState.isWidgetEnabled ? 12.h : MediaQuery.of(context).size.width / 5.85.h,
          ),
          room ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DraggableTable(TableFour(),
                    onDraggableCanceled: (widget) =>
                        _handleDragCancelled(widget)),
                SizedBox(
                  height: 100.v,
                ),
                DraggableTable(TableEight(90),
                    onDraggableCanceled: (widget) =>
                        _handleDragCancelled(widget)),
                SizedBox(
                  height: 100.v,
                ),
                DraggableTable(TableEight(0),
                    onDraggableCanceled: (widget) =>
                        _handleDragCancelled(widget)),
              ],
            ),
          ) : const SizedBox.shrink(),
          !room ? RightDrawer() : const SizedBox.shrink(),
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
