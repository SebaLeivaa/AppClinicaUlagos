// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'screens/olvide_mi_clave.dart';
import 'screens/registrarse.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue_900,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset(
            'lib/img/logoClinica.png',
            height: 200.0,
            width: double.infinity,
          ),
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
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            child: const TextField(
              style: TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                hintText: 'Ej: 20589741-2',
                hintStyle: TextStyle(color: AppColors.placeholders),
                filled: true,
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
                fillColor: AppColors.white,
                prefixIcon: Icon(Icons.person),
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
                    color: AppColors.white,
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
            child: TextField(
              style: const TextStyle(color: AppColors.black),
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: 'Ingrese su contraseña',
                hintStyle: const TextStyle(color: AppColors.placeholders),
                filled: true,
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
                fillColor: AppColors.white,
                prefixIcon: const Icon(Icons.lock),
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
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OlvideMiClaveScreen(),
                    ),
                  );
                },
                splashColor: AppColors.hipervinculo.withOpacity(0.5),
                child: const Text(
                  'Olvidé mi contraseña',
                  style: TextStyle(
                    color: AppColors.hipervinculo,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.hipervinculo,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 75),
          Align(
            alignment: Alignment.center,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColors.buttons,
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {},
                splashColor: AppColors.buttonsHover,
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
                          color: AppColors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.login,
                        color: AppColors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
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
              splashColor: AppColors.hipervinculo.withOpacity(0.5),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(
                      color: AppColors.hipervinculo,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.hipervinculo,
                    ),
                  ),
                  Text(
                    'Regístrate aquí',
                    style: TextStyle(
                      color: AppColors.hipervinculo,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.hipervinculo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
