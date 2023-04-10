import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bovinapp/screens/screens.dart';

void main() => runApp(const MyApp());

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
        '/': (context) => const LoginScreen(),
        'OlvidePassword': (context) => const OlvidePassword(),
        'CrearCuenta': (context) => const CrearCuenta(),
        'Home1': (context) => const Home1(),
        'NuevoRegistro': (context) => const NuevoRegistro(),
        'SiguienteRegistro': (context) => const SiguienteRegistro(),
        'InventarioFisico': (context) => const InventarioFisico(),
        'Invitacion': (context) => const Invitacion(),
        'Produccion': (context) => const Produccion(),
        'MisTareasMetas': (context) => const MisTareasMetas(),
        'MiUsuarioyFinca': (context) => const MiUsuarioYFinca(),
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
        'ConfirmacionCuenta': (context) => const ConfirmacionCuentaPage(),
        'ConsultaAlimentos': (context) => const ConsultaAlimentos(),
        'NuevoRegistroInventarioFisico': (context) =>
            const NuevoRegistroInventarioFisico(),
        'ConsultaMedicamentos': (context) => const ConsultaMedicamentos(),
        'ConsultaFerreteria': (context) => const ConsultaFerreteria(),
        'ConsultaMaquinaria': (context) => const ConsultaMaquinaria(),
        'ConsultaOtros': (context) => const ConsultaOtros(),
      },
    );
  }
}
