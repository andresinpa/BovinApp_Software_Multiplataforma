import 'dart:io';
import 'dart:ui';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:BovinApp/screens/Auth/Register/ImagenUsuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:provider/provider.dart';

class NuevoRegistroInventarioFisico extends StatefulWidget {
  const NuevoRegistroInventarioFisico({super.key});

  @override
  State<NuevoRegistroInventarioFisico> createState() =>
      _NuevoRegistroInventarioFisicoState();
}

class _NuevoRegistroInventarioFisicoState
    extends State<NuevoRegistroInventarioFisico> {
  TextEditingController nombreProducto = TextEditingController();
  TextEditingController ingreso = TextEditingController();
  TextEditingController codigoProducto = TextEditingController();
  TextEditingController fechaObtencion = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController utilidad = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  dynamic uploaded;
  dynamic imageLocal;
  bool bandera = true;
  final firebase = FirebaseFirestore.instance;
  var clasificacion = [
    'Ferreteria',
    'Alimentos',
    'Medicamentos',
    'Maquinaria',
    'Insumos',
  ];
  String vistaClasificacion = 'Ferreteria';

  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);
    setState(() {
      _pickedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  late User objUser;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  validarDatos() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(objUser.usuario)
          .collection('InventarioFisico');
      QuerySnapshot productos = await ref.get();
      if (productos.docs.isNotEmpty) {
        for (var cursor in productos.docs) {
          if (cursor.get('CodigoProducto') == codigoProducto.text) {
            await DialogUnBoton.alert(context, 'Error',
                '¡El codigo del producto ya ha sido registrado!');
            bandera = false;
            break;
          } else {
            bandera = true;
          }
        }
      }
      if (bandera == true) {
        if (_pickedImage == null) {
          imageLocal = '';
          uploaded =
              'https://firebasestorage.googleapis.com/v0/b/bovinapp-project.appspot.com/o/BovinApp%2Favatar.png?alt=media&token=aaa46974-ff9d-471d-a10c-87b8d626a2a9';
        } else {
          imageLocal = _pickedImage;
          uploaded = await uploadImage(imageLocal, codigoProducto.text);
        }
        await firebase
            .collection('Usuarios')
            .doc(objUser.usuario)
            .collection('InventarioFisico')
            .doc(codigoProducto.text)
            .set({
          "NombreProducto": nombreProducto.text,
          "Ingreso": ingreso.text,
          "CodigoProducto": codigoProducto.text,
          "FechaObtencion": fechaObtencion.text,
          "PrecioProducto": precio.text,
          "UtilidadProducto": utilidad.text,
          "DescripcionProducto": descripcion.text,
          "ClasificacionProducto": vistaClasificacion,
        });
      }
      print('Se envio la información');
    } catch (e) {
      print("error ---->$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2008),
        lastDate: DateTime.now(),
      );
    }

    int currentIndex = 1;
    void onTabSelected(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarRetroceder(title: 'Nuevo Producto'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffe3ffff),
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: const Color(0xff7081cb)),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 142,
                    height: 142,
                    child: _pickedImage != null
                        ? Image.file(
                            _pickedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(FontAwesomeIcons.wrench, size: 75),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(FontAwesomeIcons.image),
                label: const Text(
                  'Foto del artículo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  iconColor:
                      MaterialStateProperty.all<Color>(const Color(0xfff16437)),
                ),
              ),
              SizedBox(
                height: size.width * 0.1,
              ),
              Column(
                children: [
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.key,
                    hint: 'Codigo del producto',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: codigoProducto,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.cow,
                    hint: 'Nombre Producto',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    controler: nombreProducto,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 38,
                      ),
                      TextInputFieldWidth(
                        controler: ingreso,
                        icon: FontAwesomeIcons.moneyCheckDollar,
                        hint: 'Obtención',
                        inputType: TextInputType.none,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.6,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      MaterialButton(
                        onPressed: _showDatePicker,
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          size: 24,
                          color: Color(0xfff16437),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: 1,
                    icon: FontAwesomeIcons.dollarSign,
                    hint: 'Precio',
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    controler: precio,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.cow), // Icono deseado
                      SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text(
                        'Clasificación del producto',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: vistaClasificacion,
                          icon: const Icon(Icons.arrow_downward,
                              color: Color(0xfff16437)),
                          elevation: 16,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              vistaClasificacion = value!;
                            });
                          },
                          items: clasificacion.map((String valor) {
                            return DropdownMenuItem(
                                value: valor,
                                child: Text(
                                  valor,
                                ));
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: null,
                    icon: FontAwesomeIcons.chartLine,
                    hint: 'Usos',
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    controler: utilidad,
                  ),
                  SizedBox(
                    height: size.width * 0.008,
                  ),
                  TextInputField(
                    maxLines: null,
                    icon: FontAwesomeIcons.rectangleList,
                    hint: 'Descripción',
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    controler: descripcion,
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        validarDatos();
                        Navigator.pushNamed(context, 'InventarioFisico');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0)),
                        padding: const EdgeInsets.all(0),
                        minimumSize: Size(size.width * 0.5, 50.0),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        initialIndex: currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}
