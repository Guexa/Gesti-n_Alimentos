class Mesa {
  final int? id;
  final String status;
  final String asignadaPara;

  Mesa({this.id, required this.status, required this.asignadaPara});

  Map<String, dynamic> toMap() {
    return {
      'idMesa': id,
      'status': status,
      'asignada_para': asignadaPara,
    };
  }
}
