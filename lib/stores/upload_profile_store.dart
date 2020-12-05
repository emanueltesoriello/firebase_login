import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_login/services/uploadProfileImage/upload_repo.dart';
import 'package:flutter/foundation.dart';

import 'package:mobx/mobx.dart';

part 'upload_profile_store.g.dart';

class UploadProfileStore = _UploadProfileStore with _$UploadProfileStore;

abstract class _UploadProfileStore with Store {
  @observable
  String filePath;
  @observable
  Uint8List fileBytes;
  @observable
  String fileName;

  @observable
  ObservableFuture uploadFuture;

  @computed
  bool get isFileSelected {
    if (fileName.isEmpty) return false;


    if (kIsWeb) {
      if (fileBytes.isEmpty) return false;
    } else {
      if (filePath.isEmpty) return false;
    }

    return true;
  }

  @action
  Future selectFile() async {
    print("waiting for file to be loaded");
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image); // image formats

    if (result != null) {
      filePath = result.files.single.path;
      fileBytes = result.files.single.bytes;
      fileName = result.files.single.name;
    } else {
      print('Canceled by user');
    }
    return;
  }

  @action
  Future<String> uploadImage() async {
    Future<String> future = uploadFile(
        fileBytes: fileBytes, fileName: fileName, filePath: filePath);
    uploadFuture = ObservableFuture(future);
    return future;
  }
}
