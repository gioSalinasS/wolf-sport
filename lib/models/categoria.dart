class Categoria {
  String id;
  String nombre;

  Categoria({required this.id, required this.nombre});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: '', // Este se asignará más adelante
      nombre: json['nombre'] ?? '',
    );
  }
}