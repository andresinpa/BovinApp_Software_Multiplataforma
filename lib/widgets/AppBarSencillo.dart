// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The `AppBarSencillo` class is a simple implementation of an app bar in Dart, with a customizable
/// title.
class AppBarSencillo extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarSencillo({super.key, required this.title});

  /// The `@override` annotation indicates that the following method is overriding a method from a
  /// superclass or implementing an interface.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// This function returns an AppBar widget with a centered title and no leading icon.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the location of a widget within the
  /// widget tree. It is used to access the properties and methods of the current widget and its
  /// ancestors.
  ///
  /// Returns:
  ///   The code is returning an AppBar widget.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }
}
