// ignore_for_file: file_names

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore dbTareas = FirebaseFirestore.instance;

Future<List> getTareas(firebase, objUser) async {
  List tareas = [];
  CollectionReference collectionReferenceTareas = firebase
      .collection('Usuarios')
      .doc(objUser)
      .collection('Tareas');
  //QuerySnapshot queryTareas = await collectionReferenceTareas.get();
  QuerySnapshot queryTareas = await collectionReferenceTareas
      .orderBy('FechaCreacion', descending: true)
      .get();
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

Future<void> addTareas(String nombreTarea, String descripcionTarea,
    String fechaCreacion, bool estadoTarea, firebase, objUser) async {

  await firebase
      .collection('Usuarios')
      .doc(objUser)
      .collection('Tareas')
      .add({
        'NombreTarea': nombreTarea,
        'DescripcionTarea': descripcionTarea,
        'FechaCreacion': fechaCreacion,
        'EstadoTarea': estadoTarea
      });

}

Future<void> updateTarea(String uid, String newName, String newDescripcion,
    String fecha, bool newEstado, firebase, objUser) async {
  await firebase
      .collection('Usuarios')
      .doc(objUser)
      .collection('Tareas').doc(uid).set({
    'NombreTarea': newName,
    'DescripcionTarea': newDescripcion,
    'FechaCreacion': fecha,
    'EstadoTarea': newEstado,
  });
}

Future<void> deleteTarea(String uid, firebase, objUser) async {
  await firebase
      .collection('Usuarios')
      .doc(objUser)
      .collection('Tareas').doc(uid).delete();
}
