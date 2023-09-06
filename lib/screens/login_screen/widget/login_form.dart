// ignore_for_file: use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/login_screen/widget/add_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final formKey = GlobalKey<FormState>();
  var _password = '';
  var _email = '';
  final authFirebase = FirebaseAuth.instance;

  void _submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        if (widget.isLogin) {
          final UserCredential = await authFirebase.signInWithEmailAndPassword(
              email: _email, password: _password);
        } else {
          final dataUser =
              await Navigator.of(context).push<Map<String, dynamic>>(
            MaterialPageRoute(
              builder: (context) => AddProfile(email: _email),
            ),
          );

          if (dataUser != null) {
            final userCredential =
                await authFirebase.createUserWithEmailAndPassword(
                    email: _email, password: _password);

            final storageRef = FirebaseStorage.instance
                .ref()
                .child('user_images')
                .child('${userCredential.user!.uid}.jpg');

            await storageRef.putFile(dataUser['pickedImage']);
            final imageUrl = await storageRef.getDownloadURL();

            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
              'firstName': dataUser['firstName'],
              'lastName': dataUser['lalstName'],
              'phoneNumber': dataUser['phoneNumber'],
              "gender": dataUser['gender'],
              "dateBirth": dataUser['dateBirth'],
              "email": _email,
              "image_url": imageUrl
            });
          }
        }
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.code),
          ),
        );
      }
    } else {
      return;
    }
  }

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
        key: formKey,
        child: Column(children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@')) {
                return 'Invalid Email! Please enter a email address';
              }
              return null;
            },
            onSaved: (newValue) => _email = newValue!,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) => _password = value,
            maxLength: 20,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.key),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 10) {
                return 'Password must be at least 10 characters long!';
              }
              return null;
            },
            onSaved: (newValue) {
              _password = newValue!;
            },
          ),
          widget.isLogin
              ? const SizedBox(
                  height: 25,
                )
              : Column(
                  children: [
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Confirmation Password",
                        prefixIcon: Icon(Icons.key),
                      ),
                      validator: (value) {
                        if (value != _password) {
                          return 'Password not mathed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
          InkWell(
            onTap: () {
              _submit();
            },
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
              child: Text(
                widget.isLogin ? "Login" : "Sign Up",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
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
