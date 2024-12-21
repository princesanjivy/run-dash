import 'package:flutter/material.dart';
import 'package:run_dash/providers/game_controller.dart';
import 'package:run_dash/providers/player_controller.dart';
import 'package:run_dash/providers/screen_controller.dart';
import 'package:run_dash/screens/game.dart';
import 'package:provider/provider.dart';
import 'package:run_dash/screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayerController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GameController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void calcSize() {
    ScreenController screenControlProvider =
        Provider.of<ScreenController>(context, listen: false);
    screenControlProvider.calcSize(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    calcSize();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
