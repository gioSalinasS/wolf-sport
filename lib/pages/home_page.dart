import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/pages/categoria_page.dart';
import 'package:wolf_sport/services/alumno_service.dart';
import 'package:wolf_sport/widgets/card_categorias.dart';
import 'package:wolf_sport/pages/form_page.dart'; 
import 'package:firebase_auth/firebase_auth.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _cerrarSesion()async{
     setState(() {});
     await FirebaseAuth.instance.signOut(); 
  }

  @override
  Widget build(BuildContext context) {

    final alumnoService = Provider.of<AlumnoService>(context);
    

    //if(alumnoService.isLoading) return const LoadingPage();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    //Colors.white,
                    Color.fromARGB(255, 70, 113, 148),
                    Colors.blue,
                  ]
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80)
                ),
                boxShadow: [
                  BoxShadow(
                    //color: Colors.purple,
                    blurStyle: BlurStyle.normal,
                    blurRadius: 5,
                    offset: Offset(0, 4)
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/wolf.png'),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        'Recuerda',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'El deporte es vida',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    iconSize: 40,
                    onPressed: () async{
                      _cerrarSesion();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: alumnoService.categorias.length,
          itemBuilder: (context, index) {
            final nombreCategoria = alumnoService.categorias[index].id;
            return  GestureDetector(
              onTap: () => {
                //alumnoService.alumnoSeleccionado = alumnoService.alumnos[index],
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriaPage(nombreCat: nombreCategoria),)),
              },
              child: Column(
                children: [
                  CardCategorias(nombre: nombreCategoria.toString()),
                ],
              ),
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormPage()), 
            );
          },
        ),
      ),
    );
  }
}
