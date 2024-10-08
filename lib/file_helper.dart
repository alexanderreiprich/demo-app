import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:demo_app/image_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';

class FileHelper {
  static Future<ImageData?> getFileFromSystem() async {
    // Initialize Image Picker and let user choose image
    final ImagePicker picker = ImagePicker();
    XFile? chosenFile = await picker.pickImage(source: ImageSource.gallery);

    // Convert image data to custom object
    if (chosenFile != null) {
      var data = await chosenFile.readAsBytes();
      var imageData = ImageData(data, chosenFile.mimeType);
      return imageData;
    }
    return null;
  }

  static Future<void> uploadImage(ImageData imageData) async {
    try {
      // Get token from user, rename image and upload
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      final result = await Amplify.Storage.uploadData(
        data: StorageDataPayload.bytes(
          imageData.data,
          contentType: imageData.mime,
        ),
        path: StoragePath.fromString('images/$token.jpg'),
      ).result;
      
      safePrint('Uploaded data: ${result.uploadedItem.path}');
    } on StorageException catch (e) {
      safePrint(e.message);
    }
  }
}
