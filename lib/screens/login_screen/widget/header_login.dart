import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  HeaderLogin({super.key});

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
          "Please enter your account bellow",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}
