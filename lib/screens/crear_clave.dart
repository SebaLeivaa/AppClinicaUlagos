// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siguiente Interfaz'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rut: ${widget.rut}'),
          Text('Nombres: ${widget.nombres}'),
          Text('Apellido paterno: ${widget.apellidoPat}'),
          Text('Apellido materno: ${widget.apellidoMat}'),
          Text('Fecha de nacimiento: ${widget.fechaNacimiento}'),
          Text('Genero: ${widget.genero}'),
          Text('Correo: ${widget.correo}'),
          Text('Telefono: ${widget.telefono}'),
          // Resto de tu interfaz...
        ],
      ),
    );
  }
}
