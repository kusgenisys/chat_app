import 'package:chat_app/widgets/chat/newMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Chat"),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert,color: Colors.white),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app,color: Colors.black),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Logout")
                  ],
                ),
                value: "logout",
              )
            ],
            onChanged: (itemIdentifire) {
              if(itemIdentifire == 'logout'){
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Expanded(
            child: Messages()
          ),
          NewMessages()
        ],
      ),
    );
  }
}
