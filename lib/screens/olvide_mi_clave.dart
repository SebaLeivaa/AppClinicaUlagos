import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OlvideMiClaveScreen extends StatefulWidget {
  const OlvideMiClaveScreen({Key? key}) : super(key: key);

  @override
  _OlvideMiClaveScreenState createState() => _OlvideMiClaveScreenState();
}

class _OlvideMiClaveScreenState extends State<OlvideMiClaveScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async => {sendEmail(_emailController.text)},
              child: Text('Enviar Correo de Restablecimiento'),
            ),
          ],
        ),
      ),
    );
  }

  Future sendEmail(String correo) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final emailjsServiceId = 'service_wfwgive';
    final emailjsTemplateId = 'template_73t9v2s';
    final emailjsUserId = 'M3nuqzaSU1cCBpY4_';

    print(correo);

    try {
      final response = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'service_id': emailjsServiceId,
            'template_id': emailjsTemplateId,
            'user_id': emailjsUserId,
            'template_params': {
              'to_name': 'Nombre del destinatario',
              'from_name': 'Tu Nombre',
              'message': 'Contenido del correo.',
              'user_email': correo
            },
          }));

      if (response.statusCode == 200) {
        print('Correo enviado exitosamente');
      } else {
        print(
            'Error al enviar el correo. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al enviar el correo: $e');
    }
  }
}
