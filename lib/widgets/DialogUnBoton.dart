// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `DialogUnBoton` class in Dart is a utility class that displays an alert dialog with a single
/// button.
class DialogUnBoton {
  static Future<void> alert(
      BuildContext context, String titulo, String mensaje) async {
    /// The `showDialog` function is used to display a dialog box on the screen. It takes in a
    /// `BuildContext` object and a `builder` function as parameters.
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
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
      },
    );
  }
}
