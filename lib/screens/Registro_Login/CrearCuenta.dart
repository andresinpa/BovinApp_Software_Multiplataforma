import 'dart:math';
import 'dart:ui';
import 'package:bovinapp/Design/palette.dart';
import 'package:bovinapp/screens/screens.dart';
import 'package:bovinapp/widgets/PasswordInput.dart';
import 'package:bovinapp/widgets/TextInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import '../../DTO/user.dart';

class CrearCuenta extends StatefulWidget {
  CrearCuenta();
  @override
  CrearCuentaApp createState() => CrearCuentaApp();
}

class CrearCuentaApp extends State<CrearCuenta> {
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
                  style: TextStyle(color: Colors.blueGrey),
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

      if (usuarios.docs.length != 0) {
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
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ConfirmacionCuentaPage(objUser)));
      }
    } catch (e) {
      print('Error.....' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 4,
                            sigmaY: 4,
                          ),
                          child: CircleAvatar(
                            radius: size.width * 0.15,
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            child: Icon(FontAwesomeIcons.user,
                                color: kWhite, size: size.width * 0.1),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kWhite,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
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
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: kBlue,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (password.text == confirmacion.text) {
                            validarDatos();
                          } else {
                            alert("Las contraseñas no coinciden");
                          }
                        },
                        child: Text(
                          'Registrar',
                          style:
                              kBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Ya tienes una cuenta?     ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Ingresar',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    final serviceId = 'service_8zg5d6h';
    final templateId = 'template_df7zc0j';
    final userId = 'MzvTx11b0rcHUpIf3';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
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
    print('informacion enviada al correo');
  }
}
