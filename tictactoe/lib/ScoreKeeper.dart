import 'package:flutter/material.dart';
class ScoreKeeper extends StatefulWidget {
  final int pl1;
  final int pl2;
  const ScoreKeeper({ Key key,this.pl1,this.pl2 }) : super(key: key);

  @override
  _ScoreKeeperState createState() => _ScoreKeeperState();
}

class _ScoreKeeperState extends State<ScoreKeeper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("${widget.pl1} : ${widget.pl2}",style: TextStyle(color: Colors.yellow,fontSize: 40),),
    );
  }
}