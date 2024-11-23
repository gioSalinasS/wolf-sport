import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/pages/categoria_page_admin.dart';
import 'package:wolf_sport/services/alumno_service.dart';
import 'package:wolf_sport/widgets/card_categorias.dart';
import 'package:wolf_sport/pages/form_page.dart'; 
import 'package:firebase_auth/firebase_auth.dart';


class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {

  void _cerrarSesion()async{
     try {
    await FirebaseAuth.instance.signOut();

    // Redirige a la página de inicio de sesión
    Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    // Maneja cualquier error (opcional)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('No se pudo cerrar la sesión. Inténtalo nuevamente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    final alumnoService = Provider.of<AlumnoService>(context);
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriaPageAdmin(nombreCat: nombreCategoria,))),
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