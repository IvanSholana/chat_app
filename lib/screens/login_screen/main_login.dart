import 'package:flutter/material.dart';
import 'package:chat_app/screens/login_screen/widget/login_form.dart';
import 'package:chat_app/screens/login_screen/widget/header_login.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: HeaderLogin(),
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginForm()
              ],
            ),
          )),
    );
  }
}
