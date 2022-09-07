import 'dart:math';

class BBGame {
  int? X;
  int? Y;
  int? Z;
  String? guess = '0';
  String? key;
  int balls = 0;
  int strikes = 0;
  int winner = 0;

  void generateKey() {
    Random rng = Random();
    X = rng.nextInt(10);
    do {
      Y = rng.nextInt(10);
    } while(X == Y);
    do {
      Z = rng.nextInt(10);
    } while(X == Z || Y == Z);
    key = X.toString() + Y.toString() + Z.toString();
  }

  void checkGuess() {
    if(key![0] == guess![0]) strikes++;
    if(key![0] == guess![1] || key![0] == guess![2]) balls++;
    if(key![1] == guess![1]) strikes++;
    if(key![1] == guess![0] || key![1] == guess![2]) balls++;
    if(key![2] == guess![2]) strikes++;
    if(key![2] == guess![0] || key![2] == guess![1]) balls++;
  }

  void checkWinner() {
    if(strikes == 3) winner = 1;
  }
}