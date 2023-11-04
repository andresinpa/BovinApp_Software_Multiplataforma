// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `DialogDosBotones` class is a Dart class that creates a dialog with two buttons (Cancel and
/// Accept) and displays it on the screen.
class DialogDosBotones {
  static Future<void> alert(BuildContext context, String titulo, String mensaje,
      String nombrePantalla) async {
    /// The `showDialog` function is used to display a dialog on the screen. It takes a `BuildContext`
    /// as a parameter, which is typically the context of the current widget.
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context,
                    nombrePantalla); // Navegar a la pantalla especificada
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
