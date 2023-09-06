import 'package:flutter/material.dart';

class MessageSection extends StatelessWidget {
  const MessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 3),
              blurRadius: 0.5)
        ],
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(right: 160, top: 20, left: 10),
      child: Stack(children: [
        Text(
          "Hello World",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        const Positioned(
          child: Text(
            "10:43",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          bottom: 0,
          right: 0,
        )
      ]),
    );
  }
}
