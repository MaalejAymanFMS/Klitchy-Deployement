part of gestion_de_table;

class LeftDrawer extends StatefulWidget {
  final Function()? onTap;
  const LeftDrawer(this.onTap, {super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  final TextEditingController roomNameController = TextEditingController();
  final List<Widget> _room = [
    const Room("Main room"),
  ];

  void addRoom() {
    setState(() {
      _room.add(Room(roomNameController.text));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5.6,
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
            RoomVM(addRoom,_room.length, roomNameController),
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
                return room;
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
