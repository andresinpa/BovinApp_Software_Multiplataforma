// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `TextInputField` class is a stateless widget that represents a text input field with
/// customizable properties such as controller, icon, hint, input type, input action, and maximum lines.
class TextInputField extends StatelessWidget {
  /// The code is defining a class called `TextInputField` which is a stateless widget in Dart. The
  /// class has several properties such as `controller`, `icon`, `hint`, `inputType`, `inputAction`, and
  /// `maxLines`. These properties are required and must be provided when creating an instance of the
  /// `TextInputField` class.
  const TextInputField({
    Key? key,
    required this.controler,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.maxLines,
  }) : super(key: key);
  final TextEditingController controler;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final dynamic maxLines;

  /// This function returns a TextField widget wrapped in a Padding widget with specified size and
  /// decoration.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget. It
  /// is typically used to access the theme, media query, and other properties of the current widget
  /// tree.
  ///
  /// Returns:
  ///   The code is returning a Padding widget with a SizedBox as its child. The SizedBox has a
  /// specified height and width based on the size of the device screen. Inside the SizedBox, there is a
  /// Center widget that contains a TextField widget. The TextField has various properties such as
  /// maxLines, controller, decoration, keyboardType, and textInputAction.
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
            maxLines: maxLines,
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
