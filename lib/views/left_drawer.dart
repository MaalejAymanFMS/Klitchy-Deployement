part of gestion_de_table;
class LeftDrawer extends StatefulWidget {
  final Function()? onTap;
  const LeftDrawer(this.onTap,{super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5.6,
      color: AppColors.primaryColor,
      child:  Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            TopMenuDrawer(widget.onTap),
            SizedBox(height: 40,),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            Rooms(),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(height: 40,),
            Room("Terrace"),
            SizedBox(height: 10,),
            Room("Main dinning"),
            SizedBox(height: 10,),
            Room("Pool bar"),
          ],
        ),
      ),
    );
  }
}
