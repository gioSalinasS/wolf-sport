import 'package:flutter/material.dart';
import 'package:wolf_sport/widgets/alumno_list.dart';

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
            AlumnoList(),
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