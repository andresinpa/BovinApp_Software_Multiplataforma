import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore dbTareas = FirebaseFirestore.instance;

Future<List> getTareas() async {
  List tareas = [];
  CollectionReference collectionReferenceTareas = dbTareas.collection('Tareas');
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
    String fechaCreacion, bool estadoTarea) async {
  await dbTareas.collection('Tareas').add({
    'NombreTarea': nombreTarea,
    'DescripcionTarea': descripcionTarea,
    'FechaCreacion': fechaCreacion,
    'EstadoTarea': estadoTarea
  });
}

Future<void> updateTarea(String uid, String newName, String newDescripcion,
    String fecha, bool newEstado) async {
  await dbTareas.collection('Tareas').doc(uid).set({
    'NombreTarea': newName,
    'DescripcionTarea': newDescripcion,
    'FechaCreacion': fecha,
    'EstadoTarea': newEstado,
  });
}

Future<void> deleteTarea(String uid) async {
  await dbTareas.collection('Tareas').doc(uid).delete();
}
