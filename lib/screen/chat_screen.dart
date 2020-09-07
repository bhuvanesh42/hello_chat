import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello chat'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(10),
          child: Text('hai there'),
        ),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/Gy3GKtLCHCzKEhnWqZa2/messages')
              .snapshots()
              .listen((event) {
            print(event.documents[0]['texts']);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
