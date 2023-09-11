part of gestion_de_table;

class LeftDrawer extends StatefulWidget {
  final Function()? onTap;

  const LeftDrawer(this.onTap, {super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  List<Widget> _room = [
    Room("Terrace"),
    Room("Main dinning"),
    Room("Pool bar"),
  ];

  void addRoom() {
    setState(() {
      _room.add(Room("new room"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5.6,
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            TopMenuDrawer(widget.onTap),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            Rooms(addRoom,_room.length),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 40,
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
