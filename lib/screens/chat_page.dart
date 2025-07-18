import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbits/consts/constants.dart';
import 'package:redbits/helpers/chat_buble.dart';
import 'package:redbits/models/arguments_model.dart';
import 'package:redbits/models/messages_model.dart';

// ignore: must_be_immutable

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final TextEditingController controller = TextEditingController();
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollection,
  );
  final ScrollController _controller = ScrollController();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArgumentsModel;

    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .where(
            'createdAt',
            isNotEqualTo: null,
          ) // ✅ فلترة الرسائل الغير مكتملة
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessagesModel> messagesList = snapshot.data!.docs
              .map((doc) => MessagesModel.fromJson(doc))
              .toList();

          return Scaffold(
            backgroundColor: Color(0xFFE0E0E0),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text('Chat'),
              backgroundColor: Colors.white,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final message = messagesList[index];
                      if (message.id == args.email) {
                        return ChatBuble(message: message);
                      } else {
                        return ChatBubleOfFriend(message: message);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                    ),

                    child: TextField(
                    
                      controller: controller,
                      onSubmitted: (data) async {
                        if (data.trim().isEmpty) return;

                        await messages.add({
                          'message': data.trim(),
                          'createdAt':
                              FieldValue.serverTimestamp(), // ✅ التوقيت من السيرفر
                          'id': args.email,
                          'name': args.name,
                        });
                    
                        controller.clear();
                        _controller.animateTo(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      decoration: InputDecoration(
                        
                        hint: Text(
                          'Send a message...',
                          style: TextStyle(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (controller.text.trim().isEmpty) return;

                            await messages.add({
                              'message': controller.text.trim(),
                              'createdAt':
                                  FieldValue.serverTimestamp(), // ✅ التوقيت من السيرفر
                              'id': args.email,
                              'name': args.name,
                            });
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                          icon: Icon(Icons.send),
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(32),
                        ),
                        enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong.'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
