// ignore_for_file: library_private_types_in_public_api

import 'package:clinica_ulagos_app/screens/crear_clave.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:clinica_ulagos_app/funcionesValidaciones/validaciones.dart';
import 'package:clinica_ulagos_app/consultasFirebase/consultas.dart';

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
  bool errorRutVacio = false;
  bool errorRutExiste = false;
  bool errorRutInvalido = false;
  bool errorNombreVacio = false;
  bool errorApePatVacio = false;
  bool errorApeMatVacio = false;
  bool errorFecVacio = false;
  bool errorCorreoVacio = false;
  bool errorCorreoExiste = false;
  bool errorCorreoInvalido = false;
  bool errorTelefonoVacio = false;
  bool errorTelefonoExiste = false;
  bool errorTelefonoInvalido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue_900,
        title: const Text(
          'Registrarse',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
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
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      setState(() {
                        errorRutVacio = true;
                      });
                    } else if (!validarRut(value)) {
                      setState(() {
                        errorRutVacio = false;
                        errorRutExiste = false;
                        errorRutInvalido = true;
                      });
                    } else {
                      checkIfRutExists(value).then((rutExists) {
                        setState(() {
                          errorRutExiste = rutExists;
                          errorRutVacio = false;
                          errorRutInvalido = false;
                        });
                      });
                    }
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorRutVacio = true;
                    });
                  } else if (!validarRut(value)) {
                    setState(() {
                      errorRutVacio = false;
                      errorRutExiste = false;
                      errorRutInvalido = true;
                    });
                  } else {
                    checkIfRutExists(value).then((rutExists) {
                      setState(() {
                        errorRutExiste = rutExists;
                        errorRutVacio = false;
                        errorRutInvalido = false;
                      });
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
            if (errorRutVacio || errorRutExiste || errorRutInvalido)
              Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text(
                  errorRutVacio
                      ? 'Por favor, ingrese un rut.'
                      : errorRutInvalido
                          ? 'Ingrese un rut válido.'
                          : 'El rut ya está registrado en el sistema.',
                  style: const TextStyle(color: AppColors.error),
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
                    'Nombre(s)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
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
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorNombreVacio = true;
                    });
                  } else {
                    setState(() {
                      errorNombreVacio = false;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorNombreVacio = true;
                    });
                  } else {
                    setState(() {
                      errorNombreVacio = false;
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
            if (errorNombreVacio)
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
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorApePatVacio = true;
                    });
                  } else {
                    setState(() {
                      errorApePatVacio = false;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorApePatVacio = true;
                    });
                  } else {
                    setState(() {
                      errorApePatVacio = false;
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
            if (errorApePatVacio)
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
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorApeMatVacio = true;
                    });
                  } else {
                    setState(() {
                      errorApeMatVacio = false;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorApeMatVacio = true;
                    });
                  } else {
                    setState(() {
                      errorApeMatVacio = false;
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
            if (errorApeMatVacio)
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
                      Icon(Icons.calendar_today, color: AppColors.icons),
                ),
                readOnly: true,
                onTap: () {
                  _seleccionarFecha();
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorFecVacio = true;
                    });
                  } else {
                    setState(() {
                      errorFecVacio = false;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorFecVacio = true;
                    });
                  } else {
                    setState(() {
                      errorFecVacio = false;
                      dateValue = value;
                    });
                  }
                  return null;
                },
              ),
            ),
            if (errorFecVacio)
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
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
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorCorreoVacio = true;
                    });
                  } else if (!validarCorreo(value)) {
                    setState(() {
                      errorCorreoVacio = false;
                      errorCorreoExiste = false;
                      errorCorreoInvalido = true;
                    });
                  } else {
                    checkIfCorreoExists(value).then((correoExists) {
                      setState(() {
                        errorCorreoExiste = correoExists;
                        errorCorreoVacio = false;
                        errorCorreoInvalido = false;
                      });
                    });
                  }
                },
                validator: (value) {
                  // Validar si el campo está vacío
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorCorreoVacio = true;
                    });
                  } else if (!validarCorreo(value)) {
                    setState(() {
                      errorCorreoVacio = false;
                      errorCorreoExiste = false;
                      errorCorreoInvalido = true;
                    });
                  } else {
                    checkIfCorreoExists(value).then((correoExists) {
                      setState(() {
                        errorCorreoExiste = correoExists;
                        errorCorreoVacio = false;
                        errorCorreoInvalido = false;
                      });
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
            if (errorCorreoVacio || errorCorreoExiste || errorCorreoInvalido)
              Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text(
                  errorCorreoVacio
                      ? 'Por favor, ingrese un correo electrónico.'
                      : errorCorreoInvalido
                          ? 'Ingrese un correo electrónico válido.'
                          : 'El correo electrónico ya está registrado en el sistema.',
                  style: const TextStyle(color: AppColors.error),
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
                    'Teléfono móvil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
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
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorTelefonoVacio = true;
                    });
                  } else if (!validarTelefono(value)) {
                    setState(() {
                      errorTelefonoVacio = false;
                      errorTelefonoExiste = false;
                      errorTelefonoInvalido = true;
                    });
                  } else {
                    checkIfTelefonoExists(value).then((telefonoExists) {
                      setState(() {
                        errorTelefonoExiste = telefonoExists;
                        errorTelefonoVacio = false;
                        errorTelefonoInvalido = false;
                      });
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorTelefonoVacio = true;
                    });
                  } else if (!validarTelefono(value)) {
                    setState(() {
                      errorTelefonoVacio = false;
                      errorTelefonoExiste = false;
                      errorTelefonoInvalido = true;
                    });
                  } else {
                    checkIfTelefonoExists(value).then((telefonoExists) {
                      setState(() {
                        errorTelefonoExiste = telefonoExists;
                        errorTelefonoVacio = false;
                        errorTelefonoInvalido = false;
                      });
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
            if (errorTelefonoVacio ||
                errorTelefonoExiste ||
                errorTelefonoInvalido)
              Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text(
                  errorTelefonoVacio
                      ? 'Por favor, ingrese un número telefónico.'
                      : errorTelefonoInvalido
                          ? 'Ingrese un número telefónico válido.'
                          : 'El número telefónico ya está registrado en el sistema.',
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            const SizedBox(height: 25),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      if (!errorRutVacio &&
                          !errorRutExiste &&
                          !errorRutInvalido &&
                          !errorNombreVacio &&
                          !errorApePatVacio &&
                          !errorApeMatVacio &&
                          !errorFecVacio &&
                          !errorCorreoVacio &&
                          !errorCorreoExiste &&
                          !errorCorreoInvalido &&
                          !errorTelefonoVacio &&
                          !errorTelefonoExiste &&
                          !errorTelefonoInvalido) {
                        // ignore: use_build_context_synchronously
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: AppColors.buttons,
                    padding: const EdgeInsets.all(10.0),
                    fixedSize: const Size(250, 60),
                    foregroundColor: AppColors.blue_900,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cree su contraseña',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
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
}
