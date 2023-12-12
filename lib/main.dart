// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:clinica_ulagos_app/screens/inicioSesionValido/mis_reservas.dart';
import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'screens/olvide_mi_clave.dart';
import 'screens/registrarse.dart';
import 'package:clinica_ulagos_app/funcionesValidaciones/validaciones.dart';
import 'package:clinica_ulagos_app/consultasFirebase/consultas.dart';
import 'package:clinica_ulagos_app/consultasFirebase/autenticar_usuario.dart';
import 'package:clinica_ulagos_app/administrarSesiones/sesiones.dart';

//Importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: verificarSesion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return snapshot.data == true
                ? const MisReservasScreen()
                : const LoginPage();
          }
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  final TextEditingController _rutController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  String rutValue = '';
  String claveValue = '';
  bool errorRutVacio = false;
  bool errorRutInvalido = false;
  bool errorRutExiste = false;
  bool errorClave = false;
  bool errorClaveVacia = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blue_400, AppColors.blue_900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        //Probando si no cambiar ListView por column y eliminar el controller
        child: ListView(
          controller: _scrollController,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'lib/img/logoClinica.png',
              height: 200.0,
              width: double.infinity,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 35.0,
                          top: 30.0,
                        ),
                        child: const Text(
                          'Rut',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 10.0, right: 30.0),
                    child: TextFormField(
                      controller: _rutController,
                      onSaved: (value) {
                        rutValue = value ?? '';
                      },
                      onChanged: (value) {
                        if (!validarRut(value)) {
                          setState(() {
                            errorRutInvalido = true;
                            errorRutExiste = false;
                            errorRutVacio = false;
                            errorClave = false;
                            errorClaveVacia = false;
                          });
                        } else {
                          setState(() {
                            errorRutInvalido = false;
                            errorRutExiste = false;
                            errorRutVacio = false;
                            errorClaveVacia = false;
                            errorClave = false;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            errorRutVacio = true;
                            errorClaveVacia = false;
                          });
                        } else if (!validarRut(value)) {
                          setState(() {
                            errorRutInvalido = true;
                            errorRutVacio = false;
                            errorClaveVacia = false;
                            errorClave = false;
                          });
                        } else {
                          checkIfRutExists(value).then((rutExists) {
                            if (rutExists) {
                              setState(() {
                                errorRutExiste = false;
                                errorRutVacio = false;
                                errorRutInvalido = false;
                                errorClaveVacia = false;
                                errorClave = false;
                              });
                            } else {
                              setState(() {
                                errorRutExiste = true;
                                errorRutVacio = false;
                                errorRutInvalido = false;
                                errorClaveVacia = false;
                                errorClave = false;
                              });
                            }
                          });
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Ej: 20589741-2',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person, color: AppColors.icons),
                      ),
                    ),
                  ),
                  if (errorRutVacio || errorRutExiste || errorRutInvalido)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0, left: 30.0),
                        child: Text(
                          errorRutVacio
                              ? 'Por favor, ingrese un rut.'
                              : errorRutInvalido
                                  ? 'Ingrese un rut válido.'
                                  : 'El rut no está registrado en el sistema.',
                          style: const TextStyle(color: AppColors.error2),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 35.0,
                          top: 30.0,
                        ),
                        child: const Text(
                          'Contraseña',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
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
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      top: 10.0,
                      right: 30.0,
                    ),
                    child: TextFormField(
                      controller: _claveController,
                      onSaved: (value) {
                        claveValue = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          checkIfRutExists(rutValue).then((rutExists) {
                            if (rutExists) {
                              errorClaveVacia = true;
                              errorClave = false;
                            } else {
                              errorClaveVacia = false;
                              errorClave = false;
                            }
                          });
                        } else {
                          checkIfRutExists(rutValue).then((rutExists) {
                            if (rutExists) {
                              autenticarUsuario(rutValue, value)
                                  .then((claveValida) {
                                setState(() {
                                  errorClave = !claveValida;
                                  errorClaveVacia = false;
                                });
                              });
                            } else {
                              setState(() {
                                errorClave = false;
                                errorClaveVacia = false;
                              });
                            }
                          });
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: 'Ingrese su contraseña',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.lock, color: AppColors.icons),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.icons),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (errorClaveVacia || errorClave)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0, left: 30.0),
                        child: Text(
                          errorClaveVacia
                              ? 'Por favor, ingrese una contraseña.'
                              : 'Contraseña incorrecta',
                          style: const TextStyle(color: AppColors.error2),
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 10.0, right: 30.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OlvideMiClaveScreen(),
                            ),
                          );
                        },
                        splashColor: Colors.blue.withOpacity(0.5),
                        child: const Text(
                          'Olvidé mi contraseña',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            obtenerReservasUsuarios(rutValue);
                            if (await autenticarUsuario(rutValue, claveValue)) {
                              await guardarSesion(rutValue);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MisReservasScreen(),
                                ),
                              );
                            }
                          } else {}
                        },
                        splashColor: Colors.blueAccent,
                        child: Container(
                          height: 75,
                          width: 200,
                          padding: const EdgeInsets.all(16.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ingresar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Icon(
                                Icons.login,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrarseScreen(),
                    ),
                  );
                },
                splashColor: Colors.blue.withOpacity(0.5),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tienes cuenta?',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                    Text(
                      'Regístrate aquí',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
