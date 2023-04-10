// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../palette.dart';
import 'package:bovinapp/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    'BovinApp',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //Padding 1 email
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInputField(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Correo electrónico',
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    controler: email,
                  ),

                  //Paddin 2 nombre
                  PasswordInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Contraseña',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    controler: password,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'OlvidePassword'),
                    child: const Text(
                      'Olvidé mi contraseña',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),

                  const RoundedButton(
                    buttonName: 'Ingresar',
                    rute: "Home1",
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),

              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CrearCuenta'),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: kWhite),
                    ),
                  ),
                  child: const Text(
                    'Crear nueva cuenta',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
