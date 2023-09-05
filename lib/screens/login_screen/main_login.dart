import 'package:flutter/material.dart';
import 'package:chat_app/screens/login_screen/widget/login_form.dart';
import 'package:chat_app/screens/login_screen/widget/header_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;

  void cekLogin() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
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
                  child: HeaderLogin(isLogin: _isLogin),
                ),
                const SizedBox(
                  height: 5,
                ),
                LoginForm(
                  isLogin: _isLogin,
                  isLoginCheck: cekLogin,
                )
              ],
            ),
          )),
    );
  }
}
