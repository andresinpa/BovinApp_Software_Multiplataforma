// ignore_for_file: file_names, deprecated_member_use

import 'package:BovinApp/Design/Background.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcercaDeScreen extends StatefulWidget {
  const AcercaDeScreen({super.key});

  @override
  State<AcercaDeScreen> createState() => _AcercaDeScreenState();
}

class _AcercaDeScreenState extends State<AcercaDeScreen> {
  /// The function `onTabSelected` updates the `currentIndex` variable with the provided `index` value.
  ///
  /// Args:
  ///   index (int): The index parameter is the new index of the selected tab.
  int currentIndex = 1;
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// The above code is creating a screen for confirming an account in a mobile app. It includes a
    /// form where the user can enter a validation code sent to their email. If the entered code matches
    /// the expected code, the user's data is inserted and they are redirected to the home screen. If
    /// the code does not match, an error message is displayed. The code also includes a confirmation
    /// dialog that appears when the user tries to navigate back from this screen, asking for
    /// confirmation before allowing the navigation.
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Acerca de'),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "ACERCA DE ...",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color.fromARGB(255, 230, 74, 25)),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'BOVINAPP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  const Text(
                    'Versión 1.0.0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    '© 2023 BovinApp, Inc.',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    'BovinApp es una aplicación para la gestión ganadera. Permite a los ganaderos registrar la producción de leche, la información de los bovinos, inventario físico, metas, tareas y mucho más.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: size.height * 0.01),
                  const Text(
                    'Contáctanos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chat_rounded,
                        ),
                        iconSize: 32,
                        onPressed: () {
                          // Abre la aplicación de WhatsApp con un mensaje predefinido
                          const whatsappUrl =
                              "https://wa.me/+573143212221?text=Hola%2C%20quiero%20contactarte";
                          launch(whatsappUrl);
                        },
                      ),
                      const SizedBox(width: 20), // Espacio entre los iconos
                      IconButton(
                        icon: const Icon(
                          Icons.email_outlined,
                        ),
                        iconSize: 32,
                        onPressed: () {
                          // Abre la aplicación de Gmail con un mensaje predefinido
                          const gmailUrl =
                              "mailto:bovinapp2023@gmail.com?subject=Contacto%20desde%20BovinApp";
                          launch(gmailUrl);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BottomBar(initialIndex: currentIndex, onTabSelected: onTabSelected),
    );
  }
}
