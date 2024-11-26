import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/models/alumno.dart';
import 'package:wolf_sport/services/alumno_service.dart';

class CategoriaPageAdmin extends StatefulWidget {
  final String nombreCat;
  const CategoriaPageAdmin({super.key, required this.nombreCat});

  @override
  State<CategoriaPageAdmin> createState() => _CategoriaPageAdminState();
}

class _CategoriaPageAdminState extends State<CategoriaPageAdmin> {

  List<bool> estatuscheck = [];   
  List<Alumno> copiaAlumnos=[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.nombreCat);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        final alumnoService = Provider.of<AlumnoService>(context, listen: false);
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
          const SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Asistencias",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(width: 15,)
            ],
          ),
           Expanded(
            child: ListView.builder(
              itemCount: widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil.length : alumnoService.alumnosJunior.length,
              itemBuilder: (context, index) {
                final nombreAl = widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil[index].nombre : alumnoService.alumnosJunior[index].nombre ;
                final tutorAl = widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil[index].nombreTutor: alumnoService.alumnosJunior[index].nombreTutor;
                final asistencia = widget.nombreCat == "infantil" ? alumnoService.alumnosInfantil[index].asistencias: alumnoService.alumnosJunior[index].asistencias;
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Alumno: $nombreAl"),
                  subtitle: Text("Tutor: $tutorAl"),
                  trailing: Text(
                    asistencia,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ):const Text("No hay alumnos"),
    );
  }
}