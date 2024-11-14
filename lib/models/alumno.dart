import 'dart:convert';

class Alumno {
    int asistencias;
    String fNacimiento;
    String nombre;
    String nombreTutor;
    int telTutor;
    String? id;

    Alumno({
        required this.asistencias,
        required this.fNacimiento,
        required this.nombre,
        required this.nombreTutor,
        required this.telTutor,
        this.id
    });

    factory Alumno.fromJson(String str) => Alumno.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Alumno.fromMap(Map<String, dynamic> json) => Alumno(
        asistencias: json["asistencias"],
        fNacimiento: json["f_nacimiento"],
        nombre: json["nombre"],
        nombreTutor: json["nombre_tutor"],
        telTutor: json["tel_tutor"],
    );

    Map<String, dynamic> toMap() => {
        "asistencias": asistencias,
        "f_nacimiento": fNacimiento,
        "nombre": nombre,
        "nombre_tutor": nombreTutor,
        "tel_tutor": telTutor,
    };
}