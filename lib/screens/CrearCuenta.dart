import 'dart:ui';

import 'package:bovinapp/palette.dart';
import 'package:bovinapp/widgets/PasswordInput.dart';
import 'package:bovinapp/widgets/RoundedButton.dart';
import 'package:bovinapp/widgets/TextInputField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CrearCuenta extends StatelessWidget {
  const CrearCuenta({super.key});

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
                    const TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: 'Nombres',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next),
                    const TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: 'Apellidos',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next),
                    const TextInputField(
                        icon: FontAwesomeIcons.circleUser,
                        hint: 'Usuario',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next),
                    const TextInputField(
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Correo electrónico',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    const TextInputField(
                        icon: FontAwesomeIcons.houseChimney,
                        hint: 'Nombre de su finca',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next),
                    const TextInputField(
                        icon: FontAwesomeIcons.arrowUp19,
                        hint: 'Cabezas de ganado',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next),
                    const PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Contraseña',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    const PasswordInput(
                      icon: FontAwesomeIcons.shield,
                      hint: 'Confirmar la contraseña',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const RoundedButton(
                      buttonName: 'Registrar',
                      rute: 'ConfirmacionCuenta',
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Ya tienes una cuenta?     ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Ingresar',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
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
