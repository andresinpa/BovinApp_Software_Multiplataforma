import 'package:flutter/material.dart';

class AppBarSencillo extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarSencillo({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
