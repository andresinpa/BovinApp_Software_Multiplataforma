import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';

class ConsultaAlimentos extends StatefulWidget {
  const ConsultaAlimentos({super.key});
  @override
  ConsultaAlimentosApp createState() => ConsultaAlimentosApp();
}

class ConsultaAlimentosApp extends State<ConsultaAlimentos> {
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
            title: const Text('Alimentos'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Usuarios')
                .doc(objUser.usuario)
                .collection('InventarioFisico')
                .snapshots(),
            builder: (context, snapshot) {
              final documentos = snapshot.data?.docs ?? [];
              final categoriaAlimentos = documentos
                  .where((doc) => doc['ClasificacionProducto'] == 'Alimentos')
                  .toList();
              if (categoriaAlimentos.isEmpty) {
                return const Center(
                    child: Text('No hay información disponible.'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildCategoria("🌿", categoriaAlimentos),
                    ],
                  ),
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

        // Agregamos el SingleChildScrollView aquí.
        SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: documentos.length,
            itemBuilder: (context, index) {
              final documento = documentos[index];
              final nombre = documento['NombreProducto'];
              final codigo = documento['CodigoProducto'];
              final utilidad = documento['UtilidadProducto'];
              final precio = documento['PrecioProducto'];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
