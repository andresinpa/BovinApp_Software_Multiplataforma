// ignore_for_file: file_names

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

/// `FirebaseFirestore dbTareas = FirebaseFirestore.instance;` is creating an instance of the
/// `FirebaseFirestore` class and assigning it to the variable `dbTareas`. This instance is used to
/// interact with the Cloud Firestore database.
FirebaseFirestore dbTareas = FirebaseFirestore.instance;

/// The function `getTareas` retrieves a list of tasks from a Firebase collection for a specific user,
/// ordered by creation date.
///
/// Args:
///   firebase: The "firebase" parameter is a reference to the Firebase instance that you are using in
/// your application. It is used to access the Firestore database.
///   objUser: The `objUser` parameter is an object that represents the user for whom we want to
/// retrieve the tasks. It could be the user's ID, username, or any other identifier that uniquely
/// identifies the user in the Firebase database.
///
/// Returns:
///   The function `getTareas` returns a `Future<List>` object.
Future<List> getTareas(firebase, objUser) async {
  List tareas = [];
  CollectionReference collectionReferenceTareas =
      firebase.collection('Usuarios').doc(objUser).collection('Tareas');
  //QuerySnapshot queryTareas = await collectionReferenceTareas.get();
  QuerySnapshot queryTareas = await collectionReferenceTareas
      .orderBy('FechaCreacion', descending: true)
      .get();

  /// The code block `for (var documento in queryTareas.docs) { ... }` is iterating over each document
  /// in the `queryTareas` snapshot, which represents the result of the Firestore query.
  for (var documento in queryTareas.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final informacionTarea = {
      'NombreTarea': data['NombreTarea'],
      'DescripcionTarea': data['DescripcionTarea'],
      'EstadoTarea': data['EstadoTarea'],
      'FechaCreacion': data['FechaCreacion'],
      'uid': documento.id,
    };
    tareas.add(informacionTarea);
  }
  return tareas;
}

/// The function adds a new task to a user's collection in Firebase Firestore.
///
/// Args:
///   nombreTarea (String): The name of the task.
///   descripcionTarea (String): The parameter "descripcionTarea" is a string that represents the
/// description of the task. It provides additional information about the task that needs to be done.
///   fechaCreacion (String): The parameter "fechaCreacion" is a string that represents the date and
/// time when the task was created.
///   estadoTarea (bool): The parameter "estadoTarea" is a boolean value that represents the state of
/// the task. It indicates whether the task is completed or not.
///   firebase: The `firebase` parameter is an instance of the Firebase Firestore database. It is used
/// to interact with the database and perform operations such as adding data.
///   objUser: The objUser parameter is the user object or user ID that identifies the user for whom the
/// task is being added.
Future<void> addTareas(String nombreTarea, String descripcionTarea,
    String fechaCreacion, bool estadoTarea, firebase, objUser) async {
  /// The code `await firebase.collection('Usuarios').doc(objUser).collection('Tareas').add({...})` is
  /// adding a new document to the "Tareas" subcollection under a specific user document in the Firestore
  /// database.
  await firebase.collection('Usuarios').doc(objUser).collection('Tareas').add({
    'NombreTarea': nombreTarea,
    'DescripcionTarea': descripcionTarea,
    'FechaCreacion': fechaCreacion,
    'EstadoTarea': estadoTarea
  });
}

/// The function updates a task in a Firestore database with new name, description, date, and status.
///
/// Args:
///   uid (String): The unique identifier of the task that needs to be updated.
///   newName (String): The new name for the task.
///   newDescripcion (String): The new description for the task.
///   fecha (String): The parameter "fecha" represents the date of the task creation.
///   newEstado (bool): The newEstado parameter is a boolean value that represents the updated state of
/// the task. It indicates whether the task is completed (true) or not completed (false).
///   firebase: The firebase parameter is an instance of the Firebase Firestore database. It is used to
/// access and manipulate data in the database.
///   objUser: The `objUser` parameter is the user object that represents the current user. It is used
/// to identify the user in the Firebase database and update their task.
Future<void> updateTarea(String uid, String newName, String newDescripcion,
    String fecha, bool newEstado, firebase, objUser) async {
  await firebase
      .collection('Usuarios')
      .doc(objUser)
      .collection('Tareas')
      .doc(uid)
      .set({
    'NombreTarea': newName,
    'DescripcionTarea': newDescripcion,
    'FechaCreacion': fecha,
    'EstadoTarea': newEstado,
  });
}

/// The function `deleteTarea` deletes a document with a specific UID from a subcollection called
/// "Tareas" under a user document in a Firestore database.
///
/// Args:
///   uid (String): The unique identifier of the task that needs to be deleted.
///   firebase: The "firebase" parameter is likely an instance of the Firebase Firestore database. It is
/// used to interact with the database and perform operations such as deleting a document.
///   objUser: The `objUser` parameter is the user object that represents the user whose task needs to
/// be deleted. It is used to identify the specific user's collection of tasks in the Firebase database.
Future<void> deleteTarea(String uid, firebase, objUser) async {
  await firebase
      .collection('Usuarios')
      .doc(objUser)
      .collection('Tareas')
      .doc(uid)
      .delete();
}
