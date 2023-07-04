import 'package:flutter/material.dart';

class GridInvBovino extends StatefulWidget {
  const GridInvBovino({super.key});

  @override
  State<GridInvBovino> createState() => _GridInvBovinoState();
}

class _GridInvBovinoState extends State<GridInvBovino> {
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
