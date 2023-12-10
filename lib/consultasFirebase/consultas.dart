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
