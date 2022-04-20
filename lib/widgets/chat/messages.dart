import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  Future<void> futureData() async {
    FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final user = FirebaseAuth.instance.currentUser;
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("chat")
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (context, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final chatDocs = chatSnapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['userName'],
                    chatDocs[index]['imageUrl'],
                    chatDocs[index]['userId'] == user!.uid,
                    key: ValueKey(chatDocs[index].id),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
