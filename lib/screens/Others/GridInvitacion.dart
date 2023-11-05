// ignore_for_file: file_names, unused_element, deprecated_member_use, use_build_context_synchronously

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// The class GridInvitacion is a StatefulWidget in Dart.
class GridInvitacion extends StatefulWidget {
  const GridInvitacion({super.key});

  @override
  State<GridInvitacion> createState() => _GridInvitacionState();
}

/// The `_GridInvitacionState` class is a stateful widget that builds a grid view with different items,
/// each containing an image and a title, and handles navigation to different screens when an item is
/// pressed.
class _GridInvitacionState extends State<GridInvitacion> {
  /// The `build` method in the `_GridInvitacionState` class is responsible for creating the user
  /// interface for the `GridInvitacion` widget.
  /// The `appDownloadLink` variable is a string that contains a URL to download an app. It is used in
  /// the `_copyToClipboardAndShowSnackbar` function to copy the link to the clipboard and show a
  /// snackbar message in a Flutter app.
  final String appDownloadLink =
      "https://mailunicundiedu-my.sharepoint.com/:f:/g/personal/jainfante_ucundinamarca_edu_co/EilRhtRLyJ5DlEnZFrVsV08B5lFynsa0CfPjHBo1ZdyBFA?e=d39X94";

  /// The function copies a given app download link to the clipboard and shows a snackbar message in a
  /// Flutter app.
  ///
  /// Args:
  ///   context (BuildContext): The `BuildContext` is a parameter that represents the location in the
  /// widget tree where the current widget is being built. It is typically used to access the
  /// `ScaffoldMessenger` and show a `SnackBar` within the current context.
  void _copyToClipboardAndShowSnackbar(BuildContext context) {
    FlutterClipboard.copy(appDownloadLink).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("El enlace de invitación ha sido copiado al portapapeles"),
      ));
    });
  }

  /// The function `_openMessageApp` opens the default messaging app and shows a snackbar message if it
  /// fails to open.
  void _openMessageApp() async {
    const url = "sms:";
    if (await canLaunch(url)) {
      _copyToClipboardAndShowSnackbar(context);
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No se pudo abrir la aplicación de mensajes"),
      ));
    }
  }

  /// The function `_openTelegramApp` opens the Telegram app and copies the link to the clipboard,
  /// showing a snackbar message if the app cannot be opened.
  void _openTelegramApp() async {
    var url = "http://t.me/share?url=$appDownloadLink";

    if (await launch(url)) {
      _copyToClipboardAndShowSnackbar(context);
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No se pudo abrir la aplicación de Telegram"),
      ));
    }
  }

  /// The function `_openWhatsApp` opens the WhatsApp application with a specified text and shows a
  /// snackbar if the application cannot be opened.
  void _openWhatsApp() async {
    var url = "https://wa.me/?text=$appDownloadLink";

    if (await launch(url)) {
      _copyToClipboardAndShowSnackbar(context);
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No se pudo abrir la aplicación de WhatsApp"),
      ));
    }
  }

  /// The function `_openEmailApp` opens the email app with a pre-filled body and shows a snackbar
  /// message if the app cannot be launched.
  void _openEmailApp() async {
    final url = "mailto:?body=$appDownloadLink";
    if (await launch(url)) {
      _copyToClipboardAndShowSnackbar(context);
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No se pudo abrir la aplicación de correo electrónico"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Items item1 = Items(
        title: 'Generar Enlace',
        img: 'assets/images/invitacion/invitacion1.png',
        onPressed: () {
          _copyToClipboardAndShowSnackbar(context);
        });
    Items item2 = Items(
        title: 'Mensaje de texto',
        img: 'assets/images/invitacion/invitacion2.png',
        onPressed: () {
          _openMessageApp();
        });
    Items item3 = Items(
        title: 'Telegram',
        img: 'assets/images/invitacion/invitacion3.png',
        onPressed: () {
          _openTelegramApp();
        });
    Items item4 = Items(
        title: 'WhatsApp',
        img: 'assets/images/invitacion/invitacion4.png',
        onPressed: () {
          _openWhatsApp();
        });

    Items item5 = Items(
        title: "Correo Electrónico",
        img: 'assets/images/invitacion/invitacion5.png',
        onPressed: () {
          _openEmailApp();
        });
    Items item6 = Items(
        title: 'Bluetooth',
        img: 'assets/images/invitacion/invitacion6.png',
        onPressed: () {
          _copyToClipboardAndShowSnackbar(context);
        });

    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xffffccbc;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
              color: Color(color),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: data.onPressed,
                  child: Image.asset(data.img, width: size.width * 0.3),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff1d38ae),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// The class "Items" represents an item with a title, image, and an optional onPressed function.
class Items {
  String title;
  String img;
  Function()? onPressed;
  Items({required this.title, required this.img, this.onPressed});
}
