import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {
  const FondoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(    
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(350)),
              gradient: LinearGradient(
                colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 19, 138, 202),
                  ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              )
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(350)),
              gradient: LinearGradient(
                colors: [
                    Color.fromARGB(175, 27, 112, 240),
                    Color.fromARGB(225, 255, 255, 255),
                  ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              )
            ),
          ),
        ],
      ),
    );
  }
}