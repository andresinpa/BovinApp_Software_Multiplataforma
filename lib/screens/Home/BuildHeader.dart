// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `buildHeader` function returns a Material widget with a header containing the user's profile
/// picture, username, and email.
///
/// Args:
///   context (BuildContext): The `context` parameter is an object that provides access to various
/// information about the current build context, such as the theme, media queries, and localization. It
/// is typically passed down from the parent widget's build method.
///
/// Returns:
///   a Material widget with an InkWell widget as its child. The InkWell widget has a Container widget
/// as its child, which contains a Column widget. The Column widget contains a CircleAvatar widget,
/// followed by two SizedBox widgets, and finally two Text widgets.
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

              /// The `backgroundImage` property of the `CircleAvatar` widget is used to set the
              /// background image of the circle avatar. In this case, it is using the `NetworkImage`
              /// class to load the image from the `objUser.imagenCloudStorage` URL. This means that the
              /// `objUser.imagenCloudStorage` variable contains the URL of the user's profile picture
              /// stored in a cloud storage service.
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
