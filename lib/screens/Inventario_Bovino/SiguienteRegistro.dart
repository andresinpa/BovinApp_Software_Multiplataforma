import 'package:BovinApp/Widgets/TextInputFieldOtros.dart';
import 'package:BovinApp/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List<String> listaEdad = [
  'Meses',
  'Años',
];

const List<String> listaRazas = [
  '',
  'Holstein',
  'Normando',
  'Montbeliarde',
  'Jersey',
];

class SiguienteRegistro extends StatelessWidget {
  const SiguienteRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Siguiente(),
        ),
      ),
    );
  }
}

class Siguiente extends StatefulWidget {
  const Siguiente({super.key});

  @override
  State<Siguiente> createState() => _SiguienteRegistroState();
}

class _SiguienteRegistroState extends State<Siguiente> {
  String dropdownValue = listaEdad.first;
  String dropdownValue2 = listaRazas.first;
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2008),
      lastDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(),
        ),
        Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.3,
                  ),
                  const Text(
                    'Registro de bovinos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  const Text(
                    'Ingresa algunos datos más ...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 38,
                          ),
                          const TextInputFieldOtros(
                            icon: FontAwesomeIcons.cakeCandles,
                            hint: 'Edad',
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.next,
                            widthContainer: 0.4,
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: listaEdad
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 38,
                          ),
                          const TextInputFieldOtros(
                            icon: FontAwesomeIcons.moneyCheckDollar,
                            hint: 'Ingreso a la finca',
                            inputType: TextInputType.none,
                            inputAction: TextInputAction.next,
                            widthContainer: 0.6,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          MaterialButton(
                            onPressed: _showDatePicker,
                            child: const Icon(
                              Icons.calendar_month_rounded,
                              size: 38,
                            ),
                          ),
                        ],
                      ),
                      const TextInputFieldOtros(
                        icon: FontAwesomeIcons.key,
                        hint: 'Código de la madre',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 38,
                          ),
                          const TextInputFieldOtros(
                            icon: FontAwesomeIcons.cow,
                            hint: 'Raza',
                            inputType: TextInputType.none,
                            inputAction: TextInputAction.next,
                            widthContainer: 0.3,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          DropdownButton<String>(
                            value: dropdownValue2,
                            elevation: 16,
                            style: const TextStyle(fontSize: 20),
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue2 = value!;
                              });
                            },
                            items: listaRazas
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const TextInputFieldOtros(
                        icon: FontAwesomeIcons.key,
                        hint: 'Código del padre',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 38,
                          ),
                          const TextInputFieldOtros(
                            icon: FontAwesomeIcons.cow,
                            hint: 'Raza',
                            inputType: TextInputType.none,
                            inputAction: TextInputAction.next,
                            widthContainer: 0.3,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          DropdownButton<String>(
                            value: dropdownValue2,
                            elevation: 16,
                            style: const TextStyle(fontSize: 20),
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue2 = value!;
                              });
                            },
                            items: listaRazas
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'En caso de que sea vaca ...',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          SizedBox(
                            width: 38,
                          ),
                          TextInputFieldOtros(
                            icon: FontAwesomeIcons.bottleDroplet,
                            hint: 'Leche diaria',
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.next,
                            widthContainer: 0.5,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Litros',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const RoundedButton(
                        buttonName: 'Registrar',
                        rute: "",
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
