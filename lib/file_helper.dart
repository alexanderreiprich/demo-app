import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:demo_app/image_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FileHelper {
  static Future<ImageData?> getFileFromSystem() async {
    final ImagePicker picker = ImagePicker();

    XFile? chosenFile = await picker.pickImage(source: ImageSource.gallery);

    if (chosenFile != null && chosenFile.mimeType != null) {
      var data = await chosenFile.readAsBytes();
      var imageData = ImageData(data, chosenFile.mimeType!);
      return imageData;
    }
    return null;
  }

  static Future<void> uploadImage(ImageData imageData) async {
    try {
      const uuid = Uuid();
      final result = await Amplify.Storage.uploadData(
        data: StorageDataPayload.bytes(
          imageData.data,
          contentType: imageData.mime,
        ),
        path: StoragePath.fromString('images/${uuid.v1()}.jpg'),
      ).result;
      
      safePrint('Uploaded data: ${result.uploadedItem.path}');
    } on StorageException catch (e) {
      safePrint(e.message);
    }
  }
}
