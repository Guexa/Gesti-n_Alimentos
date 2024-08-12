class Usuario {
  final int? id;
  final String name;
  final String user;
  final String role;
  final String password;

  Usuario({
    this.id,
    required this.name,
    required this.user,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'idusuario': id,
      'name': name,
      'users': user,
      'role': role,
      'password': password,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['idusuario'],
      name: map['name'],
      user: map['users'],
      role: map['role'],
      password: map['password'],
    );
  }
}
