import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:BovinApp/screens/Modules/FichasIndividuales/FichasIndividualesResultados.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';
import 'package:BovinApp/DTO/Bovino.dart';

class FichasIndividuales extends StatefulWidget {
  const FichasIndividuales({super.key});

  @override
  State<FichasIndividuales> createState() => _FichasIndividualesState();
}

const List<String> clasificacion = [
  'Vacas',
  'Toros',
  'Terneros',
  'Novillas',
  'Bueyes'
];
const List<String> Raza = ['Holstein', 'Normando', 'Montbeliarde', 'Jersey'];

class _FichasIndividualesState extends State<FichasIndividuales> {
  TextEditingController buscar = TextEditingController();

  String razaBovino = Raza.first;
  String clasificacionBovino = clasificacion.first;
  bool bandera = true;
  Bovino objBovino = Bovino();
  late User objUser;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  validarDatos() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('InventarioBovino');
      QuerySnapshot bovinos = await ref.get();
      if (bovinos.docs.isNotEmpty) {
        for (var cursor in bovinos.docs) {
          if ((cursor.get('CodigoBovino') == buscar.text ||
                  cursor.get('NombreBovino') == buscar.text) &&
              (cursor.get('CategoriaBovino') == clasificacionBovino) &&
              (cursor.get('RazaBovino') == razaBovino)) {
            objBovino.codigoBovino = cursor.get('CodigoBovino');
            objBovino.nombreBovino = cursor.get('NombreBovino');
            objBovino.categoriaBovino = cursor.get('CategoriaBovino');
            objBovino.razaBovino = cursor.get('RazaBovino');
            objBovino.edadBovino = cursor.get('EdadBovino');
            objBovino.codigoMadre = cursor.get('CodigoMadre');
            objBovino.razaMadre = cursor.get('RazaMadre');
            objBovino.codigoPadre = cursor.get('CodigoPadre');
            objBovino.razaPadre = cursor.get('RazaPadre');
            objBovino.lecheDiaria = cursor.get('lecheDiaria');
            objBovino.ingreso = cursor.get('IngresoBovino');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FichasIndividualesResultados(objBovino)));
            print('encontrado');
            bandera = false;
            break;
          } else {
            bandera = true;
          }
        }
      }
      if (bandera == true) {
        await DialogUnBoton.alert(
            context, ' No Encontrado', '¡Bovino no encontrado!');
        print('no encontrado');
      }
    } catch (e) {
      print("error ---->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'BovinApp',
                style: TextStyle(
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
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // ignore: prefer_const_constructors
                  TextInputField(
                    maxLines: 1,
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
                            fontSize: 22,
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: clasificacionBovino,
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
                            clasificacionBovino = value!;
                          });
                        },
                        items: clasificacion
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
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
                            fontSize: 22,
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: razaBovino,
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
                            razaBovino = value!;
                          });
                        },
                        items:
                            Raza.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        validarDatos();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0)),
                        padding: const EdgeInsets.all(0),
                        minimumSize: Size(size.width * 0.5, 50.0),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Buscar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )))
      ],
    );
  }
}
