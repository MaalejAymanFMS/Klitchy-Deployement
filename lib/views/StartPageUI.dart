import 'package:flutter/material.dart';
import 'package:klitchyapp/models/tables.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/utils/size_utils.dart';
import 'package:klitchyapp/viewmodels/right_drawer_vm.dart';
import 'package:klitchyapp/viewmodels/start_page_interractor.dart';
import 'package:klitchyapp/views/right_drawer.dart';
import 'package:klitchyapp/views/table_order.dart';
import 'package:klitchyapp/views/table_right_drawer.dart';
import 'package:klitchyapp/widget/checkout.dart';
import 'package:klitchyapp/widget/table_timer.dart';
import 'package:klitchyapp/widget/tables/table_3.dart';
import 'package:klitchyapp/widget/tables/table_6.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';
import '../utils/locator.dart';
import '../widget/custom_button.dart';
import '../widget/tables/table_2.dart';
import '../widget/tables/table_4.dart';
import '../widget/tables/table_8.dart';

class StartPageUI extends StatefulWidget {
  final String name;
  final String id;
  final AppState appState;
  late final bool room;

  StartPageUI(
      {Key? key,
      required this.name,
      required this.id,
      required this.appState,
      required this.room})
      : super(key: key);

  @override
  StartPageUIState createState() => StartPageUIState();
}

class StartPageUIState extends State<StartPageUI> {
  final List<Widget> _newTables = [];
  late List<Widget> _gridChildren =
      List.generate(6 * 6, (index) => Container());

  final interactor = getIt<StartPageInterractor>();
  List<double> tableRotation = [0, 90, 180, 270];
  int currentIndex = 0;
  String tableName = '';
  String tableId = '';
  bool _dataFetched = false;
  String _fetchedRoomName = "false";

  double tableRotationFunction() {
    final rotation = tableRotation[currentIndex];
    currentIndex = (currentIndex + 1) % tableRotation.length;
    return rotation;
  }

