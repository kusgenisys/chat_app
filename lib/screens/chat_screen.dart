import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("chats/Il3lUzD4MX3rMrVEvlG7/messages")
                  .snapshots(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snap.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(documents[index]['text']),
                  ),
                );
              },
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 310,
                margin: const EdgeInsets.only(right: 10,left: 10,bottom: 10),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey.withOpacity(0.3)),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                      hintText: "Type..", border: InputBorder.none),
                ),
              ),
              InkWell(
                onTap: (){
                  FirebaseFirestore.instance.collection("chats/Il3lUzD4MX3rMrVEvlG7/messages").add({
                    'text': _textEditingController.text
                  }).then((value) => _textEditingController.clear());
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin:const EdgeInsets.only(right: 10,bottom: 10),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.send,color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
