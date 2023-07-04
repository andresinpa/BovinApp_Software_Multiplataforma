import 'dart:io';
import 'dart:ui';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ImagePicker _imagePicker = ImagePicker();
    File? _pickedImage;
    Future<void> _pickImage(ImageSource source) async {
      final pickedImage = await _imagePicker.pickImage(source: source);
      setState(() {
        _pickedImage = pickedImage != null ? File(pickedImage.path) : null;
      });
    }

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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffe3ffff),
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: const Color(0xff7081cb)),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 142,
                    height: 142,
                    child: _pickedImage != null
                        ? Image.file(
                            _pickedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(FontAwesomeIcons.cow, size: 75),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(FontAwesomeIcons.image),
                label: const Text(
                  'Foto del bovino',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  iconColor:
                      MaterialStateProperty.all<Color>(const Color(0xfff16437)),
                ),
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
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    controler: codigoBovino,
                    icon: FontAwesomeIcons.codeFork,
                    hint: 'Código del bovino',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    controler: nombreBovino,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Nombre del bovino',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  Column(
                    children: [
                      TextInputField(
                        controler: razaBovino,
                        icon: FontAwesomeIcons.cow,
                        hint: 'Seleccione la Raza',
                        inputType: TextInputType.none,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: size.width * 0.008,
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
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
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
                      TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, 'SiguienteRegistro');
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: Colors.deepOrange),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.all(0),
                          minimumSize: Size(size.width * 0.6, 60.0),
                        ),
                        child: const Text(
                          'Continuar Registro',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.1,
                      ),
                    ],
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
