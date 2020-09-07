import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello Chat'),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) => Container(
            padding: EdgeInsets.all(10),
            child: Text('hello chat..'),
          ),
          itemCount: 10,
        ));
  }
}
