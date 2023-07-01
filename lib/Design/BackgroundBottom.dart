import 'package:flutter/material.dart';

class BackgroundBotttom extends StatelessWidget {
  final Widget child;

  const BackgroundBotttom({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width <= 414) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.935,
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
