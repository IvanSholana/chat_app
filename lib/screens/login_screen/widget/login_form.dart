import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key, required this.isLoginCheck, required this.isLogin});
  void Function() isLoginCheck;
  bool isLogin;

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Form(
        child: Column(children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.key),
            ),
          ),
          widget.isLogin
              ? const SizedBox(
                  height: 25,
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Confirmation Password",
                        prefixIcon: Icon(Icons.key),
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blueAccent],
                ),
              ),
              child: Text(widget.isLogin ? "Login" : "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.isLoginCheck();
                });
              },
              child: Text(widget.isLogin
                  ? "Dont have account? Register"
                  : "Have an account? Login"),
            ),
          )
        ]),
      ),
    );
  }
}
