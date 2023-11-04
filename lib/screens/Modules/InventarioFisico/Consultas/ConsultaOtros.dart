// ignore_for_file: file_names

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

/// The class ConsultaOtros is a StatefulWidget in Dart.
class ConsultaOtros extends StatefulWidget {
  const ConsultaOtros({super.key});
  @override
  ConsultaOtrosApp createState() => ConsultaOtrosApp();
}

class ConsultaOtrosApp extends State<ConsultaOtros> {
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

  /// The line `final db = FirebaseFirestore.instance;` creates an instance of the `FirebaseFirestore`
  /// class, which is used to interact with the Firestore database.
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

  /// This function builds a widget that displays a list of "Insumos" (supplies) from a Firestore
  /// collection, categorized by their "ClasificacionProducto" (product classification).
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the location of a widget within the
  /// widget tree. It is typically used to access the theme, media query, and other properties of the
  /// current app or widget.
  ///
  /// Returns:
  ///   The code is returning a `Stack` widget that contains a `Container` and a `Scaffold`. The
  /// `Scaffold` widget has an `AppBar`, a `body` that contains a `StreamBuilder` widget, and a
  /// `bottomNavigationBar` that is a custom `BottomBar` widget.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Insumos'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Usuarios')
                .doc(objUser.usuario)
                .collection('InventarioFisico')
                .snapshots(),
            builder: (context, snapshot) {
              // Obtén los documentos de la colección
              final documentos = snapshot.data?.docs ?? [];
              // Separa los documentos en dos listas según el valor de "categoria"
              final categoriaOtros = documentos
                  .where((doc) => doc['ClasificacionProducto'] == 'Insumos')
                  .toList();
              if (categoriaOtros.isEmpty) {
                // Muestra un mensaje si no hay información en la categoría.
                return const Text('No hay información disponible.');
              } else {
                return ListView(
                  children: <Widget>[
                    _buildCategoria("👨‍🌾", categoriaOtros),
                  ],
                );
              }
            },
          ),
          bottomNavigationBar: BottomBar(
              initialIndex: currentIndex, onTabSelected: onTabSelected),
        ),
      ],
    );
  }

  /// The `_buildCategoria` function returns a column widget that displays a title and a list of cards,
  /// each containing information about a product.
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
  /// ListView.builder. Each item in the list is displayed as a Card with a ListTile, showing the item's
  /// name, code, utility, and price.

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

          /// The `itemBuilder` is a callback function that is called for each item in the list. It
          /// takes two arguments: `context` and `index`.
          itemBuilder: (context, index) {
            final documento = documentos[index];
            final nombre = documento['NombreProducto'];
            final codigo = documento['CodigoProducto'];
            final utilidad = documento['UtilidadProducto'];
            final precio = documento['PrecioProducto'];

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
                    Text("Utilidad: $utilidad"),
                    Text("Precio: $precio"),
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
