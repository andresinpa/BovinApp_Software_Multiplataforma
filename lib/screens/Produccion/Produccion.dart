import 'package:bovinapp/widgets/RoundedButton2.dart';
import 'package:flutter/material.dart';

class Produccion extends StatefulWidget {
  const Produccion({super.key});

  @override
  State<Produccion> createState() => _ProduccionState();
}

class _ProduccionState extends State<Produccion> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'BovinApp',
              style: TextStyle(
                color: Colors.black,
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
            child: MatrizImagenesProduccion(),
          ),
        ),
      ],
    );
  }
}

class MatrizImagenesProduccion extends StatefulWidget {
  const MatrizImagenesProduccion({
    Key? key,
  }) : super(key: key);

  @override
  State<MatrizImagenesProduccion> createState() =>
      _MatrizImagenesProduccionState();
}

class _MatrizImagenesProduccionState extends State<MatrizImagenesProduccion> {
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        const Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                SizedBox(
                  width: 32,
                ),
                Text(
                  'Historial de',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                SizedBox(
                  width: 0.08,
                ),
                Text(
                  'Producción',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.production_quantity_limits_rounded,
                  size: 32,
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/produccion/produccion1.png'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Carne',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, ''),
                child: Image.asset('assets/images/produccion/produccion2.png',
                    fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Leche',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/produccion/produccion3.png'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Reproducción',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
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
                color: const Color.fromARGB(156, 109, 184, 194),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/produccion/produccion4.png'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Nuevo Registro',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(156, 38, 88, 153),
                    fontSize: 18),
              ),
            )
          ],
        ),

        //////////////////////////////////////////////////////////////////////////////////////

        Column(
          children: <Widget>[
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color.fromARGB(255, 0, 4, 255)
                            .withOpacity(.32);
                      }
                      return Colors.orange;
                    }),
                    value: isChecked,
                    onChanged: (bool? value) => {
                          setState(() {
                            isChecked = value!;
                          }),
                        }),
                const Text(
                  'Carne',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color.fromARGB(255, 0, 4, 255)
                            .withOpacity(.32);
                      }
                      return Colors.orange;
                    }),
                    value: isChecked1,
                    onChanged: (bool? value) => {
                          setState(() {
                            isChecked1 = value!;
                          }),
                        }),
                const Text(
                  'Leche',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color.fromARGB(255, 0, 4, 255)
                            .withOpacity(.32);
                      }
                      return Colors.orange;
                    }),
                    value: isChecked2,
                    onChanged: (bool? value) => {
                          setState(() {
                            isChecked2 = value!;
                          }),
                        }),
                const Text(
                  'Reproducción',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),

        const Column(
          children: [
            RoundedButton2(
              buttonName: 'Generar informe imprimible',
              rute: '',
              width: 0.15,
              height: 0.4,
            ),
          ],
        ),
      ],
    );
  }
}
