// ignore_for_file: avoid_print, duplicate_ignore, use_build_context_synchronously

import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Design/Background.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The ConfirmacionEliminar class is a StatefulWidget that takes a User object as a parameter and creates
/// a ConfirmacionEliminarApp widget.
class ConfirmacionEliminar extends StatefulWidget {
  final User cadena;
  const ConfirmacionEliminar(this.cadena, {super.key});
  @override
  ConfirmacionEliminarApp createState() => ConfirmacionEliminarApp();
}

/// The `ConfirmacionEliminarApp` class is a stateful widget that displays a confirmation screen for a
/// user account and allows the user to validate their account by entering a code.
class ConfirmacionEliminarApp extends State<ConfirmacionEliminar> {
  TextEditingController codigo = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  dynamic uploaded;

  /// The function `insertarDatos()` is used to insert data into a Firebase collection called "Usuarios"
  /// in Dart programming language.
  eliminar() async {
    // ignore: duplicate_ignore
    try {
      if (widget.cadena.usuario != '') {
        await firebase
            .collection('Usuarios')
            .doc(widget.cadena.usuario)
            .delete();
        await DialogUnBoton.alert(context, 'Solicitud',
            'El codigo ha sido validado, ¡Tu usuario ha sido eliminado 😭!');
      } else {
        print('Aqui --------> ${widget.cadena.usuario}');
      }
      // ignore: avoid_print
      print('se envio la informacion');
    } catch (e) {
      print("Error ----->$e");
    }
  }

  /// The build function is responsible for creating and returning the widget tree that represents the
  /// user interface of the app.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter in the build method is a reference to the current
  /// build context of the widget tree. It provides access to various resources and services, such as
  /// theme data, media queries, and navigation. It is typically used to retrieve or modify data related
  /// to the current state of the app.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// The above code is creating a screen for confirming an account in a mobile app. It includes a
    /// form where the user can enter a validation code sent to their email. If the entered code matches
    /// the expected code, the user's data is inserted and they are redirected to the home screen. If
    /// the code does not match, an error message is displayed. The code also includes a confirmation
    /// dialog that appears when the user tries to navigate back from this screen, asking for
    /// confirmation before allowing the navigation.
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
                    "CONFIRMACIÓN DE ELIMINAR",
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
                          '¡Hola ${widget.cadena.nombre}!, gracias por usar BovinApp como tu software para la gestión de tu ganado bovino y de tu finca. Si deseas eliminar tu cuenta LOS DATOS NO PODRÁN RESTAURARSE si estas seguro, por favor valida tus datos e ingresa el código de ingreso que fue enviado al correo "${widget.cadena.email}" para continuar.',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: size.height * 0.03),
                      TextInputField(
                        maxLines: 1,
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
                              eliminar();
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
                                "Eliminar",
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
