import 'package:flutter/material.dart';

/// The `BackgroundSimple` class is a widget that displays a background image with different layouts
/// based on the screen size.
class BackgroundSimple extends StatelessWidget {
  final Widget child;

  /// The `BackgroundSimple` class is a widget that takes a `child` widget as a parameter. The `const
  /// BackgroundSimple({ ... })` is the constructor of the class.
  const BackgroundSimple({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width <= 414) {
      return SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/login_register/top1.png",
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
      /// The code is returning a `SizedBox` widget with the specified width and height. Inside the
      /// `SizedBox`, there is a `Stack` widget that allows multiple widgets to be stacked on top of
      /// each other. The `alignment` property of the `Stack` is set to `Alignment.center`, which means
      /// the child widgets will be centered within the `Stack`.
      return SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 10,
              right: 40,
              child: Image.asset("login_register/main.png",
                  width: size.width * 0.3),
            ),
            child
          ],
        ),
      );
    }
  }
}
