import 'package:BovinApp/Design/BackgroundBottom.dart';
import 'package:BovinApp/Screens/Modules/Produccion/GridProduccion.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';

class Produccion extends StatefulWidget {
  const Produccion({super.key});

  @override
  State<Produccion> createState() => _ProduccionState();
}

class _ProduccionState extends State<Produccion> {
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
