import 'package:flutter/material.dart';

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
