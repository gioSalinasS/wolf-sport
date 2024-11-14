//simport 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wolf_sport/models/alumno.dart';
import 'package:wolf_sport/models/categoria.dart';

class AlumnoService extends ChangeNotifier{
  
  final String _baseUrl = "wolf-sport-default-rtdb.firebaseio.com";
  final List<Alumno>  alumnos = [];
  final List<Categoria> categorias = [];

  bool isLoading=true;
  bool isSaving =false;

  Alumno? alumnoSeleccionado;

  AlumnoService(){
    this.obtenerCategorias();
    this.obtenerAlumnosCat();
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
  Future obtenerAlumnosCat() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'/infantil/alumnos.json');
    final resp = await http.get(url);

    //final Map<String, dynamic> alumnosMap = jsonDecode(resp.body);
    final Map<String, dynamic> alumnosMap = jsonDecode(resp.body);

    alumnosMap.forEach((key, value) {
      final temAlumno = Alumno.fromJson(value);
      temAlumno.id = key;
      alumnos.add(temAlumno);
    });

    isLoading = false;
    notifyListeners();
    return alumnos;
  }

  //método para actualizar un alumno
  Future<String> updateAlumno(Alumno alumno) async{
    final url = Uri.https(_baseUrl,'infantil/alumnos/${alumno.id}.json');
    final resp = await http.put(url,body: alumno.toJson());

    final decodedData = resp.body;
    print(decodedData);

    final index =
      alumnos.indexWhere((element) => element.id == alumno.id);

    alumnos[index]=alumno;

    return alumno.id!;
  }

  //método para crear o actualizar 
  Future saveOrCreateAlumno (Alumno alumno) async{
    isSaving = true;
    notifyListeners();

    if(alumno.id == null){
      await nuevoAlumno(alumno);
    }else{
      await updateAlumno(alumno);
    }
    isSaving = false;
    notifyListeners();
  }

  //método para agregar un nuevo alumno
  Future<String> nuevoAlumno(Alumno alumno) async{
    final url = Uri.https(_baseUrl,'infantil/alumnos.json');
    final resp = await http.post(url, body: alumno.toJson());
    final decodedData = json.decode(resp.body);

    alumno.id = decodedData['name'];
    alumnos.add(alumno);

    return alumno.id!;
  }




}