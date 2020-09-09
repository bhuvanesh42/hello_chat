import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final controller = new TextEditingController();
  var _entermessage = '';
  void _sendssage() async {
    FocusScope.of(context).unfocus();
    final cid =  await FirebaseAuth.instance.currentUser();
    final userdata = await Firestore.instance.collection('user').document(cid.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _entermessage,
      'createdtime': Timestamp.now(),
      'userid' : cid.uid,
      'username' : userdata['username'],
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Send a message'),
              onChanged: (value) {
                setState(() {
                  _entermessage = value;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _entermessage.trim().isEmpty ? null : _sendssage)
        ],
      ),
    );
  }
}
