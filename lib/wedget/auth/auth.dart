import 'package:flutter/material.dart';
import 'package:hello_chat/wedget/picker/user_image.dart';


class Authform extends StatefulWidget {
  final bool isloading;
  final void Function(
    String mail,
    String username,
    String password,
    bool islogin,
    BuildContext ctx,
  ) submitfn;

  Authform(this.submitfn, this.isloading);

  @override
  _AuthformState createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formkey = GlobalKey<FormState>();
  var islogin = true;
  String usermail = '';
  String username = '';
  String userpass = '';
  void _submit() {
    final isvalid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isvalid) {
      _formkey.currentState.save();
      widget.submitfn(
          usermail.trim(), username.trim(), userpass.trim(), islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  if(!islogin) UserImage(),

                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'plase enter valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSaved: (value) {
                      usermail = value;
                    },
                  ),
                  if (!islogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'plase enter minimum of 4 characters to username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        username = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'plase enter at least minimum length of 7';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'password'),
                    obscureText: true,
                    onSaved: (value) {
                      userpass = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if(widget.isloading) CircularProgressIndicator(),
                  if(!widget.isloading)
                  RaisedButton(
                    onPressed: _submit,
                    child: Text(islogin ? 'Login' : 'Signup'),
                  ),
                  if(!widget.isloading)
                  FlatButton(
                    child: Text(islogin
                        ? 'Create an Account'
                        : 'aleady have an account'),
                    onPressed: () {
                      setState(() {
                        islogin = !islogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
