import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  final Function callback;
  SwitchScreen({Key key,this.callback}):super(key: key);
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State<SwitchScreen> {
  bool isSwitched = false;
  var textValue = 'User vs User';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        widget.callback(true);
        textValue = 'User vs Computer';
      });
      print('User vs Computer');
    } else {
      setState(() {
        isSwitched = false;
        widget.callback(false);
        textValue = 'User vs User';
      });
      print('User vs User');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: isSwitched,
            activeColor: Colors.green,
            activeTrackColor: Colors.lime,
            inactiveThumbColor: Colors.redAccent,
            inactiveTrackColor: Colors.orange,
          )),
      Text(
        '$textValue',
        style: TextStyle(fontSize: 20,
        color: Colors.white),

      )
    ]);
  }
}
