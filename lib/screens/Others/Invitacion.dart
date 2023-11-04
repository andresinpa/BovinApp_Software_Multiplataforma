// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `Invitacion` class is a stateless widget that displays a screen with a grid of invitation
/// options.
class Invitacion extends StatelessWidget {
  const Invitacion({super.key});
/// The code builds a Flutter widget that displays a grid of images and text for sharing the
/// application.
/// 
/// Args:
///   context (BuildContext): The `context` parameter is a required parameter in the `build` method of a
/// `StatelessWidget` or `StatefulWidget`. It represents the current build context of the widget tree.
/// It is typically used to access the theme, media query, and other properties of the current context.
/// 
/// Returns:
///   The code is returning a `Stack` widget, which contains a `Scaffold` widget as its child. The
/// `Scaffold` widget has an `AppBar` as its `appBar` property and a `Padding` widget as its `body`
/// property. The `Padding` widget contains a `MatrizImges` widget.

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'BovinApp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.exit_to_app_rounded),
                onPressed: () {},
              ),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.only(top: 5),
            child: MatrizImges(),
          ),
        ),
      ],
    );
  }
}

class MatrizImges extends StatelessWidget {
  const MatrizImges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        const Column(
          children: <Widget>[
            SizedBox(
              height: 90,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Comparte la',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'aplicación',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.share_rounded,
                  size: 28,
                ),
              ],
            ),
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion1.png',
                  scale: 5),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Generar enlace',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, ''),
                child: Image.asset('assets/images/invitacion/invitacion2.png',
                    scale: 4),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Mensaje de texto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion3.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Telegram',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion4.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'WhatsApp',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion5.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Correo Electrónico',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion6.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Bluetooth',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////
      ],
    );
  }
}
