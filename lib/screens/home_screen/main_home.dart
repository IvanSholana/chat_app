import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/home_screen/widget/chat_section.dart';
import 'package:chat_app/screens/home_screen/widget/message.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
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
            const SizedBox(height: 10),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No message found"),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var firstUser = snapshot.data!.docs[0].data()['userID'];
                var lastUserID;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final currentUserID =
                          snapshot.data!.docs[index].data()['userID'];

                      // Cek jika pengguna berbeda dengan pengguna sebelumnya
                      if (currentUserID != lastUserID) {
                        lastUserID = currentUserID; // Simpan pengguna terakhir
                        return MessageSection(
                          data: snapshot.data!.docs[index].data(),
                          aktor: currentUserID ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? "1"
                              : "2",
                          status: "baru",
                        );
                      } else {
                        return MessageSection(
                          data: snapshot.data!.docs[index].data(),
                          aktor: currentUserID ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? "1"
                              : "2",
                          status: "lama",
                        );
                      }
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MessageBar(),
            ),
          ],
        ),
      ),
    );
  }
}
