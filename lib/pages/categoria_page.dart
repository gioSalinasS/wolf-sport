import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/services/alumno_service.dart';

class CategoriaPage extends StatefulWidget {
  final String nombreCat;
  const CategoriaPage({super.key, required this.nombreCat,});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {  

  List<bool> estatuscheck = [];   

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
    });
  }


  @override
  Widget build(BuildContext context) {
    final alumnoService = Provider.of<AlumnoService>(context);   
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de asistencia"),
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
                  activeColor: Color.fromARGB(255, 11, 73, 107),
                  title: Text('Alumno: $nombreAl'),
                  subtitle: Text('Nombre del tutor: $tutorAl'),
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