import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/helpers/snack_bar.dart';
import 'package:chat_app/models/arguments_model.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? pass;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 85),
                child: ListView(
                  children: [
                    
                    Center(
                      child: Text(
                        'Sign up to reconnect , calmly and clearly',
                        style: TextStyle(
                          fontFamily: 'pacifico',
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    CustomTextField(labelText: 'Username', value: (data) {}),
                    CustomTextField(
                      labelText: 'Email Address',
                      value: (data) {
                        email = data;
                      },
                    ),
                    CustomTextField(
                      obscure: true,
                      labelText: 'Password',
                      value: (data) {
                        pass = data;
                      },
                    ),
                    CustomButton(
                      color: Color(0xff00081C),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await registering();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(
                              context,
                              LoginPage.id,
                              arguments: ArgumentsModel(email: email),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              // ignore: use_build_context_synchronously
                              snackBar(context, 'email exists');
                            } else if (e.code == 'weak-password') {
                              // ignore: use_build_context_synchronously
                              snackBar(context, 'weak password');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                      height: 60,
                      width: double.infinity,
                      title: 'Submit New Account',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset('assets/images/rawa.png', height: 150),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registering() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: pass!);
  }
}
