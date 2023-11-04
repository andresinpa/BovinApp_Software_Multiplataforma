import 'package:flutter/material.dart';

/// The class GridInvBovino is a StatefulWidget in Dart.
class GridInvBovino extends StatefulWidget {
  const GridInvBovino({super.key});

  @override
  State<GridInvBovino> createState() => _GridInvBovinoState();
}

/// The `_GridInvBovinoState` class is a stateful widget that builds a grid view with different items,
/// each containing an image and a title, and handles navigation to different screens when an item is
/// pressed.
class _GridInvBovinoState extends State<GridInvBovino> {
  /// The `build` method is responsible for building the widget tree for the `GridInvBovino` class. It
  /// returns a `Flexible` widget containing a `GridView.count` widget. The `GridView.count` widget
  /// creates a grid view with a specified number of columns and rows.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Items item1 = Items(
        title: 'Vacas',
        img: 'assets/images/inventariobovino/bovino1.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaVacas');
        });
    Items item2 = Items(
        title: 'Toros',
        img: 'assets/images/inventariobovino/bovino2.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaToros');
        });
    Items item3 = Items(
        title: 'Terneros',
        img: 'assets/images/inventariobovino/bovino3.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaTerneros');
        });
    Items item4 = Items(
        title: 'Novillas',
        img: 'assets/images/inventariobovino/bovino4.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaNovillas');
        });

    Items item5 = Items(
        title: "Bueyes",
        img: 'assets/images/inventariobovino/bovino5.png',
        onPressed: () {
          Navigator.pushNamed(context, 'ConsultaBueyes');
        });
    Items item6 = Items(
        title: 'Nuevo Registro',
        img: 'assets/images/inventariobovino/bovino6.png',
        onPressed: () {
          Navigator.pushNamed(context, 'NuevoRegistro');
        });

    List<Items> myList = [item1, item2, item3, item4, item5, item6];
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
