// ignore_for_file: library_private_types_in_public_api

import 'package:clinica_ulagos_app/screens/crear_clave.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrarseScreen extends StatefulWidget {
  const RegistrarseScreen({Key? key}) : super(key: key);

  @override
  _RegistrarseScreenState createState() => _RegistrarseScreenState();
}

// ... Importaciones y código anterior

class _RegistrarseScreenState extends State<RegistrarseScreen> {
  final TextEditingController _rutController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apePatController = TextEditingController();
  final TextEditingController _apeMatController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String rutValue = '';
  String nombresValue = '';
  String apellidoPatValue = '';
  String apellidoMatValue = '';
  String dateValue = '';
  String generoValue = '';
  String correoValue = '';
  String telefonoValue = '';
  Color femeninoColor = AppColors.inputs;
  Color masculinoColor = AppColors.inputs;
  Color otroColor = AppColors.inputs;
  bool errorRut = false;
  bool errorNombre = false;
  bool errorApePat = false;
  bool errorApeMat = false;
  bool errorFec = false;
  bool errorCorreo = false;
  bool errorTelefono = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue_900,
        title: const Text(
          'REGISTRARSE',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        centerTitle: true, // Centra el texto del título
        iconTheme: const IconThemeData(
          color: AppColors.white,
          size: 36,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Rut',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextFormField(
                controller: _rutController,
                onSaved: (value) {
                  rutValue = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorRut = true;
                    });
                  } else {
                    setState(() {
                      errorRut = false;
                      rutValue = value;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'Ej: 20589741-2',
                  hintStyle: TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                ),
              ),
            ),
            if (errorRut)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese un rut',
                    style: TextStyle(color: AppColors.error)),
              ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Nombre(s)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextFormField(
                controller: _nombresController,
                onSaved: (value) {
                  nombresValue = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorNombre = true;
                    });
                  } else {
                    setState(() {
                      errorNombre = false;
                      nombresValue = value;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu nombre...',
                  hintStyle: TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                ),
              ),
            ),
            if (errorNombre)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese su nombre',
                    style: TextStyle(color: AppColors.error)),
              ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Apellido Paterno',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextFormField(
                controller: _apePatController,
                onSaved: (value) {
                  apellidoPatValue = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorApePat = true;
                    });
                  } else {
                    setState(() {
                      errorApePat = false;
                      apellidoPatValue = value;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu apellido paterno...',
                  hintStyle: TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                ),
              ),
            ),
            if (errorApePat)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese su apellido paterno',
                    style: TextStyle(color: AppColors.error)),
              ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Apellido Materno',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextFormField(
                controller: _apeMatController,
                onSaved: (value) {
                  apellidoMatValue = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorApeMat = true;
                    });
                  } else {
                    setState(() {
                      errorApeMat = false;
                      apellidoMatValue = value;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu apellido materno...',
                  hintStyle: TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                ),
              ),
            ),
            if (errorApeMat)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese su apellido materno',
                    style: TextStyle(color: AppColors.error)),
              ),
            // Campo de entrada de fecha
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Fecha de Nacimiento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextFormField(
                onSaved: (value) {
                  dateValue = value ?? '';
                },
                controller: _dateController,
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'Seleccione...',
                  hintStyle: TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                  suffixIcon:
                      Icon(Icons.calendar_today), // Icono del calendario
                ),
                readOnly: true,
                onTap: () {
                  _seleccionarFecha();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorFec = true;
                    });
                  } else {
                    setState(() {
                      errorFec = false;
                      dateValue = value;
                    });
                  }
                  return null;
                },
              ),
            ),
            if (errorFec)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese su fecha de nacimiento',
                    style: TextStyle(color: AppColors.error)),
              ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Género (opcional)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        generoValue = 'F';
                        femeninoColor = AppColors.blue_400;
                        masculinoColor = AppColors.inputs;
                        otroColor = AppColors.inputs;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: femeninoColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Radio de la esquina
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0), // Relleno interno
                      fixedSize: const Size(110.0, 25.0),
                    ),
                    child: Text('Femenino',
                        style: TextStyle(
                          color: generoValue == 'F'
                              ? AppColors.white
                              : AppColors.black,
                        )),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        generoValue = 'M';
                        femeninoColor = AppColors.inputs;
                        masculinoColor = AppColors.blue_400;
                        otroColor = AppColors.inputs;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: masculinoColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Radio de la esquina
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0), // Relleno interno
                      fixedSize: const Size(110.0, 25.0),
                    ),
                    child: Text('Masculino',
                        style: TextStyle(
                          color: generoValue == 'M'
                              ? AppColors.white
                              : AppColors.black,
                        )),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        generoValue = 'O';
                        femeninoColor = AppColors.inputs;
                        masculinoColor = AppColors.inputs;
                        otroColor = AppColors.blue_400;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: otroColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Radio de la esquina
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0), // Relleno interno
                      fixedSize: const Size(110.0, 25.0),
                    ),
                    child: Text('Otro',
                        style: TextStyle(
                          color: generoValue == 'O'
                              ? AppColors.white
                              : AppColors.black,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Correo electrónico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextFormField(
                controller: _correoController,
                onSaved: (value) {
                  correoValue = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorCorreo = true;
                    });
                  } else {
                    setState(() {
                      errorCorreo = false;
                      correoValue = value;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'correo@dominio.cl',
                  hintStyle: TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                ),
              ),
            ),
            if (errorCorreo)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese su correo electrónico',
                    style: TextStyle(color: AppColors.error)),
              ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Teléfono móvil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextFormField(
                controller: _telefonoController,
                onSaved: (value) {
                  telefonoValue = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorTelefono = true;
                    });
                  } else {
                    setState(() {
                      errorTelefono = false;
                      telefonoValue = value;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'Ej: 958476828',
                  hintStyle: TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                ),
              ),
            ),
            if (errorTelefono)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese su teléfono móvil',
                    style: TextStyle(color: AppColors.error)),
              ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  if (!errorRut &&
                      !errorNombre &&
                      !errorApePat &&
                      !errorApeMat &&
                      !errorFec &&
                      !errorCorreo &&
                      !errorTelefono) {
                    await enviarDatosAFirebase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CrearClaveScreen(
                          rut: rutValue,
                          nombres: nombresValue,
                          apellidoPat: apellidoPatValue,
                          apellidoMat: apellidoMatValue,
                          fechaNacimiento: dateValue,
                          genero: generoValue,
                          correo: correoValue,
                          telefono: telefonoValue,
                        ),
                      ),
                    );
                  } else {
                    _scrollController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                }
              },
              child: const Text('Cree su contraseña'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _seleccionarFecha() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1923),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Future<void> enviarDatosAFirebase() async {
    try {
      // Accede a tu colección en Firestore
      CollectionReference paciente =
          FirebaseFirestore.instance.collection('paciente');

      String idPaciente = rutValue;

      await paciente.doc(idPaciente).set({
        'rut': rutValue,
        'nombres': nombresValue,
        'apellido_paterno': apellidoPatValue,
        'apellido_materno': apellidoMatValue,
        'fecha_nacimiento': dateValue,
        'genero': generoValue,
        'correo': correoValue,
        'telefono': telefonoValue,
      });

      print('Datos enviados a Firebase con éxito.');
    } catch (e) {
      print('Error al enviar datos a Firebase: $e');
      // Puedes manejar el error según tus necesidades
    }
  }
}
