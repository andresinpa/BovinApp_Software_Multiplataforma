import 'dart:io';
import 'dart:ui';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../Home/Home.dart';

class MiUsuarioYFinca extends StatefulWidget {
  const MiUsuarioYFinca({super.key});
  @override
  MiUsuarioYFincaApp createState() => MiUsuarioYFincaApp();
}

class MiUsuarioYFincaApp extends State<MiUsuarioYFinca> {
  TextEditingController nombre = TextEditingController();
  TextEditingController nombreFinca = TextEditingController();
  TextEditingController direccionFinca = TextEditingController();
  TextEditingController areaFinca = TextEditingController();
  TextEditingController unidadMedida = TextEditingController();
  final db = FirebaseFirestore.instance;
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var documento;
  insertarDatos() async {
    try {
      CollectionReference ref = db.collection('Usuarios');
      QuerySnapshot usuarios = await ref.get();

      if (usuarios.docs.isNotEmpty) {
        for (var cursor in usuarios.docs) {
          if (cursor.get('EmailUsuario') == 'widget.user.email') {
            //Corregir
            documento = (cursor.id).toString();
          }
        }
        var docRef = db.collection("Usuarios").doc(documento);
        docRef.update({
          "NombreUsuario": nombre.text,
          "FincaUsuario": nombreFinca.text,
          "DireccionFinca": direccionFinca.text,
          "AreaFinca": areaFinca.text,
          "AreaUnidadMedida": unidadMedida.text,
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error ----->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var lista = ['Metros cuadrados', 'Fanegadas'];
    String vista = 'Unidad de medida';

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
      appBar: const AppBarRetroceder(title: 'Mi Usuario y Finca'),
      body: SingleChildScrollView(
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
                      : const Icon(Icons.person, size: 75),
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.image),
              label: const Text(
                'Actualizar foto',
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
                const TextInputFieldDisabled(
                  icon: Icons.email_rounded,
                  hint: 'Correo electrónico',
                ),
                SizedBox(
                  height: size.width * 0.008,
                ),
                const TextInputFieldDisabled(
                  icon: FontAwesomeIcons.circleUser,
                  hint: 'Usuario',
                ),
                SizedBox(
                  height: size.width * 0.008,
                ),
                TextInputField(
                  icon: Icons.man_2_rounded,
                  hint: 'Nombre',
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  controler: nombre,
                ),
                SizedBox(
                  height: size.width * 0.008,
                ),
                TextInputField(
                  icon: FontAwesomeIcons.houseChimney,
                  hint: 'Nombre de la Finca',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: nombreFinca,
                ),
                SizedBox(
                  height: size.width * 0.008,
                ),
                TextInputField(
                  icon: FontAwesomeIcons.locationArrow,
                  hint: 'Dirección de la finca',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: direccionFinca,
                ),
                SizedBox(
                  height: size.width * 0.008,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.chartArea,
                      hint: 'Mi finca tiene un área de:',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      controler: areaFinca,
                    ),
                    SizedBox(
                      height: size.width * 0.008,
                    ),
                    DropdownButton(
                      items: lista.map((String valor) {
                        return DropdownMenuItem(
                            value: valor,
                            child: Text(
                              valor,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ));
                      }).toList(),
                      onChanged: (value) => {
                        //setState(() {
                        //vista = value;

                        //})
                        // ignore: avoid_print
                        unidadMedida.text = value.toString()
                      },
                      hint: Text(
                        vista,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      insertarDatos();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Home()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.all(0),
                      minimumSize: Size(size.width * 0.6, 60.0),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Actualizar y Guardar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
      bottomNavigationBar: BottomBar(
        initialIndex: currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}
