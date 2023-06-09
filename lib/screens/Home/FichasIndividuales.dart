import 'package:flutter/material.dart';
import 'package:bovinapp/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FichasIndividuales extends StatelessWidget {
  FichasIndividuales({super.key});
  TextEditingController buscar= TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var clasificacion = ['Vacas', 'Toros', 'Terneros', 'Novillas', 'Bueyes'];
    var Raza = ['Holstein', 'Normando', 'Montbeliarde', 'Jersey'];
    String vistaClasificacion = 'Vacas';
    String vistaRaza = 'Holstein';
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'BovinApp',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  const Image(
                    image: AssetImage('assets/images/home1/home3.png'),
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: const Text(
                      'Fichas Individuales',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'Datos Generales',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'Ingrese el nombre o codigo del bovino',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // ignore: prefer_const_constructors
                  TextInputField(
                    icon: FontAwesomeIcons.magnifyingGlass,
                    hint: 'Buscar',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    controler: buscar,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'Buscar por:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.5,
                        child: const Text(
                          'Clasificación',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      DropdownButton(
                        items: clasificacion.map((String a) {
                          return DropdownMenuItem(
                              value: a,
                              child: Text(
                                a,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ));
                        }).toList(),
                        onChanged: (value) => {
                          //setState(() {
                          //vista = value;

                          //})
                          // ignore: avoid_print
                          print(value)
                        },
                        hint: Text(
                          vistaClasificacion,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.4,
                        child: const Text(
                          'Raza',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      DropdownButton(
                        items: Raza.map((String a) {
                          return DropdownMenuItem(
                              value: a,
                              child: Text(
                                a,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ));
                        }).toList(),
                        onChanged: (value) => {
                          //setState(() {
                          //vista = value;

                          //})
                          // ignore: avoid_print
                          print(value)
                        },
                        hint: Text(
                          vistaRaza,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, 'FichasIndividualesResultados');
                    },
                    child: const RoundedButton(
                        buttonName: 'Buscar',
                        rute: 'FichasIndividualesResultados'),
                  ),
                ],
              ),
            )))
      ],
    );
  }
}
