import 'package:flutter/material.dart';

class FondoLoginLoad extends StatelessWidget {
  
  final Widget child;
  
  const FondoLoginLoad({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: double.infinity,
            child: const Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 100,
              ),
          ),
          this.child
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  //const _PurpleBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      //color: Colors.indigo,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 0.8),
          ]
        )
      ),
      child: const Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child: _Esfera(),
          ),
          Positioned(
            top: 150,
            right: 50,
            child: _Esfera(),
          ),
          Positioned(
            top: 80,
            left: 150,
            child: _Esfera(),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: _Esfera(),
          ),
        ],
      ),
    );
  }
}

class _Esfera extends StatelessWidget {
  const _Esfera({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}