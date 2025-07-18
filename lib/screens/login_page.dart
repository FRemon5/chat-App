import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:redbits/helpers/snack_bar.dart';
import 'package:redbits/models/arguments_model.dart';
import 'package:redbits/screens/chat_page.dart';
import 'package:redbits/screens/register_page.dart';
import 'package:redbits/widgets/custom_button.dart';
import 'package:redbits/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? email;
  String? pass;
  String? name;
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
                padding: const EdgeInsets.only(top: 125),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        'Welcome back to Rawa',
                        style: TextStyle(
                          fontFamily: 'pacifico',
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    
                    CustomTextField(
                      labelText: 'Username',
                      value: (data) {
                        name = data;
                      },
                    ),
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
                      height: 60,
                      width: double.infinity,
                      title: 'Login',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await logining();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(
                              context,
                              ChatPage.id,
                              arguments: ArgumentsModel(
                                name: name,
                                email: email,
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-credential') {
                              // ignore: use_build_context_synchronously
                              snackBar(context, 'there was something wrong');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                    ),
                    CustomButton(
                      color: Colors.yellow,
                      height: 60,
                      width: double.infinity,
                      title: 'Create Account',
                      onTap: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don\'t have an account? ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            'Sign Up',
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
      ),
    );
  }

  Future<void> logining() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: pass!);
  }
}
