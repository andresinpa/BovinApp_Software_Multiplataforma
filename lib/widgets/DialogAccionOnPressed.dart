// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `DialogAccionOnPressed` class is a Dart class that provides a static method for displaying an
/// alert dialog with a title, message, and two buttons (Cancel and Accept) in a Flutter application.
class DialogAccionOnPressed {
  /// The `alert` function in Dart displays an AlertDialog with a given title, message, and two buttons
  /// (Cancel and Accept) and executes a provided function when the Accept button is pressed.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the current state of the widget tree.
  /// It is typically obtained from the build method of a widget or from a callback that is passed a
  /// BuildContext parameter.
  ///   titulo (String): The title of the alert dialog.
  ///   mensaje (String): The "mensaje" parameter is a string that represents the message or content of
  /// the alert dialog. It is the text that will be displayed to the user.
  ///   accionAceptar (Function): The parameter "accionAceptar" is a function that will be called when
  /// the user presses the "Aceptar" button in the dialog.
  ///
  /// Returns:
  ///   The `alert` function is returning a `Future<void>`.
  static Future<void> alert(BuildContext context, String titulo, String mensaje,
      Function accionAceptar) async {
    showDialog(
      context: context,
      builder: (BuildContext buildcontext) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cerrar el diálogo al presionar "Cancelar"
              },
              child: const Text(
                'Cancelar',
              ),
            ),
            TextButton(
              onPressed: () {
                accionAceptar(); // Llamar a la función proporcionada al presionar "Aceptar"
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text(
                'Aceptar',
              ),
            ),
          ],
        );
      },
    );
  }
}
