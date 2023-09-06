// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'dart:io';

class MessageSection extends StatelessWidget {
  MessageSection(
      {super.key,
      required this.data,
      required this.aktor,
      required this.status});

  String aktor;
  final data;
  final status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          aktor != "1" && status == "baru"
              ? Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['image_url']),
                  ))
              : const SizedBox(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: aktor != "1"
                      ? const EdgeInsets.only(left: 10)
                      : const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: aktor == "1"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: status == "baru"
                        ? Text(
                            data['username'],
                          )
                        : const SizedBox(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 3),
                          blurRadius: 0.5)
                    ],
                    color: aktor == "1" ? Colors.blueAccent : Colors.purple,
                    borderRadius: aktor == "1"
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))
                        : const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(13),
                  margin: aktor == "1"
                      ? status == "baru"
                          ? const EdgeInsets.only(left: 160, right: 10, top: 5)
                          : const EdgeInsets.only(left: 90, right: 55, top: 5)
                      : status == "baru"
                          ? const EdgeInsets.only(left: 10, right: 160, top: 5)
                          : const EdgeInsets.only(left: 55, right: 90, top: 5),
                  child: Stack(children: [
                    Text(
                      data['text'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        '${data['createdAt'].toDate().hour.toString()}:${data['createdAt'].toDate().minute.toString()}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
          aktor == "1" && status == "baru"
              ? Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['image_url']),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
