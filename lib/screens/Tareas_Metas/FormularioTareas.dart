import 'package:bovinapp/DTO/Tareas.dart';
import 'package:bovinapp/screens/Tareas_Metas/ListadoTareas.dart';
import 'package:bovinapp/screens/Tareas_Metas/services/TareasServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormularioTareas extends StatefulWidget {
  const FormularioTareas({Key? key}) : super(key: key);

  static const nombrePagina = 'FormularioTareas';
  @override
  _FormularioTareasState createState() => _FormularioTareasState();
}

class _FormularioTareasState extends State<FormularioTareas> {
  final idForm = GlobalKey<FormState>();
  //Map<String, dynamic>? tarea;
  Tareas objTareas = Tareas();
  bool flag = false;

  TextEditingController nombreTarea = TextEditingController();
  TextEditingController descripcionTarea = TextEditingController();
  String fechaCreacion = DateTime.now().toString();
  bool estadoTarea = true;
  //Map<String, dynamic> nuevaTarea = {};

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
    //tarea = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
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
      //initialValue: (tarea != null) ? tarea!['nombre'] : "",
      /*onSaved: (valor) {
        nuevaTarea['nombre'] = valor;
      },*/
      decoration: const InputDecoration(
        hintText: 'Nombre de la tarea',
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
        //initialValue: (tarea != null) ? tarea!['descripcion'] : "",
        /*onSaved: (valor) {
          nuevaTarea['descripcion'] = valor;
        },*/
        maxLines: null,
        decoration: const InputDecoration(
          hintText: 'Descripción de la tarea',
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
            await addTareas(nombreTarea.text, descripcionTarea.text,
                    fechaCreacion, 'andres', estadoTarea)
                .then((_) => {
                      Navigator.popAndPushNamed(
                          context, ListadoTareas.nombrePagina)
                    });

            /*nuevaTarea['estado'] = false;
          if (tarea != null) {
            Navigator.popAndPushNamed(context, ListadoTareas.nombrePagina);
          } else {
            Navigator.popAndPushNamed(context, ListadoTareas.nombrePagina);
          }*/
          },
          child: //(tarea != null)
              //?
              const Text('Editar Tarea')
          //: const Text('Crear Tarea'),
          ),
    );
  }

  /*tareasBD() async {
    try {
      CollectionReference datesBD =
          FirebaseFirestore.instance.collection('Tareas');
      QuerySnapshot tareas = await datesBD.get();

      if (tareas.docs.isNotEmpty) {
        for (var cursor in tareas.docs) {
          if (cursor.get('NombreTarea') == nombreTarea.text) {
            alert('La tarea ya existe');
            flag = false;
          }
        }
      }
      if (flag == true) {
        objTareas.nombreTarea = nombreTarea.text;
        objTareas.fechaCreacion = fechaCreacion;
        objTareas.estadoTarea = estadoTarea;
        objTareas.descripcionTarea = descripcionTarea.text;
      }
    } catch (e) {
      print('Error.....' + e.toString());
    }
  }*/
}
