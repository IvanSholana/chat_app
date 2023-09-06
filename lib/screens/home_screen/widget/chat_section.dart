import 'package:flutter/material.dart';

class MessageBar extends StatefulWidget {
  @override
  State<MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  var _inputMassage = TextEditingController();

  @override
  void dispose() {
    _inputMassage.dispose();
    super.dispose();
  }

  void sendMassage(String value) {
    if (value.trim().isEmpty) {
      return;
    }

    // Send a Message
    _inputMassage.clear();
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
        IconButton(onPressed: () {}, icon: const Icon(Icons.send))
      ],
    );
  }
}
