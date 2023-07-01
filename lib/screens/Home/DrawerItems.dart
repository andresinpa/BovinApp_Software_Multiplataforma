import 'package:flutter/material.dart';

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
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
          Center(child: Image.asset('assets/icon/icon.png', height: 190)),
          const Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Text(
                    'BovinApp',
                    style: TextStyle(color: Color(0xff1d38ae)),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  Text(
                    'Versión 1.0',
                    style: TextStyle(color: Color(0xff1d38ae)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
