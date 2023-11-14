import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/DTO/Bovino.dart';
import 'package:BovinApp/Screens/Modules/FichasIndividuales/FichasIndividualesResultados.dart';

class ConsultaBueyes extends StatefulWidget {
  const ConsultaBueyes({super.key});
  @override
  ConsultaBueyesApp createState() => ConsultaBueyesApp();
}

class ConsultaBueyesApp extends State<ConsultaBueyes> {
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
            title: const Text('Mis Bueyes'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('Usuarios')
                .doc(objUser.usuario)
                .collection('InventarioBovino')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final documentos = snapshot.data?.docs ?? [];
                final categoriaBueyes = documentos
                    .where((doc) => doc['CategoriaBovino'] == 'Bueyes')
                    .toList();
                if (categoriaBueyes.isEmpty) {
                  return const Center(
                      child: Text('No hay información disponible.'));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildCategoria("🐮", categoriaBueyes),
                    ],
                  ),
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
            initialIndex: currentIndex,
            onTabSelected: onTabSelected,
          ),
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
                      Text("Raza: $raza"),
                      Text("Edad: $edad años"),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
