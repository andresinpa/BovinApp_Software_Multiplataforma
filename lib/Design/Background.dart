import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
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
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/login_register/top2.png",
                width: size.width,
              ),
            ),
            Positioned(
              top: 30,
              right: 20,
              child: Image.asset(
                "assets/login_register/main.png",
                width: size.width * 0.35,
              ),
            ),
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
