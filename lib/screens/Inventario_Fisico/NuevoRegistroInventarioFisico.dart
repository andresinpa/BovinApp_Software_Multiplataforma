import 'dart:ui';

import 'package:bovinapp/Design/palette.dart';
import 'package:bovinapp/widgets/RoundedButton.dart';
import 'package:bovinapp/widgets/TextInputField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NuevoRegistroInventarioFisico extends StatelessWidget {
  NuevoRegistroInventarioFisico({super.key});
  TextEditingController codigoFinca = TextEditingController();
  TextEditingController codigoProducto = TextEditingController();
  TextEditingController fechaObtencion = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController utilidad = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var clasificacion = [
      'Ferretería',
      'Alimentos',
      'Medicamentos',
      'Maquinaria',
      'Otros'
    ];
    String vistaClasificacion = 'Ferretería';

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                SizedBox(
                  height: size.width * 0.1,
                  child: const Text(
                    'Nuevo Articulo',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 4,
                            sigmaY: 4,
                          ),
                          child: CircleAvatar(
                            radius: size.width * 0.15,
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            child: Icon(FontAwesomeIcons.wrench,
                                color: kWhite, size: size.width * 0.1),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kWhite,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    TextInputField(
                        icon: FontAwesomeIcons.houseChimneyMedical,
                        hint: 'Codigo de la finca',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        controler: codigoFinca,),
                    TextInputField(
                        icon: FontAwesomeIcons.key,
                        hint: 'Codigo del producto',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        controler: codigoProducto,),
                    TextInputField(
                        icon: FontAwesomeIcons.calendar,
                        hint: 'Fecha de obtención',
                        inputType: TextInputType.datetime,
                        inputAction: TextInputAction.next,
                        controler: fechaObtencion,),
                    TextInputField(
                        icon: FontAwesomeIcons.dollarSign,
                        hint: 'Precio',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        controler: precio,),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          child: Text(
                            'Clasificación:    ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        DropdownButton(
                          items: clasificacion.map((String a) {
                            return DropdownMenuItem(
                                value: a,
                                child: Text(
                                  a,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                ));
                          }).toList(),
                          onChanged: (value) => {
                            //setState(() {
                            //vista = value;

                            //})
                            // ignore: avoid_print
                            print(value)
                          },
                          hint: Text(
                            vistaClasificacion,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInputField(
                        icon: FontAwesomeIcons.rectangleXmark,
                        hint: 'Utilidad',
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        controler: utilidad,),
                    TextInputField(
                        icon: FontAwesomeIcons.rectangleList,
                        hint: 'Descripción',
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        controler: descripcion,),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, 'BusquedaIndividualArticulo');
                          },
                          child: const RoundedButton(
                              buttonName: 'Guardar', rute: 'InventarioFisico'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
