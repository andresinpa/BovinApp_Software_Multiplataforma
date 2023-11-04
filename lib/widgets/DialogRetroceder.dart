// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The function `mostrarAlerta` displays an alert dialog with a confirmation message and returns a
/// Future<bool> indicating whether the user clicked on "Aceptar" or "Cancelar".
///
/// Args:
///   context (BuildContext): The `BuildContext` object represents the location in the widget tree where
/// the dialog should be shown. It is typically obtained from the `BuildContext` parameter in the
/// `build` method of a widget.
///
/// Returns:
///   The `mostrarAlerta` function is returning a `Future<bool?>`.
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
