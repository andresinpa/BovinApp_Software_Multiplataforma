// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// The class GridInvFisico is a StatefulWidget in Dart.
class GridInvFisico extends StatefulWidget {
  const GridInvFisico({super.key});

  @override
  State<GridInvFisico> createState() => _GridInvFisicoState();
}

/// The `_GridInvFisicoState` class is a stateful widget that builds a grid view with different items,
/// each containing an image and a title, and handles navigation to different screens when an item is
/// pressed.
class _GridInvFisicoState extends State<GridInvFisico> {
  /// The `build` method in the `_GridInvFisicoState` class is responsible for creating the user
  /// interface for the `GridInvFisico` widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Items item1 = Items(
        title: 'Alimentos',
        img: 'assets/images/inventario/Inventario1.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaAlimentos');
        });
    Items item2 = Items(
        title: 'Medicamentos',
        img: 'assets/images/inventario/Inventario2.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaMedicamentos');
        });
    Items item3 = Items(
        title: 'Ferretería',
        img: 'assets/images/inventario/Inventario3.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaFerreteria');
        });
    Items item4 = Items(
        title: 'Maquinaria',
        img: 'assets/images/inventario/Inventario4.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaMaquinaria');
        });

    Items item5 = Items(
        title: "Insumos",
        img: 'assets/images/inventario/Inventario5.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaOtros');
        });
    Items item6 = Items(
        title: 'Nuevo Registro',
        img: 'assets/images/inventario/Inventario6.png',
        onPressed: () {
          Navigator.pushNamed(context, 'NuevoRegistroInventarioFisico');
        });

    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xffffccbc;
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
