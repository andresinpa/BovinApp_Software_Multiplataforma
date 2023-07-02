import 'package:flutter/material.dart';

class TextInputFieldDisabled extends StatelessWidget {
  const TextInputFieldDisabled({
    Key? key,
    required this.icon,
    required this.hint,
  }) : super(key: key);
  final IconData icon;
  final String hint;

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
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                ),
              ),
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }
}
