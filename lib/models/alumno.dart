//import 'dart:convert';

class Alumno {

  String? id;
  String asistencias;
  String fNacimiento;
  String nombre;
  String nombreTutor;
  String telTutor;

  Alumno({
    this.id, 
    required this.asistencias,
    required this.fNacimiento,
    required this.nombre,
    required this.nombreTutor,
    required this.telTutor,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) {
    return Alumno(
      asistencias: json["asistencias"],
      fNacimiento: json["f_nacimiento"],
      nombre: json["nombre"],
      nombreTutor: json["nombre_tutor"],
      telTutor: json["tel_tutor"],
    );
  }
}