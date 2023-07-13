// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildHeader(BuildContext context) {
  // Obtén la instancia de UserProvider en cualquier pantalla
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  // Obtén la instancia de User
  final objUser = userProvider.user;

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
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(objUser.imagenCloudStorage),
            ),
            const SizedBox(height: 12),
            Text(
              '${'¡Hola ' + objUser.usuario}!',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              objUser.email,
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
