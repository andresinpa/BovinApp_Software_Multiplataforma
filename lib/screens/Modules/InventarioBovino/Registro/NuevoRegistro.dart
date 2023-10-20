// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:BovinApp/DTO/Bovino.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:BovinApp/screens/Modules/InventarioBovino/Registro/SiguienteRegistro.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

const List<String> list = [
  'Holstein',
  'Normando',
  'Montbeliarde',
  'Jersey',
  'Cruzado',
];

const List<String> list2 = [
  'Vacas',
  'Toros',
  'Terneros',
  'Novillas',
  'Bueyes',
];

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return const NuevoRegistro();
  }
}

class NuevoRegistro extends StatefulWidget {
  const NuevoRegistro({super.key});

  @override
  State<NuevoRegistro> createState() => _NuevoRegistroState();
}

class _NuevoRegistroState extends State<NuevoRegistro> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;
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
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  late User objUser;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

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
