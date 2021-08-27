import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wibu_chat_app/constants.dart';

User? loggedInUser;
final _firestore = FirebaseFirestore.instance.collection('ShinoAki');

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController searchTextController = TextEditingController();
  String mess = '';
  @override
  void initState() {
    getCurUser();
    super.initState();
  }

  void getCurUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Messages',
            style: kMainText,
          ),
          leading: CircleAvatar(
            child: Image.asset('assets/avatar.png'),
            minRadius: 35,
            backgroundColor: Colors.transparent,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              margin: const EdgeInsets.symmetric(horizontal: kPadding),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: kPadding),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamMessage(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: kPadding),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        mess = value;
                      },
                      controller: searchTextController,
                      decoration: InputDecoration(
                        hintText: 'Say something to ShinoAki',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      searchTextController.clear();
                      _firestore.add({
                        'sender': loggedInUser?.email ?? 'null',
                        'message': mess,
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamMessage extends StatelessWidget {
  const StreamMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: Colors.grey,
            );
          }
          return Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                reverse: true,
                children: snapshot.data!.docs.reversed
                    .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: loggedInUser?.email == data['sender']
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          data['sender'],
                          style: TextStyle(
                            color: loggedInUser?.email == data['sender']
                                ? Colors.black54
                                : Colors.orange[700],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          borderRadius: loggedInUser?.email == data['sender']
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0))
                              : BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                          color: loggedInUser?.email == data['sender']
                              ? Colors.black54
                              : Colors.orangeAccent,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              data['message'],
                              style: kLoginText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
