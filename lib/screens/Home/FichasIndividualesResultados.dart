import 'dart:ui';
import 'package:bovinapp/Design/palette.dart';
import 'package:bovinapp/widgets/RoundedButton.dart';
import 'package:bovinapp/widgets/TextInputField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FichasIndividualesResultados extends StatefulWidget {
  const FichasIndividualesResultados({super.key});

  @override
  State<FichasIndividualesResultados> createState() =>
      _FichasIndividualesResultadosState();
}

class _FichasIndividualesResultadosState
    extends State<FichasIndividualesResultados> {
  TextEditingController buscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var clasificacion = ['Vacas', 'Toros', 'Terneros', 'Novillas', 'Bueyes'];
    String vistaClasificacion = 'Vacas';

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
                        'Carlota',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.05,
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
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 4,
                            sigmaY: 4,
                          ),
                          child: CircleAvatar(
                            radius: size.width * 0.15,
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            child: Icon(FontAwesomeIcons.cow,
                                color: kWhite, size: size.width * 0.1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
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
                              fontSize: 2,
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
                          width: size.width * 0.6,
                          child: const Text(
                            'Edad:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: const Text(
                            'Clasificación:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        DropdownButton(
                          items: clasificacion.map((String a) {
                            return DropdownMenuItem(value: a, child: Text(a));
                          }).toList(),
                          onChanged: (value) => {
                            //setState(() {
                            //vista = value;

                            //})
                            // ignore: avoid_print
                            print(value)
                          },
                          hint: Text(
                            vistaClasificacion,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: const Text(
                            'Fecha de nacimiento o de ingreso: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            '1-1-2022',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
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
                          width: size.width * 0.6,
                          child: const Text(
                            'Codigo del padre: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            '7',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
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
                          width: size.width * 0.6,
                          child: const Text(
                            'Raza del padre: ',
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: const Text(
                            'Codigo de la madre: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            '8',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
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
                          width: size.width * 0.6,
                          child: const Text(
                            'Raza del padre: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: const Text(
                            'Hoistein',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.bottleWater,
                      hint: 'Produccion de leche diaria',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      controler: buscar,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'FichasIndividuales');
                          },
                          child: const RoundedButton(
                            buttonName: 'Actualizar y Guardar',
                            rute: 'FichasIndividuales',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
