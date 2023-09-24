import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:klitchyapp/models/tables.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/viewmodels/start_page_interractor.dart';
import 'package:klitchyapp/views/right_drawer.dart';
import 'package:klitchyapp/views/table_order.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';
import '../utils/locator.dart';
import '../widget/custom_button.dart';
import '../widget/tables/table_4.dart';
import '../widget/tables/table_8.dart';

class StartPageUI extends StatefulWidget {
  final String name;
  final String id;
  const StartPageUI({Key? key, required this.name, required this.id}) : super(key: key);

  @override
  StartPageUIState createState() => StartPageUIState();
}

class StartPageUIState extends State<StartPageUI> {
  final List<Widget> _newTables = [];
  late List<Widget> _gridChildren =
  List.generate(7 * 6, (index) => Container());

  bool room = true;
  final interactor = getIt<StartPageInterractor>();

  void addTable(String description, int x, int y, int numberOfSeats, String roomDescription, String roomID) async {
    Map<String, dynamic> body = {
      "owner": "pos@gameprod.com",
      "idx": 0,
      "docstatus": 0,
      "type": "Table",
      "room": roomID,
      "no_of_seats": numberOfSeats,
      "minimum_seating": numberOfSeats,
      "description": description,
      "color": "#1579d0",
      "data_style": "{\"x\":$x,\"y\":$y,\"width\":\"94.5454px\",\"height\":\"100px\",\"background-color\":\"#1579d0\"}",
      "current_user": "pos@gameprod.com",
      "room_description": roomDescription,
      "shape": "Square",
      "doctype": "Restaurant Object",
      "status_managed": [],
      "production_center_group": []
    };
    var response = await interactor.addTable(body);
  }

  void fetchTables() async {

    Map<String, dynamic> params = {
      "fields": ["name","description","data_style"],
      "filters" : [["room_description", "LIKE", "%${widget.name}%"],["type","LIKE","Table"]]
    };
    var response = await interactor.retrieveListOfTables(params);
    if(response.data!.isNotEmpty) {
      setState(() {
        _gridChildren =
            List.generate(7 * 6, (index) => Container());
      });
      setState(() {
        for (var i = 0; i < response.data!.length; i++) {
          List<String> parts = response.data![i].description!.split('-');

          if (parts[0] == "T4") {
            _gridChildren[int.tryParse(parts[1])!] = TableFour(id: response.data![i].name,);
          }
          if (parts[0] == "T8" && parts[2] == "90") {
            _gridChildren[int.tryParse(parts[1])!] = TableEight(rotation:90, id: response.data![i].name,);
          }
          if (parts[0] == "T8" && parts[2] == "0") {
            _gridChildren[int.tryParse(parts[1])!] = TableEight(rotation: 0, id: response.data![i].name,);
          }
        }
      });
    }
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    fetchTables();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Center(
      child: Row(
        children: [
          Container(
            height: (150 * 5).v,
            width: (260 * 4).h,
            decoration: const BoxDecoration(
              color: Color(0xFF0E1227),
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: room ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 130.h / 75.v,
              ),
              itemCount: 7 * 6,
              itemBuilder: (BuildContext context, int index) {
                Widget widget = _gridChildren[index];
                return GestureDetector(
                  onDoubleTap: () {
                    _handleDelete(index, widget);
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
                                    _handleDelete(index, widget);
                                    appState.deleteTable();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("delete"))
                            ],
                          );
                        });
                  },
                  child: SizedBox(
                    width: 130.h,
                    height: 130.v,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 70.h,
                          top: 35.v,
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
                DraggableTable(TableEight(rotation: 90),
                    onDraggableCanceled: (widget) =>
                        _handleDragCancelled(widget)),
                SizedBox(
                  height: 100.v,
                ),
                DraggableTable(TableEight(rotation: 0),
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
    if (data is TableEight && data.rotation == 0) {
      addTable("T8-$index-0", index, index, 8, widget.name, widget.id);
    } else if (data is TableFour) {
      addTable("T4-$index-0", index, index, 4, widget.name, widget.id);
    } else if (data is TableEight && data.rotation == 90) {
      addTable("T8-$index-90", index, index, 8, widget.name, widget.id);
    }

  }

  void _handleDragCancelled(Widget widget) {
    setState(() {
      _newTables.add(widget);
    });
  }

  void _handleDelete(int index, Widget data) async {
    DeleteTable? res;
    if(data is TableEight && data.rotation == 0) {
      res = await interactor.deleteTable(data.id!);
    } else if(data is TableEight && data.rotation == 90) {
      res = await interactor.deleteTable(data.id!);
    } else if (data is TableFour) {
      res = await interactor.deleteTable(data.id!);
    }
    setState(() {
      if (res?.message == "ok") {
        _gridChildren[index] = Container();
      }
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
