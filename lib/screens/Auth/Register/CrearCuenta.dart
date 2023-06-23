// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:io';
import 'dart:math';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Auth/Login/BackgroundSimple.dart';
import 'package:BovinApp/Screens/Auth/Register/ConfirmacionCuentaPage.dart';
import 'package:BovinApp/Widgets/PasswordInput.dart';
import 'package:BovinApp/Widgets/TextInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class CrearCuenta extends StatefulWidget {
  const CrearCuenta({super.key});
  @override
  CrearCuentaApp createState() => CrearCuentaApp();
}

class CrearCuentaApp extends State<CrearCuenta> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);
    setState(() {
      _pickedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  final TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController finca = TextEditingController();
  TextEditingController ganado = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmacion = TextEditingController();
  User objUser = User();
  bool bandera = true;
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
                ),
              )
            ],
          );
        });
  }

  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('Usuarios');
      QuerySnapshot usuarios = await ref.get();

      if (usuarios.docs.isNotEmpty) {
        for (var cursor in usuarios.docs) {
          if (cursor.get('EmailUsuario') == email.text) {
            alert('El email ya existe');
            bandera = false;
          }
        }
      }
      if (bandera == true) {
        password.text = (sha256.convert(utf8.encode(password.text))).toString();
        objUser.nombre = nombre.text;
        objUser.apellido = apellido.text;
        objUser.usuario = usuario.text;
        objUser.email = email.text;
        objUser.finca = finca.text;
        objUser.ganado = ganado.text;
        objUser.password = password.text;
        objUser.codigo = (Random().nextInt(99999) + 11111).toString();
        await sendEmail(
            name: objUser.nombre,
            email: objUser.email,
            message: objUser.codigo);
        nombre.clear();
        apellido.clear();
        usuario.clear();
        email.clear();
        finca.clear();
        ganado.clear();
        password.clear();
        confirmacion.clear();
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ConfirmacionCuentaPage(objUser)));
      }
    } catch (e) {
      print('Error.....$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('BovinApp'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: BackgroundSimple(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        "REGISTRO",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 230, 74, 25)),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffe3ffff),
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 2, color: const Color(0xff7081cb)),
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
                            : const Icon(Icons.person, size: 75),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.image),
                    label: const Text(
                      'Añadir foto',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      iconColor: MaterialStateProperty.all<Color>(
                          const Color(0xfff16437)),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.user,
                    hint: 'Nombres',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: nombre,
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.user,
                    hint: 'Apellidos',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: apellido,
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.circleUser,
                    hint: 'Usuario',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: usuario,
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Correo electrónico',
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    controler: email,
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.houseChimney,
                    hint: 'Nombre de su finca',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: finca,
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.arrowUp19,
                    hint: 'Cabezas de ganado',
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    controler: ganado,
                  ),
                  PasswordInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Contraseña',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: password,
                  ),
                  PasswordInput(
                    icon: FontAwesomeIcons.shield,
                    hint: 'Confirmar la contraseña',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    controler: confirmacion,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 8),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (password.text == confirmacion.text) {
                            validarDatos();
                          } else {
                            alert("Las contraseñas no coinciden");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0),
                          minimumSize: Size(size.width * 0.5, 50.0),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 50),
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color(0xff9ce6e5);
                              }
                              return Colors.transparent;
                            },
                          ),
                        ),
                        child: const Text(
                          '¿Ya tienes una cuenta? Ingresar',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    const serviceId = 'service_8zg5d6h';
    const templateId = 'template_df7zc0j';
    const userId = 'MzvTx11b0rcHUpIf3';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    // ignore: unused_local_variable
    final response = await http.post(
      url,
      headers: {
        'origin': 'http:localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_message': message,
        },
      }),
    );
    // ignore: avoid_print
    print('informacion enviada al correo');
  }
}
