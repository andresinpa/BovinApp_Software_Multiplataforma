import 'package:BovinApp/Screens/Auth/Login/Background.dart';
import 'package:BovinApp/Widgets/TextInputField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OlvidePassword extends StatefulWidget {
  const OlvidePassword({Key? key}) : super(key: key);

  @override
  State<OlvidePassword> createState() => _OlvidePasswordState();
}

class _OlvidePasswordState extends State<OlvidePassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Recuperar Cuenta",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 230, 74, 25)),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  textAlign: TextAlign.center,
                  'Ingresa tu correo electrónico, te enviaremos instrucciones para reestablecer tu contraseña',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextInputField(
                icon: FontAwesomeIcons.envelope,
                hint: 'Correo electrónico',
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                controler: email,
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0),
                    minimumSize: Size(size.width * 0.5, 50.0),
                    elevation: 0,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      child: const Text(
                        "Enviar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
