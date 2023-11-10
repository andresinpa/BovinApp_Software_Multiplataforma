// ignore_for_file: file_names, avoid_print

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:BovinApp/DTO/Bovino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';

/// The line `const List<String> listaEdad = ['Meses', 'Años'];` is declaring a constant list of strings
/// named `listaEdad`. This list contains two elements: "Meses" and "Años".
const List<String> listaEdad = [
  'Meses',
  'Años',
];

/// The line `const List<String> list2 = ['Vacas', 'Toros', 'Terneros', 'Novillas', 'Bueyes'];` is
/// declaring a constant list of strings named `list2`. This list contains five elements: "Vacas",
/// "Toros", "Terneros", "Novillas", and "Bueyes".
const List<String> list2 = [
  'Vacas',
  'Toros',
  'Terneros',
  'Novillas',
  'Bueyes',
];

/// The class FichasIndividualesResultados is a StatefulWidget that takes a Bovino object as a parameter
/// and creates a state for managing its individual results.
class FichasIndividualesResultados extends StatefulWidget {
  final Bovino cadena;

  const FichasIndividualesResultados(this.cadena, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FichasIndividualesResultadosState createState() =>
      _FichasIndividualesResultadosState();
}

/// The `_FichasIndividualesResultadosState` class is a stateful widget that displays and updates
/// information about an individual bovine.
class _FichasIndividualesResultadosState
    extends State<FichasIndividualesResultados> {
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

  String clasificacionBovino = 'Vaca';
  String edad = 'Meses';
  TextEditingController edadBovino = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  late User objUser;

  /// The initState function initializes the state of the widget by assigning values to variables and
  /// retrieving user information from a provider.
  @override
  void initState() {
    super.initState();
    clasificacionBovino = widget.cadena.categoriaBovino;
    edadBovino.text = widget.cadena.edadBovino;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// The function `validarDatos()` validates data and saves it to a Firestore database if all required
  /// fields are not empty.
  validarDatos() async {
    try {
      if (widget.cadena.codigoBovino != '' ||
          widget.cadena.nombreBovino != '' ||
          widget.cadena.razaBovino != '' ||
          widget.cadena.categoriaBovino != '') {
        // Obtén una referencia al documento
        /// The above code is creating a reference to a collection in a Firestore database. It is accessing the
        /// "Usuarios" collection, then accessing a specific document based on the "usuario" field of the
        /// "objUser" object, and finally accessing the "InventarioBovino" subcollection within that document.
        CollectionReference documentReference = firebase
            .collection('Usuarios')
            .doc(objUser.usuario)
            .collection('InventarioBovino');

        await documentReference.doc(widget.cadena.codigoBovino).set({
          "NombreBovino": widget.cadena.nombreBovino,
          "CategoriaBovino": clasificacionBovino,
          "EdadBovino": edadBovino.text,
          "lecheDiaria": widget.cadena.lecheDiaria,
          "RazaBovino": widget.cadena.razaBovino,
          "IngresoBovino": widget.cadena.ingreso,
          "CodigoMadre": widget.cadena.codigoMadre,
          "RazaMadre": widget.cadena.razaMadre,
          "CodigoPadre": widget.cadena.codigoPadre,
          "RazaPadre": widget.cadena.razaPadre,
          "CodigoBovino": widget.cadena.codigoBovino,
        });
        // ignore: use_build_context_synchronously
        await DialogUnBoton.alert(
            context, 'Exitoso', 'Registro de Bovino exitoso');
      }
      print('se envio la información');
    } catch (e) {
      print("error ----->$e");
    }
  }

  /// This function builds a widget for displaying individual information about a bovine animal.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the build context of the widget. It is used
  /// to access the theme, media query, and other properties of the current widget tree. It is typically
  /// passed down from the parent widget's build method.
  ///
  /// Returns:
  ///   The build method is returning a Scaffold widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ficha Individual'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.05,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(
                    FontAwesomeIcons.cow,
                    size: 55,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                Text(
                  widget.cadena.nombreBovino,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 230, 74, 25),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.02,
                ),
                Text(
                  'Código: ${widget.cadena.codigoBovino}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),

                /// The above code is building a series of information rows using the _buildInfoRow function. Each row
                /// displays a specific piece of information about a bovine object, such as its breed, date of birth or
                /// entry, parent codes and breeds, and daily milk production.
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1), // Columna de etiquetas
                    1: FlexColumnWidth(2), // Columna de valores
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: Colors.orange, width: 2),
                  children: [
                    TableRow(
                      children: [
                        _buildInfoLabel('Raza'),
                        _buildInfoValue(widget.cadena.razaBovino),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildInfoLabel('Nacimiento o ingreso'),
                        _buildInfoValue(widget.cadena.ingreso),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildInfoLabel('Código del padre'),
                        _buildInfoValue(widget.cadena.codigoPadre),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildInfoLabel('Raza del padre'),
                        _buildInfoValue(widget.cadena.razaPadre),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildInfoLabel('Código de la madre'),
                        _buildInfoValue(widget.cadena.codigoMadre),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildInfoLabel('Raza de la madre'),
                        _buildInfoValue(widget.cadena.razaMadre),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildInfoLabel('leche diaria'),
                        _buildInfoValue(widget.cadena.lecheDiaria),
                      ],
                    ),

                    // Agrega más filas según sea necesario
                  ],
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),

                const Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.shapes), // Icono deseado
                        SizedBox(
                            width: 10), // Espacio entre el icono y el texto
                        Text(
                          'Seleccione la categoría',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                DropdownButton<String>(
                  value: clasificacionBovino,
                  icon: const Icon(Icons.arrow_downward,
                      color: Color(0xfff16437)),
                  elevation: 16,
                  underline: Container(
                    height: 2,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      clasificacionBovino = value!;
                    });
                  },
                  items: list2.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          widthContainer: 0.4,
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
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      height: size.height * 0.05,
                      width: size.width * 0.6,
                      child: TextButton(
                        onPressed: () {
                          validarDatos();
                          Navigator.pushNamed(context, 'FichasIndividuales');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xfff16437),
                        ),
                        child: const Text(
                          'Actualizar y Guardar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                16,
                            fontWeight: FontWeight.bold,                          
                          ),
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
            initialIndex: currentIndex, onTabSelected: onTabSelected));
  }

  /// The function `_buildInfoRow` returns a row widget with a label and value displayed in a centered
  /// manner.
  ///
  /// Args:
  ///   label (String): The label parameter is a string that represents the label or title for the
  /// information being displayed in the row. It could be something like "Name", "Age", or "Address".
  ///   value (String): The "value" parameter is a string that represents the value to be displayed in the
  /// row.
  ///
  /// Returns:
  ///   a widget of type `Row`.
  Widget _buildInfoLabel(String label) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: const Color.fromARGB(255, 233, 214, 185),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoValue(String value) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
