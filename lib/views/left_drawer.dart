part of gestion_de_table;

class LeftDrawer extends StatefulWidget {
  final Function()? onTap;
  final AppState appState;

  const LeftDrawer(this.onTap, this.appState, {super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  final TextEditingController roomNameController = TextEditingController();
  final interactor = getIt<RoomInteractor>();
  List<Room> _room = [];
  String id = '';
  int selectedRoomIndex = 0;

  void addRoom() {
    setState(() {
      _room.insert(0,Room(roomNameController.text, id, true));
      widget.appState.chooseRoom(_room[0].title, _room[0].id);
      widget.appState.setNumberOfTables(0);
    });
  }

  void fetchRooms() async {
    Map<String, dynamic> params = {
      "fields": ["name","description", "type"],
      "filters": [["type", "LIKE", "Room"]],
    };
    var response = await interactor.getAllRooms(params);
    for (var i = 0; i < response.data!.length; i++) {
      if(response.data![i].type == 'Room') {
        setState(() {
          if(response.data![i].description! != "Terrasse") {
            _room.add(
                Room(response.data![i].description!,
                    response.data![i].name!, false));
          }
        });
      }
    }
    widget.appState.chooseRoom(_room[0].title, _room[0].id);
  }

  @override
  void initState() {
    fetchRooms();
    super.initState();
  }

  void handleIdChange(String newId) {
    setState(() {
      id = newId;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 5.6,
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.only(top: 10.v),
        child: Column(
          children: [
            TopMenuDrawer(widget.onTap),
            SizedBox(
              height: 40.v,
            ),
            Divider(
              height: 1.v,
              thickness: 1,
              color: Colors.black,
            ),
            RoomVM(addRoom, _room.length, roomNameController, handleIdChange),
            Divider(
              height: 1.v,
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 40.v,
            ),
            Column(
              children: _room.asMap().entries.map((entry) {
                final index = entry.key;
                final room = entry.value;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedRoomIndex = index;
                    });
                    widget.appState.chooseRoom(room.title, room.id);
                    widget.appState.switchRoom();
                    print(widget.appState.choosenRoom);
                  },
                  child: Room(
                    room.title,
                    room.id,
                    selectedRoomIndex == index, // Pass isSelected
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
