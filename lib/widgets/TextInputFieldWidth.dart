import 'package:flutter/material.dart';

class TextInputFieldWidth extends StatelessWidget {
  const TextInputFieldWidth({
    Key? key,
    required this.controler,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.widthContainer,
  }) : super(key: key);

  final TextEditingController controler;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final double widthContainer;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: size.height * 0.08,
        width: size.width * widthContainer,
        child: Center(
          child: TextField(
            controller: controler,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                ),
              ),
              hintText: hint,
            ),
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}