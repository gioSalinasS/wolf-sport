import 'dart:convert';

class FormularioData {
  String? id; 
  String nombreCompleto;
  DateTime? fechaNacimiento;
  String? categoria;
  String nombreTutor;
  String telefonoTutor;

  FormularioData({
    this.id,  
    required this.nombreCompleto,
    this.fechaNacimiento,
    this.categoria,
    required this.nombreTutor,
    required this.telefonoTutor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'nombre_completo': nombreCompleto,
      'fecha_nacimiento': fechaNacimiento?.toIso8601String(),  
      'categoria': categoria,
      'nombre_tutor': nombreTutor,
      'telefono_tutor': telefonoTutor,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory FormularioData.fromMap(Map<String, dynamic> map) {
    return FormularioData(
      id: map['id'], 
      nombreCompleto: map['nombre_completo'],
      fechaNacimiento: map['fecha_nacimiento'] != null
          ? DateTime.parse(map['fecha_nacimiento']) 
          : null,
      categoria: map['categoria'],
      nombreTutor: map['nombre_tutor'],
      telefonoTutor: map['telefono_tutor'],
    );
  }
  factory FormularioData.fromJson(String jsonStr) {
    return FormularioData.fromMap(json.decode(jsonStr));
  }
}
