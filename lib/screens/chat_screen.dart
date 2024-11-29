import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercourse/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

late User signinedUser; //This Give Us a user
final _firestore = FirebaseFirestore.instance;

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? messageText; //This Give Us a text of message
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signinedUser = user;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error $e");
    }
  }


  @override
  void initState() {
    getCurrentUser();
    // ignore: avoid_print
    print(signinedUser.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 72, 191, 247),
          title: const Text(
            "Message Me",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  //here logout function
                  await _auth.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                      (route) => false);
                },
                icon: const Icon(Icons.close))
          ],
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStream(),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Color.fromARGB(255, 72, 191, 247),
                          width: 1.5))),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    onChanged: (val) {
                      messageText = val;
                    },
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "Write Your Message Here ...",
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  )),
                  IconButton(
                      onPressed: () async {
                        controller.clear();
                        await _firestore.collection("messages").add({
                          "text": messageText,
                          "sender": signinedUser.email,
                          "time": FieldValue.serverTimestamp()
                        });
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 72, 191, 247),
                      ))
                ],
              ),
            )
          ],
        )));
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("messages").orderBy('time').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<MessageLine> messageWidgets = [];

        if (!snapshot.hasData) {
          // Show a progress indicator while waiting for the data
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }

        // Proceed if there is data
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final senderEmail = message.get('sender');
          final currentUseremail = signinedUser.email;
          final messageWidget = MessageLine(
            text: messageText,
            sender: senderEmail,
            isMe: currentUseremail == senderEmail,
          );
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({super.key, this.text, this.sender, required this.isMe});
  final String? text;
  final String? sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
              shape: isMe? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )) : const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
              elevation: 5,
              color: isMe? const Color.fromARGB(255, 72, 191, 247) : Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "$text",
                  style: TextStyle(fontSize: 15, color: isMe? Colors.white : Colors.black45),
                ),
              )),
        ],
      ),
    );
  }
}
