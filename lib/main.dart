import 'package:bovinapp/firebase_options.dart';
import 'package:bovinapp/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
