// ignore_for_file: file_names

import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/DetalleTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/FormularioTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/services/TareasServices.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The class ListadoTareas is a StatefulWidget in Dart that represents a list of tasks.
class ListadoTareas extends StatefulWidget {
  const ListadoTareas({super.key});

  /// In the code snippet provided, `nombrePagina` is a static constant variable that stores the name of
  /// the page/screen "ListadoTareas". It is used as a reference to navigate to this screen using
  /// `Navigator.pushNamed()`.
  static const nombrePagina = "ListadoTareas";
  static final List<Map<String, dynamic>> tareas = [];

  @override
  State<ListadoTareas> createState() => _ListadoTareasState();
}

/// The `_ListadoTareasState` class is a stateful widget that displays a list of tasks fetched from a
/// Firestore database and allows the user to delete tasks and navigate to a task detail screen.
class _ListadoTareasState extends State<ListadoTareas> {
  /// The line `final firebase = FirebaseFirestore.instance;` is creating an instance of the
  /// `FirebaseFirestore` class from the `cloud_firestore` package. This instance is stored in the
  /// variable `firebase` and can be used to interact with the Firestore database.

  /// In the given code snippet, `final firebase = FirebaseFirestore.instance;` is creating an instance of
  /// the `FirebaseFirestore` class from the `cloud_firestore` package. This instance is stored in the
  /// variable `firebase` and can be used to interact with the Firestore database.
  final firebase = FirebaseFirestore.instance;

  late User objUser;

  /// The initState function retrieves the user object from the UserProvider using the Provider package in
  /// Dart.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// The function `onTabSelected` updates the `currentIndex` variable with the provided `index` value.
  ///
  /// Args:
  ///   index (int): The index parameter is the new index of the selected tab.
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// This function builds a screen with a list of tasks fetched from Firebase, allowing the user to
  /// delete tasks by swiping them and confirming the deletion, and navigate to a task detail screen by
  /// tapping on a task.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter is the BuildContext object, which represents the
  /// location in the widget tree where the widget is being built. It is typically used to access the
  /// theme, media query, and other properties of the current build context.
  ///
  /// Returns:
  ///   The code is returning a Scaffold widget with an AppBar, a body that includes a FutureBuilder, a
  /// floating action button, and a bottom navigation bar. The body of the FutureBuilder is a Column
  /// widget that contains a SizedBox, an Image, and a ListView.builder. The ListView.builder is used to
  /// display a list of tasks, and each task is wrapped in a Dismissible widget.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas 📋'),
      ),
      body: FutureBuilder(
        future: getTareas(firebase, objUser.usuario),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else if (snapshot.hasData) {
            final tareas = (snapshot.data as List<dynamic>);
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                            await deleteTarea(
                                tarea['uid'], firebase, objUser.usuario);
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
                            /// The `onTap` property in the `ListTile` widget is used to define an
                            /// action when the user taps on the tile. In this case, when the user taps
                            /// on a task in the list, it will navigate to the `DetalleTareas` screen
                            /// using `Navigator.pushNamed`.
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

      /// The `floatingActionButton` property in the `Scaffold` widget is used to define a floating
      /// action button that appears at the bottom right corner of the screen.
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
