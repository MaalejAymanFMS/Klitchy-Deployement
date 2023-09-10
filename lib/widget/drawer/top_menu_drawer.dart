part of gestion_de_table;

class TopMenuDrawer extends StatefulWidget {
  final Function()? onTap;
  const TopMenuDrawer(this.onTap,{Key? key});

  @override
  State<TopMenuDrawer> createState() => _TopMenuDrawerState();
}

class _TopMenuDrawerState extends State<TopMenuDrawer> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => appState.toggleWidget(),
          child: const SizedBox(
            width: 32,
            height: 32,
            child: Icon(
              Icons.menu,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("klitchy restaurant", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            Text("Restaurant", style: TextStyle(fontWeight: FontWeight.normal)),
          ],
        )
      ],
    );
  }
}