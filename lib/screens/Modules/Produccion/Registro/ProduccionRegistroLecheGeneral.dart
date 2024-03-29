// ignore_for_file: avoid_print, unused_element, no_leading_underscores_for_local_identifiers, file_names

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// The line `const List<String> listaHorario = ['Mañana', 'Tarde'];` is declaring a constant list of
/// strings named `listaHorario`. This list contains two elements: "Mañana" and "Tarde". The `const`
/// keyword is used to indicate that the list is a compile-time constant, meaning its values cannot be
/// modified at runtime.
const List<String> listaHorario = [
  'Mañana',
  'Tarde',
];

/// The class "NuevoRegistroProduccionLeche" is a stateful widget in Dart.
class NuevoRegistroProduccionLeche extends StatefulWidget {
  const NuevoRegistroProduccionLeche({super.key});

  @override
  State<NuevoRegistroProduccionLeche> createState() =>
      _NuevoRegistroProduccionLecheState();
}

/// The `_NuevoRegistroProduccionLecheState` class is a stateful widget that allows users to register
/// daily milk production and saves the data to a Firestore database.
class _NuevoRegistroProduccionLecheState
    extends State<NuevoRegistroProduccionLeche> {
  String horario = listaHorario.first;
  TextEditingController leche = TextEditingController();

  bool bandera = true;
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

  /// The function `validarDatos()` checks if a document exists in a Firestore collection and updates it
  /// with a new field or creates a new document if it doesn't exist.
  validarDatos() async {
    try {
      DateTime now = DateTime.now();
      // Formatea la fecha en el formato "yyyy-MM-dd"
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      /// The code `DocumentReference docRef =
      /// firebase.collection('Usuarios').doc(objUser.usuario).collection('ProduccionLeche').doc(formattedDate);`
      /// is creating a reference to a specific document in the Firestore database.
      DocumentReference docRef = firebase
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('ProduccionLeche')
          .doc(formattedDate);
      docRef.get().then((docSnapshot) {
        if (docSnapshot.exists) {
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;

          // Agrega el nuevo campo a los datos actuales
          data['Leche $horario'] = ("${leche.text} litros");
          // Actualiza el documento con los nuevos datos
          docRef.update(data).then((value) {
            print('Nuevo campo guardado exitosamente');
          }).catchError((error) {
            print('Error al guardar el nuevo campo: $error');
          });
        } else {
          firebase
              .collection('Usuarios')
              .doc(objUser.usuario)
              .collection('ProduccionLeche')
              .doc(formattedDate)
              .set({
            "Leche $horario": ("${leche.text} litros"),
          });
          print('El documento no existe');
        }
      }).catchError((error) {
        print('Error al recuperar el documento: $error');
      });
    } catch (e) {
      print("error ---->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// The `_showDatePicker` function displays a date picker dialog with the current date as the initial
    /// date and a range from 2008 to the current date.
    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2008),
        lastDate: DateTime.now(),
      );
    }

    int currentIndex = 1;
    void onTabSelected(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Leche del hato'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.width * 0.06,
                  ),
                  const Text(
                    "🥛",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.06,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Leche producida en litros',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: leche,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  DropdownButton<String>(
                    value: horario,
                    icon: const Icon(Icons.arrow_downward,
                        color: Color(0xfff16437)),
                    elevation: 16,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        horario = value!;
                      });
                    },
                    items: listaHorario
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        validarDatos();
                        Navigator.pushNamed(context, 'Produccion');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0)),
                        padding: const EdgeInsets.all(0),
                        minimumSize: Size(size.width * 0.5, 50.0),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        initialIndex: currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}
