import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:redbits/firebase_options.dart';
import 'package:redbits/screens/chat_page.dart';
import 'package:redbits/screens/login_page.dart';
import 'package:redbits/screens/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'login': (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
    );
  }
}
