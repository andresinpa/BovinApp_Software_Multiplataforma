// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int initialIndex;
  final void Function(int) onTabSelected;

  const BottomBar({
    Key? key,
    required this.initialIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: setStateBottom,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.agriculture_rounded),
          label: 'Mi Finca',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_work),
          label: 'BovinApp',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendario',
        ),

        // BottomNavigationBarItem(icon: Icon(Icons.settings)),
      ],
    );
  }

  void setStateBottom(int index) {
    setState(() {
      currentIndex = index;
      widget.onTabSelected(index);
      switch (index) {
        case 0:
          Navigator.pop(context);
          break;
        case 1:
          break;
        case 2:
          Navigator.pushNamed(context, 'MisTareasMetas');
          break;
        default:
          break;
      }
    });
  }
}
