import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor:Color.fromARGB(255, 130, 11, 151),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer, 
      color:Color.fromARGB(146, 168, 189, 247),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.all(10.0), 
      child: const Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0)),
          _Indicadores(),
          Divider(
            thickness: 10.0,
            color: Color.fromARGB(255, 90, 18, 118),
            height: 10.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          SizedBox(height: 10.0,),
          _CamposInicio(),
          SizedBox(height: 10.0,),
          Divider(),
          _BotonInicio(),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }
}

class _CamposInicio extends StatelessWidget {
  const _CamposInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Form(
        child: Column(
          children: [
            TextFormField(              
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
              colors: [Colors.blue,Colors.purple,]
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

class _BotonInicio extends StatelessWidget {
  const _BotonInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          side: const BorderSide(
            style: BorderStyle.none,
          ),
          backgroundColor:const Color.fromARGB(128, 81, 1, 101),
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          elevation: 20.0
        ),onPressed: () => {
          Navigator.pushReplacementNamed(context, 'home')
        },
        child: Text(
          "Iniciar sesión".toUpperCase(),
          style:const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}