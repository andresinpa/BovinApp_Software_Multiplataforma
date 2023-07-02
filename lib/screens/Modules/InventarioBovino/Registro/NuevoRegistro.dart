import 'dart:ui';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  TextEditingController nombreFinca = TextEditingController();
  TextEditingController codigoBovino = TextEditingController();
  TextEditingController nombreBovino = TextEditingController();
  TextEditingController razaBovino = TextEditingController();
  TextEditingController categoriaBovino = TextEditingController();
  String dropdownValue = list.first;
  String dropdownValue2 = list2.first;
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
                            child: Icon(FontAwesomeIcons.cow,
                                size: size.width * 0.1),
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
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.arrowUp,
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
                    TextInputField(
                      controler: nombreFinca,
                      icon: FontAwesomeIcons.tractor,
                      hint: 'Nombre de la finca',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controler: codigoBovino,
                      icon: FontAwesomeIcons.codeFork,
                      hint: 'Código del bovino',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controler: nombreBovino,
                      icon: FontAwesomeIcons.cow,
                      hint: 'Nombre del bovino',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controler: razaBovino,
                      icon: FontAwesomeIcons.cow,
                      hint: 'Seleccione la Raza',
                      inputType: TextInputType.none,
                      inputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      underline: Container(
                        height: 2,
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
                    TextInputField(
                      controler: categoriaBovino,
                      icon: FontAwesomeIcons.shapes,
                      hint: 'Seleccione la categoría',
                      inputType: TextInputType.none,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      underline: Container(
                        height: 2,
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
