import 'package:flutter/material.dart';

/// The function builds a menu with various options and displays the BovinApp logo and version
/// information.
///
/// Args:
///   context (BuildContext): The `context` parameter is a required parameter of type `BuildContext`. It
/// is used to access the current context of the widget tree. The context provides information about the
/// current state of the app and allows you to access resources such as themes, media queries, and
/// navigation.
///
/// Returns:
///   a Container widget with a padding and a child widget. The child widget is a Wrap widget with a
/// runSpacing property set to 18.0. Inside the Wrap widget, there are several ListTile widgets, each
/// with a leading icon, iconColor, title, and onTap property. After the ListTiles, there is an
/// Image.asset widget and a Row widget with two Text widgets.
Widget buildMenuItems(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.05,
        bottom: size.height * 0.05),
    child: Wrap(
      runSpacing: 18.0,
      children: [
        ListTile(
            leading: const Icon(Icons.share_rounded),
            iconColor: const Color(0xff1d38ae),
            title: const Text('Invita a otros ganaderos a usar BovinApp'),
            onTap: () {
              Navigator.pushNamed(context, 'Invitacion');
            }),
        ListTile(
            leading: const Icon(Icons.calendar_month_rounded),
            iconColor: const Color(0xff1d38ae),
            title: const Text('Mis tareas y metas'),
            onTap: () {
              Navigator.pushNamed(context, 'MisTareasMetas');
            }),
        ListTile(
            leading: const Icon(Icons.password_rounded),
            iconColor: const Color(0xff1d38ae),
            title: const Text('Cambio de contraseña'),
            onTap: () {
              Navigator.pushNamed(context, 'CambioPassword');
            }),
        ListTile(
            leading: const Icon(Icons.info_rounded),
            iconColor: const Color(0xff1d38ae),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pushNamed(context, 'AcercaDe');
            }),
        ListTile(
            leading: const Icon(Icons.delete_forever),
            iconColor: const Color(0xff1d38ae),
            title: const Text('Eliminar mi cuenta'),
            onTap: () {
              Navigator.pushNamed(context, 'EliminarCuenta');
            }),
        Center(
            child:
                Image.asset('assets/icon/icon.png', height: size.height * 0.2)),
        Center(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  right: size.width * 0.135,
                  left: size.width * 0.03,
                ),
                child: const Text(
                  'BovinApp',
                  style: TextStyle(color: Color(0xff1d38ae)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: size.width * 0.13,
                    right: size.width * 0.03),
                child: const Text(
                  'Versión 1.0',
                  style: TextStyle(color: Color(0xff1d38ae)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
