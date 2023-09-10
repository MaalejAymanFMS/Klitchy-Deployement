library gestion_de_table;

import 'package:flutter/material.dart';
import 'package:klitchyapp/config/app_colors.dart';
import 'package:klitchyapp/widget/available_waiters.dart';
import 'package:provider/provider.dart';
import '../utils/AppState.dart';
import '../widget/drawer/room.dart';
import '../widget/drawer/rooms.dart';
import 'StartPageUI.dart';

part '../widget/drawer/top_menu_drawer.dart';

part 'left_drawer.dart';

class GestionDeTable extends StatefulWidget {
  const GestionDeTable({super.key});

  @override
  State<GestionDeTable> createState() => _GestionDeTableState();
}

bool? isDrawerOpen;

class _GestionDeTableState extends State<GestionDeTable> {
  void _handleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen!;
    });
  }

  @override
  void initState() {
    isDrawerOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5),
                child: InkWell(
                    onTap: () => appState.toggleWidget(),
                    child: const Icon(Icons.menu, color: Colors.white)),
              ),
              appState.isWidgetEnabled
                  ? Drawer(
                      child: LeftDrawer(_handleDrawer),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: AvailableWaiters(appState.numberOfTables),
              ),
              StartPageUI(),
            ],
          )
        ],
      ),
    );
  }
}
