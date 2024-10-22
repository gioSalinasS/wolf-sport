import 'package:flutter/material.dart';
import 'package:wolf_sport/widgets/card_container.dart';
import 'package:wolf_sport/widgets/fondo_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FondoLogin(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardContainer()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}