import 'package:flutter/material.dart';

class RazasBovinosUbate extends StatelessWidget {
  const RazasBovinosUbate({super.key});

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
                            Navigator.pushNamed(context, 'InformeProduccion'),
                        child: Image.asset(
                            'assets/images/inventariobovino/bovino4.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Normando',
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
                      child: Image.asset(
                          'assets/images/inventariobovino/bovino3.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Holstein',
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
                      child: Image.asset('assets/images/home2/home1.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Montbéliarde',
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
                      child: Image.asset(
                          'assets/images/inventariobovino/bovino5.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Jersey',
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
                      child: Image.asset('assets/images/home2/home2.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Conoce a Ubaté',
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
