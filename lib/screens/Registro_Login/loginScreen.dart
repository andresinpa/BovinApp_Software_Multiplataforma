// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';
import 'package:bovinapp/screens/Home/Home1_Drawer.dart';
import 'package:bovinapp/widgets/PasswordInput.dart';
import 'package:bovinapp/widgets/TextInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../DTO/user.dart';
import '../../Design/palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenApp createState() => LoginScreenApp();
}

class LoginScreenApp extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  User objUser = User();
  bool bandera = true;
  // ignore: non_constant_identifier_names
  Future<void> alert(String Titulo, String contenido) async {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(Titulo),
            content: Text(contenido),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (bandera == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Home1(objUser)));
                  }
                },
                child: const Text(
                  'Aceptar',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
      bool bandera = false;
      if (usuarios.docs.isNotEmpty) {
        for (var cursor in usuarios.docs) {
          if (cursor.get('EmailUsuario') == email.text) {
            if (cursor.get('PasswordUsuario') == password.text) {
              bandera = true;
              print('*************Acceso aceptado****************');
              objUser.nombre = cursor.get('NombreUsuario');
              objUser.apellido = cursor.get('ApellidosUsuario');
              objUser.finca = cursor.get('FincaUsuario');
              objUser.ganado = cursor.get('GanadoUsuario');
              objUser.usuario = cursor.get('Usuario');
              objUser.email = cursor.get('EmailUsuario');
              email.clear();
              password.clear();
            } else {}
          }
        }
      } else {
        alert('Usuario no encontrado', 'Primero debe crear la cuenta');
        print('no hay documentos en la colección');
      }
      if (bandera == true) {
        alert('Usuario encontrado', 'Acceso aceptado');
      } else {
        alert('Contraseña incorrecta', 'Por favor intente de nuevo');
        print('*************Contraseña incorrecta****************');
        email.clear();
        password.clear();
      }
    } catch (e) {
      print('Error....$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // Container(
        //   decoration: const BoxDecoration(
        //     color: Color.fromARGB(255, 6, 156, 44),
        //   ),
        // ),
        Scaffold(
          backgroundColor: Color.fromARGB(255, 253, 253, 253),
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    'BovinApp',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //Padding 1 email
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInputField(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Correo electrónico',
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    controler: email,
                  ),

                  //Paddin 2 nombre
                  PasswordInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Contraseña',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    controler: password,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'OlvidePassword'),
                    child: const Text(
                      'Olvidé mi contraseña',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
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
                        password.text =
                            (sha256.convert(utf8.encode(password.text)))
                                .toString();
                        validarDatos();
                      },
                      child: Text(
                        'Ingresar',
                        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),

              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CrearCuenta'),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: kWhite),
                    ),
                  ),
                  child: const Text(
                    'Crear nueva cuenta',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
