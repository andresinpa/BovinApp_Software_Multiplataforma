import 'package:flutter/material.dart';

class DialogUnBoton {
  static Future<void> alert(
      BuildContext context, String titulo, String mensaje) async {
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
