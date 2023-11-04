import 'package:BovinApp/Design/BackgroundBottom.dart';
import 'package:BovinApp/Screens/Modules/Produccion/GridProduccion.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';

/// The class "Produccion" is a stateful widget in Dart.
class Produccion extends StatefulWidget {
  const Produccion({super.key});

  @override
  State<Produccion> createState() => _ProduccionState();
}

class _ProduccionState extends State<Produccion> {
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

  /// This function builds a Scaffold with an AppBar, a SingleChildScrollView, a BackgroundBotttom widget,
  /// and a BottomBar widget.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the location of a widget within the
  /// widget tree. It is used to access the properties and methods of the current widget and its
  /// ancestors.
  ///
  /// Returns:
  ///   The build method is returning a Scaffold widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Producción'),
      body: SingleChildScrollView(
        child: BackgroundBotttom(
          height: size.height * 0.935,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              const GridProduccion(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomBar(initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }
}
