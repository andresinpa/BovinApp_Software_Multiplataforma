import 'package:BovinApp/Design/BackgroundBottom.dart';
import 'package:BovinApp/Screens/Modules/InventarioBovino/GridInvBovino.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';

class InventarioBovinos extends StatefulWidget {
  const InventarioBovinos({super.key});
  @override
  InventarioBovinosApp createState() => InventarioBovinosApp();
}

class InventarioBovinosApp extends State<InventarioBovinos> {
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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
