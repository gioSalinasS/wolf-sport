import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wolf_sport/models/alumno.dart';
import 'package:wolf_sport/models/categoria.dart';

class AlumnoService extends ChangeNotifier {
  final String _baseUrl = "wolf-sport-default-rtdb.firebaseio.com";
  List<Alumno> alumnosInfantil = [];
  List<Alumno> alumnosJunior = [];
  final List<Categoria> categorias = [];

  bool isLoading = true;
  bool isSaving = false;

  AlumnoService() {
    obtenerCategorias();
    obtenerAlumnos();
    obtenerAlumnosJunior();
  }

  // Función para obtener categorías
  Future obtenerCategorias() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, '/.json');
    final resp = await http.get(url);

    print(url);

    final Map<String, dynamic> categoriasMap = jsonDecode(resp.body);

    categoriasMap.forEach((key, value) {
      final tempCat = Categoria.fromJson(value);
      tempCat.id = key;
      categorias.add(tempCat);
    });

    isLoading = false;
    notifyListeners();
    return categorias;
  }

  // Obtener alumnos categoría Infantil
  Future obtenerAlumnos() async {
    alumnosInfantil=[];
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'infantil/alumnos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> alumnosMap = jsonDecode(resp.body);

    alumnosMap.forEach((key, value) {
      final tempAl = Alumno.fromMap(value);
      tempAl.id = key;
      alumnosInfantil.add(tempAl);
    });
    isLoading = false;
    notifyListeners();
    return alumnosInfantil;
  }

  // Obtener alumnos categoría Junior
  Future obtenerAlumnosJunior() async {
    alumnosJunior=[];
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'junior/alumnos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> alumnosMap = jsonDecode(resp.body);

    alumnosMap.forEach((key, value) {
      final tempAl = Alumno.fromMap(value);
      tempAl.id = key;
      alumnosJunior.add(tempAl);
    });
    isLoading = false;
    notifyListeners();
    return alumnosJunior;
  }

  // Actualizar asistencia (Infantil)
  Future<String> updateAsistencia(Alumno alumno) async {
    final url = Uri.https(_baseUrl, '/infantil/alumnos/${alumno.id}.json');
    final resp = await http.patch(
      url,
      body: json.encode({
        'asistencias': alumno.asistencias,
      }),
    );

    // Decodifica la respuesta
    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      print('Asistencia actualizada: $decodedData');
      return alumno.id!;
    } else {
      throw Exception('Error al actualizar la asistencia: ${resp.statusCode}');
    }
  }

  // Actualizar asistencia (Junior)
  Future<String> updateAsistenciaJunior(Alumno alumno) async {
    final url = Uri.https(_baseUrl, '/junior/alumnos/${alumno.id}.json');
    final resp = await http.patch(
      url,
      body: json.encode({
        'asistencias': alumno.asistencias,
      }),
    );

    // Decodifica la respuesta
    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      print('Asistencia actualizada: $decodedData');
      return alumno.id!;
    } else {
      throw Exception('Error al actualizar la asistencia: ${resp.statusCode}');
    }
  }

  // Método para crear o actualizar alumno
  Future saveOrCreateAlumno(Alumno alumno) async {
    isSaving = true;
    notifyListeners();

    if (alumno.id != null) {
      await updateAsistencia(alumno);
    }

    isSaving = false;
    notifyListeners();
  }

  //categoría Infantil
  Future<String> crearAlumnoInfantil({
    required String nombre,
    required String nombreTutor,
    required String telTutor,
    required String fNacimiento,
  }) async {
    final alumno = Alumno(
      asistencias: "0",
      fNacimiento: fNacimiento,
      nombre: nombre,
      nombreTutor: nombreTutor,
      telTutor: telTutor,
    );

    final url = Uri.https(_baseUrl, 'infantil/alumnos.json');
    final resp = await http.post(url, body: json.encode(alumno.toMap()));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      final id = decodedData['name'];
      print('Alumno Infantil creado');
      //print('Alumno Infantil creado con ID: $id');
      return id;
    } else {
      throw Exception('Error al crear el alumno Infantil: ${resp.statusCode}');
    }
  }

  // ategoría Junior
  Future<String> crearAlumnoJunior({
    required String nombre,
    required String nombreTutor,
    required String telTutor,
    required String fNacimiento,
  }) async {
    final alumno = Alumno(
      asistencias: "0",
      fNacimiento: fNacimiento,
      nombre: nombre,
      nombreTutor: nombreTutor,
      telTutor: telTutor,
    );

    final url = Uri.https(_baseUrl, 'junior/alumnos.json');
    final resp = await http.post(url, body: json.encode(alumno.toMap()));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      final id = decodedData['name'];
      print('Alumno Junior creado');
      return id;
    } else {
      throw Exception('Error al crear el alumno Junior: ${resp.statusCode}');
    }
  }
}
