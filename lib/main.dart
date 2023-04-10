import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bovinapp/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bovinapp/firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BovinApp',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        'OlvidePassword': (context) => OlvidePassword(),
        'CrearCuenta': (context) => CrearCuenta(),
        'Home1': (context) => const Home1(),
        'NuevoRegistro': (context) => const NuevoRegistro(),
        'SiguienteRegistro': (context) => const SiguienteRegistro(),
        'InventarioFisico': (context) => const InventarioFisico(),
        'Invitacion': (context) => const Invitacion(),
        'Produccion': (context) => const Produccion(),
        'MisTareasMetas': (context) => const MisTareasMetas(),
        'MiUsuarioyFinca': (context) => MiUsuarioYFinca(),
        'InventarioBovinos': (context) => const InventarioBovinos(),
        'FichasIndividuales': (context) => FichasIndividuales(),
        'FichasIndividualesResultados': (context) =>
            FichasIndividualesResultados(),
        'ConsultaVacas': (context) => const ConsultasVacas(),
        'ConsultaToros': (context) => const ConsultasToros(),
        'ConsultaTerneros': (context) => const ConsultaTerneros(),
        'ConsultaNovillas': (context) => const ConsultaNovillas(),
        'ConsultaBueyes': (context) => const ConsultaBueyes(),
        'RazasBovinosUbate': (context) => const RazasBovinosUbate(),
        'CambioPassword': (context) => CambioPassword(),
        'ConsultaAlimentos': (context) => const ConsultaAlimentos(),
        'NuevoRegistroInventarioFisico': (context) =>
            NuevoRegistroInventarioFisico(),
        'ConsultaMedicamentos': (context) => const ConsultaMedicamentos(),
        'ConsultaFerreteria': (context) => const ConsultaFerreteria(),
        'ConsultaMaquinaria': (context) => const ConsultaMaquinaria(),
        'ConsultaOtros': (context) => const ConsultaOtros(),
      },
    );
  }
}
