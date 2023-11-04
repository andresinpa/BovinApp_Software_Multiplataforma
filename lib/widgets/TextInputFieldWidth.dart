// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `TextInputFieldWidth` class is a stateless widget in Dart that represents a text input field
/// with a specified width.
class TextInputFieldWidth extends StatelessWidget {
  /// The code is defining a constructor for the `TextInputFieldWidth` class. The constructor takes
  /// several parameters, including `key`, `controler`, `icon`, `hint`, `inputType`, `inputAction`, and
  /// `widthContainer`. The `key` parameter is an optional parameter of type `Key`, while the other
  /// parameters are required.
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

  /// This function returns a widget that displays a text field with an icon and a hint text.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter is the BuildContext object that represents the
  /// location in the widget tree where this widget is being built. It is typically used to access the
  /// theme, media query, and other information about the app's current state.
  ///
  /// Returns:
  ///   The code is returning a Padding widget containing a SizedBox widget, which in turn contains a
  /// Center widget. Inside the Center widget, there is a TextField widget with various properties such
  /// as controller, decoration, keyboardType, and textInputAction.
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
