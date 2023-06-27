// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
Future<String> uploadImage(File image, usuario) async {
  print(image.path);
  Reference ref = storage.ref().child('$usuario').child('Registro');
  final UploadTask uploadTask = ref.putFile(image);
  print(uploadTask);

  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  final String url = await snapshot.ref.getDownloadURL();
  print(url);

  if (snapshot.state == TaskState.success) {
    return url;
  } else {
    return '';
  }
}
