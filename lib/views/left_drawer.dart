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

  void addRoom() {
    setState(() {
      _room.insert(0,Room(roomNameController.text, id));
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
          _room.add(
              Room(response.data![i].description!,
                  response.data![i].name!));
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
              children: _room.map((room) {
                return InkWell(onTap: () {
                  widget.appState.chooseRoom(room.title, room.id);
                  print(widget.appState.choosenRoom);
                },
                    child: room);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
