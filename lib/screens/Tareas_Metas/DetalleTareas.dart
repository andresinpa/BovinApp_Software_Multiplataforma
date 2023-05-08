import "dart:collection";

import "package:bovinapp/screens/Tareas_Metas/FormularioTareas.dart";
import "package:bovinapp/screens/Tareas_Metas/ListadoTareas.dart";
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
        title: const Text('Detalle'),
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
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 16,
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
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, ListadoTareas.nombrePagina);
                  },
                  child: const Text('Terminar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => Navigator.pushNamed(
                      context, FormularioTareas.nombrePagina,
                      arguments: tarea),
                  child: const Text('Editar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, ListadoTareas.nombrePagina);
                  },
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
