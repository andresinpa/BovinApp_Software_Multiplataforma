// ignore_for_file: file_names

import "dart:collection";
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/FormularioTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/ListadoTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/services/TareasServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class DetalleTareas extends StatefulWidget {
  const DetalleTareas({Key? key}) : super(key: key);
  static const nombrePagina = "DetalleTareas";

  @override
  State<DetalleTareas> createState() => _DetalleTareasState();
}

class _DetalleTareasState extends State<DetalleTareas> {
    final firebase = FirebaseFirestore.instance;

  late User objUser;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    LinkedHashMap<String, dynamic>? tarea = ModalRoute.of(context)
        ?.settings
        .arguments as LinkedHashMap<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Tarea 📆'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 40,
              ),
              child: Text(
                '${tarea!['NombreTarea']}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 40,
                ),
                child: Text('${tarea['DescripcionTarea']}')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    if (await tarea['EstadoTarea'] == true) {
                      await updateTarea(
                              tarea['uid'],
                              tarea['NombreTarea'],
                              tarea['DescripcionTarea'],
                              tarea['FechaCreacion'],
                              false, firebase, objUser.usuario)
                          .then((_) => {
                                Navigator.popAndPushNamed(
                                    context, ListadoTareas.nombrePagina)
                              });
                    } else {
                      await updateTarea(
                              tarea['uid'],
                              tarea['NombreTarea'],
                              tarea['DescripcionTarea'],
                              tarea['FechaCreacion'],true,
                              firebase, objUser.usuario)
                          .then((_) => {
                                Navigator.popAndPushNamed(
                                    context, ListadoTareas.nombrePagina)
                              });
                    }
                  },
                  child: (tarea['EstadoTarea'])
                      ? const Text('Recuperar')
                      : const Text('Terminar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                  ),
                  onPressed: () => Navigator.pushNamed(
                      context, FormularioTareas.nombrePagina,
                      arguments: {
                        'NombreTarea': tarea['NombreTarea'],
                        'DescripcionTarea': tarea['DescripcionTarea'],
                        'FechaCreacion': tarea['FechaCreacion'],
                        'EstadoTarea': tarea['EstadoTarea'],
                        'uid': tarea['uid'],
                      }),
                  child: const Text('Editar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
