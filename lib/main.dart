import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/routes/routes.dart';
import 'package:klitchyapp/utils/AppState.dart';
import 'package:klitchyapp/views/full_screen_mode.dart';
import 'package:klitchyapp/views/gestion_de_table.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FullScreenMode(),
        routes: PageRoutes().routes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
