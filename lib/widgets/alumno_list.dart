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
    
    final alumnoService = Provider.of<AlumnoService>(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ListView.builder(
            itemCount: alumnoService.alumnos.length,
            itemBuilder: (context, index) {
              final nombreAl = alumnoService.alumnos[index].nombre;
              return CheckboxListTile(
                title: Text(nombreAl),
                value: false,
                onChanged: (bool? value) {
                  setState(() {
                    value ?? false;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}