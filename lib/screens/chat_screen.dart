import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text("This work"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/zIebG2EiCXXIOlFrJOdf/messages')
              // snapshots() return stream that allow as to get latest data everytime
              .snapshots()
              .listen((data) {
            print(data.documents[0]['text']);
          });
        },
      ),
    );
  }
}
