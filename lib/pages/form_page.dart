import 'package:flutter/material.dart';
import 'package:wolf_sport/widgets/card_form.dart';
import 'package:wolf_sport/widgets/fondo_form.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FondoForm(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardForm(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
