import 'package:firebase/firebase.dart' as fb;
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

Future<String> uploadFile({
  String fileName,
  String filePath,
  Uint8List fileBytes,
}) async {
  print("web...");
  if (fileBytes == null || fileName == null) {
    print('no image is selected !!');
    return null;
  }
  String fileType = fileName.split(".").last;
  fileName =  Uuid().v1()+"."+fileType;
  fb.StorageReference ref = fb.storage().ref('/profileimages/$fileName');

  fb.UploadTaskSnapshot uploadTaskSnapshot = await ref.put(fileBytes ,).future;

  var url = (await uploadTaskSnapshot.ref.getDownloadURL()).toString();
  print(url);
  return url;
}
