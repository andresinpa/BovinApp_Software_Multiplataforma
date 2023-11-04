// ignore_for_file: file_names

import 'dart:io';
import 'package:BovinApp/DTO/Services/UserProvider.dart';
import 'package:BovinApp/DTO/User.dart';
import 'package:BovinApp/Screens/Auth/Register/ImagenUsuario.dart';
import 'package:BovinApp/Widgets/BottomBar.dart';
import 'package:BovinApp/Widgets/Export/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

/// The class "MiUsuarioYFinca" is a stateful widget in Dart.
class MiUsuarioYFinca extends StatefulWidget {
  const MiUsuarioYFinca({super.key});
  @override
  MiUsuarioYFincaApp createState() => MiUsuarioYFincaApp();
}

class MiUsuarioYFincaApp extends State<MiUsuarioYFinca> {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController nombreFinca = TextEditingController();
  TextEditingController direccionFinca = TextEditingController();
  TextEditingController areaFinca = TextEditingController();
  TextEditingController unidadMedida = TextEditingController();

  /// The above code is using the Dart programming language to create a final variable `db` that
  /// represents an instance of the `FirebaseFirestore` class. It also declares a dynamic variable
  /// `uploaded` with an empty value, and an integer variable `currentIndex` with a value of 1.
  final db = FirebaseFirestore.instance;
  dynamic uploaded = '';
  int currentIndex = 1;

  /// The above code is declaring a variable `_imagePicker` of type `ImagePicker` and initializing it with
  /// a new instance of `ImagePicker`. It also declares a nullable variable `_pickedImage` of type `File`
  /// and sets it to `null`. Additionally, it declares a boolean variable `delete` and sets it to `false`.
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;
  bool delete = false;

  late User objUser;

  /// The `initState` function initializes the state of the widget and sets the values of various text
  /// fields based on the user's data.
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    objUser = userProvider.user;

