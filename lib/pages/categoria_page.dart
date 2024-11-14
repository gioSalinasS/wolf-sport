import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/services/alumno_service.dart';
//import 'package:wolf_sport/widgets/alumno_list.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {  
  @override
  Widget build(BuildContext context) {
    
    final alumnoService = Provider.of<AlumnoService>(context);
    List<bool> estatuscheck = [];   
    
    @override
    void initState() {
      super.initState();
      estatuscheck = List<bool>.filled(alumnoService.alumnos.length, false);
    }
    
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de asistencia"),
      ),
      body: alumnoService.alumnos.isNotEmpty ?
      Column(
        children: [
           Expanded(
            child: ListView.builder(
              itemCount: alumnoService.alumnos.length,
              itemBuilder: (context, index) {
                final nombreAl = alumnoService.alumnos[index].nombre;
                return CheckboxListTile(
                  title: Text(nombreAl),
                  value: index < estatuscheck.length ? estatuscheck[index] : false, 
                  onChanged: (value) {
                    setState(() {
                      estatuscheck[index] = value!;
                    });
                    print("Alumno $nombreAl asistencia: ${estatuscheck[index]}");
                  },
                  secondary: Icon(Icons.person),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Enviar lista"),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
          
                  },
                ),
              ],
            ),
          )
        ],
      ):Text("No hay alumnos"),
    );
  }
}