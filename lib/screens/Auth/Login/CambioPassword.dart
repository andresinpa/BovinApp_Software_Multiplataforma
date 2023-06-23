import 'package:BovinApp/Widgets/PasswordInput.dart';
import 'package:BovinApp/Widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CambioPassword extends StatefulWidget {
  const CambioPassword({super.key});

  @override
  State<CambioPassword> createState() => _CambioPasswordState();
}

class _CambioPasswordState extends State<CambioPassword> {
  TextEditingController nueva = TextEditingController();

  TextEditingController confirmacion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  children: [
                    //Paddin 2 nombre
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Nueva Contraseña',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      controler: nueva,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Confirmar Contraseña',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      controler: confirmacion,
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
