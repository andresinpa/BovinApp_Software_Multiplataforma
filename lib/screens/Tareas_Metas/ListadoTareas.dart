import 'package:bovinapp/screens/Tareas_Metas/DetalleTareas.dart';
import 'package:flutter/material.dart';
import 'package:bovinapp/screens/Tareas_Metas/services/TareasServices.dart';
import 'package:bovinapp/screens/Tareas_Metas/FormularioTareas.dart';

class ListadoTareas extends StatefulWidget {
  const ListadoTareas({Key? key});

  static const nombrePagina = "ListadoTareas";
  static final List<Map<String, dynamic>> tareas = [];

  @override
  State<ListadoTareas> createState() => _ListadoTareasState();
}

class _ListadoTareasState extends State<ListadoTareas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      body: FutureBuilder(
        future: getTareas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else if (snapshot.hasData) {
            final tareas = (snapshot.data as List<dynamic>);
            return ListView.builder(
                itemCount: tareas.length,
                itemBuilder: (context, index) {
                  final tarea = tareas[index];
                  return ListTile(
                    onTap: () => Navigator.pushNamed(
                        context, DetalleTareas.nombrePagina,
                        arguments: tarea),
                    title: Text('${tarea['NombreTarea']}'),
                    trailing: (tarea['EstadoTarea'])
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border),
                  );
                });
          } else {
            return const Center(child: Text('No hay datos disponibles'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.popAndPushNamed(
              context, FormularioTareas.nombrePagina);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
