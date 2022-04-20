import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final TextEditingController _enterdMessage = TextEditingController();

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enterdMessage.text,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['userName'],
      'imageUrl': userData['imageUrl']
    });
    _enterdMessage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 80,
          margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueGrey.withOpacity(0.3)),
          child: TextField(
            controller: _enterdMessage,
            onChanged: (value) {
              // _enterdMessage.text = value;
            },
            decoration: const InputDecoration(
              hintText: "Type..",
              border: InputBorder.none,
            ),
          ),
        ),
        InkWell(
          onTap: _sendMessage,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(left: 5),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10, bottom: 10),
            decoration:
                const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: const Icon(Icons.send, color: Colors.white),
          ),
        )
      ],
    );
  }
}
