import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String image;
  final bool isMe;

  const MessageBubble(this.message, this.userName,this.image, this.isMe, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(userName),
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue.shade50 : Colors.blue.shade200,
                      // borderRadius: BorderRadius.circular(30)
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomRight: isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(12),
                        bottomLeft: !isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(12),
                      ),
                    ),
                    child: Text(message),
                  ),
                  Positioned(
                    left: !isMe ? -33 : 60,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
