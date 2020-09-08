import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_chat/wedget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;

  void _submitauthform(String mail, String username, String password,
      bool islogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
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
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Authform(_submitauthform),
    );
  }
}
