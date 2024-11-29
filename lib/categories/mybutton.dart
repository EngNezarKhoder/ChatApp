import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  const Mybutton({
    super.key, required this.onPressed, required this.color, required this.textcolor, required this.title,
  });
  final void Function()? onPressed;
  final Color color;
  final Color textcolor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialButton(
        height: 42,
        onPressed: onPressed,
        color: color,
        textColor: textcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(title),
      ),
    );
  }
}


// const Color.fromARGB(255, 72, 191, 247)