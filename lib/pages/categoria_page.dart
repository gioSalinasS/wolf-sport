import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/models/alumno.dart';
import 'package:wolf_sport/services/alumno_service.dart';

class CategoriaPage extends StatefulWidget {
  final String nombreCat;
  const CategoriaPage({super.key, required this.nombreCat,});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {  

  List<bool> estatuscheck = [];   
  List<Alumno> copiaAlumnos=[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.nombreCat);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final alumnoService = Provider.of<AlumnoService>(context, listen: false);
      setState(() {
        if(widget.nombreCat == "infantil"){
          estatuscheck = List<bool>.filled(alumnoService.alumnosInfantil.length, false);
        }else{
          estatuscheck = List<bool>.filled(alumnoService.alumnosJunior.length, false);
        }
        
      });
      print(copiaAlumnos);
    });
  }

  @override
  Widget build(BuildContext context) {
    final alumnoService = Provider.of<AlumnoService>(context);  
  
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de asistencia"),
      ),
      body: ( widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil.isNotEmpty : alumnoService.alumnosJunior.isNotEmpty ) ?
      Column(
        children: [
           Expanded(
            child: ListView.builder(
              itemCount: widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil.length : alumnoService.alumnosJunior.length,
              itemBuilder: (context, index) {
                final nombreAl = widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil[index].nombre : alumnoService.alumnosJunior[index].nombre ;
                final tutorAl = widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil[index].nombreTutor: alumnoService.alumnosJunior[index].nombreTutor;
                return CheckboxListTile(
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  checkColor: Colors.white,
                  activeColor:const Color.fromARGB(255, 11, 73, 107),
                  title: Text('Alumno: $nombreAl'),
                  subtitle: Text('Nombre del tutor: $tutorAl'),
                  value: index < estatuscheck.length ? estatuscheck[index] : false,
                  onChanged: (value) {
                    setState(() {
                      estatuscheck[index] = value!;
                    });
                    //print("Alumno $nombreAl asistencia: ${estatuscheck[index]}");
                  },
                  secondary: const Icon(Icons.person),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(right: 20),
            child: FloatingActionButton(
              elevation: 10,
              splashColor: Colors.white,
              tooltip: "Enviar lista de asistencia",
              backgroundColor: const Color.fromARGB(255, 11, 73, 107),
              child: const Icon(Icons.send_rounded),
              onPressed: ()async {
                setState(() {
                    isLoading = true; 
                  });
                if(widget.nombreCat == "infantil"){
                  for (int i = 0; i < alumnoService.alumnosInfantil.length; i++) {
                    if(estatuscheck[i]){
                      int nuevasAsistencias = int.parse(alumnoService.alumnosInfantil[i].asistencias) + 1;
                      alumnoService.alumnosInfantil[i].asistencias = nuevasAsistencias.toString();
                      await alumnoService.updateAsistencia(alumnoService.alumnosInfantil[i]);
                    }
                  }
                }else{
                  for (int i = 0; i < alumnoService.alumnosJunior.length; i++) {
                    if(estatuscheck[i]){
                      int nuevasAsistencias = int.parse(alumnoService.alumnosJunior[i].asistencias) + 1;
                      alumnoService.alumnosJunior[i].asistencias = nuevasAsistencias.toString();
                      await alumnoService.updateAsistenciaJunior(alumnoService.alumnosJunior[i]);
                    }
                  }
                }
                estatuscheck.every((element) => !element)
                ?
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lista de asistencia en blanco')),
                )
                :
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lista de asistencia enviada con éxito')),
                ); 
                setState(() {
                  isLoading = false;
                  if(widget.nombreCat == "infantil"){
                    estatuscheck = List<bool>.filled(alumnoService.alumnosInfantil.length, false);
                  }else{
                    estatuscheck = List<bool>.filled(alumnoService.alumnosJunior.length, false);
                  }
                });
              },
            )
          )
        ],
      ):const Text("No hay alumnos"),
    );
  }
}