import 'dart:ui';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const List<String> listaEstado = [
  'Muerto',
  'Vivo Enfermo',
  'Vivo Sano',
];

class NuevoRegistroProduccionCarne extends StatefulWidget {
  const NuevoRegistroProduccionCarne({super.key});

  @override
  State<NuevoRegistroProduccionCarne> createState() =>
      _NuevoRegistroProduccionCarneState();
}

class _NuevoRegistroProduccionCarneState
    extends State<NuevoRegistroProduccionCarne> {
  TextEditingController codigoBovino = TextEditingController();
  TextEditingController pesoNacido = TextEditingController();
  TextEditingController pesoMuerto = TextEditingController();
  TextEditingController observaciones = TextEditingController();
  TextEditingController valorVendido = TextEditingController();

  String estado = listaEstado.first;

  bool bandera = true;
  final firebase = FirebaseFirestore.instance;

  late User objUser;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  validarDatos() async {
    try {
      DateTime now = DateTime.now();
      // Formatea la fecha en el formato "yyyy-MM-dd"
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      DocumentReference docRef = firebase
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('InventarioBovino')
          .doc(codigoBovino.text);
      docRef.get().then((docSnapshot) {
        if (docSnapshot.exists) {
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;

          // Agrega el nuevo campo a los datos actuales
          data['DatosSalidaBovino'] = [
            'Peso Nacido: ' + pesoNacido.text,
            'Peso Muerto: ' + pesoMuerto.text,
            'Observaciones: ' + observaciones.text,
            'Valor Vendido: ' + valorVendido.text,
            'Estado: $estado',
            'Fecha Registro: $formattedDate'
          ];
          firebase
              .collection('Usuarios')
              .doc(objUser.usuario)
              .collection('ProduccionCarne')
              .doc(codigoBovino.text)
              .set(data);
          print('Registro exitoso');
          docRef.delete();
          print("Documento eliminado con éxito");
        } else {}
      });
    } catch (e) {
      print("error ---->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Registro producción carne'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Codigo Bovino',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: codigoBovino,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Peso nacido en Kg',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: pesoNacido,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Peso actual o cuando murio en Kg',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: pesoMuerto,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Observaciones',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: observaciones,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  DropdownButton<String>(
                    value: estado,
                    icon: const Icon(Icons.arrow_downward,
                        color: Color(0xfff16437)),
                    elevation: 16,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        estado = value!;
                      });
                    },
                    items: listaEstado
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Valor vendido',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: valorVendido,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        validarDatos();
                        Navigator.pushNamed(context, 'Produccion');
                      },
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
