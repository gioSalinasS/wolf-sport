import 'package:flutter/material.dart';
import 'package:wolf_sport/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login':(context) => LoginPage(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.indigo,
            foregroundColor: Colors.white
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white
          )
      ),
    );
  }
}