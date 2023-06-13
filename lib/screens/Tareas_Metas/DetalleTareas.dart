import "dart:collection";

import "package:bovinapp/screens/Tareas_Metas/FormularioTareas.dart";
import "package:bovinapp/screens/Tareas_Metas/ListadoTareas.dart";
import "package:bovinapp/screens/Tareas_Metas/services/TareasServices.dart";
import "package:flutter/material.dart";

class DetalleTareas extends StatelessWidget {
  const DetalleTareas({Key? key}) : super(key: key);
  static const nombrePagina = "DetalleTareas";

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
                              false)
                          .then((_) => {
                                Navigator.popAndPushNamed(
                                    context, ListadoTareas.nombrePagina)
                              });
                    } else {
                      await updateTarea(
                              tarea['uid'],
                              tarea['NombreTarea'],
                              tarea['DescripcionTarea'],
                              tarea['FechaCreacion'],
                              true)
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
