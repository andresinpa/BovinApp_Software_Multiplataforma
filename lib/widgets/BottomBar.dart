// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';

/// The `BottomBar` class is a stateful widget in Dart that represents a bottom navigation bar with an
/// initial selected index and a callback function for when a tab is selected.
class BottomBar extends StatefulWidget {
  final int initialIndex;
  final void Function(int) onTabSelected;

  /// The code `const BottomBar({ Key? key, required this.initialIndex, required this.onTabSelected, }) :
  /// super(key: key);` is the constructor for the `BottomBar` class.
  const BottomBar({
    Key? key,
    required this.initialIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

/// The `_BottomBarState` class is a stateful widget that represents a bottom navigation bar in a
/// Flutter app.
class _BottomBarState extends State<BottomBar> {
  /// The initState function in Dart initializes the currentIndex variable to the value of the
  /// initialIndex property of the widget.
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  /// This function returns a BottomNavigationBar widget with three items.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter is the build context of the widget. It is used to
  /// access the theme, localization, and other information related to the widget's position in the
  /// widget tree.
  ///
  /// Returns:
  ///   The code is returning a BottomNavigationBar widget.
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

  /// The function `setStateBottom` updates the state of the current index and performs navigation based
  /// on the selected index.
  ///
  /// Args:
  ///   index (int): The index parameter is an integer that represents the index of the selected tab. It
  /// is used to determine which tab is selected and perform the corresponding actions based on the
  /// selected tab.
  void setStateBottom(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        setState(() {
          currentIndex = index;
          widget.onTabSelected(index);
          switch (index) {
            case 0:
              Navigator.pushNamed(context, 'Home');
              break;
            case 1:
              // Handle the navigation for tab 1
              break;
            case 2:
              Navigator.pushNamed(context, 'MisTareasMetas');
              break;
            default:
              // Handle the default case
              break;
          }
        });
      } catch (e) {
        print(e);
      }
    });
  }
}
