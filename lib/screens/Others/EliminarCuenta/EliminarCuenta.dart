// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:BovinApp/DTO/Services/EmailService.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Design/Background.dart';
import 'package:BovinApp/Screens/Others/EliminarCuenta/ConfirmacionEliminar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The `EliminarCuenta` class is a stateful widget in Dart.
class EliminarCuenta extends StatefulWidget {
  const EliminarCuenta({Key? key}) : super(key: key);
  @override
  State<EliminarCuenta> createState() => _EliminarCuentaState();
}

/// The `_EliminarCuentaState` class is a stateful widget in Dart that handles the logic for password
/// recovery functionality, including validating user input and sending an email with a confirmation
/// code.
class _EliminarCuentaState extends State<EliminarCuenta> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmacion = TextEditingController();
  User objUser = User();
  bool bandera = true;
  String nombre = '';
  String usuario = '';
  String passSha256 = "";

  /// The function `validarDatos()` checks if a given email exists in a Firestore collection, and if it
  /// does, it sends a confirmation code to that email.
  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('Usuarios');
      QuerySnapshot usuarios = await ref.get();
      if (usuarios.docs.isNotEmpty) {
        for (var cursor in usuarios.docs) {
          if (cursor.get('EmailUsuario') == email.text) {
            nombre = cursor.get('NombreUsuario');
            usuario = cursor.get('Usuario');
            bandera = true;
            break;
          } else {
            bandera = false;
          }
        }
      }

      if (bandera == true) {
        passSha256 = (sha256.convert(utf8.encode(password.text))).toString();
        objUser.nombre = nombre;
        objUser.usuario = usuario;
        objUser.email = email.text;
        objUser.password = passSha256;
        objUser.codigo = (Random().nextInt(99999) + 11111).toString();
        await EmailService.sendEmail(
            name: nombre, email: objUser.email, message: objUser.codigo);
        email.clear();
        password.clear();
        confirmacion.clear();
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ConfirmacionEliminar(objUser)));
      } else {
        await DialogUnBoton.alert(context, 'Error',
            'El correo electrónico ingresado no esta registrado en BovinApp');
      }
    } catch (e) {
      print('Error.....$e');
    }
  }

  /// This function builds a Flutter widget for a password recovery screen with input fields for email,
  /// new password, and password confirmation, along with a button to submit the form.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is a required parameter in the `build` method of a
  /// Flutter widget. It represents the build context of the widget, which provides access to various
  /// properties and methods related to the widget's position in the widget tree.
  ///
  /// Returns:
  ///   The code is returning a Scaffold widget with a SingleChildScrollView as its body. The
  /// SingleChildScrollView contains a Background widget, which in turn contains a Column widget. The
  /// Column widget contains several child widgets including Text, TextInputField, PasswordInput, and
  /// ElevatedButton.
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
                  "Eliminar Cuenta",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 230, 74, 25)),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Center(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Ingresa el correo electrónico registrado en BovinApp y la su contraseña, te enviaremos instrucciones para eliminar tu cuenta.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextInputField(
                maxLines: 1,
                icon: FontAwesomeIcons.envelope,
                hint: 'Correo electrónico',
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                controler: email,
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
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    validacionesDeEntrada();
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
                        "Enviar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The function performs various validations on user input fields such as email, password, and
  /// confirmation, and displays appropriate alerts if any of the validations fail.
  void validacionesDeEntrada() async {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmacion.text.isNotEmpty) {
      if (password.text == confirmacion.text) {
        if (email.text.contains(
            RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'))) {
          if (password.text
              .contains(RegExp(r'^(?=.*[a-zA-Z])(?=.*[\d\W]).{5,}$'))) {
            await validarDatos();
          } else {
            await DialogUnBoton.alert(context, 'Alerta',
                "La contraseña debe tener al menos 5 caracteres con el uso de letras y números");
          }
        } else {
          await DialogUnBoton.alert(
              context, 'Alerta', "¡Ingrese un correo electrónico válido!");
        }
      } else {
        await DialogUnBoton.alert(
            context, 'Alerta', "¡Las contraseñas no coinciden!");
      }
    } else {
      await DialogUnBoton.alert(
          context, 'Alerta', "¡Todos los campos deben estar llenos!");
    }
  }
}
