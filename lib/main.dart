import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/pages/categoria_page.dart';
import 'package:wolf_sport/pages/home_page.dart';
import 'package:wolf_sport/pages/login_page.dart';
import 'package:wolf_sport/services/alumno_service.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  //const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlumnoService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wolf-Sport',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login':(context) => LoginPage(),
        'home':(context) => HomePage(),
        'categoria':(context) => CategoriaPage()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.indigo,
            foregroundColor: Colors.white
          ),
          /*floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 0,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white
          )*/
      ),
    );
  }
}