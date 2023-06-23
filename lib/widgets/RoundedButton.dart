// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.buttonName,
    required this.rute,
  }) : super(key: key);

  final String buttonName;
  final String rute;

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
