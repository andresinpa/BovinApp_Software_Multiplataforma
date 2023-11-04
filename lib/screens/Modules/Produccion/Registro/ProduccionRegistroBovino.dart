// ignore_for_file: file_names, avoid_print, no_leading_underscores_for_local_identifiers, unused_element

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

/// The class NuevoRegistroProduccionBovino is a StatefulWidget in Dart.
class NuevoRegistroProduccionBovino extends StatefulWidget {
  const NuevoRegistroProduccionBovino({super.key});

  @override
  State<NuevoRegistroProduccionBovino> createState() =>
      _NuevoRegistroProduccionBovinoState();
}

class _NuevoRegistroProduccionBovinoState
    extends State<NuevoRegistroProduccionBovino> {
  TextEditingController leche = TextEditingController();
  TextEditingController codigoBovino = TextEditingController();

  bool bandera = true;

  /// The line `final firebase = FirebaseFirestore.instance;` is creating an instance of the
  /// `FirebaseFirestore` class from the `cloud_firestore` package. This instance can be used to interact
  /// with the Firestore database in Firebase.
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

  /// The function `validarDatos()` updates a field in a document in a Firestore collection if the
  /// document exists, otherwise it prints an error message.
  validarDatos() async {
    try {
      /// The line `DocumentReference docRef =
      /// firebase.collection('Usuarios').doc(objUser.usuario).collection('InventarioBovino').doc(codigoBovino.text);`
      /// is creating a reference to a specific document in the Firestore database.
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
          data['lecheDiaria'] = leche.text;
          // Actualiza el documento con los nuevos datos
          docRef.update(data).then((value) {
            print('Nuevo campo guardado exitosamente');
          }).catchError((error) {
            print('Error al guardar el nuevo campo: $error');
          });
        } else {
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

    /// The function `_showDatePicker()` is used to display a date picker.
    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2008),
        lastDate: DateTime.now(),
      );
    }

    /// The `onTabSelected` function updates the `currentIndex` variable with the selected tab index.
    ///
    /// Args:
    ///   index (int): The `index` parameter is an integer that represents the index of the selected tab.
    int currentIndex = 1;
    void onTabSelected(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Registro diario'),
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
                    hint: 'Leche producida en litros',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: leche,
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
