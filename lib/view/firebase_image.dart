import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseImage extends StatefulWidget {
  final String imagePath;

  const FirebaseImage(this.imagePath, {Key? key}) : super(key: key);

  @override
  State<FirebaseImage> createState() => _FirebaseImageState();
}

class _FirebaseImageState extends State<FirebaseImage> {
  String _url = '';

  @override
  void initState() {
    FirebaseStorage.instance
        .ref()
        .child(widget.imagePath)
        .getDownloadURL()
        .then((value) {
      setState(() {
        _url = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_url == '') {
      return const SizedBox();
    }

    return Image.network(_url);
  }
}
