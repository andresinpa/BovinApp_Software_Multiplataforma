import 'dart:ui';

import 'package:bovinapp/Design/palette.dart';
import 'package:bovinapp/widgets/RoundedButton.dart';
import 'package:bovinapp/widgets/TextInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MiUsuarioYFinca extends StatelessWidget {
  MiUsuarioYFinca({super.key});
  TextEditingController usuario = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController ubicacion = TextEditingController();
  TextEditingController area = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var lista = ['metros cuadrados', 'fanegadas'];
    String vista = 'selecciona una opción';
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
                  height: size.width * 0.1,
                ),
                SizedBox(
                  height: size.width * 0.1,
                  child: const Text(
                    'Mi usuario y finca',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
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
                            child: Icon(FontAwesomeIcons.user,
                                color: kWhite, size: size.width * 0.1),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kWhite,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
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
                      children: const [
                        Text(
                          'Nombre:   ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          'Flor',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.circleUser,
                      hint: 'Usuario',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controler: usuario,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Correo electrónico',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      controler: correo,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Nombre de la finca:   ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                          ),
                        ),
                        Text(
                          'la arboleda',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.locationArrow,
                      hint: 'Ubicación de la finca',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controler: ubicacion,
                    ),
                    Column(
                      children: [
                        TextInputField(
                          icon: FontAwesomeIcons.rectangleXmark,
                          hint: 'Mi finca tiene un área de:',
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.done,
                          controler: area,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButton(
                          items: lista.map((String a) {
                            return DropdownMenuItem(
                                value: a,
                                child: Text(
                                  a,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                  ),
                                ));
                          }).toList(),
                          onChanged: (value) => {
                            //setState(() {
                            //vista = value;

                            //})
                            // ignore: avoid_print
                            print(value)
                          },
                          hint: Text(
                            vista,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          /*child: const RoundedButton(
                              buttonName: 'Actualizar y Guardar'),*/
                          child: const RoundedButton(
                              buttonName: 'Actualizar y Guardar',
                              rute: 'Home1'),
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
