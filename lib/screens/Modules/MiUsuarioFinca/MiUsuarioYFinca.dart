import 'dart:ui';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    var lista = ['metros cuadrados', 'fanegadas'];
    String vista = 'selecciona una opción';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Mi Usuario y Finca'),
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
                        child:
                            Icon(FontAwesomeIcons.user, size: size.width * 0.1),
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
                const TextInputFieldDisabled(
                  icon: FontAwesomeIcons.circleUser,
                  hint: 'Correo electrónico',
                ),
                const SizedBox(
                  height: 25,
                ),
                const TextInputFieldDisabled(
                  icon: FontAwesomeIcons.circleUser,
                  hint: 'Usuario',
                ),
                TextInputField(
                  icon: FontAwesomeIcons.envelope,
                  hint: 'Nombre',
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  controler: nombre,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextInputField(
                  icon: FontAwesomeIcons.locationArrow,
                  hint: 'Nombre de la Finca',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: nombreFinca,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextInputField(
                  icon: FontAwesomeIcons.locationArrow,
                  hint: 'Dirección de la finca',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: direccionFinca,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.rectangleXmark,
                      hint: 'Mi finca tiene un área de:',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      controler: areaFinca,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButton(
                      items: lista.map((String a) {
                        return DropdownMenuItem(
                            value: a,
                            child: Text(
                              a,
                              style: const TextStyle(
                                fontSize: 28,
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
                          fontSize: 28,
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          insertarDatos();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Home()));
                        },
                        child: const Text(
                          'Actualizar y Guardar',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
