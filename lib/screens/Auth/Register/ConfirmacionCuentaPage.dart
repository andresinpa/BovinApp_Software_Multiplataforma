// ignore_for_file: avoid_print, duplicate_ignore, use_build_context_synchronously

import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Auth/Login/Background.dart';
import 'package:BovinApp/Screens/Auth/Register/ImagenUsuario.dart';
import 'package:BovinApp/Widgets/DialogUnBoton.dart';
import 'package:BovinApp/Widgets/TextInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmacionCuentaPage extends StatefulWidget {
  final User cadena;
  const ConfirmacionCuentaPage(this.cadena, {super.key});
  @override
  ConfirmacionCuentaPageApp createState() => ConfirmacionCuentaPageApp();
}

class ConfirmacionCuentaPageApp extends State<ConfirmacionCuentaPage> {
  TextEditingController codigo = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  dynamic uploaded;
  insertarDatos() async {
    // ignore: duplicate_ignore
    try {
      if (widget.cadena.apellido != '' ||
          widget.cadena.finca != '' ||
          widget.cadena.ganado != '') {
        if (widget.cadena.imagenLocal == '') {
          uploaded = '';
        } else {
          uploaded = await uploadImage(
              widget.cadena.imagenLocal, widget.cadena.usuario);
        }
        await firebase.collection('Usuarios').doc(widget.cadena.usuario).set({
          "NombreUsuario": widget.cadena.nombre,
          "ApellidosUsuario": widget.cadena.apellido,
          "Usuario": widget.cadena.usuario,
          "EmailUsuario": widget.cadena.email,
          "FincaUsuario": widget.cadena.finca,
          "GanadoUsuario": widget.cadena.ganado,
          "PasswordUsuario": widget.cadena.password,
          "UrlAvatarUsuario": uploaded,
        });
        await DialogUnBoton.alert(context, 'Solicitud',
            'El codigo ha sido validado, ¡ya puede ingresar a la App!');
      } else {
        await firebase
            .collection('Usuarios')
            .doc(widget.cadena.usuario)
            .update({
          "PasswordUsuario": widget.cadena.password,
        });
        await DialogUnBoton.alert(context, 'Solicitud',
            'El codigo ha sido validado, ¡ya puede ingresar a la App con la nueva contraseña!');
      }

      // ignore: avoid_print
      print('se envio la informacion');
    } catch (e) {
      print("Error ----->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        bool? resultado = await mostrarAlerta(context);
        return resultado ??
            false; // Si se presiona fuera del diálogo, se considera "Cancelar"
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "CONFIRMACIÓN DE CUENTA",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color.fromARGB(255, 230, 74, 25)),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.8,
                        child: Text(
                          '¡Hola ${widget.cadena.nombre}!, gracias por elegir BovinApp como tu software para la gestión de tu ganado bovino y de tu finca. Para disfrutar de todas las opciones y caracteristicas de la App, por favor valida tus datos e ingresa el código de ingreso que fue enviado al correo "${widget.cadena.email}" para continuar.',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: size.height * 0.03),
                      TextInputField(
                        icon: FontAwesomeIcons.cow,
                        hint: 'Código',
                        inputType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        inputAction: TextInputAction.done,
                        controler: codigo,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (codigo.text == widget.cadena.codigo) {
                              insertarDatos();
                              Navigator.pushNamed(context, '/');
                            } else {
                              await DialogUnBoton.alert(context, 'Error',
                                  'No se ha podido validar el código, ¡reintentelo de nuevo!');
                            }
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
                                "Validar",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool?> mostrarAlerta(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmación'),
        content: const Text(
            '¿Estás seguro de retroceder de pantalla? El código perdera vigencia.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Cancelar
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Aceptar
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
