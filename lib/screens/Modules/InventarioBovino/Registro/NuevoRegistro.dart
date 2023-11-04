// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:BovinApp/DTO/Bovino.dart';
import 'package:BovinApp/Screens/Modules/InventarioBovino/Registro/SiguienteRegistro.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

/// The above code is declaring a constant list of strings named "list". The list contains the names of
/// different types of cows.
const List<String> list = [
  'Holstein',
  'Normando',
  'Montbeliarde',
  'Jersey',
  'Cruzado',
];

/// The above code is declaring a constant list of strings named "list2". The list contains the
/// following elements: 'Vacas', 'Toros', 'Terneros', 'Novillas', 'Bueyes'.
const List<String> list2 = [
  'Vacas',
  'Toros',
  'Terneros',
  'Novillas',
  'Bueyes',
];

/// The class "Registro" is a stateless widget that returns a "NuevoRegistro" widget.
class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return const NuevoRegistro();
  }
}

/// The class "NuevoRegistro" is a stateful widget in Dart.
class NuevoRegistro extends StatefulWidget {
  const NuevoRegistro({super.key});

  @override
  State<NuevoRegistro> createState() => _NuevoRegistroState();
}

class _NuevoRegistroState extends State<NuevoRegistro> {
  /// The `_pickImage` function uses the `ImagePicker` package to allow the user to pick an image from a
  /// specified source and updates the `_pickedImage` variable accordingly.
  ///
  /// Args:
  ///   source (ImageSource): The `source` parameter is of type `ImageSource` and it represents the source
  /// from where the image should be picked. It can be one of the following values:
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  /// The function `_pickImage` allows the user to pick an image from a specified source and updates the
  /// state with the selected image.
  ///
  /// Args:
  ///   source (ImageSource): The `source` parameter is of type `ImageSource` and is used to specify the
  /// source from where the image should be picked. It can have one of the following values:
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);
    setState(() {
      _pickedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  TextEditingController nombreFinca = TextEditingController();
  TextEditingController codigoBovino = TextEditingController();
  TextEditingController nombreBovino = TextEditingController();
  String razaBovino = list.first;
  String categoriaBovino = list2.first;
  int currentIndex = 1;
  bool bandera = true;
  Bovino objBovino = Bovino();

  /// The function updates the current index when a tab is selected.
  ///
  /// Args:
  ///   index (int): The index parameter represents the index of the selected tab. It is used to update
  /// the state of the current index, which is typically used to control the active tab in a tab bar or
  /// tab view.
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  late User objUser;

  /// The initState function retrieves the user object from the UserProvider using the Provider package
  /// in Dart.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// The function `validarDatos()` checks if a bovine code has already been registered and if not, it
  /// stores the bovine data and navigates to the next registration page.
  validarDatos() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('InventarioBovino');
      QuerySnapshot bovinos = await ref.get();
      if (bovinos.docs.isNotEmpty) {
        for (var cursor in bovinos.docs) {
          if (cursor.get('CodigoBovino') == codigoBovino.text) {
            await DialogUnBoton.alert(context, 'Error',
                '¡El codigo del Bovino ya ha sido registrado!');
            bandera = false;
          }
        }
      }
      if (bandera == true) {
        objBovino.codigoBovino = codigoBovino.text;
        objBovino.nombreBovino = nombreBovino.text;
        objBovino.razaBovino = razaBovino;
        objBovino.categoriaBovino = categoriaBovino;
        if (_pickedImage == null) {
          objBovino.imageLocal = '';
        } else {
          objBovino.imageLocal = _pickedImage;
        }
        codigoBovino.clear();
        nombreBovino.clear();
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => SiguienteRegistro(objBovino)));
      }
    } catch (e) {
      print('Error.....$e');
    }
  }

  /// This function builds a form for creating a new bovine record with fields for code, name, photo,
  /// breed, and category.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget tree.
  /// It is used to access the size of the screen using `MediaQuery.of(context).size`.
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffe3ffff),
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: const Color(0xff7081cb)),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 142,
                    height: 142,
                    child: _pickedImage != null
                        ? Image.file(
                            _pickedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(FontAwesomeIcons.cow, size: 75),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                /// The above code is defining an `onPressed` event handler that calls the `_pickImage`
                /// function with the `ImageSource.gallery` parameter.
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(FontAwesomeIcons.image),
                label: const Text(
                  'Foto del bovino',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  iconColor:
                      MaterialStateProperty.all<Color>(const Color(0xfff16437)),
                ),
              ),
              SizedBox(
                height: size.width * 0.1,
              ),
              Column(
                children: [
                  TextInputField(
                    maxLines: 1,
                    controler: codigoBovino,
                    icon: FontAwesomeIcons.codeFork,
                    hint: 'Código del bovino',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    controler: nombreBovino,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Nombre del bovino',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons
                                  .certificate), // Icono deseado
                              SizedBox(
                                  width:
                                      10), // Espacio entre el icono y el texto
                              Text(
                                'Seleccione la Raza',
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
                        value: razaBovino,
                        icon: const Icon(Icons.arrow_downward,
                            color: Color(0xfff16437)),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            razaBovino = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                                  width:
                                      10), // Espacio entre el icono y el texto
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
                        value: categoriaBovino,
                        icon: const Icon(Icons.arrow_downward,
                            color: Color(0xfff16437)),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            categoriaBovino = value!;
                          });
                        },
                        items:
                            list2.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          validarDatos();
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: Colors.deepOrange),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.all(0),
                          minimumSize: Size(size.width * 0.6, 60.0),
                        ),
                        child: const Text(
                          'Continuar Registro',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.1,
                      ),
                    ],
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
