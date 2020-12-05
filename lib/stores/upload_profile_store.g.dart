// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UploadProfileStore on _UploadProfileStore, Store {
  Computed<bool> _$isFileSelectedComputed;

  @override
  bool get isFileSelected =>
      (_$isFileSelectedComputed ??= Computed<bool>(() => super.isFileSelected,
              name: '_UploadProfileStore.isFileSelected'))
          .value;

  final _$filePathAtom = Atom(name: '_UploadProfileStore.filePath');

  @override
  String get filePath {
    _$filePathAtom.reportRead();
    return super.filePath;
  }

  @override
  set filePath(String value) {
    _$filePathAtom.reportWrite(value, super.filePath, () {
      super.filePath = value;
    });
  }

  final _$fileBytesAtom = Atom(name: '_UploadProfileStore.fileBytes');

  @override
  Uint8List get fileBytes {
    _$fileBytesAtom.reportRead();
    return super.fileBytes;
  }

  @override
  set fileBytes(Uint8List value) {
    _$fileBytesAtom.reportWrite(value, super.fileBytes, () {
      super.fileBytes = value;
    });
  }

  final _$fileNameAtom = Atom(name: '_UploadProfileStore.fileName');

  @override
  String get fileName {
    _$fileNameAtom.reportRead();
    return super.fileName;
  }

  @override
  set fileName(String value) {
    _$fileNameAtom.reportWrite(value, super.fileName, () {
      super.fileName = value;
    });
  }

  final _$uploadFutureAtom = Atom(name: '_UploadProfileStore.uploadFuture');

  @override
  ObservableFuture<dynamic> get uploadFuture {
    _$uploadFutureAtom.reportRead();
    return super.uploadFuture;
  }

  @override
  set uploadFuture(ObservableFuture<dynamic> value) {
    _$uploadFutureAtom.reportWrite(value, super.uploadFuture, () {
      super.uploadFuture = value;
    });
  }

  final _$selectFileAsyncAction = AsyncAction('_UploadProfileStore.selectFile');

  @override
  Future<dynamic> selectFile() {
    return _$selectFileAsyncAction.run(() => super.selectFile());
  }

  final _$uploadImageAsyncAction =
      AsyncAction('_UploadProfileStore.uploadImage');

  @override
  Future<String> uploadImage() {
    return _$uploadImageAsyncAction.run(() => super.uploadImage());
  }

  @override
  String toString() {
    return '''
filePath: ${filePath},
fileBytes: ${fileBytes},
fileName: ${fileName},
uploadFuture: ${uploadFuture},
isFileSelected: ${isFileSelected}
    ''';
  }
}
