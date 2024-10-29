import 'package:flutter/material.dart';

class CategoriaPage extends StatelessWidget {
  const CategoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de asistencia"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AlumnoCheckboxList(),
            Container(
              padding: EdgeInsets.only(right: 20),
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
        ),
      ),
    );
  }
}

class AlumnoCheckboxList extends StatefulWidget {
  @override
  _AlumnoCheckboxListState createState() => _AlumnoCheckboxListState();
}

class _AlumnoCheckboxListState extends State<AlumnoCheckboxList> {
  // Manejamos los estados de los checkbox
  bool alumno1 = false;
  bool alumno2 = false;
  bool alumno3 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.8,
      child: Column(
        children: [
          CheckboxListTile(
            title: Text("Alumno 1"),
            value: alumno1,
            onChanged: (bool? value) {
              setState(() {
                alumno1 = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Alumno 2"),
            value: alumno2,
            onChanged: (bool? value) {
              setState(() {
                alumno2 = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Alumno 3"),
            value: alumno3,
            activeColor: Colors.blue, // Cambia el color del checkbox seleccionado
            onChanged: (bool? value) {
              setState(() {
                alumno3 = value ?? false;
              });
            },
          ),
        ],
      ),
    );
  }
}