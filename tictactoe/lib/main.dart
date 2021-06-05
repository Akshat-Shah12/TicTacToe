import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/game_button.dart';
import './switchScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Game_button> buttonsList;
  Color cl = Colors.black;
  bool firstPlayer = true;
  List<int> player1 = <int>[];
  List<int> player2 = <int>[];
  List<int> remaining = <int>[];

  bool gameOver = false;
  bool autoGame = false;
  bool auto;

  void parentFunction(auto) {
    setState(() {
      autoGame = auto;
      autoPlay();
    });
  }

  @override
  void initState() {
    super.initState();
    remaining = List.generate(9, (i) => i + 1);
    buttonsList = doInit();
    autoPlay();
  }

  List<Game_button> doInit() {
    var lis = [
      new Game_button(id: 1),
      new Game_button(id: 2),
      new Game_button(id: 3),
      new Game_button(id: 4),
      new Game_button(id: 5),
      new Game_button(id: 6),
      new Game_button(id: 7),
      new Game_button(id: 8),
      new Game_button(id: 9),
    ];
    return lis;
  }

  void playGame(Game_button box) {
    setState(() {
      if (!gameOver) {
        if (firstPlayer) {
          box.text = "X";
          box.bg = Colors.red;
          player1.add(box.id);
          remaining.remove(box.id);
          firstPlayer = !firstPlayer;
          cl = Colors.blue[900];
        } else {
          box.text = "O";
          box.bg = Colors.blue;
          player2.add(box.id);
          remaining.remove(box.id);
          firstPlayer = !firstPlayer;
          cl = Colors.red[900];
        }
        box.enabled = false;
        int a = checkWinner();
        if (a != -1) {
          setState(() {
            gameOver = true;
          });
          if (a == 3) {
            showEndDialog("Its a Tie");
          } else {
            showEndDialog("Player " + a.toString() + " Wins!");
          }
        } else {
          autoPlay();
        }
      }
    });
  }

  int autoPlayFirstPlayer() {
    List<List<int>> circular = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ];
    for (var i = 0; i < circular.length; i++) {
      if (player1.contains(circular[i][0]) &&
          player1.contains(circular[i][1]) &&
          remaining.contains(circular[i][2])) {
        return circular[i][2];
      }
      if (player1.contains(circular[i][1]) &&
          player1.contains(circular[i][2]) &&
          remaining.contains(circular[i][0])) {
        return circular[i][0];
      }
      if (player1.contains(circular[i][0]) &&
          player1.contains(circular[i][2]) &&
          remaining.contains(circular[i][1])) {
        return circular[i][1];
      }
    }
    return 0;
  }

  int autoPlaySecondPlayer() {
    List<List<int>> circular = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ];
    for (var i = 0; i < circular.length; i++) {
      if (player2.contains(circular[i][0]) &&
          player2.contains(circular[i][1]) &&
          remaining.contains(circular[i][2])) {
        return circular[i][2];
      }
      if (player2.contains(circular[i][1]) &&
          player2.contains(circular[i][2]) &&
          remaining.contains(circular[i][0])) {
        return circular[i][0];
      }
      if (player2.contains(circular[i][0]) &&
          player2.contains(circular[i][2]) &&
          remaining.contains(circular[i][1])) {
        return circular[i][1];
      }
    }
    return 0;
  }

  void autoPlay() {
    if (!firstPlayer && autoGame) {
      Timer(Duration(milliseconds: 400), () {
        int i = 0;
        bool foundPlace = false;
        int num2 = autoPlaySecondPlayer();
        int num1 = autoPlayFirstPlayer();
        print("ll ${num1} ${num2}");
        if (num2 != 0) {
          i = num2-1;
          foundPlace = true;
        } else if (num1 != 0) {
          i = num1-1;
          foundPlace = true;
        }

        if (!foundPlace) {
          print("ndkddd");
          var r = new Random();
          var randIndex = r.nextInt(remaining.length - 1);
          var cellID = remaining[randIndex];
          i = buttonsList.indexWhere((p) => p.id == cellID);
        }
        print("${i} kdnd");

        playGame(buttonsList[i]);
      });
    }
  }

  Future showEndDialog(String title) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text('That was a good game'),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('Go Back'),
            )
          ],
        ),
      );
  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(2) &&
        player2.contains(3)) {
      winner = 2;
    }

    // row 2
    else if (player1.contains(4) &&
        player1.contains(5) &&
        player1.contains(6)) {
      winner = 1;
    } else if (player2.contains(4) &&
        player2.contains(5) &&
        player2.contains(6)) {
      winner = 2;
    }

    // row 3
    else if (player1.contains(7) &&
        player1.contains(8) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(7) &&
        player2.contains(8) &&
        player2.contains(9)) {
      winner = 2;
    }

    // col 1
    else if (player1.contains(1) &&
        player1.contains(4) &&
        player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(4) &&
        player2.contains(7)) {
      winner = 2;
    }

    // col 2
    else if (player1.contains(2) &&
        player1.contains(5) &&
        player1.contains(8)) {
      winner = 1;
    } else if (player2.contains(2) &&
        player2.contains(5) &&
        player2.contains(8)) {
      winner = 2;
    }

    // col 3
    else if (player1.contains(3) &&
        player1.contains(6) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(3) &&
        player2.contains(6) &&
        player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    else if (player1.contains(1) &&
        player1.contains(5) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(5) &&
        player2.contains(9)) {
      winner = 2;
    } else if (player2.contains(3) &&
        player2.contains(5) &&
        player2.contains(7)) {
      winner = 2;
    } else if (player1.contains(3) &&
        player1.contains(5) &&
        player1.contains(7)) {
      winner = 1;
    } else if (remaining.isEmpty) {
      winner = 3;
    }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
      player1 = [];
      player2 = [];
      remaining = List.generate(9, (i) => i + 1);
      gameOver = false;
    });
    autoPlay();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Tic Tac Toe"),
        ),
        backgroundColor: cl,
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SwitchScreen(
              callback: parentFunction,
            ),
            SizedBox(height: 100),
            new Expanded(
              child: new GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) => new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new RaisedButton(
                    padding: EdgeInsets.all(8),
                    color: buttonsList[i].bg,
                    disabledColor: buttonsList[i].bg,
                    onPressed: buttonsList[i].enabled
                        ? () => playGame(buttonsList[i])
                        : null,
                    child: new Text(
                      buttonsList[i].text,
                      style: new TextStyle(color: Colors.white, fontSize: 40.0),
                    ),
                  ),
                ),
              ),
            ),
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.all(20),
              ),
              child: new Text(
                "Reset",
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                resetGame();
              },
            )
          ],
        ));
  }
}
