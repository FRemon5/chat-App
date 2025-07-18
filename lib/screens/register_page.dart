import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:redbits/helpers/snack_bar.dart';
import 'package:redbits/models/arguments_model.dart';
import 'package:redbits/screens/chat_page.dart';
import 'package:redbits/screens/login_page.dart';
import 'package:redbits/widgets/custom_button.dart';
import 'package:redbits/widgets/custom_text_field.dart';

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
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 85),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 190, bottom: 5),
                    child: Image.asset('assets/images/Group 1.png', height: 50),
                  ),
                  Image.asset('assets/images/REDBITS.png'),
                  SizedBox(height: 50),
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 24, fontFamily: 'pacifico'),
                  ),

                  CustomTextField(
                    labelText: 'Email',
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
                    title: 'Sign Up',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
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