    if (objUser.apellido != '') {
      apellidos.text = objUser.apellido;
    }
    if (objUser.areaFinca != '') {
      areaFinca.text = objUser.areaFinca;
    }
    if (objUser.direccionFinca != '') {
      direccionFinca.text = objUser.direccionFinca;
    }
    if (objUser.finca != '') {
      nombreFinca.text = objUser.finca;
    }
    if (objUser.nombre != '') {
      nombre.text = objUser.nombre;
    }
    if (objUser.areaUnidadMedida != '') {
      unidadMedida.text = objUser.areaUnidadMedida;
    } else {
      unidadMedida.text = 'Unidad de medida';
    }
    if (objUser.imagenCloudStorage ==
        'https://firebasestorage.googleapis.com/v0/b/bovinapp-project.appspot.com/o/BovinApp%2Favatar.png?alt=media&token=aaa46974-ff9d-471d-a10c-87b8d626a2a9') {
      delete = true;
      uploaded = objUser.imagenCloudStorage;
    } else {
      uploaded = objUser.imagenCloudStorage;
    }
  }

  /// The function `_pickImage` picks an image from a specified source and updates the state with the
  /// picked image.
  ///
  /// Args:
  ///   source (ImageSource): The source parameter is of type ImageSource, which is an enum that
  /// represents the source from which the image should be picked. It can have the following values:
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);
    setState(() {
      _pickedImage = pickedImage != null ? File(pickedImage.path) : null;
      if (_pickedImage == null) {
        delete = false;
      }
    });
  }

  /// The function updates the current index when a tab is selected.
  ///
  /// Args:
  ///   index (int): The index parameter represents the index of the selected tab. It is used to update
  /// the state of the current index, which is typically used to control the active tab in a tab bar or
  /// tab view.
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  var lista = ['Unidad de medida', 'Metros cuadrados', 'Fanegadas'];

  /// This is a Dart code snippet that builds a user interface for updating user information and saving
  /// it to a database.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the BuildContext object, which represents the
  /// location in the widget tree where the widget is being built. It is typically used to access the
  /// theme, media queries, and other information about the app's current state.
  ///
  /// Returns:
  ///   The code is returning a Scaffold widget with various child widgets including buttons, text
  /// fields, and an image. The bottomNavigationBar is also included.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// The function `insertarDatos` updates user data in a Firestore database, including the user's
    /// name, surname, farm name, farm address, farm area, unit of measurement for the area, and avatar
    /// URL.
    insertarDatos() async {
      try {
        if (_pickedImage == null) {
          objUser.imagenLocal = '';
        } else {
          objUser.imagenLocal = _pickedImage;
        }
        if (objUser.imagenLocal == '' || objUser.imagenLocal == null) {
          delete
              ? uploaded =
                  'https://firebasestorage.googleapis.com/v0/b/bovinapp-project.appspot.com/o/BovinApp%2Favatar.png?alt=media&token=aaa46974-ff9d-471d-a10c-87b8d626a2a9'
              : uploaded = objUser.imagenCloudStorage;
        } else {
          uploaded = await uploadImage(objUser.imagenLocal, objUser.usuario);
        }
        var docRef = db.collection("Usuarios").doc(objUser.usuario);
        docRef.update({
          "NombreUsuario": nombre.text,
          "ApellidosUsuario": apellidos.text,
          "FincaUsuario": nombreFinca.text,
          "DireccionFinca": direccionFinca.text,
          "AreaFinca": areaFinca.text,
          "AreaUnidadMedida": unidadMedida.text,
          "UrlAvatarUsuario": uploaded,
        });
        objUser.nombre = nombre.text;
        objUser.apellido = apellidos.text;
        objUser.finca = nombreFinca.text;
        objUser.imagenCloudStorage = uploaded;
        objUser.direccionFinca = direccionFinca.text;
        objUser.areaFinca = areaFinca.text;
        objUser.areaUnidadMedida = unidadMedida.text;
      } catch (e) {
        // ignore: avoid_print
        print("Error ----->$e");
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarSencillo(title: 'Mi Usuario y Finca'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.width * 0.1,
            ),
            OutlinedButton.icon(
              /// The above code is defining an onPressed event handler for a button. If the variable
              /// "delete" is true, the onPressed event will be set to null, meaning the button will be
              /// disabled. If "delete" is false, the onPressed event will display an alert dialog with
              /// a confirmation message. If the user confirms the action, the "uploaded" variable will
              /// be updated with a new URL and the "_pickedImage" variable will be set to null.
              /// Finally, the "delete" variable will be set to true.
              onPressed: delete
                  ? null
                  : () => {
                        DialogAccionOnPressed.alert(context, 'Alerta',
                            '¡Al eliminar la foto no se podrá recuperar!', () {
                          uploaded =
                              'https://firebasestorage.googleapis.com/v0/b/bovinapp-project.appspot.com/o/BovinApp%2Favatar.png?alt=media&token=aaa46974-ff9d-471d-a10c-87b8d626a2a9';
                          setState(() {
                            _pickedImage = null;
                          });
                          delete = true;
                        }),
                      },
              icon: const Icon(Icons.delete),
              label: const Text(
                'Eliminar foto',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                iconColor: MaterialStateProperty.all<Color>(delete
                    ? Colors.blueGrey
                    : const Color.fromARGB(255, 179, 14, 14)),
              ),
            ),
            SizedBox(
              height: size.width * 0.03,
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
                      : CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(
                              delete ? uploaded : objUser.imagenCloudStorage),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => {
                if (_pickedImage == null)
                  {
                    _pickImage(ImageSource.gallery),
                    delete = true,
                  }
                else
                  {
                    /// The above code is using the `setState` method in Dart to update the state of the
                    /// application. It sets the `_pickedImage` variable to `null` and the `delete`
                    /// variable to `false`. It then checks if the `objUser.imagenCloudStorage` variable
                    /// is equal to a specific URL. If it is, it sets the `delete` variable to `true`.
                    setState(() {
                      _pickedImage = null;
                      delete = false;
                      if (objUser.imagenCloudStorage ==
                          'https://firebasestorage.googleapis.com/v0/b/bovinapp-project.appspot.com/o/BovinApp%2Favatar.png?alt=media&token=aaa46974-ff9d-471d-a10c-87b8d626a2a9') {
                        delete = true;
                      }
                    }),
                  }
              },
              icon: const Icon(Icons.image),
              label: Text(
                _pickedImage != null ? 'Mantener mi foto' : 'Actualizar foto',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                iconColor:
                    MaterialStateProperty.all<Color>(const Color(0xfff16437)),
              ),
            ),
            SizedBox(
              height: size.width * 0.03,
            ),
            Column(
              children: [
                TextInputFieldDisabled(
                  icon: Icons.email_rounded,
                  hint: objUser.email,
                ),
                TextInputFieldDisabled(
                  icon: FontAwesomeIcons.circleUser,
                  hint: objUser.usuario,
                ),
                TextInputField(
                  maxLines: 1,
                  icon: Icons.man_2_rounded,
                  hint: 'Nombre',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: nombre,
                ),
                TextInputField(
                  maxLines: 1,
                  icon: Icons.man_4_rounded,
                  hint: 'Apellidos',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: apellidos,
                ),
                TextInputField(
                  maxLines: 1,
                  icon: FontAwesomeIcons.houseChimney,
                  hint: 'Nombre de la Finca',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: nombreFinca,
                ),
                TextInputField(
                  maxLines: 2,
                  icon: FontAwesomeIcons.locationArrow,
                  hint: 'Dirección de la finca',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  controler: direccionFinca,
                ),
                Column(
                  children: [
                    TextInputField(
                      maxLines: 1,
                      icon: FontAwesomeIcons.chartArea,
                      hint: 'Mi finca tiene un área de:',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      controler: areaFinca,
                    ),
                    DropdownButton(
                      value: unidadMedida.text,
                      items: lista.map((String valor) {
                        return DropdownMenuItem(
                            value: valor,
                            child: Text(
                              valor,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ));
                      }).toList(),
                      onChanged: (valor) {
                        setState(() {
                          unidadMedida.text = valor.toString();
                        });
                      },
                      hint: Text(
                        unidadMedida.text,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nombre.text == objUser.nombre &&
                          apellidos.text == objUser.apellido &&
                          nombreFinca.text == objUser.finca &&
                          direccionFinca.text == objUser.direccionFinca &&
                          areaFinca.text == objUser.areaFinca &&
                          unidadMedida.text == objUser.areaUnidadMedida) {
                        DialogDosBotones.alert(
                            context,
                            'Error',
                            'Aún no has hecho cambios para actualizar, ¿deseas salir de esta pestaña?',
                            'Home');
                      } else {
                        if (nombre.text.length < 3) {
                          DialogUnBoton.alert(context, 'Alerta',
                              'El campo de nombre debe tener más de dos caracteres');
                        } else if (apellidos.text.length < 3) {
                          DialogUnBoton.alert(context, 'Alerta',
                              'El campo de apellidos debe tener más de dos caracteres');
                        } else if (nombreFinca.text.isEmpty) {
                          DialogUnBoton.alert(context, 'Alerta',
                              'Debe ingresar el nombre de la finca');
                        } else if (unidadMedida.text == 'Unidad de medida' &&
                            areaFinca.text.isNotEmpty) {
                          DialogUnBoton.alert(context, 'Alerta',
                              'Si agrega un valor para el área de la finca debe asignarle una unidad de medida');
                        } else if ((areaFinca.text.isEmpty ||
                                areaFinca.text == '0' ||
                                areaFinca.text == '0 ') &&
                            unidadMedida.text != 'Unidad de medida') {
                          DialogUnBoton.alert(context, 'Alerta',
                              'Si asigna una unidad de medida debe existir un valor para el área de la finca');
                        } else {
                          DialogAccionOnPressed.alert(context, 'Alerta',
                              '¿Desea guardar todos los cambios realizados?',
                              () {
                            insertarDatos();
                            objUser.imagenLocal = '';
                            Navigator.pop(context);
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.all(0),
                      minimumSize: Size(size.width * 0.6, 60.0),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Actualizar y Guardar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
      bottomNavigationBar: BottomBar(
        initialIndex: currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}
