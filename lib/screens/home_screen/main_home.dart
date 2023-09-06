import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/home_screen/widget/chat_section.dart';
import 'package:chat_app/screens/home_screen/widget/message.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NgeChat"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => MessageSection(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MessageBar(),
            )
          ],
        ),
      ),
    );
  }
}
