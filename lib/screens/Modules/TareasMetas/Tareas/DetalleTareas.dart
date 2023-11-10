// ignore_for_file: file_names

import "dart:collection";
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/FormularioTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/ListadoTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/services/TareasServices.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

/// The class "DetalleTareas" is a stateful widget in Dart that represents a page for displaying
/// detailed information about tasks.
class DetalleTareas extends StatefulWidget {
  const DetalleTareas({Key? key}) : super(key: key);
  static const nombrePagina = "DetalleTareas";

  @override
  State<DetalleTareas> createState() => _DetalleTareasState();
}

/// The `_DetalleTareasState` class is a stateful widget that displays the details of a task and allows
/// the user to update or edit the task.
class _DetalleTareasState extends State<DetalleTareas> {
  /// The function updates the value of the currentIndex variable with the provided index value.
  ///
  /// Args:
  ///   index (int): The parameter "index" is an integer that represents the index of the selected tab.
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }
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

  /// This function builds a detailed view of a task in a Flutter app, including its name, description,
  /// and buttons to edit or change its status.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget. It
  /// is typically provided by the `build` method of a widget and is used to access various properties
  /// and methods related to the widget tree and the current state of the app.
  ///
  /// Returns:
  ///   The code is returning a Scaffold widget with an AppBar and a body containing a
  /// SingleChildScrollView widget. Inside the SingleChildScrollView, there is a Column widget with
  /// several children. The children include a Container with the task name, a Text widget for the
  /// description, another Container with the task description, and finally, a Row widget with two
  /// ElevatedButton widgets for updating and editing the task.
  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    LinkedHashMap<String, dynamic>? tarea = ModalRoute.of(context)
        ?.settings
        .arguments as LinkedHashMap<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Tarea'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                  height: size.width * 0.05,
                ),
            const Text(
                '👨‍🌾',
                style: TextStyle(
                  fontSize: 42,
                ),
              ),
              SizedBox(
                  height: size.width * 0.02,
                ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 40,
              ),
              child: 
              Text(
                '${tarea!['NombreTarea']}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 230, 74, 25),
                ),
              ),
            ),
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 40,
                  right: 12,
                  left: 12,
                ),
                child: Text('${tarea['DescripcionTarea']}', style: const TextStyle(fontSize: 18),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    /// The code block you provided is checking the value of the `EstadoTarea` property
                    /// of the `tarea` object. If the value is `true`, it calls the `updateTarea`
                    /// function with the parameters `false` and then navigates back to the
                    /// `ListadoTareas` page. If the value is `false`, it calls the `updateTarea`
                    /// function with the parameters `true` and then navigates back to the
                    /// `ListadoTareas` page.
                    if (await tarea['EstadoTarea'] == true) {
                      await updateTarea(
                              tarea['uid'],
                              tarea['NombreTarea'],
                              tarea['DescripcionTarea'],
                              tarea['FechaCreacion'],
                              false,
                              firebase,
                              objUser.usuario)
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
                              true,
                              firebase,
                              objUser.usuario)
                          .then((_) => {
                                Navigator.popAndPushNamed(
                                    context, ListadoTareas.nombrePagina)
                              });
                    }
                  },

                  /// The `child: (tarea['EstadoTarea']) ? const Text('Recuperar') : const
                  /// Text('Terminar')` code is a ternary operator in Dart.
                  child: (tarea['EstadoTarea'])
                      ? const Text('Recuperar')
                      : const Text('Terminar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                  ),

                  /// The `onPressed` property of the `ElevatedButton` widget is assigned a function
                  /// that is executed when the button is pressed. In this case, the function uses the
                  /// `Navigator.pushNamed` method to navigate to the `FormularioTareas` page.
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
      bottomNavigationBar: BottomBar(
            initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }
}
