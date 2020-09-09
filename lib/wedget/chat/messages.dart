import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_chat/wedget/chat/message_bubble.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futuresnapshot) {
        if (futuresnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdtime', descending: true)
                .snapshots(),
            builder: (ctx, chatsnapsht) {
              if (chatsnapsht.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatdoc = chatsnapsht.data.documents;

              return ListView.builder(
                reverse: true,
                itemCount: chatdoc.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatdoc[index]['text'],
                  chatdoc[index]['username'],
                  chatdoc[index]['userid'] == futuresnapshot.data.uid,
                  key: ValueKey(chatdoc[index].documentID),
                ),
              );
            });
      },
    );
  }
}
