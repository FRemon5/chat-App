import 'package:flutter/material.dart';
import 'package:chat_app/models/messages_model.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final MessagesModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          // padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
          decoration: BoxDecoration(
            color: Color(0xff0040E1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)
            ),
          ),
          child: Column(
            children: [
              

              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 5,
                  bottom: 5,
                  right: 5,
                ),
                child: Text(
                  message.message,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubleOfFriend extends StatelessWidget {
  const ChatBubleOfFriend({super.key, required this.message});
  final MessagesModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          // padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
          decoration: BoxDecoration(
            color: Color(0xff00081C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16)
            ),
          ),
          child: Column(
            children: [
              

              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 5,
                  bottom: 5,
                  right: 5,
                ),
                child: Text(
                  message.message,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
