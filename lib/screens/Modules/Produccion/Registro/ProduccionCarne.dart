// ignore_for_file: file_names, avoid_print, unused_element, no_leading_underscores_for_local_identifiers

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// The line `const List<String> listaEstado = ['Muerto', 'Vivo Enfermo', 'Vivo Sano'];` is declaring a
/// constant list of strings named `listaEstado`. This list contains three elements: "Muerto", "Vivo
/// Enfermo", and "Vivo Sano". This list is used as the options for a dropdown button in the `build`
/// method of the `NuevoRegistroProduccionCarne` class.
const List<String> listaEstado = [
  'Muerto',
  'Vivo Enfermo',
  'Vivo Sano',
];

/// The class "NuevoRegistroProduccionCarne" is a stateful widget in Dart.
class NuevoRegistroProduccionCarne extends StatefulWidget {
  const NuevoRegistroProduccionCarne({super.key});

  @override
  State<NuevoRegistroProduccionCarne> createState() =>
      _NuevoRegistroProduccionCarneState();
}

/// The `_NuevoRegistroProduccionCarneState` class is a stateful widget that allows users to register
/// production data for a specific cattle, including weight, observations, and selling price.
class _NuevoRegistroProduccionCarneState
    extends State<NuevoRegistroProduccionCarne> {
  TextEditingController codigoBovino = TextEditingController();
  TextEditingController pesoNacido = TextEditingController();
  TextEditingController pesoMuerto = TextEditingController();
  TextEditingController observaciones = TextEditingController();
  TextEditingController valorVendido = TextEditingController();

  String estado = listaEstado.first;

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

  /// The function `validarDatos()` validates data and performs operations on a Firestore database in
  /// Dart.
  validarDatos() async {
    try {
      DateTime now = DateTime.now();
      // Formatea la fecha en el formato "yyyy-MM-dd"
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      DocumentReference docRef = firebase
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('InventarioBovino')
          .doc(codigoBovino.text);
      docRef.get().then((docSnapshot) {
        if (docSnapshot.exists) {
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;

          // Agrega el nuevo campo a los datos actuales
          data['DatosSalidaBovino'] = [
            'Peso Nacido: ${pesoNacido.text}',
            'Peso Muerto: ${pesoMuerto.text}',
            'Observaciones: ${observaciones.text}',
            'Valor Vendido: ${valorVendido.text}',
            'Estado: $estado',
            'Fecha Registro: $formattedDate'
          ];
          firebase
              .collection('Usuarios')
              .doc(objUser.usuario)
              .collection('ProduccionCarne')
              .doc(codigoBovino.text)
              .set(data);
          print('Registro exitoso');
          docRef.delete();
          print("Documento eliminado con éxito");
        } else {}
      });
    } catch (e) {
      print("error ---->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// The function `_showDatePicker()` shows a date picker dialog with the current date as the initial
    /// date and a range from 2008 to the current date.
    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2008),
        lastDate: DateTime.now(),
      );
    }

    /// The function `onTabSelected` updates the `currentIndex` variable with the value of the `index`
    /// parameter and triggers a state update.
    ///
    /// Args:
    ///   index (int): The index parameter is an integer that represents the index of the selected tab.

    int currentIndex = 1;
    void onTabSelected(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Registro producción carne'),
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
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Codigo Bovino',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: codigoBovino,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Peso nacido en Kg',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: pesoNacido,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Peso actual o cuando murio en Kg',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: pesoMuerto,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Observaciones',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: observaciones,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  DropdownButton<String>(
                    value: estado,
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
                        estado = value!;
                      });
                    },
                    items: listaEstado
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
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Valor vendido',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: valorVendido,
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
