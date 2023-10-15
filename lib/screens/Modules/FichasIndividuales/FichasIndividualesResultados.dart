import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:BovinApp/DTO/Bovino.dart';

class FichasIndividualesResultados extends StatelessWidget {
  final Bovino cadena;

  const FichasIndividualesResultados(this.cadena, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha Individual'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blue[100],
              child: Icon(
                FontAwesomeIcons.cow,
                size: 80,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Text(
              cadena.nombreBovino,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Código: ${cadena.codigoBovino}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            _buildInfoRow('Raza:', cadena.razaBovino),
            _buildInfoRow('Edad:', cadena.edadBovino),
            _buildInfoRow('Clasificación:', cadena.categoriaBovino),
            _buildInfoRow('Fecha de nacimiento o de ingreso:', cadena.ingreso),
            _buildInfoRow('Código del padre:', cadena.codigoPadre),
            _buildInfoRow('Raza del padre:', cadena.razaPadre),
            _buildInfoRow('Código de la madre:', cadena.codigoMadre),
            _buildInfoRow('Raza de la madre:', cadena.razaMadre),
            SizedBox(height: 16),
            TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.bottleWater),
                hintText: 'Producción de leche diaria',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'FichasIndividuales');
              },
              child: Text('Actualizar y Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
