import 'package:flutter/material.dart';

class GridDashboard extends StatefulWidget {
  const GridDashboard({super.key});

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Items item1 = Items(
        title: 'Mi usuario y finca',
        img: 'assets/images/home1/Home1.png',
        onPressed: () {
          Navigator.pushNamed(context, 'MiUsuarioYFinca');
        });
    Items item2 = Items(
        title: 'Inventario Bovino',
        img: 'assets/images/home1/home2.png',
        onPressed: () {
          Navigator.pushNamed(context, 'InventarioBovinos');
        });
    Items item3 = Items(
        title: 'Fichas individuales',
        img: 'assets/images/home1/home3.png',
        onPressed: () {
          Navigator.pushNamed(context, 'FichasIndividuales');
        });
    Items item4 = Items(
        title: 'Inventario Fisico',
        img: 'assets/images/home1/home4.png',
        onPressed: () {
          Navigator.pushNamed(context, 'InventarioFisico');
        });

    Items item5 = Items(
        title: "Producción",
        img: 'assets/images/home1/home5.png',
        onPressed: () {
          Navigator.pushNamed(context, 'Produccion');
        });
    Items item6 = Items(
        title: 'Informes de mi finca',
        img: 'assets/images/home1/home7.png',
        onPressed: () {
          Navigator.pushNamed(context, 'RazasBovinosUbate');
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

class Items {
  String title;
  String img;
  Function()? onPressed;
  Items({required this.title, required this.img, this.onPressed});
}
