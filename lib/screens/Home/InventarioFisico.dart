import 'package:flutter/material.dart';

class InventarioFisico extends StatelessWidget {
  const InventarioFisico({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'BovinApp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.exit_to_app_rounded),
                onPressed: () {},
              ),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.only(top: 5),
            child: MatrizImagenes(),
          ),
        ),
      ],
    );
  }
}

class MatrizImagenes extends StatelessWidget {
  const MatrizImagenes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        const Column(
          children: <Widget>[
            SizedBox(
              height: 109,
            ),
            Row(
              children: [
                SizedBox(
                  width: 56.5,
                ),
                Text(
                  'Inventario ',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Row(
              children: [
                const Text(
                  'Fisíco',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/icon/icon.png',
                  width: 90,
                  height: 90,
                ),
              ],
            ),
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'ConsultaAlimentos'),
                child: Image.asset('assets/images/inventario/Inventario1.png',
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Alimentos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'ConsultaMedicamentos'),
                child: Image.asset('assets/images/inventario/Inventario2.png',
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Medicamentos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'ConsultaFerreteria'),
                child: Image.asset('assets/images/inventario/Inventario3.png',
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Ferretería',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'ConsultaMaquinaria'),
                child: Image.asset('assets/images/inventario/Inventario4.png',
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Maquinaria',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'ConsultaOtros'),
                child: Image.asset('assets/images/inventario/Inventario5.png',
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Otros',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, 'NuevoRegistroInventarioFisico'),
                child: Image.asset('assets/images/inventario/Inventario6.png',
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Nuevo registro',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////
      ],
    );
  }
}
