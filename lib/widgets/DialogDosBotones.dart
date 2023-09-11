import 'package:flutter/material.dart';

class DialogDosBotones {
  static Future<void> alert(BuildContext context, String titulo, String mensaje,
      String nombrePantalla) async {
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
