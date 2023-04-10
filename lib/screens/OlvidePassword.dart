import 'package:bovinapp/widgets/RoundedButton.dart';
import 'package:bovinapp/widgets/TextInputField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OlvidePassword extends StatelessWidget {
  const OlvidePassword({Key? key}) : super(key: key);

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Olvide mi contraseña',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.8,
                      child: const Text(
                        'Ingresa tu correo electrónico, te enviaremos instrucciones para reestablecer tu contraseña',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // ignore: prefer_const_constructors
                    TextInputField(
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Correo electrónico',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const RoundedButton(
                      buttonName: 'Enviar',
                      rute: "",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
