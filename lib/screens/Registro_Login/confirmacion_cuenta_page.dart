import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bovinapp/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../DTO/user.dart';
import '../../Design/palette.dart';

class ConfirmacionCuentaPage extends StatefulWidget {
  final User cadena;
  ConfirmacionCuentaPage(this.cadena);
  @override
  ConfirmacionCuentaPageApp createState() => ConfirmacionCuentaPageApp();

}
class ConfirmacionCuentaPageApp extends State<ConfirmacionCuentaPage> {
  TextEditingController codigo = TextEditingController();
    final firebase = FirebaseFirestore.instance;
    insertarDatos() async{
    try{
      await firebase.collection('Usuarios').doc().set({
        "NombreUsuario":widget.cadena.nombre,
        "ApellidosUsuario":widget.cadena.apellido,
        "Usuario":widget.cadena.usuario,
        "EmailUsuario":widget.cadena.email,
        "FincaUsuario":widget.cadena.finca,
        "GanadoUsuario":widget.cadena.ganado,
        "PasswordUsuario":widget.cadena.password,
      });
      print('se envio la informacion');
    }catch (e){
      print("Error ----->"+e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              '¡Confirma tu cuenta!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.8,
                      child: Text(
                        '"'+widget.cadena.nombre+'", gracias por elegir BovinApp como tu software para la gestión de tu ganado bovino y de tu finca. Estas a un paso de disfrutar de todas las opciones y caracteristicas de la App. Por favor valida tus datos e ingresa el código de la finca que fue enviado al correo "'+(widget.cadena.email)+'" para continuar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: const Text(
                          'Ingresa aqui el código',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ignore: prefer_const_constructors
                      TextInputField(
                        icon: FontAwesomeIcons.envelope,
                        hint: 'codigo',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.done,
                        controler: codigo,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kBlue,
                            ),
                            child: TextButton(
                              onPressed: () {
                                if(codigo.text==widget.cadena.codigo){
                                  insertarDatos();
                                  Navigator.pushNamed(context, '/');
                                }else{
                                    print('codigo erroneo');
                                }
                              },

                              child: Text(
                                'Enviar',
                                style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
