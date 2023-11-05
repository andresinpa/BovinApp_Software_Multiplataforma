// ignore_for_file: file_names, use_build_context_synchronously, avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:BovinApp/screens/Auth/Register/ImagenUsuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// The class NuevoRegistroInventarioFisico is a StatefulWidget in Dart.
class NuevoRegistroInventarioFisico extends StatefulWidget {
  const NuevoRegistroInventarioFisico({super.key});

  @override
  State<NuevoRegistroInventarioFisico> createState() =>
      _NuevoRegistroInventarioFisicoState();
}

/// The `_NuevoRegistroInventarioFisicoState` class is a stateful widget that allows users to create a
/// new inventory item by providing various details such as product name, code, price, classification,
/// description, etc.
class _NuevoRegistroInventarioFisicoState
    extends State<NuevoRegistroInventarioFisico> {
  DateTime? selectedDate;
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

  /// The above code is importing the `FirebaseFirestore` class from the `firebase` package and creating
  /// an instance of it called `firebase`.
  final firebase = FirebaseFirestore.instance;

  /// The above code is declaring a variable called "clasificacion" and assigning it an array of strings.
  /// The array contains different categories such as 'Ferreteria', 'Alimentos', 'Medicamentos',
  /// 'Maquinaria', and 'Insumos'.
  var clasificacion = [
    'Ferreteria',
    'Alimentos',
    'Medicamentos',
    'Maquinaria',
    'Insumos',
  ];
  String vistaClasificacion = 'Ferreteria';

  /// The above code is declaring a variable `_imagePicker` of type `ImagePicker` and initializing it with
  /// a new instance of the `ImagePicker` class. It also declares a nullable variable `_pickedImage` of
  /// type `File`.
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  /// The function `_pickImage` allows the user to pick an image from a specified source and updates the
  /// state with the selected image.
  ///
  /// Args:
  ///   source (ImageSource): The `source` parameter is of type `ImageSource` and is used to specify the
  /// source from where the image should be picked. It can have one of the following values:
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);
    setState(() {
      _pickedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  late User objUser;

  /// The initState function retrieves the user object from the UserProvider using the Provider package in
  /// Dart.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;
  }

  /// The function `validarDatos()` checks if a product code already exists in a Firestore collection
  /// and if not, it adds the product information to the collection.
  validarDatos() async {
    try {
      /// The above code is creating a reference to a collection in Firestore called "Usuarios". It then
      /// retrieves a specific document within that collection using the value of the "objUser.usuario"
      /// variable. Finally, it retrieves a subcollection called "InventarioFisico" within that document
      /// and stores the result in the "productos" variable.
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

        /// The above code is using the Firebase Firestore database to add a new document to the
        /// "InventarioFisico" collection under a specific user's document in the "Usuarios" collection.
        /// The document contains various fields such as "NombreProducto", "Ingreso", "CodigoProducto",
        /// "FechaObtencion", "PrecioProducto", "UtilidadProducto", "DescripcionProducto", and
        /// "ClasificacionProducto". The values for these fields are obtained from the corresponding
        /// text inputs.
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

  /// The function `_showDatePicker` is used to display a date picker dialog and update the selected
  /// date if a new date is picked.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter is the BuildContext object that represents the
  /// current build context of the widget tree. It is used to show the date picker dialog and to access
  /// the current theme and localization information.
  Future<void> _showDatePicker(BuildContext context) async {
    final currentDate = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? currentDate,
        firstDate: DateTime(currentDate.year - 15),
        lastDate: currentDate);

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  /// This function builds a form for creating a new product with various input fields and a bottom
  /// navigation bar.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget tree.
  /// It is typically used to access the theme, media queries, and other properties of the current
  /// context.
  ///
  /// Returns:
  ///   The code is returning a Scaffold widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// The `onTabSelected` function updates the `currentIndex` variable with the selected tab index.
    ///
    /// Args:
    ///   index (int): The `index` parameter is an integer that represents the index of the selected tab.
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
                        hint: selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : 'Obtención',
                        inputType: TextInputType.none,
                        inputAction: TextInputAction.next,
                        widthContainer: 0.6,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      MaterialButton(
                        onPressed: () => _showDatePicker(context),
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
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
