import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

Future<String> uploadFile({
  String fileName,
  String filePath,
  List<int> fileBytes,
}) async {
  print("mobile");
  if (filePath == null || fileName == null) {
    print('no image is selected !!');
    return null;
  }
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String fileType = fileName.split(".").last;
  fileName = Uuid().v1() + "." + fileType;
  await storage.ref('profileimages/' + fileName).putFile(File(filePath));
  String url = await storage.ref('profileimages/' + fileName).getDownloadURL();
  print(url);
  return url;
}
