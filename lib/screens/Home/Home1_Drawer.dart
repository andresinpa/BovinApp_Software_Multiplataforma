import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Home/MiUsuarioYFinca.dart';
import 'package:flutter/material.dart';

class Home1 extends StatefulWidget {
  final User user;
  const Home1(this.user, {super.key});
  @override
  Home1App createState() => Home1App();
}

class Home1App extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                  const AlertDialog(
                    title: Text('Saliendo ...'),
                  );
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                //////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MiUsuarioYFinca(widget.user))),
                        child: Image.asset('assets/images/home1/Home1.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Mi usuario y finca',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),
                ///////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'InventarioBovinos'),
                        child: Image.asset('assets/images/home1/home2.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Inventario de bovinos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),
                ///////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'FichasIndividuales'),
                        child: Image.asset('assets/images/home1/home3.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Fichas individuales',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),
                ///////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'InventarioFisico'),
                        child: Image.asset('assets/images/home1/home4.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Inventario Fisico',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),
                ///////////////////////////////////////////////////////////////////////////////////////
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'Produccion'),
                        child: Image.asset('assets/images/home1/home5.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Producción',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),
                ///////////////////////////////////////////////////////////////////////////////////////

                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'RazasBovinosUbate'),
                        child: Image.asset('assets/images/home1/home6.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Razas de bovinos en Ubaté',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),

                //////////////////////////////////////////////////////////////////////////////////////
                /*GestureDetector(
                        child: const Card(
                          child: Image(
                            image: AssetImage('assets/images/home1/Home1.png'),
                            fit: BoxFit.fill,
                            height: 5,
                          ),
                        ),
                      ),*/
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'MisTareasMetas');
            },
            child: const Icon(Icons.notification_add_rounded),
          ),
        ),
      ],
    );
  }
}

Widget buildHeader(BuildContext context) => Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/128/3593/3593532.png'),
              ),
              SizedBox(height: 12),
              Text(
                '¡Hola florecita!',
              ),
              Text(
                'bovinapp2023@gmail.com',
              ),
            ],
          ),
        ),
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
      child: Wrap(
        runSpacing: 18.0,
        children: [
          ListTile(
              leading: const Icon(Icons.share_rounded),
              title: const Text('Invita a ganaderos Ubatenses a usar BovinApp'),
              onTap: () {
                Navigator.pushNamed(context, 'Invitacion');
              }),
          ListTile(
              leading: const Icon(Icons.calendar_month_rounded),
              title: const Text('Mis tareas y metas'),
              onTap: () {
                Navigator.pushNamed(context, 'MisTareasMetas');
              }),
          ListTile(
              leading: const Icon(Icons.password_rounded),
              title: const Text('Cambio de contraseña'),
              onTap: () {
                Navigator.pushNamed(context, 'CambioPassword');
              }),
          ListTile(
              leading: const Icon(Icons.info_rounded),
              title: const Text('Acerca de'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.update_rounded),
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
                  Text('BovinApp'),
                  SizedBox(
                    width: 130,
                  ),
                  Text('Versión 1.0'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
