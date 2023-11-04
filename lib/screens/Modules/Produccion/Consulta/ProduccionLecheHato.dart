// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

/// The class "ProduccionLecheHato" is a stateful widget in Dart.
class ProduccionLecheHato extends StatefulWidget {
  const ProduccionLecheHato({super.key});
  @override
  ProduccionLecheHatoApp createState() => ProduccionLecheHatoApp();
}

class ProduccionLecheHatoApp extends State<ProduccionLecheHato> {
  /// The line `final db = FirebaseFirestore.instance;` creates an instance of the `FirebaseFirestore`
  /// class, which is used to interact with the Firestore database. This instance is stored in the
  /// variable `db` for later use.
  final db = FirebaseFirestore.instance;
  late User objUser;

  /// The initState function retrieves the user object from the UserProvider using the Provider package in
  /// Dart.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// This Dart function builds a widget that displays a list of documents from a Firestore collection,
  /// separated into categories.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the location of a widget within the
  /// widget tree. It is used to access the theme, media query, and other properties of the parent widget.
  ///
  /// Returns:
  ///   The code is returning a `Stack` widget that contains a `Container` and a `Scaffold`. The
  /// `Scaffold` has an `AppBar` and a `body` that is a `StreamBuilder` widget. Inside the
  /// `StreamBuilder`, there is a `ListView` widget that contains a `_buildCategoria` widget.

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Lista de Documentos'),
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
                return const Text('No hay información disponible.');
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

  /// The `_buildCategoria` function returns a column widget that displays a title and a list of cards,
  /// each containing information from a document.
  ///
  /// Args:
  ///   title (String): The title is the category title that will be displayed at the top of the widget.
  /// It is a string value.
  ///   documentos (List<QueryDocumentSnapshot>): A list of QueryDocumentSnapshot objects. Each object
  /// represents a document in a Firestore collection.
  ///
  /// Returns:
  ///   The code is returning a widget that displays a column with a title and a list of cards. Each card
  /// represents a document and contains information about the document, such as the date and the values
  /// of "Leche Mañana" and "Leche Tarde".

  Widget _buildCategoria(String title, List<QueryDocumentSnapshot> documentos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: documentos.length,

          /// The `itemBuilder` is a callback function that is called for each item in the list. It takes two
          /// arguments: `context` and `index`.
          itemBuilder: (context, index) {
            final documento = documentos[index];
            final lecheM = documento['Leche Mañana'];
            final lecheT = documento['Leche Tarde'];

            final nombreDocumento = documento.id;

            return Card(
              elevation: 3, // Agrega una sombra alrededor del elemento.
              margin:
                  const EdgeInsets.all(10), // Márgenes alrededor del elemento.
              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(10), // Espacio interno del ListTile.
                leading: const CircleAvatar(
                  // Agrega una imagen o avatar en la parte izquierda.
                  backgroundColor: Color.fromARGB(
                      255, 236, 158, 68), // Color de fondo del avatar.
                ),
                title: Text(
                  ("Fecha: $nombreDocumento"),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
