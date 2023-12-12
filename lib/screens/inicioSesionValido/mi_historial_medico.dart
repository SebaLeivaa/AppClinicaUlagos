import 'package:clinica_ulagos_app/screens/inicioSesionValido/detalle_cita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clinica_ulagos_app/theme/colors.dart';
import 'package:clinica_ulagos_app/administrarSesiones/sesiones.dart';
import 'package:clinica_ulagos_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clinica_ulagos_app/screens/inicioSesionValido/mis_reservas.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clinica_ulagos_app/consultasFirebase/consultas.dart';

class MiHistorialMedicoScreen extends StatefulWidget {
  const MiHistorialMedicoScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MiHistorialMedicoScreenState createState() =>
      _MiHistorialMedicoScreenState();
}

class _MiHistorialMedicoScreenState extends State<MiHistorialMedicoScreen> {
  final SessionManager _sessionManager = SessionManager();
  List<Map<String, dynamic>> datosHistorialUsuario = [];
  String? rutUsuario;
  String? nombreUsuario;
  String? correoUsuario;
  String? apePatUsuario;
  String? apeMatUsuario;
  String? fecNacUsuario;
  String? telefonoUsuario;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _sessionManager.startSessionTimer(context);

    cargarDatosUsuario().then((List<Map<String, dynamic>> result) {
      setState(() {
        datosHistorialUsuario = result;
      });
    });
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
        backgroundColor: AppColors.blue_900,
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset('lib/img/logoClinica.png', height: 45),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<bool>(
        future: verificarSesion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Puedes mostrar un indicador de carga mientras se verifica la sesión
            return Scaffold(
              backgroundColor: AppColors.blue_900,
              body: Center(
                child: Image.asset('lib/img/logoClinica.png'),
              ),
            );
          } else {
            if (snapshot.data == true) {
              // La sesión está activa, muestra el contenido de la pantalla
              return Scaffold(
                body: Column(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      color: AppColors.blue_400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'BIENVENIDO',
                              style: TextStyle(
                                fontSize: 22,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text('$nombreUsuario',
                                style: const TextStyle(
                                    fontSize: 28, color: AppColors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              '$apePatUsuario' ' $apeMatUsuario',
                              style: const TextStyle(
                                  fontSize: 28, color: AppColors.white),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                backgroundColor: AppColors.buttons2,
                                padding: const EdgeInsets.all(10.0),
                                fixedSize: const Size(250, 60),
                                foregroundColor: AppColors.error,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Reservar Hora',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(
                                    Icons.access_time_filled,
                                    color: AppColors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          Container(
                            // Puedes ajustar el ancho máximo de la caja aquí
                            constraints: const BoxConstraints(
                                maxWidth: 150, maxHeight: 40),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MisReservasScreen(),
                                  ),
                                );
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Center(
                                    child: Text(
                                      'Mis reservas',
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              // Puedes ajustar el ancho máximo de la caja aquí
                              constraints: const BoxConstraints(
                                  maxWidth: 200, maxHeight: 40),
                              child: GestureDetector(
                                onTap: () {
                                  // No hay acción cuando se hace clic
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.buttons,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Center(
                                      child: Text(
                                        'Mi historial médico',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 28.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Historial de reservas',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    if (datosHistorialUsuario.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 0.0,
                        ),
                        child: CarouselSlider(
                            options: CarouselOptions(
                              height: 275.0,
                              autoPlay: false,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.90,
                            ),
                            items: datosHistorialUsuario.map(
                              (i) {
                                Timestamp formatoTimeStamp = i['fecha'];
                                DateTime fecha = formatoTimeStamp.toDate();
                                String detalle = i['detalle'];
                                List<String> nombreDia = [
                                  'Lunes',
                                  'Martes',
                                  'Miércoles',
                                  'Jueves',
                                  'Viernes',
                                  'Sábado',
                                  'Domingo'
                                ];
                                List<String> nombreMes = [
                                  'Enero',
                                  'Febrero',
                                  'Marzo',
                                  'Abril',
                                  'Mayo',
                                  'Junio',
                                  'Julio',
                                  'Agosto',
                                  'Septiembre',
                                  'Octubre',
                                  'Noviembre',
                                  'Diciembre'
                                ];
                                int numeroDia = fecha.day;
                                int anio = fecha.year;
                                int numeroDiaDeLaSemana = fecha.weekday;
                                int numeroMes = fecha.month;
                                int hora = fecha.hour;
                                int minutos = fecha.minute;

                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: SizedBox(
                                          width: 400,
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                side: const BorderSide(
                                                  color: AppColors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppColors.blue_500,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                20.0),
                                                        topRight:
                                                            Radius.circular(
                                                                20.0),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .calendar_month_sharp,
                                                          color:
                                                              AppColors.white,
                                                          size: 30,
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                          '${nombreDia[numeroDiaDeLaSemana - 1]} ${numeroDia.toString()} de ${nombreMes[numeroMes - 1]} del ${anio.toString()}',
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 10),
                                                      Image.asset(
                                                          'lib/img/default.png',
                                                          height: 100),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${i['nombre_profesional']} ${i['apellido_paterno_profesional']} ${i['apellido_materno_profesional'].substring(0, 1)}.',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            i['especialidad']
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color: AppColors
                                                                  .blue_400,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Container(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                  top: 4.0,
                                                                  bottom: 4.0),
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .blue_500,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              child: Text(
                                                                '${hora.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}',
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .white),
                                                              )),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          width: 200,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DetalleCitaScreen(
                                                                    citaDetalle:
                                                                        detalle,
                                                                    fullNameProfesional:
                                                                        '${i['nombre_profesional']} ${i['apellido_paterno_profesional']} ${i['apellido_materno_profesional'].substring(0, 1)}.',
                                                                    fullDateCita:
                                                                        '${nombreDia[numeroDiaDeLaSemana - 1]} ${numeroDia.toString()} de ${nombreMes[numeroMes - 1]} del ${anio.toString()}',
                                                                    fullHourCita:
                                                                        '${hora.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}',
                                                                    especialidad:
                                                                        i['especialidad'],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .blue_500,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              fixedSize:
                                                                  const Size(
                                                                      250, 60),
                                                              foregroundColor:
                                                                  AppColors
                                                                      .blue_900,
                                                            ),
                                                            child:
                                                                const Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                6),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Ver detalle',
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppColors.white,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 8),
                                                                          Icon(
                                                                            Icons.file_copy, // Puedes cambiar el icono según tus necesidades
                                                                            color:
                                                                                AppColors.white,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                          ),
                                                        ),
                                                      ]),
                                                  const SizedBox(height: 20),
                                                ],
                                              )),
                                        ));
                                  },
                                );
                              },
                            ).toList()),
                      )
                  ],
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
              return Container();
            }
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> cargarDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      rutUsuario = prefs.getString('rutUsuario');
      nombreUsuario = prefs.getString('nombreUsuario');
      nombreUsuario = nombreUsuario?.toUpperCase();
      apePatUsuario = prefs.getString('apePatUsuario');
      apePatUsuario = apePatUsuario?.toUpperCase();
      apeMatUsuario = prefs.getString('apeMatUsuario');
      apeMatUsuario = apeMatUsuario?.toUpperCase();
      correoUsuario = prefs.getString('correoUsuario');
      telefonoUsuario = prefs.getString('telefonoUsuario');
      fecNacUsuario = prefs.getString('fecNacUsuario');
    });

    List<Map<String, dynamic>> datosHistorialUsuario =
        await obtenerHistorialUsuarios(rutUsuario!);

    return datosHistorialUsuario;
  }
}
