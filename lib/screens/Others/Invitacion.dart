import 'package:flutter/material.dart';

class Invitacion extends StatelessWidget {
  const Invitacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'BovinApp',
              style: TextStyle(
                color: Colors.black,
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
        Column(
          children: <Widget>[
            const SizedBox(
              height: 90,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Comparte la',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 90,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'aplicación',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion1.png',
                  scale: 5),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Generar enlace',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion3.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Telegram',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion4.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'WhatsApp',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion5.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Correo Electrónico',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/invitacion/invitacion6.png',
                  scale: 4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Bluetooth',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
              ),
            )
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////
      ],
    );
  }
}
