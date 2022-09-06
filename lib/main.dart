import 'package:flutter/material.dart';
import 'package:project1/viewscreen/game_screen.dart';

import 'viewscreen/game_start.dart';

void main() {
  runApp(const BaseballGame());
}

class BaseballGame extends StatelessWidget {
  const BaseballGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: GameStart.routeName,
      routes: {
        GameStart.routeName:(context) => const GameStart(),
        GameScreen.routeName:(context) => const GameScreen(),
      },
    );
  }
}