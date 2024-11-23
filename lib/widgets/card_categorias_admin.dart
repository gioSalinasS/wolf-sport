import 'package:flutter/material.dart';

class CardCategoriasAdmin extends StatelessWidget {
  final String nombre;
  const CardCategoriasAdmin({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5)
            )
          ]
        ),
        child: Stack(
          //alignment: Alignment.bottomLeft,
          children: [
            //_PurpleBox(),
            _NombreCategoria(nombre: nombre,),
            Positioned(
              top: 10,
              right: 50,
              child: _Logo()
            ),
            Positioned(
              bottom: 50,
              left: 50,
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width*0.7,
                height: 50,
                child: const Text(
                  "El verdadero desafío no es vencer al rival, sino superarnos a nosotros mismos",
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              )
            ),
            Positioned(
              bottom: 115,
              child: Container(
                color: Colors.black.withOpacity(.80),
                width: MediaQuery.of(context).size.width,
                height: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NombreCategoria extends StatelessWidget {
  final String nombre;
  const _NombreCategoria({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 90,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 70, 113, 148),
              Colors.blue,
            ]
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            topRight: Radius.circular(5)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            Text("Categoria $nombre",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration:  BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 156, 156, 156),]
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            offset: Offset(0,5),
          )
        ],
        shape: BoxShape.circle,
        border: Border.all(
          width: 2
        )
      ),
      child: Image.asset('assets/wolf_card.png')
    );
  }
}