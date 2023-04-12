import 'package:flutter/material.dart';

class ConsultaBueyes extends StatelessWidget {
  const ConsultaBueyes({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: const Text(
                        'Bueyes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                Container(
                  color: const Color.fromARGB(255, 212, 240, 253),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Nombre:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Carlota',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Código:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '25',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Raza:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Normando',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Edad:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '3 años',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  color: const Color.fromARGB(255, 248, 211, 219),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Nombre:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'lola',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Código:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '5',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Raza:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Normando',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Edad:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '1 años',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  color: const Color.fromARGB(255, 213, 250, 224),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Nombre:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'fyora',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Código:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '2',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Raza:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Jersey',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Edad:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '5 años',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
