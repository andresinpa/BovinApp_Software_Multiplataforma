// ignore_for_file: file_names

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

class ConsultasToros extends StatefulWidget {
  const ConsultasToros({super.key});
  @override
  ConsultaTorosApp createState() => ConsultaTorosApp();
}

class ConsultaTorosApp extends State<ConsultasToros> {
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final db = FirebaseFirestore.instance;
  late User objUser;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Mis Toros'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Usuarios')
                .doc(objUser.usuario)
                .collection('InventarioBovino')
                .snapshots(),
            builder: (context, snapshot) {
              // Obtén los documentos de la colección
              final documentos = snapshot.data?.docs ?? [];
              // Separa los documentos en dos listas según el valor de "categoria"
              final categoriaToros = documentos
                  .where((doc) => doc['CategoriaBovino'] == 'Toros')
                  .toList();
              if (categoriaToros.isEmpty) {
                // Muestra un mensaje si no hay información en la categoría.
                return const Text('No hay información disponible.');
              }
              return ListView(
                children: <Widget>[
                  _buildCategoria("🐮", categoriaToros),
                ],
              );
            },
          ),
          bottomNavigationBar: BottomBar(
                initialIndex: currentIndex, onTabSelected: onTabSelected),
        ),
      ],
    );
  }

  Widget _buildCategoria(String title, List<QueryDocumentSnapshot> documentos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: documentos.length,
          itemBuilder: (context, index) {
            final documento = documentos[index];
            final nombre = documento['NombreBovino'];
            final codigo = documento['CodigoBovino'];
            final raza = documento['RazaBovino'];
            final edad = documento['EdadBovino'];

            return Card(
              elevation: 3, // Agrega una sombra alrededor del elemento.
              margin: const EdgeInsets.all(10), // Márgenes alrededor del elemento.
              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(10), // Espacio interno del ListTile.
                leading: CircleAvatar(
                  // Agrega una imagen o avatar en la parte izquierda.
                  backgroundColor: Colors.blue, // Color de fondo del avatar.
                  child: Text(nombre[0], style: const TextStyle(color: Colors.white)),
                ),
                title: Text(
                  nombre,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Código: $codigo"),
                    Text("Raza: $raza"),
                    Text("Edad: $edad años"),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
