import 'package:demo_app/file_helper.dart';
import 'package:flutter/material.dart';


class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(child: const Text("Ahoi!"), onPressed: () async {
      var file = await FileHelper.getFileFromSystem();
      if (file != null) {
        FileHelper.uploadImage(file);
      }
    });
  }
}
