import 'package:flutter/material.dart';

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
