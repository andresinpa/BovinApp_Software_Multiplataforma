import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

class ConsultaMedicamentos extends StatefulWidget {
  const ConsultaMedicamentos({super.key});
  ConsultaMedicamentosApp createState() => ConsultaMedicamentosApp();
}

class ConsultaMedicamentosApp extends State<ConsultaMedicamentos> {
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
                .collection('InventarioFisico')
                .snapshots(),
            builder: (context, snapshot) {
              // Obtén los documentos de la colección
              final documentos = snapshot.data?.docs ?? [];
              // Separa los documentos en dos listas según el valor de "categoria"
              final categoriaMedicamentos = documentos
                  .where(
                      (doc) => doc['ClasificacionProducto'] == 'Medicamentos')
                  .toList();
              if (categoriaMedicamentos.isEmpty) {
                // Muestra un mensaje si no hay información en la categoría.
                return Text('No hay información disponible.');
              } else {
                return ListView(
                  children: <Widget>[
                    _buildCategoria("Medicamentos", categoriaMedicamentos),
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
            final nombre = documento['NombreProducto'];
            final codigo = documento['CodigoProducto'];
            final utilidad = documento['UtilidadProducto'];
            final precio = documento['PrecioProducto'];

            return Card(
              elevation: 3, // Agrega una sombra alrededor del elemento.
              margin: EdgeInsets.all(10), // Márgenes alrededor del elemento.
              child: ListTile(
                contentPadding:
                    EdgeInsets.all(10), // Espacio interno del ListTile.
                leading: CircleAvatar(
                  // Agrega una imagen o avatar en la parte izquierda.
                  backgroundColor: Colors.blue, // Color de fondo del avatar.
                  child: Text(nombre[0], style: TextStyle(color: Colors.white)),
                ),
                title: Text(
                  nombre,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
