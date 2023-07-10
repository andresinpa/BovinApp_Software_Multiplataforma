import 'package:flutter/material.dart';

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
            title: const Text('Invita a ganaderos Ubatenses a usar BovinApp'),
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
            onTap: () {}),
        ListTile(
            leading: const Icon(Icons.update_rounded),
            iconColor: const Color(0xff1d38ae),
            title: const Text('Actualizaciones'),
            onTap: () {}),
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
