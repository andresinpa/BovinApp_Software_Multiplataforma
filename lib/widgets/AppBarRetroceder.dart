import 'package:flutter/material.dart';

/// The `AppBarRetroceder` class is a custom implementation of an app bar in Dart that includes a back
/// button and a title.
class AppBarRetroceder extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarRetroceder({super.key, required this.title});

  /// The `@override` annotation indicates that the following method is overriding a method from a
  /// superclass or implementing an interface.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// This function returns an AppBar widget with a back button, a title, and centered title text.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is an object that provides access to various resources
  /// and information about the current build context, such as the theme, media query, and localization.
  /// It is typically passed down from the parent widget's build method.
  ///
  /// Returns:
  ///   The code is returning an AppBar widget.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
