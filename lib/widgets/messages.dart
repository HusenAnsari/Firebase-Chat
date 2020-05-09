import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapShot) {
              if (chatSnapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapShot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['userId'] == futureSnapShot.data.uid,
                    key: ValueKey(chatDocs[index].documentID)),
              );
            });
      },
    );
  }
}
