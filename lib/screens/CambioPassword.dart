import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bovinapp/widgets/widgets.dart';

class CambioPassword extends StatelessWidget {
  const CambioPassword({super.key});

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
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: SingleChildScrollView(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: size.width * 0.2,
                ),
                const Center(
                  child: Text(
                    'Cambio Contraseña',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: const Text(
                    'Ingresa tu nueva contraseña',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                //Padding 1 email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    //Paddin 2 nombre
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Nueva Contraseña',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Confirmar Contraseña',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'MiUsuarioyFinca');
                  },
                  child: const RoundedButton(buttonName: 'Guardar', rute: '/'),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
