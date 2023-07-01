// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:BovinApp/Design/Background.dart';
import 'package:BovinApp/Screens/Home/Home.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenApp createState() => LoginScreenApp();
}

class LoginScreenApp extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isHovered = false;
  bool bandera = false;
  String pass = "";

  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('Usuarios');
      QuerySnapshot usuarios = await ref.get();
      if (usuarios.docs.isNotEmpty) {
        for (var cursor in usuarios.docs) {
          if (cursor.get('EmailUsuario') == email.text) {
            if (cursor.get('PasswordUsuario') == pass) {
              bandera = true;
              email.clear();
              password.clear();
            }
          }
        }
      }
      if (bandera == true) {
        DialogUnBoton.alert(
            context, 'Acceso aceptado', '¡Bienvenido a BovinApp!');
      } else {
        await DialogUnBoton.alert(context, 'Error',
            '¡Los datos ingresados podrían no ser correctos, reintente de nuevo!');
      }
    } catch (e) {
      print('Error....$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Background(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "INGRESAR",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(255, 230, 74, 25)),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                TextInputField(
                  icon: FontAwesomeIcons.envelope,
                  hint: 'Correo electrónico',
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  controler: email,
                ),
                SizedBox(height: size.height * 0.03),
                PasswordInput(
                  icon: FontAwesomeIcons.lock,
                  hint: 'Contraseña',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.done,
                  controler: password,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'OlvidePassword');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xff9ce6e5);
                          }
                          return Colors.transparent;
                        },
                      ),
                    ),
                    child: const Text(
                      'Olvidé mi contraseña',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      pass = (sha256.convert(utf8.encode(password.text)))
                          .toString();
                      validarDatos();
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Home()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0),
                      minimumSize: Size(size.width * 0.5, 50.0),
                      elevation: 0,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        child: const Text(
                          "Ingresar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'CrearCuenta');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xff9ce6e5);
                          }
                          return Colors.transparent;
                        },
                      ),
                    ),
                    child: const Text(
                      '¿No tienes cuenta? Registrar',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
