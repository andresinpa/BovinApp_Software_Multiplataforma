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

const List<String> listaEdad = [
  'Meses',
  'Años',
];

const List<String> list2 = [
  'Vacas',
  'Toros',
  'Terneros',
  'Novillas',
  'Bueyes',
];

class FichasIndividualesResultados extends StatefulWidget {
  final Bovino cadena;

  const FichasIndividualesResultados(this.cadena, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FichasIndividualesResultadosState createState() =>
      _FichasIndividualesResultadosState();
}

class _FichasIndividualesResultadosState
    extends State<FichasIndividualesResultados> {
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

  @override
  void initState() {
    super.initState();
    clasificacionBovino = widget.cadena.categoriaBovino;
    edadBovino.text = widget.cadena.edadBovino;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  validarDatos() async {
    try {
      if (widget.cadena.codigoBovino != '' ||
          widget.cadena.nombreBovino != '' ||
          widget.cadena.razaBovino != '' ||
          widget.cadena.categoriaBovino != '') {
        // Obtén una referencia al documento
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
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(
                    FontAwesomeIcons.cow,
                    size: 80,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.cadena.nombreBovino,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Código: ${widget.cadena.codigoBovino}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Raza:', widget.cadena.razaBovino),
                _buildInfoRow(
                    'Fecha de nacimiento o de ingreso:', widget.cadena.ingreso),
                _buildInfoRow('Código del padre:', widget.cadena.codigoPadre),
                _buildInfoRow('Raza del padre:', widget.cadena.razaPadre),
                _buildInfoRow('Código de la madre:', widget.cadena.codigoMadre),
                _buildInfoRow('Raza de la madre:', widget.cadena.razaMadre),
                _buildInfoRow('leche diaria:', widget.cadena.lecheDiaria),
                const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        validarDatos();
                        Navigator.pushNamed(context, 'FichasIndividuales');
                      },
                      child: const Text('Actualizar y Guardar'),
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
