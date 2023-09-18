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
          child: SizedBox(
            width: 32.h,
            height: 32.v,
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("klitchy restaurant", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(
              height: 5.v,
            ),
            const Text("Restaurant", style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.secondaryTextColor)),
          ],
        )
      ],
    );
  }
}