import 'package:flutter/material.dart';
import 'package:tictactoe/game_button.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
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
          firstPlayer = !firstPlayer;
          cl = Colors.blue[900];
        } else {
          box.text = "O";
          box.bg = Colors.blue;
          player2.add(box.id);
          firstPlayer = !firstPlayer;
          cl = Colors.red[900];
        }
        box.enabled = false;
        int a = checkWinner();
        if (a != -1) {
          setState(() {
            gameOver=true;
          });
          showEndDialog("Player " + a.toString() + " Wins!");
        }
      }
    });
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
                Navigator.of(context).pop();
              },
              child: Text('Go Back'),
            )
          ],
        ),
      );
  int checkWinner() {
    var winner = -1;
    print(player1);
    print(player2);
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(2) &&
        player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }

    // if (winner != -1) {
    //   if (winner == 1) {
    //     showDialog(
    //         context: context,
    //         builder: (_) => new CustomDialog("Player 1 Won",
    //             "Press the reset button to start again.", resetGame));
    //   } else {
    //     showDialog(
    //         context: context,
    //         builder: (_) => new CustomDialog("Player 2 Won",
    //             "Press the reset button to start again.", resetGame));
    //   }
    // }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
      player1 = [];
      player2 = [];
      gameOver=false;
    });
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
                    // style: ElevatedButton.styleFrom(
                    //   padding: EdgeInsets.all(8),
                    //   primary:buttonsList[i].bg,
                    //   onPrimary: buttonsList[i].bg,
                    // ),
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
