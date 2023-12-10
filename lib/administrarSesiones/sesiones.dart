// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:clinica_ulagos_app/main.dart';

class SessionManager {
  late Timer _timer;

  void startSessionTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      _verificarSesionAutomaticamente(context);
    });
  }

  void stopSessionTimer() {
    _timer.cancel();
  }

  Future<void> _verificarSesionAutomaticamente(BuildContext context) async {
    if (!(await verificarSesion())) {
      // La sesión ha expirado, redirige a la pantalla de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }
}

Future<void> guardarSesion() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('sesion', true);
  prefs.setString('horaInicioSesion', DateTime.now().toIso8601String());
}

Future<bool> verificarSesion() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool sesionActiva = prefs.getBool('sesion') ?? false;

  if (sesionActiva) {
    String horaInicioSesion = prefs.getString('horaInicioSesion') ?? "";
    if (horaInicioSesion.isNotEmpty) {
      DateTime inicioSesion = DateTime.parse(horaInicioSesion);
      // Duración de sesión deseada en minutos
      int duracionSesionMinutos = 30;
      // Compara la diferencia en minutos
      return DateTime.now().difference(inicioSesion).inMinutes <
          duracionSesionMinutos;
    }
  }

  return false;
}
