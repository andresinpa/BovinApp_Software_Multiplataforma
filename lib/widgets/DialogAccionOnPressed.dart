import 'package:flutter/material.dart';

class DialogAccionOnPressed {
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
