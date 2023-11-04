// ignore_for_file: file_names

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

/// The class ProduccionConsultacarne is a StatefulWidget in Dart.
class ProduccionConsultacarne extends StatefulWidget {
  const ProduccionConsultacarne({super.key});
  @override
  ProduccionConsultacarneApp createState() => ProduccionConsultacarneApp();
}

/// The `ProduccionConsultacarneApp` class is a stateful widget that displays a list of production data
/// for a specific category of meat.
class ProduccionConsultacarneApp extends State<ProduccionConsultacarne> {
  /// The function `onTabSelected` updates the `currentIndex` variable with the provided `index` value.
  ///
  /// Args:
  ///   index (int): The index parameter is the new index of the selected tab.
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// `final db = FirebaseFirestore.instance;` creates an instance of the `FirebaseFirestore` class,
  /// which is used to interact with the Firestore database. It allows you to perform operations such as
  /// reading, writing, and querying data.
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

  /// This function builds a widget that displays a list of documents from a Firestore collection based
  /// on a specific category.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter is a BuildContext object that represents the
  /// location in the widget tree where this widget is being built. It is typically used to access the
  /// theme, media query, and other information about the app's current state.
  ///
  /// Returns:
  ///   The code is returning a Stack widget, which contains a Container and a Scaffold widget. The
  /// Scaffold widget has an AppBar, a body that contains a StreamBuilder widget, and a
  /// bottomNavigationBar.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Carne'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Usuarios')
                .doc(objUser.usuario)
                .collection('ProduccionCarne')
                .snapshots(),
            builder: (context, snapshot) {
              // Obtén los documentos de la colección
              final documentos = snapshot.data?.docs ?? [];
              // Separa los documentos en dos listas según el valor de "categoria"
              final produccionCarne = documentos.toList();
              if (produccionCarne.isEmpty) {
                // Muestra un mensaje si no hay información en la categoría.
                return const Text('No hay información disponible.');
              }
              return ListView(
                children: <Widget>[
                  _buildCategoria("Bovinos", produccionCarne),
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

  /// The function `_buildCategoria` returns a column widget that displays a title and a list of cards,
  /// each containing information from a document.
  ///
  /// Args:
  ///   title (String): The title is a string that represents the category title for the widget.
  ///   documentos (List<QueryDocumentSnapshot>): A list of QueryDocumentSnapshot objects.
  ///
  /// Returns:
  ///   The code is returning a widget that displays a column with a title and a list of cards. Each card
  /// represents a document from the provided list of QueryDocumentSnapshots. The card displays the name,
  /// code, and some additional data of each document.

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

          /// The `itemBuilder` is a callback function that is called for each item in the list. It takes two
          /// parameters: `context` and `index`.
          itemBuilder: (context, index) {
            final documento = documentos[index];
            final nombre = documento['NombreBovino'];
            final codigo = documento['CodigoBovino'];
            final datoSalida = documento['DatosSalidaBovino'];

            return Card(
              elevation: 3, // Agrega una sombra alrededor del elemento.
              margin:
                  const EdgeInsets.all(10), // Márgenes alrededor del elemento.
              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(10), // Espacio interno del ListTile.
                leading: CircleAvatar(
                  // Agrega una imagen o avatar en la parte izquierda.
                  backgroundColor: Colors.blue, // Color de fondo del avatar.
                  child: Text(nombre[0],
                      style: const TextStyle(color: Colors.white)),
                ),
                title: Text(
                  nombre,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Código: $codigo"),
                    Text(datoSalida[0]),
                    Text(datoSalida[3]),
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
