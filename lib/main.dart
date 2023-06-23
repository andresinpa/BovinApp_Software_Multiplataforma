import 'dart:convert';

import 'package:BovinApp/DTO/FirebaseOptions.dart';
import 'package:BovinApp/Screens/Screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:json_theme/json_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TEMA CLARO
  final themeStrNormal =
      await rootBundle.loadString('assets/themes/theme_normal.json');
  final themeJsonNormal = jsonDecode(themeStrNormal);
  final themeNormal = ThemeDecoder.decodeThemeData(themeJsonNormal)!;

  //TEMA OSCURO
  final themeStrBlack =
      await rootBundle.loadString('assets/themes/theme_black.json');
  final themeJsonBlack = jsonDecode(themeStrBlack);
  final themeBlack = ThemeDecoder.decodeThemeData(themeJsonBlack)!;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(theme: themeNormal));
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
        'NuevoRegistro': (context) => const NuevoRegistro(),
        'SiguienteRegistro': (context) => const SiguienteRegistro(),
        'InventarioFisico': (context) => const InventarioFisico(),
        'Invitacion': (context) => const Invitacion(),
        'Produccion': (context) => const Produccion(),
        'MisTareasMetas': (context) => const MisTareasMetas(),
        'InventarioBovinos': (context) => const InventarioBovinos(),
        'FichasIndividuales': (context) => const FichasIndividuales(),
        'FichasIndividualesResultados': (context) =>
            const FichasIndividualesResultados(),
        'ConsultaVacas': (context) => const ConsultasVacas(),
        'ConsultaToros': (context) => const ConsultasToros(),
        'ConsultaTerneros': (context) => const ConsultaTerneros(),
        'ConsultaNovillas': (context) => const ConsultaNovillas(),
        'ConsultaBueyes': (context) => const ConsultaBueyes(),
        'RazasBovinosUbate': (context) => const RazasBovinosUbate(),
        'CambioPassword': (context) => const CambioPassword(),
        'ConsultaAlimentos': (context) => const ConsultaAlimentos(),
        'NuevoRegistroInventarioFisico': (context) =>
            const NuevoRegistroInventarioFisico(),
        'ConsultaMedicamentos': (context) => const ConsultaMedicamentos(),
        'ConsultaFerreteria': (context) => const ConsultaFerreteria(),
        'ConsultaMaquinaria': (context) => const ConsultaMaquinaria(),
        'ConsultaOtros': (context) => const ConsultaOtros(),
        'DetalleTareas': (context) => const DetalleTareas(),
        'FormularioTareas': (context) => const FormularioTareas(),
        'ListadoTareas': (context) => const ListadoTareas()
      },
    );
  }
}
