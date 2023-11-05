// ignore_for_file: file_names

import 'package:BovinApp/Design/BackgroundBottom.dart';
import 'package:BovinApp/Screens/Modules/InventarioFisico/GridInvFisico.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';

/// The class InventarioFisico is a StatefulWidget in Dart.
class InventarioFisico extends StatefulWidget {
  const InventarioFisico({super.key});
  @override
  InventarioFisicoApp createState() => InventarioFisicoApp();
}

/// The `InventarioFisicoApp` class is a stateful widget that represents the main app screen for an
/// inventory management application.
class InventarioFisicoApp extends State<InventarioFisico> {
  /// The function `onTabSelected` updates the `currentIndex` variable with the provided `index` value.
  ///
  /// Args:
  ///   index (int): The index parameter is the new index of the selected tab.
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// This function builds a Scaffold with an AppBar, a SingleChildScrollView containing a
  /// BackgroundBotttom widget, and a BottomNavigationBar.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter is the current build context of the widget. It is
  /// typically used to access the theme, media queries, and other properties of the current widget tree.
  ///
  /// Returns:
  ///   The build method is returning a Scaffold widget.

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Inventario Fisíco'),
      body: SingleChildScrollView(
        child: BackgroundBotttom(
          height: size.height * 0.935,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              const GridInvFisico(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomBar(initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }
}
