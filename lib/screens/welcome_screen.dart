import 'package:flutter/material.dart';
import 'package:fluttercourse/categories/mybutton.dart';
import 'package:fluttercourse/screens/login_screnn.dart';
import 'package:fluttercourse/screens/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [Image.asset("images/images (3).jpeg")],
              ),
              Mybutton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const LoginScrenn()));
                  },
                  color: const Color.fromARGB(255, 72, 191, 247),
                  textcolor: Colors.white,
                  title: "Sign In"),
              const SizedBox(
                height: 10,
              ),
              Mybutton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  },
                  color: const Color.fromARGB(251, 245, 245, 245),
                  textcolor: const Color.fromARGB(255, 72, 191, 247),
                  title: "Regeister")
            ],
          ),
        ));
  }
}
