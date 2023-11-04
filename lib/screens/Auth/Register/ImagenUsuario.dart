// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

/// The line `final FirebaseStorage storage = FirebaseStorage.instance;` is creating an instance of the
/// FirebaseStorage class and assigning it to the variable `storage`. This instance can be used to
/// interact with the Firebase Storage service.
final FirebaseStorage storage = FirebaseStorage.instance;

/// The function `uploadImage` takes a file and a user as input, uploads the file to Firebase Storage,
/// and returns the download URL of the uploaded image.
///
/// Args:
///   image (File): The "image" parameter is of type File and represents the image file that needs to be
/// uploaded.
///   usuario: The "usuario" parameter is a variable that represents the user's username or ID. It is
/// used to create a specific folder structure in the Firebase Storage where the image will be uploaded.
///
/// Returns:
///   a `Future<String>`.
Future<String> uploadImage(File image, usuario) async {
  print(image.path);
  Reference ref =
      storage.ref().child('BovinApp').child('$usuario').child('Registro');
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
