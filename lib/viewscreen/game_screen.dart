import 'package:flutter/material.dart';

import '../model/bbgame_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = '/gameScreen';

  @override
  State<StatefulWidget> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  late _Controller con;
  late BBGame gameModel;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    gameModel = BBGame();
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baseball Game'),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            onPressed: con.newGame,
            child: const Text('New Game'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Key  : '),
            Text('Guess: '),
            CustomPaint(
              
            )
          ]
        ),
      ),
    );
  }
}

class _Controller {
  _GameScreenState state;
  _Controller(this.state);

  void newGame() {

  }
}
