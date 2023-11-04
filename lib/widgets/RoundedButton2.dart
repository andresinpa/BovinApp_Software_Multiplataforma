// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `RoundedButton2` class is a stateless widget in Dart that creates a rounded button with
/// customizable properties such as button name, route, width, and height.
class RoundedButton2 extends StatelessWidget {
  const RoundedButton2({
    Key? key,
    required this.buttonName,
    required this.rute,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String buttonName;
  final String rute;
  final double width;
  final double height;

  /// This function returns a TextButton widget with a specified size and text, which navigates to a
  /// specified route when pressed.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget. It
  /// is typically used to access the theme, media queries, and other information related to the
  /// widget's position in the widget tree.
  ///
  /// Returns:
  ///   The code is returning a SizedBox widget with a TextButton child.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * width,
      width: size.width * height,
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, rute),
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
