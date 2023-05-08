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
    tareas.add(documento.data());
  }
  return tareas;
}

Future<void> addTareas(String nombreTarea, String descripcionTarea,
    String fechaCreacion, String usuario, bool estadoTarea) async {
  await dbTareas.collection('Tareas').add({
    'NombreTarea': nombreTarea,
    'DescripcionTarea': descripcionTarea,
    'FechaCreacion': fechaCreacion,
    'Usuario': usuario,
    'EstadoTarea': estadoTarea
  });
}
