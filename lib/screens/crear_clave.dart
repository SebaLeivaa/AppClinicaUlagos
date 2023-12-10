// ignore_for_file: library_private_types_in_public_api
import 'package:clinica_ulagos_app/screens/registrarse_exitoso.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrearClaveScreen extends StatefulWidget {
  const CrearClaveScreen(
      {Key? key,
      required this.rut,
      required this.nombres,
      required this.apellidoPat,
      required this.apellidoMat,
      required this.fechaNacimiento,
      required this.genero,
      required this.correo,
      required this.telefono})
      : super(key: key);

  final String rut;
  final String nombres;
  final String apellidoPat;
  final String apellidoMat;
  final String fechaNacimiento;
  final String genero;
  final String correo;
  final String telefono;

  @override
  _CrearClaveScreenState createState() => _CrearClaveScreenState();
}

class _CrearClaveScreenState extends State<CrearClaveScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _claveController2 = TextEditingController();

  String claveValue = '';
  String claveValue2 = '';
  bool errorClaveVacia = false;
  bool obscureText = true;
  bool errorClaveIguales = false;
  RegExp validacionClave1 = RegExp(r'^.{8,}$');
  RegExp validacionClave2 = RegExp(r'[A-Z]');
  RegExp validacionClave3 = RegExp(r'[a-z]');
  RegExp validacionClave4 = RegExp(r'[0-9]');
  RegExp validacionClaveGeneral =
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}$');
  bool errorClaveGeneral = false;

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
                  child: const Text('Crear contraseña',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                      )),
                ),
                const SizedBox(height: 60),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Contraseña',
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
                controller: _claveController,
                onSaved: (value) {
                  claveValue = value ?? '';
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorClaveVacia = true;
                    });
                  } else if (value != claveValue2) {
                    setState(() {
                      errorClaveIguales = true;
                      claveValue = value;
                      errorClaveVacia = false;
                    });
                  } else {
                    setState(() {
                      errorClaveIguales = false;
                      errorClaveVacia = false;
                      claveValue = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorClaveVacia = true;
                    });
                  } else if (!validacionClaveGeneral.hasMatch(value)) {
                    errorClaveGeneral = true;
                    errorClaveVacia = false;
                  } else {
                    setState(() {
                      errorClaveVacia = false;
                      claveValue = value;
                      errorClaveGeneral = false;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: '********',
                  hintStyle: const TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15.0),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.icons),
                    ),
                  ),
                ),
              ),
            ),
            if (errorClaveVacia)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text('Por favor, ingrese una contraseña.',
                    style: TextStyle(color: AppColors.error, fontSize: 12)),
              ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    top: 30.0,
                  ),
                  child: const Text(
                    'Confirmar contraseña',
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
                controller: _claveController2,
                onSaved: (value) {
                  claveValue = value ?? '';
                },
                onChanged: (value) {
                  if (value != claveValue) {
                    setState(() {
                      errorClaveIguales = true;
                      claveValue2 = value;
                    });
                  } else {
                    setState(() {
                      errorClaveIguales = false;
                      claveValue2 = value;
                    });
                  }
                },
                validator: (value) {
                  if (value != claveValue) {
                    setState(() {
                      errorClaveIguales = true;
                    });
                  } else {
                    setState(() {
                      errorClaveIguales = false;
                      claveValue2 = value!;
                    });
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.black),
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: '********',
                  hintStyle: const TextStyle(color: AppColors.placeholders),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15.0),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blue_400,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: AppColors.inputs,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.icons),
                    ),
                  ),
                ),
              ),
            ),
            if (errorClaveIguales)
              const Padding(
                padding: EdgeInsets.only(top: 7.0, left: 30.0),
                child: Text(
                    'Las contraseñas no coinciden. Por favor, asegúrate de ingresar la misma contraseña en ambos campos.',
                    style: TextStyle(color: AppColors.error, fontSize: 12)),
              ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey,
                    width: 0.25,
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.5),
                      leading: Icon(Icons.check_circle,
                          color:
                              validacionClave1.hasMatch(_claveController.text)
                                  ? AppColors.check
                                  : AppColors.icons),
                      title: const Text(
                        'Debe tener al menos 8 caracteres.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.5),
                      leading: Icon(Icons.check_circle,
                          color:
                              validacionClave2.hasMatch(_claveController.text)
                                  ? AppColors.check
                                  : AppColors.icons),
                      title: const Text(
                        'Debe incluir al menos una letra mayúscula.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.5),
                      leading: Icon(Icons.check_circle,
                          color:
                              validacionClave3.hasMatch(_claveController.text)
                                  ? AppColors.check
                                  : AppColors.icons),
                      title: const Text(
                        'Debe incluir al menos una letra minúscula.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.5),
                      leading: Icon(Icons.check_circle,
                          color:
                              validacionClave4.hasMatch(_claveController.text)
                                  ? AppColors.check
                                  : AppColors.icons),
                      title: const Text(
                        'Debe incluir al menos un número.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      if (!errorClaveGeneral &&
                          !errorClaveVacia &&
                          !errorClaveIguales) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RegistrarseExitosoScreen(),
                          ),
                        );
                        await enviarDatosAFirebase();
                      }
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: AppColors.buttons,
                      padding: const EdgeInsets.all(10.0),
                      fixedSize: const Size(250, 60),
                      foregroundColor: AppColors.blue_900),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Registrarse',
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
            )
          ],
        ),
      ),
    );
  }

  Future<void> enviarDatosAFirebase() async {
    try {
      CollectionReference paciente =
          FirebaseFirestore.instance.collection('paciente');

      String idPaciente = widget.rut;

      // Verifica si el documento ya existe antes de intentar agregarlo
      bool existeDocumento =
          await paciente.doc(idPaciente).get().then((doc) => doc.exists);

      if (!existeDocumento) {
        // Si el documento no existe se agrega
        await paciente.doc(idPaciente).set({
          'rut': widget.rut,
          'nombres': widget.nombres,
          'apellido_paterno': widget.apellidoPat,
          'apellido_materno': widget.apellidoMat,
          'fecha_nacimiento': widget.fechaNacimiento,
          'genero': widget.genero,
          'correo': widget.correo,
          'telefono': widget.telefono,
          'clave': claveValue
        });
      } else {
        // ignore: avoid_print
        print(
            'El documento con el Rut $idPaciente ya existe en la base de datos.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al enviar datos a Firebase: $e');
    }
  }
}
