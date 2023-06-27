import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.controler,
  }) : super(key: key);
  final TextEditingController controler;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool mostrarPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: size.height * 0.08,
        width: size.width * 0.8,
        child: Center(
          child: TextField(
            controller: widget.controler,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  widget.icon,
                  size: 28,
                ),
              ),
              hintText: widget.hint,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    mostrarPassword =
                        !mostrarPassword; // Alterna el estado de mostrarPassword
                  });
                },
                child: Icon(
                  mostrarPassword
                      ? FontAwesomeIcons.eyeSlash // Icono de ojo cerrado
                      : FontAwesomeIcons.eye, // Icono de ojo abierto
                ),
              ),
            ),
            obscureText: !mostrarPassword,
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
          ),
        ),
      ),
    );
  }
}
