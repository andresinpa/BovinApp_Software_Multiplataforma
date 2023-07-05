import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List<String> listaEdad = [
  'Meses',
  'Años',
];

const List<String> listaRazas = [
  'Holstein',
  'Normando',
  'Montbeliarde',
  'Jersey',
];

class SiguienteRegistro extends StatelessWidget {
  const SiguienteRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Siguiente();
  }
}

class Siguiente extends StatefulWidget {
  const Siguiente({super.key});

  @override
  State<Siguiente> createState() => _SiguienteRegistroState();
}

class _SiguienteRegistroState extends State<Siguiente> {
  TextEditingController edadBovino = TextEditingController();
  TextEditingController ingreso = TextEditingController();
  TextEditingController codigoMadre = TextEditingController();
  TextEditingController razaMadre = TextEditingController();
  TextEditingController codigoPadre = TextEditingController();
  TextEditingController razaPadre = TextEditingController();
  TextEditingController lecheDiaria = TextEditingController();
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

  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Nuevo Bovino'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              const Text(
                'Ingresa algunos datos más ...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff16437),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 38,
                      ),
                      TextInputFieldWidth(
                        controler: edadBovino,
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
                        icon: const Icon(Icons.arrow_downward,
                            color: Color(0xfff16437)),
                        elevation: 16,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 38,
                      ),
                      TextInputFieldWidth(
                        controler: ingreso,
                        icon: FontAwesomeIcons.moneyCheckDollar,
                        hint: 'Ingreso a la finca',
                        inputType: TextInputType.none,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.6,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      MaterialButton(
                        onPressed: _showDatePicker,
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          size: 24,
                          color: Color(0xfff16437),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  TextInputField(
                    controler: codigoMadre,
                    icon: FontAwesomeIcons.key,
                    hint: 'Código de la madre',
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.cow), // Icono deseado
                      SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text(
                        'Selecciona la raza de la madre',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue2,
                          icon: const Icon(Icons.arrow_downward,
                              color: Color(0xfff16437)),
                          elevation: 16,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  TextInputField(
                    controler: codigoPadre,
                    icon: FontAwesomeIcons.key,
                    hint: 'Código del padre',
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.cow), // Icono deseado
                      SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text(
                        'Selecciona la raza del padre',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue2,
                          icon: const Icon(Icons.arrow_downward,
                              color: Color(0xfff16437)),
                          elevation: 16,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  const Text(
                    'Si es una vaca, agregue ...',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 38,
                      ),
                      TextInputFieldWidth(
                        controler: lecheDiaria,
                        icon: FontAwesomeIcons.bottleDroplet,
                        hint: 'Leche diaria',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.5,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Text(
                        'Litros',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0)),
                        padding: const EdgeInsets.all(0),
                        minimumSize: Size(size.width * 0.5, 50.0),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        initialIndex: currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}
