// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';

/// The `RoundedButton` class is a stateless widget in Dart that creates a rounded button with a
/// specified name and route.
class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.buttonName,
    required this.rute,
  }) : super(key: key);

  final String buttonName;
  final String rute;

  /// This function returns a TextButton widget with a specified height, width, and onPressed action,
  /// which navigates to a specified route when pressed.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget. It is
  /// typically used to access the theme, media queries, and other information related to the current
  /// widget tree.
  ///
  /// Returns:
  ///   A SizedBox widget is being returned.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.08,
      width: size.width * 0.8,
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, rute),
        child: Text(
          buttonName,
        ),
      ),
    );
  }
}
