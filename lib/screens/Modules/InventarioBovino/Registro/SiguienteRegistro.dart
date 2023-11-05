// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:BovinApp/DTO/Bovino.dart';
import 'package:BovinApp/Screens/Auth/Register/ImagenUsuario.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// The above code is declaring a constant list of strings called "listaEdad" with two elements: "Meses"
/// and "Años".
const List<String> listaEdad = [
  'Meses',
  'Años',
];

/// The above code is declaring a constant list of strings called "listarazas". It contains the names of
/// different breeds of cows.
const List<String> listarazas = [
  'Holstein',
  'Normando',
  'Montbeliarde',
  'Jersey',
];

/// The class SiguienteRegistro is a StatefulWidget that takes a Bovino object as a parameter and
/// creates a state for it.
class SiguienteRegistro extends StatefulWidget {
  final Bovino cadena;
  const SiguienteRegistro(this.cadena, {super.key});

  @override
  State<SiguienteRegistro> createState() => _SiguienteRegistroState();
}

/// The `_SiguienteRegistroState` class is a stateful widget that allows the user to enter additional
/// data for a new bovine registration.
class _SiguienteRegistroState extends State<SiguienteRegistro> {
  DateTime? selectedDate;

  TextEditingController edadBovino = TextEditingController();
  TextEditingController ingreso = TextEditingController();
  TextEditingController codigoMadre = TextEditingController();
  TextEditingController codigoPadre = TextEditingController();
  TextEditingController lecheDiaria = TextEditingController();
  String edad = listaEdad.first;
  String razaMadre = listarazas.first;
  String razaPadre = listarazas.first;
  Bovino bovino = Bovino();
  dynamic uploaded;

  late User objUser;

  /// The initState function retrieves the user object from the UserProvider using the Provider package in
  /// Dart.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// The above code is importing the `FirebaseFirestore` class from the `firebase` package and creating
  /// an instance of it called `firebase`.
  final firebase = FirebaseFirestore.instance;

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

  /// The function `validarDatos()` is used to validate and save data related to a bovine animal in a
  /// Firestore database.
  validarDatos() async {
    try {
      if (widget.cadena.codigoBovino != '' ||
          widget.cadena.nombreBovino != '' ||
          widget.cadena.razaBovino != '' ||
          widget.cadena.categoriaBovino != '') {
        if (widget.cadena.imageLocal == '') {
          uploaded =
              'https://firebasestorage.googleapis.com/v0/b/bovinapp-project.appspot.com/o/BovinApp%2Favatar.png?alt=media&token=aaa46974-ff9d-471d-a10c-87b8d626a2a9';
        } else {
          uploaded = await uploadImage(
              widget.cadena.imageLocal, widget.cadena.codigoBovino);
        }

        // Obtén una referencia al documento
        CollectionReference documentReference = firebase
            .collection('Usuarios')
            .doc(objUser.usuario)
            .collection('InventarioBovino');

        await documentReference.doc(widget.cadena.codigoBovino).set({
          "NombreBovino": widget.cadena.nombreBovino,
          "CategoriaBovino": widget.cadena.categoriaBovino,
          "RazaBovino": widget.cadena.razaBovino,
          "EdadBovino": (edadBovino.text),
          "IngresoBovino": selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!).toString()
                            : ' ',
          "CodigoMadre": codigoMadre.text,
          "RazaMadre": razaMadre,
          "CodigoPadre": codigoPadre.text,
          "RazaPadre": razaPadre,
          "lecheDiaria": lecheDiaria.text,
          "CodigoBovino": widget.cadena.codigoBovino,
        });
        widget.cadena.imagenCloudStorage = uploaded;
        await DialogUnBoton.alert(
            context, 'Exitoso', 'Registro de Bovino exitoso');
      }
      print('se envio la información');
    } catch (e) {
      print("error ----->$e");
    }
  }

  /// The function `_showDatePicker` is used to display a date picker dialog and update the selected
  /// date if a new date is picked.
  /// 
  /// Args:
  ///   context (BuildContext): The context parameter is the BuildContext object that represents the
  /// current build context of the widget tree. It is used to show the date picker dialog and to access
  /// the current theme and localization information.
  Future<void> _showDatePicker(BuildContext context) async {
    final currentDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: DateTime(currentDate.year -15 ),
      lastDate: currentDate
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  /// This function builds a form for entering data about a new bovine, including age, income, mother's
  /// code and breed, father's code and breed, and daily milk production if it is a cow.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget tree.
  /// It is used to access the theme, media queries, and other contextual information.
  ///
  /// Returns:
  ///   The code is returning a Scaffold widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Nuevo Bovino'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              const Text(
                'Ingresa algunos datos más ...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff16437),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 38,
                      ),
                      TextInputFieldWidth(
                        controler: edadBovino,
                        icon: FontAwesomeIcons.cakeCandles,
                        hint: 'Edad',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.5,
                      ),
                      const SizedBox(
                        width: 55,
                      ),
                      DropdownButton<String>(
                        value: edad,
                        icon: const Icon(Icons.arrow_downward,
                            color: Color(0xfff16437)),
                        elevation: 16,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            edad = value!;
                          });
                        },
                        items: listaEdad
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 38,
                      ),
                      TextInputFieldWidth(
                        controler: ingreso,
                        icon: FontAwesomeIcons.moneyCheckDollar,
                        hint: selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : 'Ingreso a la finca',
                        inputType: TextInputType.none,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.6,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      MaterialButton(
                        onPressed: () => _showDatePicker(context),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          size: 24,
                          color: Color(0xfff16437),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  TextInputField(
                    maxLines: 1,
                    controler: codigoMadre,
                    icon: FontAwesomeIcons.key,
                    hint: 'Código de la madre',
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.cow), // Icono deseado
                      SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text(
                        'Selecciona la raza de la madre',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: razaMadre,
                          icon: const Icon(Icons.arrow_downward,
                              color: Color(0xfff16437)),
                          elevation: 16,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              razaMadre = value!;
                            });
                          },
                          items: listarazas
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  TextInputField(
                    maxLines: 1,
                    controler: codigoPadre,
                    icon: FontAwesomeIcons.key,
                    hint: 'Código del padre',
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.cow), // Icono deseado
                      SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text(
                        'Selecciona la raza del padre',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: razaPadre,
                          icon: const Icon(Icons.arrow_downward,
                              color: Color(0xfff16437)),
                          elevation: 16,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              razaPadre = value!;
                            });
                          },
                          items: listarazas
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  const Text(
                    'Si es una vaca, agregue ...',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 38,
                      ),
                      TextInputFieldWidth(
                        controler: lecheDiaria,
                        icon: FontAwesomeIcons.bottleDroplet,
                        hint: 'Leche diaria',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.5,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Text(
                        'Litros',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        validarDatos();
                        Navigator.pushNamed(context, 'InventarioBovinos');
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
