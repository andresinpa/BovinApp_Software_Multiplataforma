import 'dart:ui';

import 'package:bovinapp/palette.dart';
import 'package:bovinapp/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/TextInputFieldOtros.dart';

const List<String> list = [
  'Holstein',
  'Normando',
  'Montbeliarde',
  'Jersey',
];

const List<String> list2 = [
  'Vacas',
  'Toros',
  'Terneros',
  'Novillas',
  'Bueyes',
];

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('BovinApp')),
        body: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: NuevoRegistro(),
        ),
      ),
    );
  }
}

class NuevoRegistro extends StatefulWidget {
  const NuevoRegistro({super.key});

  @override
  State<NuevoRegistro> createState() => _NuevoRegistroState();
}

class _NuevoRegistroState extends State<NuevoRegistro> {
  String dropdownValue = list.first;
  String dropdownValue2 = list2.first;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 4,
                            sigmaY: 4,
                          ),
                          child: CircleAvatar(
                            radius: size.width * 0.15,
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            child: Icon(FontAwesomeIcons.cow,
                                color: kWhite, size: size.width * 0.1),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kWhite,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    const TextInputFieldOtros(
                      icon: FontAwesomeIcons.tractor,
                      hint: 'Nombre de la finca',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      widthContainer: 0.8,
                    ),
                    const TextInputFieldOtros(
                      icon: FontAwesomeIcons.codeFork,
                      hint: 'Código del bovino',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      widthContainer: 0.8,
                    ),
                    const TextInputFieldOtros(
                      icon: FontAwesomeIcons.cow,
                      hint: 'Nombre del bovino',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      widthContainer: 0.8,
                    ),
                    const TextInputFieldOtros(
                      icon: FontAwesomeIcons.cow,
                      hint: 'Seleccione la Raza',
                      inputType: TextInputType.none,
                      inputAction: TextInputAction.next,
                      widthContainer: 0.8,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const TextInputFieldOtros(
                      icon: FontAwesomeIcons.shapes,
                      hint: 'Seleccione la categoría',
                      inputType: TextInputType.none,
                      inputAction: TextInputAction.done,
                      widthContainer: 0.8,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue2 = value!;
                        });
                      },
                      items:
                          list2.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const RoundedButton(
                      buttonName: 'Siguiente',
                      rute: "SiguienteRegistro",
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
