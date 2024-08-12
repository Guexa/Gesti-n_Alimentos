import 'package:supabase_flutter/supabase_flutter.dart';

class EmpleadoService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllEmployees() async {
    final response = await _supabaseClient.from('usuario').select().execute();

    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<void> addEmployee(
      String nombre, String usuario, String rol, String contrasenia) async {
    await _supabaseClient.from('usuario').insert({
      'name': nombre,
      'users': usuario,
      'role': rol,
      'password': contrasenia,
    }).execute();
  }

  Future<void> updateEmployee(
      int id, String nombre, String usuario, String rol) async {
    await _supabaseClient
        .from('usuario')
        .update({
          'name': nombre,
          'users': usuario,
          'role': rol,
        })
        .eq('idusuario', id)
        .execute();
  }

  Future<void> deleteEmployee(int id) async {
    await _supabaseClient.from('usuario').delete().eq('idusuario', id).execute();
  }

  Future<void> authenticateUser(String username, String password) async {
    try {
      final response = await _supabaseClient
          .from('usuario')
          .select()
          .eq('users', username)
          .eq('password', password)
          .execute();

      final data = response.data as List<dynamic>;
      if (data.isEmpty) {
        throw Exception('Usuario o contraseña incorrectos');
      }
    } catch (e) {
      print('Error authenticating user: $e');
      rethrow;
    }
  }
}
