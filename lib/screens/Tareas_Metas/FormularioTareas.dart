// ignore_for_file: library_private_types_in_public_api
import 'dart:collection';
import 'package:BovinApp/DTO/Tareas.dart';
import 'package:BovinApp/Screens/Tareas_Metas/ListadoTareas.dart';
import 'package:BovinApp/Screens/Tareas_Metas/services/TareasServices.dart';
import 'package:flutter/material.dart';

class FormularioTareas extends StatefulWidget {
  const FormularioTareas({Key? key}) : super(key: key);

  static const nombrePagina = 'FormularioTareas';
  @override
  _FormularioTareasState createState() => _FormularioTareasState();
}

class _FormularioTareasState extends State<FormularioTareas> {
  final idForm = GlobalKey<FormState>();
  Tareas objTareas = Tareas();
  TextEditingController nombreTarea = TextEditingController();
  TextEditingController descripcionTarea = TextEditingController();
  String fechaCreacion = DateTime.now().toString();
  bool estadoTarea = false;
  LinkedHashMap<String, dynamic>? tarea;

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

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Formulario de tareas 📝'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(fechaCreacion),
              Form(
                key: idForm,
                child: Column(
                  children: <Widget>[
                    _crearInputNombre(),
                    _crearInputDescripcion(),
                    _crearBotonAgregar(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _crearInputNombre() {
    return TextFormField(
      controller: nombreTarea,
      decoration: const InputDecoration(
        hintText: 'Nombre de la tarea',
        border: OutlineInputBorder(),
      ),
    );
  }

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
                    tarea!['EstadoTarea'])
                .then((_) => {
                      Navigator.popAndPushNamed(
                          context, ListadoTareas.nombrePagina)
                    });
          } else {
            await addTareas(nombreTarea.text, descripcionTarea.text,
                    fechaCreacion, estadoTarea)
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
