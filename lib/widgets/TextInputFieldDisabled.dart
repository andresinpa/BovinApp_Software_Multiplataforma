// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `TextInputFieldDisabled` class is a stateless widget that displays a disabled text input field
/// with an icon and a hint text.
class TextInputFieldDisabled extends StatelessWidget {
  /// The code snippet is defining a constructor for the `TextInputFieldDisabled` class.
  const TextInputFieldDisabled({
    Key? key,
    required this.icon,
    required this.hint,
  }) : super(key: key);
  final IconData icon;
  final String hint;

  /// This function returns a disabled TextField widget with a prefix icon and a hint text, wrapped in a
  /// Padding and SizedBox.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget. It
  /// is typically used to access the theme, media query, and other properties of the current widget
  /// tree.
  ///
  /// Returns:
  ///   The code is returning a Padding widget with a SizedBox as its child. The SizedBox has a
  /// specified height and width based on the size of the screen. Inside the SizedBox, there is a Center
  /// widget with a TextField as its child. The TextField is disabled and has a prefixIcon (an Icon
  /// widget) and a hintText.
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
