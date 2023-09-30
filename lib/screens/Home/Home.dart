import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Design/BackgroundBottom.dart';
import 'package:BovinApp/Screens/Home/BuildHeader.dart';
import 'package:BovinApp/Screens/Home/DrawerItems.dart';
import 'package:BovinApp/Screens/Home/GridDashboard.dart';
import 'package:BovinApp/Widgets/DialogDosBotones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeApp createState() => HomeApp();
}

class HomeApp extends State<Home> {
  late User objUser;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final objUser = userProvider.user;
    // Actualiza los datos del usuario antes de mostrar el encabezado
    userProvider.updateUser(objUser);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'BovinApp',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              DialogDosBotones.alert(
                  context, 'Alerta', '¿Quieres salir de la aplicación?', '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BackgroundBotttom(
          height: size.height * 0.935,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              const GridDashboard(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'MisTareasMetas');
        },
        child: const Icon(Icons.notification_add_rounded),
      ),
    );
  }
}
