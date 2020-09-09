import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File image;

  void imagepicker() async {
    final pickimagefile = ImagePicker();

    final imageflie = await pickimagefile.getImage(source: ImageSource.gallery);
    final pickedfile = File(imageflie.path);
    setState(() {
      image = pickedfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,

          backgroundColor: Colors.grey,
          backgroundImage: image != null ? FileImage(image) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: imagepicker,
          icon: Icon(Icons.image),
          label: Text('Add image'),
        )
      ],
    );
  }
}
