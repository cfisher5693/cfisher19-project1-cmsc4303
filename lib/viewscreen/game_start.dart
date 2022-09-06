import 'package:flutter/material.dart';
import 'package:project1/viewscreen/game_screen.dart';

class GameStart extends StatefulWidget {
  const GameStart({Key? key}) : super(key: key);
  static const routeName = '/gameStart';

  @override
  State<StatefulWidget> createState() {
    return _GameStartState();
  }
}

class _GameStartState extends State<GameStart> {
  late _Controller con;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baseball Game'),
        actions: [
          ElevatedButton(
            onPressed: con.onPressed,
            child: const Text('New Game'),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 180,
          width: 300,
          child: Card(
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Play Ball~~~',
                      style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 10),
                  const Text('Press Start'),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: con.onPressed,
                        child: const Text('Start'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _GameStartState state;
  _Controller(this.state);

  void onPressed() {
    Navigator.pushNamed(state.context, GameScreen.routeName);
  }
}
