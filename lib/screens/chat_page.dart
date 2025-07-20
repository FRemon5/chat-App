import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/consts/constants.dart';
import 'package:chat_app/helpers/chat_buble.dart';
import 'package:chat_app/models/arguments_model.dart';
import 'package:chat_app/models/messages_model.dart';

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
            appBar: AppBar(
              backgroundColor: Color(0xff00081C),
              automaticallyImplyLeading: false,
              title: Image.asset('assets/images/rawa.png', height: 90),
              centerTitle: true,
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff00081C),
                    Color(0xff00174F),
                    Color(0xff002582),
                    Color(0xff0040E1),
                  ],
                ),
              ),
              child: Column(
                children: [
                  
                  Divider(thickness: 3),
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
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromRGBO(200, 200, 200, 0.2),
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
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
