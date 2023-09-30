import 'package:flutter/material.dart';

class ConsultaMaquinaria extends StatelessWidget {
  const ConsultaMaquinaria({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
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
                      width: size.width * 0.8,
                      child: const Text(
                        'Maquinaria',
                        style: TextStyle(
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
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Carlota',
                              style: TextStyle(
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
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '25',
                              style: TextStyle(
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
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: const Text(
                              'Normando',
                              style: TextStyle(
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
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Text(
                              '3 años',
                              style: TextStyle(
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
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            'Nombre:',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            'lola',
                            style: TextStyle(
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
                              fontSize: 28,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Text(
                            '5',
                            style: TextStyle(
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
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            'Normando',
                            style: TextStyle(
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
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Text(
                            '1 años',
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            'Nombre:',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            'fyora',
                            style: TextStyle(
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
                              fontSize: 28,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Text(
                            '2',
                            style: TextStyle(
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
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            'Jersey',
                            style: TextStyle(
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
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Text(
                            '5 años',
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
