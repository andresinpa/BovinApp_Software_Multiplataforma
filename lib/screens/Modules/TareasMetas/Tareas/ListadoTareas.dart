import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/DetalleTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/FormularioTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/services/TareasServices.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';

class ListadoTareas extends StatefulWidget {
  const ListadoTareas({super.key});

  static const nombrePagina = "ListadoTareas";
  static final List<Map<String, dynamic>> tareas = [];

  @override
  State<ListadoTareas> createState() => _ListadoTareasState();
}

class _ListadoTareasState extends State<ListadoTareas> {
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas 📋'),
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset('assets/images/tareas/tareas.png',
                      fit: BoxFit.contain),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = tareas[index];
                        return Dismissible(
                          onDismissed: (direction) async {
                            await deleteTarea(tarea['uid']);
                            tareas.remove(index);
                          },
                          confirmDismiss: (direction) async {
                            bool result = false;

                            result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "¿Estás seguro de eliminar la tarea?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            return Navigator.pop(
                                              context,
                                              false,
                                            );
                                          },
                                          child: const Text(
                                            "Cancelar",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 150, 15, 15)),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            return Navigator.pop(
                                              context,
                                              true,
                                            );
                                          },
                                          child: const Text("Eliminar")),
                                    ],
                                  );
                                });
                            return result;
                          },
                          key: Key(tarea['uid']),
                          background: Container(
                            color: Colors.blueAccent,
                            child: const Icon(Icons.delete),
                          ),
                          direction: DismissDirection.startToEnd,
                          child: ListTile(
                            onTap: () => Navigator.pushNamed(
                                context, DetalleTareas.nombrePagina,
                                arguments: {
                                  'NombreTarea': tarea['NombreTarea'],
                                  'DescripcionTarea': tarea['DescripcionTarea'],
                                  'FechaCreacion': tarea['FechaCreacion'],
                                  'EstadoTarea': tarea['EstadoTarea'],
                                  'uid': tarea['uid'],
                                }),
                            title: Text(
                              '${tarea['NombreTarea']}',
                              style: TextStyle(
                                color: tarea['EstadoTarea']
                                    ? const Color.fromARGB(255, 204, 35, 23)
                                    : Colors.black,
                              ),
                            ),
                            trailing: (tarea['EstadoTarea'])
                                ? const Icon(
                                    Icons.star,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.star_border),
                          ),
                        );
                      }),
                ),
              ],
            );
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
        backgroundColor: const Color.fromARGB(255, 3, 116, 27),
        focusColor: const Color.fromARGB(255, 11, 151, 70),
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar:
          BottomBar(initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }
}
