class Menu {
  final int? id;
  final String categoria;
  final String nombre;
  final double precio;
  final String opciones;

  Menu({this.id, required this.categoria, required this.nombre, required this.precio, required this.opciones});

  Map<String, dynamic> toMap() {
    return {
      'idMenu': id,
      'categoria': categoria,
      'nombre': nombre,
      'precio': precio,
      'opciones': opciones,
    };
  }
}
