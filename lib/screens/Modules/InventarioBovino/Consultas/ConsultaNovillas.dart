// ignore_for_file: file_names

import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

/// The class ConsultaNovillas is a StatefulWidget in Dart.
class ConsultaNovillas extends StatefulWidget {
  const ConsultaNovillas({super.key});
  @override
  ConsultaNovillasApp createState() => ConsultaNovillasApp();
}

class ConsultaNovillasApp extends State<ConsultaNovillas> {
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

  /// This function builds a widget that displays a list of "Novillas" (a category of bovine animals)
  /// from a Firestore database.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the location of a widget within the
  /// widget tree. It is used to access the theme, media query, and other properties of the current
  /// build context.
  ///
  /// Returns:
  ///   The code is returning a `Stack` widget that contains a `Container` and a `Scaffold`. The
  /// `Scaffold` widget has an `AppBar`, a `body` that contains a `StreamBuilder` widget, and a
  /// `bottomNavigationBar` that is a custom `BottomBar` widget.
  /// This function builds a widget that displays a list of "Novillas" (a category of bovine animals)
  /// from a Firestore database.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a reference to the location of a widget within the
  /// widget tree. It is used to access the theme, media query, and other properties of the current
  /// build context.
  ///
  /// Returns:
  ///   The code is returning a `Stack` widget, which contains a `Container` and a `Scaffold`. The
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
            title: const Text('Mis Novillas'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Usuarios')
                .doc(objUser.usuario)
                .collection('InventarioBovino')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Obtén los documentos de la colección
                final documentos = snapshot.data?.docs ?? [];
                // Separa los documentos en dos listas según el valor de "categoria"
                final categoriaNovillas = documentos
                    .where((doc) => doc['CategoriaBovino'] == 'Novillas')
                    .toList();
                if (categoriaNovillas.isEmpty) {
                  // Muestra un mensaje si no hay información en la categoría.
                  return const Text('No hay información disponible.');
                }
                return ListView(
                  children: <Widget>[
                    _buildCategoria("🐄", categoriaNovillas),
                  ],
                );
              } else {
                return ListView(
                  children: <Widget>[
                    Container(
                      height: 50,
                      color: Colors.amber[500],
                      child: const Center(
                        child: Text('No hay datos registrados'),
                      ),
                    )
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

  /// The `_buildCategoria` function is responsible for building a widget that displays a list of
  /// "Novillas" (a category of bovine animals) from a Firestore database.
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
                    Text("Raza: $raza"),
                    Text("Edad: $edad años"),
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
