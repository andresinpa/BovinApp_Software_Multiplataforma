// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The class GridProduccion is a StatefulWidget in Dart.
class GridProduccion extends StatefulWidget {
  const GridProduccion({super.key});

  @override
  State<GridProduccion> createState() => _GridProduccionState();
}

/// The `_GridProduccionState` class builds a flexible grid view with multiple items, each containing an
/// image and a title, and handles navigation to different screens when an item is pressed.

class _GridProduccionState extends State<GridProduccion> {
  /// The `build` method in the `_GridProduccionState` class is responsible for creating the user
  /// interface for the `GridProduccion` widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Items item1 = Items(
        title: 'Leche del Bovino',
        img: 'assets/images/produccion/produccion2.png',
        onPressed: () {
          Navigator.pushNamed(context, 'RegistroLecheBovino');
        });
    Items item2 = Items(
        title: 'Leche del Hato',
        img: 'assets/images/produccion/produccion4.png',
        onPressed: () {
          Navigator.pushNamed(context, 'RegistroLecheGeneral');
        });
    Items item3 = Items(
        title: 'Consulta Produccion Leche',
        img: 'assets/images/home2/home1.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ProduccionLecheHato');
        });
    Items item4 = Items(
        title: 'Carne y ventas',
        img: 'assets/images/produccion/produccion1.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ProduccionCarne');
        });
    Items item5 = Items(
        title: 'Produccion carne',
        img: 'assets/images/produccion/produccion1.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ProduccionConsultaCarne');
        });

    List<Items> myList = [item1, item2, item3, item4, item5];
    var color = 0xffffccbc;

    /// The code is returning a `Flexible` widget that contains a `GridView.count` widget.
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
              color: Color(color),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: data.onPressed,
                  child: Image.asset(data.img, width: size.width * 0.3),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff1d38ae),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// The class "Items" represents an item with a title, image, and an optional onPressed function.
class Items {
  String title;
  String img;
  Function()? onPressed;
  Items({required this.title, required this.img, this.onPressed});
}
