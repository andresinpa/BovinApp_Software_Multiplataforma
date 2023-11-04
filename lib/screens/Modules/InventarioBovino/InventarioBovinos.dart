import 'package:BovinApp/Design/BackgroundBottom.dart';
import 'package:BovinApp/Screens/Modules/InventarioBovino/GridInvBovino.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';

/// The class "InventarioBovinos" is a stateful widget in Dart.
class InventarioBovinos extends StatefulWidget {
  const InventarioBovinos({super.key});
  @override
  InventarioBovinosApp createState() => InventarioBovinosApp();
}

/// The `InventarioBovinosApp` class is a stateful widget that builds a scaffold with an app bar, a
/// scrollable body, and a bottom navigation bar.
class InventarioBovinosApp extends State<InventarioBovinos> {
  /// The code `int currentIndex = 1;` initializes a variable `currentIndex` with a value of 1. This
  /// variable is used to keep track of the currently selected tab in the bottom navigation bar.
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// This function builds a Scaffold with an AppBar, a SingleChildScrollView with a BackgroundBotttom
  /// widget, and a BottomNavigationBar.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter is the current build context of the widget. It is
  /// used to access the theme, media queries, and other properties of the current widget tree.
  ///
  /// Returns:
  ///   The build method is returning a Scaffold widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Inventario Bovino'),
      body: SingleChildScrollView(
        child: BackgroundBotttom(
          height: size.height * 0.935,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              const GridInvBovino(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomBar(initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }
}
