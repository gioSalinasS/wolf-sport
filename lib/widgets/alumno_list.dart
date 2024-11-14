import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/services/alumno_service.dart';

class AlumnoList extends StatefulWidget {
  const AlumnoList({super.key});

  @override
  State<AlumnoList> createState() => _AlumnoListState();
}

class _AlumnoListState extends State<AlumnoList> {
  @override
  Widget build(BuildContext context) {
    

    late List<bool> estatuscheck = [];

    final alumnoService = Provider.of<AlumnoService>(context);
    estatuscheck = List<bool>.filled(alumnoService.alumnos.length, false);
    
    return ListView.builder(
      itemCount: alumnoService.alumnos.length,
      itemBuilder: (context, index) {
        //print(alumnoService.alumnos.length);
        final nombreAl = alumnoService.alumnos[index].nombre;
        return CheckboxListTile(
          title: Text(nombreAl),
          value: estatuscheck[index], 
          onChanged: (value) {
            //print(estatuscheck[index]);
            setState(() {
              estatuscheck[index] = value!;
            });
            print(estatuscheck[index]);
          },
        );
      },
    );
  }
}