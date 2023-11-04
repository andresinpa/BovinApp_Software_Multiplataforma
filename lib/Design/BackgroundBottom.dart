import 'package:flutter/material.dart';

/// The `BackgroundBottom` class is a widget that displays a background image at the bottom of the
/// screen, with the option to adjust its height based on the screen size.
class BackgroundBotttom extends StatelessWidget {
  final Widget child;
  final double height;

  /// The `const BackgroundBotttom` is a constructor for the `BackgroundBotttom` class. It takes three
  /// parameters: `key`, `child`, and `height`.
  const BackgroundBotttom({
    Key? key,
    required this.child,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width <= 414) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/login_register/bottom1.png",
                width: size.width,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/login_register/bottom2.png",
                width: size.width,
              ),
            ),
            ClipRect(
              child: OverflowBox(
                maxHeight: size.height,
                child: child,
              ),
            ),
          ],
        ),
      );
    } else {
      /// The code is returning a `SizedBox` widget with the width set to `double.infinity` (which means
      /// it takes up the entire available width) and the height set to `size.height` (which is the
      /// height of the screen).
      return SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[child],
        ),
      );
    }
  }
}
