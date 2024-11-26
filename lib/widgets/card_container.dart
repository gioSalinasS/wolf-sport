import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardContainer extends StatefulWidget {
  const CardContainer({super.key});

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {

  
  String mensaje="";
  final correoUsu = TextEditingController();
  final passController = TextEditingController();

  void iniciarSesion() async {
  // Mostrar indicador de carga
  showDialog(
    context: context,
    builder: (_) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correoUsu.text,
      password: passController.text,
    );

    Navigator.pop(context);
    String email = userCredential.user!.email ?? "";
    if (email.contains("giovanniss.ti20@utsjr.edu.mx")) {
      Navigator.pushReplacementNamed(context, 'admin');
    } else if(email.contains("noeca.ti23@utsjr.edu.mx")){
      Navigator.pushReplacementNamed(context, 'home');
    }
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); 
    if(e.code == 'channel-error'){
        _isEmpty();
      }
    if (e.code == 'user-not-found') {
      _correoInva();
    } else if (e.code == 'wrong-password') {
      _passInva();
    } else if (e.code == 'invalid-email') {
      _fomatInco();
    } else {
      _probRed(); 
    }
  }
}


  void _isEmpty(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: const Color.fromARGB(183, 168, 189, 247),
          elevation: 10,
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          icon:const  Icon(Icons.error,size: 50,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("-- Sin datos --"),
          content: const Text("Algún campo esta en blanco, favor de llenarlo como es debido"),
        );
      },
    );
  }

  void _correoInva(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: const Color.fromARGB(183, 168, 189, 247),
          elevation: 10,
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          icon:const  Icon(Icons.error),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("Correo inválido"),
          content: const Text("El correo no se encuentra registrado"),
        );
      },
    );
  }

  void _probRed(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: const Color.fromARGB(183, 168, 189, 247),
          elevation: 10,
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          icon:const  Icon(Icons.error),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("Problema de conexión"),
          content: const Text("La conexion de red es inestable"),
        );
      },
    );
  }


  void _fomatInco(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: const Color.fromARGB(183, 168, 189, 247),
          elevation: 10,
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          icon:const  Icon(Icons.error),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          title: const Text("Formato de correo incorrecto"),
          content: const Text("Favor de ingresar un correo válido"),
        );
      },
    );
  }

  void _passInva(){
    showDialog(
      context: context,
      builder: (context) {
        Radius borde = const Radius.circular(20.0);
        return AlertDialog(
          backgroundColor: const Color.fromARGB(183, 168, 189, 247),
          elevation: 10,
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(borde)),
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
          icon: const Icon(Icons.error),
          title: const Text("Contraseña incorrecta"),
          content: const Text("La contraseña no coincide"),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    correoUsu.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(255, 19, 138, 202),//Color.fromARGB(167, 130, 11, 151),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer, 
      color:const Color.fromARGB(146, 168, 189, 247),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.all(10.0), 
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          const _Indicadores(),
          const Divider(
            thickness: 10.0,
            color: Colors.white70,
            height: 10.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          const SizedBox(height: 10.0,),
          camposInicio(context),
          const SizedBox(height: 10.0,),
          const Divider(),
          botonInicio(context),
          const SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  Widget botonInicio(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          side: const BorderSide(
            style: BorderStyle.none,
          ),
          backgroundColor: Color.fromARGB(167, 5, 120, 182), //Color.fromARGB(129, 90, 18, 118),
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          elevation: 20.0
        ),onPressed: () => {
          iniciarSesion(),
        },
        child: Text(
          "Iniciar sesión".toUpperCase(),
          style:const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget camposInicio(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Form(
        child: Column(
          children: [
            TextFormField(              
              controller: correoUsu,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: "Correo electronico",
                suffixIcon: const Icon(Icons.alternate_email),
                helperText: "Ej: carutsjr@gmail.com",
                prefixIcon: const Icon(Icons.email_sharp),
                fillColor:const Color.fromARGB(73, 255, 255, 255),
                filled: true,
              ),
            ),
            const SizedBox(height: 10.0,),
            TextFormField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: "Contraseña",
                helperText: "Introduce tu contraseña",
                prefixIcon:const Icon(Icons.security),
                suffixIcon: const Icon(Icons.password),
                fillColor:const Color.fromARGB(73, 255, 255, 255),
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _Indicadores extends StatelessWidget {
  const _Indicadores({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Container(
          height: 200,
          decoration:  BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue,Colors.white,]
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                blurStyle: BlurStyle.solid,
                offset: Offset(0,10),
              )
            ],
            image:const  DecorationImage(
              image: AssetImage("assets/wolf.png"),
              fit: BoxFit.contain
            ),
            shape: BoxShape.circle,
            border: Border.all(
              width: 2
            )
          ),
        ),
        const SizedBox(height: 20.0,),
        Text(
          "Wolf - Sport".toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30.0,
            color: Color.fromARGB(255, 253, 250, 250),
            fontWeight: FontWeight.bold,    
            fontStyle: FontStyle.italic  
          ),
        ),
      ],
    ),
  );
  }
}
