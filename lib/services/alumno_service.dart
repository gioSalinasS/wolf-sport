//simport 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wolf_sport/models/alumno.dart';
import 'package:wolf_sport/models/categoria.dart';

class AlumnoService extends ChangeNotifier{
  
  final String _baseUrl = "wolf-sport-default-rtdb.firebaseio.com";
  final List<Alumno> alumnosInfantil = [];
  final List<Alumno> alumnosJunior = [];
  final List<Categoria> categorias = [];

  bool isLoading=true;
  bool isSaving =false;

  //Alumno? alumnoSeleccionado;

  AlumnoService(){
    obtenerCategorias();
    obtenerAlumnos();
    obtenerAlumnosJunior();
  }

  //funcion para obtener categorias
  Future obtenerCategorias() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'/.json');
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

  //obtener alumnos
  Future obtenerAlumnos() async{
    isLoading = true;
    notifyListeners();
    
    final url = Uri.https(_baseUrl,'infantil/alumnos.json');
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

  //obtener alumnos categoria Junior
  Future obtenerAlumnosJunior() async{
    isLoading = true;
    notifyListeners();
    
    final url = Uri.https(_baseUrl,'junior/alumnos.json');
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

  //Actualizar asistencia
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

  //Actualizar asistencia
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

  //método para crear o actualizar 
  Future saveOrCreateAlumno (Alumno alumno) async{
    isSaving = true;
    notifyListeners();

    if(alumno.id != null){
      await updateAsistencia(alumno);
    }
    isSaving = false;
    notifyListeners();
  }

  //método para agregar un nuevo alumno
  /*Future<String> nuevoAlumno(Alumno alumno) async{
    final url = Uri.https(_baseUrl,'infantil/alumnos.json');
    final resp = await http.post(url, body: alumno.toJson());
    final decodedData = json.decode(resp.body);

    alumno.id = decodedData['name'];
    alumnosInfantil.add(alumno);

    return alumno.id!;
  }*/




}