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
  var formKey = GlobalKey<FormState>();
  late BBGame gameModel;
  final Map<int, Widget> images = {
    1: Image.asset('images/blue_circle.png'),
    2: Image.asset('images/blue_orb.png'),
    3: Image.asset('images/red_circle.png'),
    4: Image.asset('images/red_orb.png'),
  };
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    gameModel = BBGame();
    gameModel.generateKey();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (gameModel.winner == 1)
              Stack(
                children: [
                  Card(
                    color: Colors.blue[200],
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Strike Out~~~',
                              style: Theme.of(context).textTheme.headline5),
                          const SizedBox(height: 10),
                          const Text('Press OK for new game'),
                          const SizedBox(height: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: con.newGame,
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            Text(
              'Key  : ${gameModel.key}',
              style: const TextStyle(
                fontFamily: 'CourierPrime',
                fontSize: 30.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Guess: ${gameModel.guess}',
              style: const TextStyle(
                fontFamily: 'CourierPrime',
                fontSize: 30.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Balls: '),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (int n = 0; n < 3; n++) con.displayBalls()],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Strikes: '),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (int n = 0; n < 3; n++) con.displayStrikes()],
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Guess',
                    ),
                    keyboardType: gameModel.winner == 0 ? TextInputType.number : null,
                    autocorrect: false,
                    readOnly: gameModel.winner == 0 ? false : true,
                    validator: gameModel.winner == 0 ? con.validateGuess : null,
                    onSaved: gameModel.winner == 0 ? con.saveGuess : null,
                  ),
                  ElevatedButton(
                    onPressed: gameModel.winner == 0 ? con.submit : null,
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Controller {
  _GameScreenState state;
  _Controller(this.state);
  String? guess = '0';

  void newGame() {
    state.render(() {
      state.gameModel = BBGame();
      state.gameModel.generateKey();
    });
  }

  Icon displayBalls() {
    if (state.gameModel.balls != 0) {
      state.gameModel.balls--;
      return const Icon(
        Icons.brightness_1,
        color: Colors.blue,
        size: 70,
      );
    } else {
      return const Icon(
        Icons.brightness_1_outlined,
        color: Colors.blue,
        size: 70,
      );
    }
  }

  Icon displayStrikes() {
    if (state.gameModel.strikes != 0) {
      state.gameModel.strikes--;
      return const Icon(
        Icons.brightness_1,
        color: Colors.red,
        size: 70,
      );
    } else {
      return const Icon(
        Icons.brightness_1_outlined,
        color: Colors.red,
        size: 70,
      );
    }
  }

  void saveGuess(String? value) {
    guess = value;
  }

  String? validateGuess(String? value) {
    if (value!.length < 3) return 'Not enough digits!';
    if (value.length > 3) return 'Too many digits!';
    if (value[0] == value[1] || value[2] == value[1] || value[0] == value[2])
      return 'Digits must be different!';
    for (int n = 0; n < value.length; n++) {
      if (value.codeUnitAt(n) < 48 || value.codeUnitAt(n) > 57)
        return 'Use only numbers!';
    }
    return null;
  }

  void submit() {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;
    currentState.save();
    FocusManager.instance.primaryFocus?.unfocus();
    state.render(() {
      state.gameModel.guess = guess;
      state.gameModel.checkGuess();
      state.gameModel.checkWinner();
    });
  }
}
