import 'package:demo_app/file_helper.dart';
import 'package:flutter/material.dart';


class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(child: const Text("Hier klicken!"), onPressed: () async {
      var file = await FileHelper.getFileFromSystem();
      if (file != null) {
        FileHelper.uploadImage(file);
      }
    });
  }
}
