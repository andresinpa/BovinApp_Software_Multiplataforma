import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// The line `const List<String> listaInformes = ['ProduccionLeche','InventarioFisicio','InventarioBovino','ProduccionCarne',];` is
/// declaring a constant list of strings named `listaInformes`.
const List<String> listaInformes = [
  'ProduccionLeche',
  'InventarioFisico',
  'InventarioBovino',
  'ProduccionCarne',
];

class Informes extends StatefulWidget {
  const Informes({super.key});
  @override
  InformesApp createState() => InformesApp();
}

class InformesApp extends State<Informes> {
  /// The line `final db = FirebaseFirestore.instance;` creates an instance of the `FirebaseFirestore`
  /// class, which is used to interact with the Firestore database. This instance is stored in the
  /// variable `db` for later use.
  final firebase = FirebaseFirestore.instance;
  late User objUser;
  String consulta = 'InventarioBovino';
  final pdf = pw.Document();

  /// The initState function retrieves the user object from the UserProvider using the Provider package in
  /// Dart.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// The function `validarDatos()` validates data and saves it to a Firestore database if all required
  /// fields are not empty.
  validarDatos() async {
    try {
      if (consulta == 'InventarioBovino') {
        final QuerySnapshot snapshot = await firebase
            .collection('Usuarios')
            .doc(objUser.usuario)
            .collection(consulta)
            .get();

        for (final DocumentSnapshot doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          final page = pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Información del inventario Bovino',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Bovino: ${data['NombreBovino']}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  // Agrega los datos del bovino en una tabla
                  pw.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      ['Campo', 'Valor'],
                      ...data.entries.map((entry) {
                        return [entry.key, entry.value.toString()];
                      }),
                    ],
                  ),
                ],
              );
            },
          );

          pdf.addPage(page);
        }
      }

      if (consulta == 'InventarioFisico') {
        final QuerySnapshot snapshot = await firebase
            .collection('Usuarios')
            .doc(objUser.usuario)
            .collection(consulta)
            .get();

        for (final DocumentSnapshot doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          final page = pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Información del inventario fisico',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Producto: ${data['NombreProducto']}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  // Agrega los datos del bovino en una tabla
                  pw.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      ['Campo', 'Valor'],
                      ...data.entries.map((entry) {
                        return [entry.key, entry.value.toString()];
                      }),
                    ],
                  ),
                ],
              );
            },
          );

          pdf.addPage(page);
        }
      }
      if (consulta == 'ProduccionLeche') {
        final QuerySnapshot snapshot = await firebase
            .collection('Usuarios')
            .doc(objUser.usuario)
            .collection(consulta)
            .get();

        for (final DocumentSnapshot doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final collectionName = doc.id;

          final page = pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Información de la producción de leche',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Fecha: $collectionName',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  // Agrega los datos del bovino en una tabla
                  pw.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      ['Campo', 'Valor'],
                      ...data.entries.map((entry) {
                        return [entry.key, entry.value.toString()];
                      }),
                    ],
                  ),
                ],
              );
            },
          );

          pdf.addPage(page);
        }
      }
      if (consulta == 'ProduccionCarne') {
        final QuerySnapshot snapshot = await firebase
            .collection('Usuarios')
            .doc(objUser.usuario)
            .collection(consulta)
            .get();

        for (final DocumentSnapshot doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          final page = pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Información de la producción carne',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Bovino: ${data['NombreBovino']}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  // Agrega los datos del bovino en una tabla
                  pw.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      ['Campo', 'Valor'],
                      ...data.entries.map((entry) {
                        return [entry.key, entry.value.toString()];
                      }),
                    ],
                  ),
                ],
              );
            },
          );

          pdf.addPage(page);
        }
      }

      // Genera el PDF y lo guarda en el dispositivo
      final pdfFile = await pdf.save();

      // Muestra el PDF con la biblioteca 'printing'
      final pdfBytes = await pdfFile;
      await Printing.layoutPdf(
        onLayout: (format) => pdfBytes,
      );
    } catch (e) {
      print("error ----->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha Individual'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Informes',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: size.width * 0.05,
              ),
              const Align(
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.shapes), // Icono deseado
                      SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text(
                        'Seleccione el tipo de informe',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              DropdownButton<String>(
                value: consulta,
                icon:
                    const Icon(Icons.arrow_downward, color: Color(0xfff16437)),
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    consulta = value!;
                  });
                },
                items:
                    listaInformes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      validarDatos();
                    },
                    child: const Text('Generar informe'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
