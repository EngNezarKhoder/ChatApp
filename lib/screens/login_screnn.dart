import 'package:flutter/material.dart';
import 'package:fluttercourse/categories/my_text_field.dart';
import 'package:fluttercourse/categories/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercourse/screens/chat_screen.dart';

class LoginScrenn extends StatefulWidget {
  const LoginScrenn({super.key});

  @override
  State<LoginScrenn> createState() => _LoginScrennState();
}

class _LoginScrennState extends State<LoginScrenn> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset("images/images (3).jpeg"),
                        MyTextField(
                          hintText: "Enter Your Email",
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          hintText: "Enter Your Password",
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Mybutton(
                            onPressed: () async {
                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                // ignore: unnecessary_null_comparison
                                if (user != null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatScreen()));
                                }
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                // ignore: avoid_print
                                print("Error $e");
                              }
                            },
                            color: const Color.fromARGB(255, 72, 191, 247),
                            textcolor: Colors.white,
                            title: "Sign In")
                      ],
                    ),
                  )
                ],
              ));
  }
}