  void addTable(String description, int x, int y, int numberOfSeats,
      String roomDescription, String roomID) async {
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
      "data_style":
          "{\"x\":$x,\"y\":$y,\"width\":\"94.5454px\",\"height\":\"100px\",\"background-color\":\"#1579d0\"}",
      "current_user": "pos@gameprod.com",
      "room_description": roomDescription,
      "shape": "Square",
      "doctype": "Restaurant Object",
      "status_managed": [],
      "production_center_group": []
    };
    await interactor.addTable(body);
  }

  void updateTable(String description, String id) async {
    Map<String, dynamic> body = {
      "description": description,
    };
    await interactor.updateTable(body, id);
  }
  int i = 0;
  void fetchTables() async {
    i += 1;
    Map<String, dynamic> params = {
      "fields": ["name", "description", "data_style"],
      "filters": [
        ["room_description", "LIKE", "%${widget.name}%"],
        ["type", "LIKE", "Table"]
      ]
    };
    var response = await interactor.retrieveListOfTables(params);
    if (response.data!.isNotEmpty) {
      if (widget.appState.numberOfTables > response.data!.length) {
        widget.appState.setNumberOfTables(response.data!.length);
      }
      for (var i = widget.appState.numberOfTables;
          i < response.data!.length;
          i++) {
        widget.appState.addTable();
      }

      setState(() {
        _gridChildren = List.generate(6 * 6, (index) => Container());
      });
      setState(() {
        if (widget.name != "Terrasse") {
          for (var i = 0; i < response.data!.length; i++) {
            List<String> parts = response.data![i].description!.split('-');
            if (parts[0] == "T2") {
              _gridChildren[int.tryParse(parts[1])!] = DraggableTable(
                  gestureDetector(
                      int.tryParse(parts[1])!,
                      TableTwo(
                        rotation: double.parse(parts[2]),
                        id: response.data![i].name,
                        name: response.data![i].description!,
                      ),
                      response.data![i].description!, response.data![i].name!),
                  onDraggableCanceled: (widget) =>
                      _handleDragCancelled(widget));
              widget.appState.addTableTimer(TableTimer(
                tableId: response.data![i].name,
                tableName: response.data![i].description,
                timer: "",
              ));
            }
            if (parts[0] == "T3") {
              _gridChildren[int.tryParse(parts[1])!] = DraggableTable(
                  gestureDetector(
                      int.tryParse(parts[1])!,
                      TableThree(
                        rotation: double.parse(parts[2]),
                        id: response.data![i].name,
                        name: response.data![i].description!,
                      ),
                      response.data![i].description!, response.data![i].name!),
                  onDraggableCanceled: (widget) =>
                      _handleDragCancelled(widget));
              widget.appState.addTableTimer(TableTimer(
                tableId: response.data![i].name,
                tableName: response.data![i].description,
                timer: "",
              ));
            }
            if (parts[0] == "T4") {
              _gridChildren[int.tryParse(parts[1])!] = DraggableTable(
                  gestureDetector(
                      int.tryParse(parts[1])!,
                      TableFour(
                        rotation: double.parse(parts[2]),
                        id: response.data![i].name,
                        name: response.data![i].description!,
                      ),
                      response.data![i].description!, response.data![i].name!),
                  onDraggableCanceled: (widget) =>
                      _handleDragCancelled(widget));
              widget.appState.addTableTimer(TableTimer(
                tableId: response.data![i].name,
                tableName: response.data![i].description,
                timer: "",
              ));
            }
            if (parts[0] == "T6") {
              _gridChildren[int.tryParse(parts[1])!] = DraggableTable(
                  gestureDetector(
                      int.tryParse(parts[1])!,
                      TableSix(
                          rotation: double.parse(parts[2]),
                          id: response.data![i].name,
                          name: response.data![i].description!),
                      response.data![i].description!, response.data![i].name!),
                  onDraggableCanceled: (widget) =>
                      _handleDragCancelled(widget));
              widget.appState.addTableTimer(TableTimer(
                tableId: response.data![i].name,
                tableName: response.data![i].description,
                timer: "",
              ));
            }
            if (parts[0] == "T8") {
              _gridChildren[int.tryParse(parts[1])!] = DraggableTable(
                  gestureDetector(
                      int.tryParse(parts[1])!,
                      TableEight(
                          rotation: double.parse(parts[2]),
                          id: response.data![i].name,
                          name: response.data![i].description!),
                      response.data![i].description!, response.data![i].name!),
                  onDraggableCanceled: (widget) =>
                      _handleDragCancelled(widget));
              widget.appState.addTableTimer(TableTimer(
                tableId: response.data![i].name,
                tableName: response.data![i].description,
                timer: "",
              ));
            }
          }
        }
      });
    } else {
      setState(() {
        _gridChildren = List.generate(6 * 6, (index) => Container());
        widget.appState.setNumberOfTables(0);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_dataFetched) {
      fetchTables();
      setState(() {
        _fetchedRoomName = widget.name;
        if(i>=2) {
          _dataFetched = true;
        }
      });
  }
    super.didChangeDependencies();
  }
  @override
  void didUpdateWidget(covariant StartPageUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name != _fetchedRoomName) {
      _dataFetched = false;
      _fetchedRoomName = widget.name;
      widget.appState.tableTimer = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Center(
      child: Row(
        children: [
          Container(
              height: (152 * 5).v,
              width: (260 * 4).h,
              decoration: const BoxDecoration(
                color: Color(0xFF0E1227),
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              child: widget.room
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 130.h / 95.v,
                      ),
                      itemCount: 6 * 6,
                      itemBuilder: (BuildContext context, int index) {
                        Widget widget = _gridChildren[index];
                        return SizedBox(
                          width: 130.h,
                          height: 130.v,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: SizedBox(
                                  width: 10.h,
                                  height: 10.v,
                                  child: widget.runtimeType != Container
                                      ? null
                                      : IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) {
                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Table menu"),
                                                      content: SizedBox(
                                                        height: 300.v,
                                                        width: 700.h,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Choose number of places:",
                                                              style: TextStyle(
                                                                  fontSize: 24),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                keyboardButton(
                                                                    "2",
                                                                    setState),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                keyboardButton(
                                                                    "3",
                                                                    setState),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                keyboardButton(
                                                                    "4",
                                                                    setState),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                keyboardButton(
                                                                    "6",
                                                                    setState),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                keyboardButton(
                                                                    "8",
                                                                    setState),
                                                                const SizedBox(
                                                                  width: 50,
                                                                ),
                                                                this
                                                                    .widget
                                                                    .appState
                                                                    .tableType,
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20.v,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "Choose the rotation: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24),
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    this
                                                                        .widget
                                                                        .appState
                                                                        .changeTableRotation(
                                                                            tableRotationFunction());
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .rotate_90_degrees_ccw),
                                                                ),
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            CustomButton(
                                                              text:
                                                                  "Place table",
                                                              onTap: () {
                                                                // this.widget.appState.switchOrder();
                                                                _handleAccept(
                                                                    this
                                                                        .widget
                                                                        .appState
                                                                        .tableType,
                                                                    index);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                ),
                              ),
                              DragTarget<Widget>(
                                builder: (BuildContext context,
                                    List<Widget?> accepted,
                                    List<dynamic> rejected) {
                                  return widget;
                                },
                                onWillAccept: (data) => data is Widget,
                                onAccept: (data) {
                                  _handleUpdate(data, index);
                                  appState.addTable();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : !widget.appState.checkout
                      ? TableOrder(appState: appState,)
                      : CheckoutScreen()),
          SizedBox(
            width: appState.isWidgetEnabled
                ? 12.h
                : MediaQuery.of(context).size.width / 5.85.h,
          ),
          !widget.room
              ? RightDrawerVM(tableName, tableId)
              : appState.tableTimer.isNotEmpty
                  ? TableRightDrawer(
                      appState: appState,
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }

  void _handleAccept(Widget data, int index) {
    setState(() {
      _gridChildren[index] = DraggableTable(data,
          onDraggableCanceled: (widget) => _handleDragCancelled(widget));
    });
    if (data is TableTwo) {
      addTable("T2-$index-${data.rotation}", index, index, 2, widget.name,
          widget.id);
    } else if (data is TableThree) {
      addTable("T3-$index-${data.rotation}", index, index, 3, widget.name,
          widget.id);
    } else if (data is TableFour) {
      addTable("T4-$index-${data.rotation}", index, index, 4, widget.name,
          widget.id);
    } else if (data is TableSix) {
      addTable("T6-$index-${data.rotation}", index, index, 6, widget.name,
          widget.id);
    } else if (data is TableEight) {
      addTable("T8-$index-${data.rotation}", index, index, 8, widget.name,
          widget.id);
    }
  }

  void _handleUpdate(Widget data, int index) {
    setState(() {
      if (data is GestureDetector) {
        final child = data.child;
        if (child is TableTwo) {
          updateTable("T2-$index-${child.rotation}", child.id!);
        } else if (child is TableThree) {
          updateTable("T3-$index-${child.rotation}", child.id!);
        } else if (child is TableFour) {
          updateTable("T4-$index-${child.rotation}", child.id!);
        } else if (child is TableSix) {
          updateTable("T6-$index-${child.rotation}", child.id!);
        } else if (child is TableEight) {
          updateTable("T8-$index-${child.rotation}", child.id!);
        }
      }
      _gridChildren[index] = data;
    });
  }

  void _handleDragCancelled(Widget widget) {
    setState(() {
      _newTables.add(widget);
    });
  }

  void _handleDelete(int index, Widget data) async {
    DeleteTable? res;
    if (data is TableTwo) {
      res = await interactor.deleteTable(data.id!);
      widget.appState.deleteTableTimer(data.id!);
    } else if (data is TableThree) {
      res = await interactor.deleteTable(data.id!);
      widget.appState.deleteTableTimer(data.id!);
    } else if (data is TableFour) {
      res = await interactor.deleteTable(data.id!);
      widget.appState.deleteTableTimer(data.id!);
    } else if (data is TableSix) {
      res = await interactor.deleteTable(data.id!);
      widget.appState.deleteTableTimer(data.id!);
    } else if (data is TableEight) {
      res = await interactor.deleteTable(data.id!);
      widget.appState.deleteTableTimer(data.id!);
    }
    setState(() {
      if (res?.message == "ok") {
        _gridChildren[index] = Container();
      }
    });
  }

  Widget keyboardButton(String label, Function setState) {
    return ElevatedButton(
      onPressed: () {
        widget.appState.changeTableType(label);
        setState(() {});
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 30, color: AppColors.dark01Color),
      ),
    );
  }

  GestureDetector gestureDetector(int index, Widget child, String id, String name) {
    return GestureDetector(
      onDoubleTap: () {
        _handleDelete(index, child);
        widget.appState.deleteTable();
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text("Table menu"),
              content: SizedBox(
                height: 300.v,
                child: Column(
                  children: [
                    Text("table number: ${index + 1}"),
                    const Spacer(),
                    CustomButton(
                      text: "add order",
                      onTap: () {
                        tableName = name;
                        tableId = id;
                        widget.appState.switchOrder();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                InkWell(
                    onTap: () {
                      _handleDelete(index, child);
                      widget.appState.deleteTable();
                      Navigator.pop(context);
                    },
                    child: const Text("delete"))
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}

class DraggableTable extends StatelessWidget {
  final Widget child;
  final Function(Widget) onDraggableCanceled;

  const DraggableTable(this.child,
      {super.key, required this.onDraggableCanceled});

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
