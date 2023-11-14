// ignore_for_file: file_names

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';
import 'package:BovinApp/DTO/Bovino.dart';
import 'package:BovinApp/Screens/Modules/FichasIndividuales/FichasIndividualesResultados.dart';

/// The class ConsultasToros is a StatefulWidget in Dart.
class ConsultasToros extends StatefulWidget {
  const ConsultasToros({super.key});
  @override
  ConsultaTorosApp createState() => ConsultaTorosApp();
}

/// The `ConsultaTorosApp` class is a stateful widget that displays a list of bulls from a Firestore
/// database and allows the user to navigate between different tabs using a bottom navigation bar.
class ConsultaTorosApp extends State<ConsultasToros> {
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

  /// This Dart function builds a widget that displays a list of "Toros" (bulls) from a Firestore
  /// collection, with a custom AppBar and a BottomNavigationBar.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the location of a widget within the
  /// widget tree. It is typically used to access the theme, media query, and other properties of the
  /// current app or widget.
  ///
  /// Returns:
  ///   The code is returning a `Stack` widget, which contains a `Container` widget and a `Scaffold`
  /// widget. The `Scaffold` widget has an `AppBar`, a `body` that contains a `StreamBuilder` widget, and
  /// a `bottomNavigationBar` that contains a `BottomBar` widget.
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

  /// The function `_buildCategoria` returns a column widget that displays a title and a list of cards
  /// with information from a list of documents.
  ///
  /// Args:
  ///   title (String): The title is a string that represents the category title for the widget. It will
  /// be displayed at the top of the widget.
  ///   documentos (List<QueryDocumentSnapshot>): A list of QueryDocumentSnapshot objects. Each object
  /// represents a document in a Firestore collection.
  ///
  /// Returns:
  ///   The code is returning a widget that displays a category title and a list of items. The category
  /// title is displayed at the center of the column, and the list of items is displayed using a
  /// ListView.builder. Each item in the list is displayed as a Card with a ListTile containing
  /// information such as the name, code, breed, and age of a bovine.

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

        /// The `ListView.builder` is a widget in Flutter that creates a scrollable list of items lazily.
        /// It is used to efficiently display a large number of items without loading them all at once.
        ListView.builder(
          shrinkWrap: true,
          itemCount: documentos.length,
          itemBuilder: (context, index) {
            final documento = documentos[index];
            final nombre = documento['NombreBovino'];
            final codigo = documento['CodigoBovino'];
            final raza = documento['RazaBovino'];
            final edad = documento['EdadBovino'];
            Bovino objBovino = Bovino();
            objBovino.codigoBovino = documento['CodigoBovino'];
            objBovino.nombreBovino = documento['NombreBovino'];
            objBovino.categoriaBovino = documento['CategoriaBovino'];
            objBovino.razaBovino = documento['RazaBovino'];
            objBovino.edadBovino = documento['EdadBovino'];
            objBovino.codigoMadre = documento['CodigoMadre'];
            objBovino.razaMadre = documento['RazaMadre'];
            objBovino.codigoPadre = documento['CodigoPadre'];
            objBovino.razaPadre = documento['RazaPadre'];
            objBovino.lecheDiaria = documento['lecheDiaria'];
            objBovino.ingreso = documento['IngresoBovino'];

            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              FichasIndividualesResultados(objBovino)));
                },
                child: Card(
                  elevation: 3, // Agrega una sombra alrededor del elemento.
                  margin: const EdgeInsets.all(
                      10), // Márgenes alrededor del elemento.
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(
                        10), // Espacio interno del ListTile.
                    leading: CircleAvatar(
                      // Agrega una imagen o avatar en la parte izquierda.
                      backgroundColor:
                          Colors.blue, // Color de fondo del avatar.
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
                        Text("Raza: $raza"),
                        Text("Edad: $edad años"),
                      ],
                    ),
                  ),
                ));
          },
        )
      ],
    );
  }
}
