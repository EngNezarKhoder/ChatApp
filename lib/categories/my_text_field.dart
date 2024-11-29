import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key, required this.onChanged, required this.hintText});
  final void Function(String)? onChanged;
  final String hintText;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool state = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.hintText == "Enter Your Password"? state : false,
      keyboardType: widget.hintText == "Enter Your Email" ? TextInputType.emailAddress : null,
      textAlign: TextAlign.center,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: widget.hintText == "Enter Your Password"
            ? IconButton(
                icon: const Icon(Icons.remove_red_eye_sharp),
                color: const Color.fromARGB(255, 72, 191, 247),
                onPressed: () {
                  setState(() {
                    state = !state;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 72, 191, 247)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 72, 191, 247), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 72, 191, 247), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
