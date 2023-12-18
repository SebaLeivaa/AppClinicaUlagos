import 'package:clinica_ulagos_app/administrarSesiones/sesiones.dart';
import 'package:clinica_ulagos_app/consultasFirebase/consultas.dart';
import 'package:clinica_ulagos_app/screens/inicioSesionValido/resultados_de_busqueda.dart';
import 'package:clinica_ulagos_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class BusquedaHoraScreen extends StatefulWidget {
  const BusquedaHoraScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BusquedaHoraScreenState createState() => _BusquedaHoraScreenState();
}

class _BusquedaHoraScreenState extends State<BusquedaHoraScreen> {
  final SessionManager _sessionManager = SessionManager();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;
  String? selectedValue2;
  List<Map<String, dynamic>> datosEspecialidades = [];
  List<Map<String, dynamic>> datosProfesionales = [];

  @override
  void initState() {
    super.initState();
    _sessionManager.startSessionTimer(context);
    cargarDatosEspecialidades();
    cargarDatosProfesionales();
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
        title: const Text(
          'Búsqueda de hora',
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
      body: Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: const Center(
              child: Text(
                'Complete los siguientes campos para la búsqueda',
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 22),
                alignment: Alignment.centerLeft,
                child: const Text('Especialidad',
                    style: TextStyle(color: AppColors.black, fontSize: 18)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccionar',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.placeholders,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: datosEspecialidades
                        .map((item) => DropdownMenuItem<String>(
                              value: item['id_especialidad'],
                              child: Text(
                                item['nombre'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                        selectedValue2 = null;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: AppColors.inputs,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                      ),
                      iconSize: 32,
                      iconEnabledColor: AppColors.black,
                      iconDisabledColor: AppColors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 400,
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.inputs,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 22),
                alignment: Alignment.centerLeft,
                child: const Text('Profesional (opcional)',
                    style: TextStyle(color: AppColors.black, fontSize: 18)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccionar',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.placeholders,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: (selectedValue == null)
                        ? datosProfesionales.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['rut'],
                              child: Text(
                                '${item['nombre']} ${item['apellido_paterno']} ${item['apellido_materno']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList()
                        : datosProfesionales
                            .where(
                                (item) => item['especialidad'] == selectedValue)
                            .map((item) {
                            return DropdownMenuItem<String>(
                              value: item['rut'],
                              child: Text(
                                '${item['nombre']} ${item['apellido_paterno']} ${item['apellido_materno']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                    value: selectedValue2,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue2 = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: AppColors.inputs,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                      ),
                      iconSize: 32,
                      iconEnabledColor: AppColors.black,
                      iconDisabledColor: AppColors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 400,
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.inputs,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 150),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (selectedValue2 != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultadosBusquedaScreen(
                                rutProfesional: selectedValue2!,
                                especialidad: null,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultadosBusquedaScreen(
                                rutProfesional: null,
                                especialidad: selectedValue!,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: AppColors.buttons,
                          padding: const EdgeInsets.all(10.0),
                          fixedSize: const Size(275, 60),
                          foregroundColor: AppColors.blue_900),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buscar disponibilidad',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void cargarDatosEspecialidades() {
    obtenerEspecialidades().then((List<Map<String, dynamic>> result) {
      setState(() {
        datosEspecialidades = result;
      });
    });
  }

  void cargarDatosProfesionales() {
    obtenerProfesionales().then((List<Map<String, dynamic>> result) {
      setState(() {
        datosProfesionales = result;
      });
    });
  }
}
