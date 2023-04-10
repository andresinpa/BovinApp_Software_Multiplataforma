import 'package:flutter/material.dart';

class InventarioBovinos extends StatelessWidget {
  const InventarioBovinos({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                ///////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 109, 184, 194),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'ConsultaVacas'),
                        child: Image.asset(
                            'assets/images/inventariobovino/bovino1.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Vacas',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(156, 38, 88, 153),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 109, 184, 194),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'ConsultaToros'),
                        child: Image.asset(
                            'assets/images/inventariobovino/bovino2.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Toros',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(156, 38, 88, 153),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 109, 184, 194),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'ConsultaTerneros'),
                        child: Image.asset(
                            'assets/images/inventariobovino/bovino3.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Terneros',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(156, 38, 88, 153),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 109, 184, 194),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'ConsultaNovillas'),
                        child: Image.asset(
                            'assets/images/inventariobovino/bovino4.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Novillas',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(156, 38, 88, 153),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 109, 184, 194),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'ConsultaBueyes'),
                        child: Image.asset(
                            'assets/images/inventariobovino/bovino5.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Bueyes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(156, 38, 88, 153),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 109, 184, 194),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'NuevoRegistro'),
                        child: Image.asset(
                            'assets/images/inventariobovino/bovino6.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Nuevo Registro',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(156, 38, 88, 153),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ////////////////////////////////////////////////////////////////////////////////////
              ],
            ),
          ),
        )
      ],
    );
  }
}
