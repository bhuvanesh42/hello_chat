import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_chat/wedget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  var _isloading = false;

  void _submitauthform(String mail, String username, String password,
      bool islogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
      setState(() {
        _isloading = true;
      });
      if (islogin) {
        authResult = await auth.signInWithEmailAndPassword(
          email: mail,
          password: password,
        );
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
          email: mail,
          password: password,
        );
        await Firestore.instance
            .collection('user')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'usermail': mail,
        });
      }
    } on PlatformException catch (err) {
      var message = 'an error occured';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isloading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Authform(_submitauthform, _isloading),
    );
  }
}
