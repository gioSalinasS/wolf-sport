class Categoria {
  String id;
  String nombre;

  Categoria({required this.id, required this.nombre});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: '', 
      nombre: json['nombre'] ?? '',
    );
  }
}