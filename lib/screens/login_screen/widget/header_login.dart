// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  HeaderLogin({super.key, required this.isLogin});

  bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/login.png'),
        SizedBox(
          height: 15,
        ),
        Text(
          "Welcome",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        Text(
          isLogin
              ? "Please enter your account bellow"
              : "Please ensure to enter the correct data",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}
