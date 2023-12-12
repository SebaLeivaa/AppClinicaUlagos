import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfRutExists(String rut) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('paciente')
        .where('rut', isEqualTo: rut)
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (error) {
    // ignore: avoid_print
    print('Error al verificar el Rut: $error');
    return false;
  }
}

Future<bool> checkIfCorreoExists(String correo) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('paciente')
        .where('correo', isEqualTo: correo)
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (error) {
    // ignore: avoid_print
    print('Error al verificar el Rut: $error');
    return false;
  }
}

Future<bool> checkIfTelefonoExists(String telefono) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('paciente')
        .where('telefono', isEqualTo: telefono)
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (error) {
    // ignore: avoid_print
    print('Error al verificar el Rut: $error');
    return false;
  }
}

Future<Map<String, dynamic>?> obtenerDatosUsuario(String rut) async {
  try {
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('paciente')
        .where('rut', isEqualTo: rut)
        .get();

    if (query.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> usuario = query.docs.first;
      Map<String, dynamic> datosUsuario = usuario.data();

      return datosUsuario;
    }
  } catch (e) {
    // ignore: avoid_print
    print("Error al obtener datos del usuario: $e");
  }

  return null;
}

Future<List<Map<String, dynamic>>> obtenerReservasUsuarios(String rut) async {
  try {
    DateTime fechaActual = DateTime.now();
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('cita_medica')
        .where('rut_paciente', isEqualTo: rut)
        .where('fecha', isGreaterThan: Timestamp.fromDate(fechaActual))
        .orderBy('fecha', descending: false)
        .get();

    List<Map<String, dynamic>> datosReservaUsuarios = [];

    if (query.docs.isNotEmpty) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> usuario in query.docs) {
        Map<String, dynamic> datosReservaUsuario = usuario.data();

        // Consulta a la colección 'profesional' usando el 'rut_profesional'
        datosReservaUsuario['id_cita'] = usuario.id;

        String rutProfesional = datosReservaUsuario['rut_profesional'];
        DocumentSnapshot<Map<String, dynamic>> profesionalSnapshot =
            await FirebaseFirestore.instance
                .collection('profesional')
                .doc(rutProfesional)
                .get();

        if (profesionalSnapshot.exists) {
          // Agregar los datos del profesional al mapa 'datosUsuario'
          Map<String, dynamic>? datosProfesional = profesionalSnapshot.data();
          if (datosProfesional != null) {
            datosReservaUsuario['nombre_profesional'] =
                datosProfesional['nombre'];
            datosReservaUsuario['apellido_paterno_profesional'] =
                datosProfesional['apellido_paterno'];
            datosReservaUsuario['apellido_materno_profesional'] =
                datosProfesional['apellido_materno'];
          } else {
            // ignore: avoid_print
            print(
                "El documento profesional no existe para el rut: $rutProfesional");
          }
        }

        datosReservaUsuarios.add(datosReservaUsuario);
      }
      print('Número de documentos en la lista: ${datosReservaUsuarios.length}');
      print(datosReservaUsuarios);
      return datosReservaUsuarios;
    }
  } catch (e) {
    // Manejo de errores...
    // ignore: avoid_print
    print("Error al obtener datos del usuario: $e");
  }

  return []; // O puedes devolver null o cualquier otra cosa según tu lógica.
}

Future<List<Map<String, dynamic>>> obtenerHistorialUsuarios(String rut) async {
  try {
    DateTime fechaActual = DateTime.now();
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('cita_medica')
        .where('rut_paciente', isEqualTo: rut)
        .where('fecha', isLessThan: Timestamp.fromDate(fechaActual))
        .orderBy('fecha', descending: true)
        .get();

    List<Map<String, dynamic>> datosHistorialUsuarios = [];

    if (query.docs.isNotEmpty) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> usuario in query.docs) {
        Map<String, dynamic> datosHistorialUsuario = usuario.data();

        // Consulta a la colección 'profesional' usando el 'rut_profesional'
        String rutProfesional = datosHistorialUsuario['rut_profesional'];
        DocumentSnapshot<Map<String, dynamic>> profesionalSnapshot =
            await FirebaseFirestore.instance
                .collection('profesional')
                .doc(rutProfesional)
                .get();

        if (profesionalSnapshot.exists) {
          // Agregar los datos del profesional al mapa 'datosUsuario'
          Map<String, dynamic>? datosProfesional = profesionalSnapshot.data();
          if (datosProfesional != null) {
            datosHistorialUsuario['nombre_profesional'] =
                datosProfesional['nombre'];
            datosHistorialUsuario['apellido_paterno_profesional'] =
                datosProfesional['apellido_paterno'];
            datosHistorialUsuario['apellido_materno_profesional'] =
                datosProfesional['apellido_materno'];
          } else {
            // ignore: avoid_print
            print(
                "El documento profesional no existe para el rut: $rutProfesional");
          }
        }

        datosHistorialUsuarios.add(datosHistorialUsuario);
      }
      return datosHistorialUsuarios;
    }
  } catch (e) {
    // Manejo de errores...
    // ignore: avoid_print
    print("Error al obtener datos del usuario: $e");
  }

  return []; // O puedes devolver null o cualquier otra cosa según tu lógica.
}

Future<void> deleteDocument(String documentId) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Referencia al documento que deseas eliminar
    DocumentReference documentReference =
        firestore.collection('cita_medica').doc(documentId);

    // Elimina el documento sin verificar su existencia
    await documentReference.delete();
  } catch (error) {
    // ignore: avoid_print
    print('Error al eliminar el documento: $error');
  }
}
