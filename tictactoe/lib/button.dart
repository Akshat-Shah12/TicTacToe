// import 'package:flutter/material.dart';
// import 'main.dart';
// class Button extends StatefulWidget {
//   final String text;
//   final double size;
//   final Color color;
//   final int x,y;
//   final Function clicked;
//   const Button({Key key,this.x,this.y,this.text, this.size, this.color, this.clicked}) : super(key: key);

//   @override
//   _ButtonState createState() => _ButtonState();
// }

// class _ButtonState extends State<Button> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(8),
//       child: ElevatedButton(
//         onPressed: () {
//           setState(() {
            
//           });
//         },
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(widget.size, widget.size),
//           primary: widget.color,
//         ),
//         child: Text(widget.text,
//         style: TextStyle(fontSize: 40),),
//       ),
//     );
//   }
// }
