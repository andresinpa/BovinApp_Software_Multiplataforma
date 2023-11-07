import 'dart:convert';

import 'package:BovinApp/DTO/FirebaseOptions.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/Screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importa la biblioteca de localización

/// The main function initializes the app, loads the theme data, initializes Firebase, sets preferred
/// device orientations, and runs the app with the specified theme.
void main() async {
  initializeDateFormatting('es_ES', null);
  WidgetsFlutterBinding.ensureInitialized();
 
  //TEMA CLARO
  final themeStrNormal =
      await rootBundle.loadString('assets/themes/theme_normal.json');
  final themeJsonNormal = jsonDecode(themeStrNormal);
  final themeNormal = ThemeDecoder.decodeThemeData(themeJsonNormal)!;

  // //TEMA OSCURO
  // final themeStrBlack =
  //     await rootBundle.loadString('assets/themes/theme_black.json');
  // final themeJsonBlack = jsonDecode(themeStrBlack);
  // final themeBlack = ThemeDecoder.decodeThemeData(themeJsonBlack)!;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MyApp(theme: themeNormal),
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BovinApp',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        'OlvidePassword': (context) => const OlvidePassword(),
        'CrearCuenta': (context) => const CrearCuenta(),
        'Home': (context) => const Home(),
        'NuevoRegistro': (context) => const NuevoRegistro(),
        'InventarioFisico': (context) => const InventarioFisico(),
        'Invitacion': (context) => const Invitacion(),
        'Produccion': (context) => const Produccion(),
        'MisTareasMetas': (context) => const Calendar(),
        'InventarioBovinos': (context) => const InventarioBovinos(),
        'FichasIndividuales': (context) => const FichasIndividuales(),
        'ConsultaVacas': (context) => const ConsultasVacas(),
        'ConsultaToros': (context) => const ConsultasToros(),
        'ConsultaTerneros': (context) => const ConsultaTerneros(),
        'ConsultaNovillas': (context) => const ConsultaNovillas(),
        'ConsultaBueyes': (context) => const ConsultaBueyes(),
        'Informes': (context) => const Informes(),
        'CambioPassword': (context) => const OlvidePassword(),
        'ConsultaAlimentos': (context) => const ConsultaAlimentos(),
        'NuevoRegistroInventarioFisico': (context) =>
            const NuevoRegistroInventarioFisico(),
        'ConsultaMedicamentos': (context) => const ConsultaMedicamentos(),
        'ConsultaFerreteria': (context) => const ConsultaFerreteria(),
        'ConsultaMaquinaria': (context) => const ConsultaMaquinaria(),
        'ConsultaOtros': (context) => const ConsultaOtros(),
        'DetalleTareas': (context) => const DetalleTareas(),
        'FormularioTareas': (context) => const FormularioTareas(),
        'ListadoTareas': (context) => const ListadoTareas(),
        'MiUsuarioYFinca': (context) => const MiUsuarioYFinca(),
        'RegistroLecheGeneral': (context) =>
            const NuevoRegistroProduccionLeche(),
        'RegistroLecheBovino': (context) =>
            const NuevoRegistroProduccionBovino(),
        'ProduccionLecheHato': (context) => const ProduccionLecheHato(),
        'ProduccionCarne': (context) => const NuevoRegistroProduccionCarne(),
        'ProduccionConsultaCarne': (context) => const ProduccionConsultacarne(),
        'AcercaDe': (context) => const AcercaDeScreen(),
        'EliminarCuenta': (context) => const EliminarCuenta(),
      },
    );
  }
}
