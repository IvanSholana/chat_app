import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBar extends StatefulWidget {
  @override
  State<MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  final _inputMassage = TextEditingController();

  @override
  void dispose() {
    _inputMassage.dispose();
    super.dispose();
  }

  void sendMassage(String value) async {
    if (value.trim().isEmpty) {
      return;
    }
    final message = _inputMassage.text;
    FocusScope.of(context).unfocus();
    _inputMassage.clear();
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    await FirebaseFirestore.instance.collection('chat').add({
      "text": message,
      "createdAt": Timestamp.now(),
      'userID': user.uid,
      'username':
          '${userData.data()!['firstName']} ${userData.data()!['lastName']}',
      'image_url': userData.data()!['image_url']
    });
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _inputMassage,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: "Send Message...",
                filled: true,
                fillColor: Colors.white),
          ),
        ),
        IconButton(
            onPressed: () {
              sendMassage(_inputMassage.text);
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}
