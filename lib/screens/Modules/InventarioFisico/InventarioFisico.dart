import 'package:BovinApp/Design/BackgroundBottom.dart';
import 'package:BovinApp/Screens/Modules/InventarioFisico/GridInvFisico.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';

class InventarioFisico extends StatefulWidget {
  const InventarioFisico({super.key});
  @override
  InventarioFisicoApp createState() => InventarioFisicoApp();
}

class InventarioFisicoApp extends State<InventarioFisico> {
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
