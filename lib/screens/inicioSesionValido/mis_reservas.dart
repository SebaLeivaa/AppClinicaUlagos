// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:clinica_ulagos_app/theme/colors.dart';
import 'package:clinica_ulagos_app/administrarSesiones/sesiones.dart';
import 'package:clinica_ulagos_app/main.dart';

class MisReservasScreen extends StatefulWidget {
  const MisReservasScreen({Key? key}) : super(key: key);

  @override
  _MisReservasScreenState createState() => _MisReservasScreenState();
}

class _MisReservasScreenState extends State<MisReservasScreen> {
  final SessionManager _sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _sessionManager.startSessionTimer(context);
  }

  @override
  void dispose() {
    _sessionManager.stopSessionTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reservas'),
      ),
      body: FutureBuilder<bool>(
        future: verificarSesion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Puedes mostrar un indicador de carga mientras se verifica la sesión
            return const CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              // La sesión está activa, muestra el contenido de la pantalla
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Contenido de la pantalla de Mis Reservas'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (!(await verificarSesion())) {
                          // La sesión ha expirado, redirige a la pantalla de inicio de sesión
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        } else {
                          // Realiza la acción deseada cuando se hace clic en el botón
                          print('Botón presionado');
                        }
                      },
                      child: const Text('Verificar Sesión'),
                    ),
                  ],
                ),
              );
            } else {
              // La sesión ha expirado, redirige a la pantalla de inicio de sesión
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
              return Container(); // Puedes devolver un contenedor vacío o cualquier otro widget aquí
            }
          }
        },
      ),
    );
  }
}
