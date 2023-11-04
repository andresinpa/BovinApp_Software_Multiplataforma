// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The PasswordInput class is a StatefulWidget that represents a password input field with an icon,
/// hint text, input type, input action, and a controller.
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

/// The `_PasswordInputState` class is a stateful widget that represents a password input field with an
/// icon and a toggle button to show or hide the password.
class _PasswordInputState extends State<PasswordInput> {
  bool mostrarPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// The code is returning a `Padding` widget that contains a `SizedBox` widget. The `SizedBox`
    /// widget has a specified height and width based on the `size` of the screen. Inside the
    /// `SizedBox`, there is a `Center` widget that contains a `TextField` widget.
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
