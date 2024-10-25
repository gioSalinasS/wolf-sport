import 'package:flutter/material.dart';

class FondoForm extends StatelessWidget {
  const FondoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5CA3F3),
            Color(0xFF73BBFB), 
            Color(0xFF356DB7), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
