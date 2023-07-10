// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildHeader(BuildContext context) {
  final FirebaseStorage storage = FirebaseStorage.instance;
  // Obtén la instancia de UserProvider en cualquier pantalla
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  // Obtén la instancia de User
  final objUser = userProvider.user;
  return FutureBuilder<DocumentSnapshot>(
    future: getDataFromFirestore(objUser.usuario),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Mientras se carga el documento
        return const CircularProgressIndicator();
      }

      if (snapshot.hasError) {
        // Si se produce un error al obtener el documento
        return const Text('Error al obtener los datos');
      }

      if (snapshot.hasData) {
        // Si se obtienen los datos exitosamente
        final data = snapshot.data!.data() as Map<String, dynamic>?;

        if (data != null) {
          return Material(
            child: InkWell(
              child: Container(
                color: const Color(0xff1d38ae),
                padding: EdgeInsets.only(
                  top: 24 + MediaQuery.of(context).padding.top,
                  bottom: 24,
                ),
                child: Column(
                  children: [
                    FutureBuilder<String>(
                      future: getImageUrl('avatar.png', storage),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> imageSnapshot) {
                        if (imageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (imageSnapshot.hasError) {
                          return const Text('Error al obtener la imagen');
                        }
                        if (imageSnapshot.hasData) {
                          return CircleAvatar(
                            radius: 52,
                            backgroundImage: data['UrlAvatarUsuario'] == ''
                                ? const NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/bovinapp-project.appspot.com/o/BovinApp%2Favatar.png?alt=media&token=aaa46974-ff9d-471d-a10c-87b8d626a2a9')
                                : NetworkImage(data['UrlAvatarUsuario']),
                          );
                        } else {
                          return const Text('No se encontró la imagen');
                        }
                      },
                    ),
                    // CircleAvatar(
                    //   radius: 52,
                    //   backgroundImage: ,
                    // ),

                    const SizedBox(height: 12),
                    Text(
                      '${'¡Hola ' + data['Usuario']}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['EmailUsuario'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
      // Si no se encuentran datos válidos
      return const Text('No se encontraron datos');
    },
  );
}

Future<DocumentSnapshot> getDataFromFirestore(String nombreDocumento) {
  return FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(nombreDocumento)
      .get();
}

Future<String> getImageUrl(String imagePath, FirebaseStorage storage) async {
  // Referencia al archivo en Firebase Storage
  Reference ref = storage.ref().child('BovinApp').child(imagePath);

  // Obtén la URL del archivo
  String imageUrl = await ref.getDownloadURL();
  return imageUrl;
}
