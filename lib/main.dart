import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_sport/pages/auth_page.dart';
import 'package:wolf_sport/pages/home_page.dart';
import 'package:wolf_sport/pages/home_page_admin.dart';
import 'package:wolf_sport/pages/login_page.dart';
import 'package:wolf_sport/services/alumno_service.dart';
import 'package:wolf_sport/services/formulario_data_service.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  //const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlumnoService()),  
        ChangeNotifierProvider(create: (_) => FormularioDataService()),  
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
      initialRoute: 'auth',
      routes: {
        'auth':(context) => AuthPage(),
        'login':(context) => LoginPage(),
        'home':(context) => HomePage(),
        //'categoria':(context) => CategoriaPage(nombreCat: "",)
        'admin':(context)=>HomePageAdmin()
      },
      onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => const LoginPage()
        );
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
