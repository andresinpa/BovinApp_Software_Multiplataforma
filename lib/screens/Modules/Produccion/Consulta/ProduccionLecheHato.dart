import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

class ProduccionLecheHato extends StatefulWidget {
  const ProduccionLecheHato({super.key});
  ProduccionLecheHatoApp createState() => ProduccionLecheHatoApp();
}

class ProduccionLecheHatoApp extends State<ProduccionLecheHato> {
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
            title: Text('Lista de Documentos'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Usuarios')
                .doc(objUser.usuario)
                .collection('ProduccionLeche')
                .snapshots(),
            builder: (context, snapshot) {
              // Obtén los documentos de la colección
              final documentos = snapshot.data?.docs ?? [];
              // Separa los documentos en dos listas según el valor de "categoria"
              final produccionHato = documentos.toList();
              if (produccionHato.isEmpty) {
                // Muestra un mensaje si no hay información en la categoría.
                return Text('No hay información disponible.');
              } else {
                return ListView(
                  children: <Widget>[
                    _buildCategoria("Producción Leche Hato", produccionHato),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoria(String title, List<QueryDocumentSnapshot> documentos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: documentos.length,
          itemBuilder: (context, index) {
            final documento = documentos[index];
            final lecheM = documento['Leche Mañana'];
            final lecheT = documento['Leche Tarde'];
            final nombreDocumento = documento.id;

            return Card(
              elevation: 3, // Agrega una sombra alrededor del elemento.
              margin: EdgeInsets.all(10), // Márgenes alrededor del elemento.
              child: ListTile(
                contentPadding:
                    EdgeInsets.all(10), // Espacio interno del ListTile.
                leading: CircleAvatar(
                  // Agrega una imagen o avatar en la parte izquierda.
                  backgroundColor: Color.fromARGB(
                      255, 236, 158, 68), // Color de fondo del avatar.
                ),
                title: Text(
                  ("Fecha: $nombreDocumento"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Leche Mañana: $lecheM"),
                    Text("Leche Tarde: $lecheT"),
                  ],
                ),
                // Puedes personalizar el icono según tus necesidades.
              ),
            );
          },
        )
      ],
    );
  }
}
