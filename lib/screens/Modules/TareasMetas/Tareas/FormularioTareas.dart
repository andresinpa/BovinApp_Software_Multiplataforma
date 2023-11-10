// ignore_for_file: library_private_types_in_public_api, file_names
import 'dart:collection';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/Tareas.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/Tareas/ListadoTareas.dart';
import 'package:BovinApp/Screens/Modules/TareasMetas/services/TareasServices.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The class "FormularioTareas" is a stateful widget in Dart used for creating a form for tasks.
class FormularioTareas extends StatefulWidget {
  const FormularioTareas({Key? key}) : super(key: key);

  static const nombrePagina = 'FormularioTareas';
  @override
  _FormularioTareasState createState() => _FormularioTareasState();
}

class _FormularioTareasState extends State<FormularioTareas> {
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// The line `final firebase = FirebaseFirestore.instance;` is creating an instance of the
  /// `FirebaseFirestore` class from the `cloud_firestore` package. This instance can be used to interact
  /// with the Firestore database in Firebase.
  final firebase = FirebaseFirestore.instance;

  late User objUser;

  /// The initState function retrieves the user object from the UserProvider using the Provider package
  /// in Dart.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// The line `final idForm = GlobalKey<FormState>();` is creating a unique key for the form widget. This
  /// key is used to identify and manipulate the state of the form. It is necessary to have a key for the
  /// form in order to perform form validation and save the form data.
  final idForm = GlobalKey<FormState>();
  Tareas objTareas = Tareas();
  TextEditingController nombreTarea = TextEditingController();
  TextEditingController descripcionTarea = TextEditingController();

  /// The line `String fechaCreacion = DateTime.now().toString();` is initializing a variable
  /// `fechaCreacion` with the current date and time in string format. It uses the `DateTime.now()`
  /// method to get the current date and time, and the `toString()` method to convert it to a string.
  /// This variable is used to display the current date and time in the UI and also to save it as the
  /// creation date of a task when creating a new task.
  String fechaCreacion = DateTime.now().toString();
  bool estadoTarea = false;

  /// The line `LinkedHashMap<String, dynamic>? tarea;` is declaring a variable named `tarea` of type
  /// `LinkedHashMap<String, dynamic>`. The `LinkedHashMap` is a collection in Dart that maintains the
  /// insertion order of its elements. The `<String, dynamic>` specifies the type of keys and values that
  /// can be stored in the `LinkedHashMap`. The `?` indicates that the variable can be nullable, meaning
  /// it can have a value of `null`.
  LinkedHashMap<String, dynamic>? tarea;

  /// The function "alert" displays an AlertDialog with a given content and an "Aceptar" button to
  /// dismiss it.
  ///
  /// Args:
  ///   contenido (String): The parameter "contenido" is a string that represents the content or message
  /// to be displayed in the alert dialog.
  ///
  /// Returns:
  ///   The `alert` function is returning an `AlertDialog` widget.
  void alert(String contenido) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(contenido),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Aceptar',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              )
            ],
          );
        });
  }

  /// This function builds a form for creating or editing tasks in a Flutter app.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is a required parameter in the `build` method of a
  /// Flutter widget. It represents the build context of the widget, which provides access to various
  /// information and services related to the widget's location in the widget tree. It is typically used
  /// to access the theme, media query,
  ///
  /// Returns:
  ///   The code is returning a Scaffold widget.

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    tarea = ModalRoute.of(context)?.settings.arguments
        as LinkedHashMap<String, dynamic>?;

    if (tarea == null) {
      nombreTarea.text = "";
      descripcionTarea.text = "";
    } else {
      nombreTarea.text = tarea!['NombreTarea'];
      descripcionTarea.text = tarea!['DescripcionTarea'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de tareas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.05,
              ),
              const Text(
                '📆',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Text(
                fechaCreacion,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Form(
                key: idForm,
                child: Column(
                  children: <Widget>[
                    _crearInputNombre(),
                    _crearInputDescripcion(),
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                    _crearBotonAgregar(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomBar(initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }

  /// The function creates a TextFormField widget with a controller and a decoration.
  ///
  /// Returns:
  ///   The method `_crearInputNombre()` is returning a `TextFormField` widget.

  _crearInputNombre() {
    return TextFormField(
      controller: nombreTarea,
      decoration: const InputDecoration(
        hintText: 'Nombre de la tarea',
        border: OutlineInputBorder(),
      ),
    );
  }

  /// The function creates an input field for entering a description of a task.
  ///
  /// Returns:
  ///   A Container widget containing a TextFormField widget.

  _crearInputDescripcion() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: TextFormField(
        controller: descripcionTarea,
        maxLines: null,
        decoration: const InputDecoration(
          hintText: 'Descripción de la tarea',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  /// This Dart function creates a button widget that either updates or adds a task based on the input
  /// provided.
  ///
  /// Args:
  ///   context (BuildContext): The `BuildContext` object represents the location in the widget tree where
  /// the button is being created. It is used to access the current theme, localization, and other
  /// contextual information.
  ///
  /// Returns:
  ///   a Container widget that contains an ElevatedButton widget.

  _crearBotonAgregar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: ElevatedButton(
        onPressed: () async {
          idForm.currentState?.save();
          if (tarea != null) {
            //print(tarea!['uid']);
            await updateTarea(
                    tarea!['uid'],
                    nombreTarea.text,
                    descripcionTarea.text,
                    tarea!['FechaCreacion'],
                    tarea!['EstadoTarea'],
                    firebase,
                    objUser.usuario)
                .then((_) => {
                      Navigator.popAndPushNamed(
                          context, ListadoTareas.nombrePagina)
                    });
          } else {
            await addTareas(nombreTarea.text, descripcionTarea.text,
                    fechaCreacion, estadoTarea, firebase, objUser.usuario)
                .then((_) => {
                      Navigator.popAndPushNamed(
                          context, ListadoTareas.nombrePagina)
                    });
          }
        },
        child: (tarea != null)
            ? const Text('Editar Tarea')
            : const Text('Crear Tarea'),
      ),
    );
  }
}
