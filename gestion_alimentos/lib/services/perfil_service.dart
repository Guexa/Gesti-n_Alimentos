import 'package:supabase_flutter/supabase_flutter.dart';

class PerfilService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<Map<String, dynamic>> getUsuarioPerfil(String usuarioId) async {
    final response = await _supabaseClient
        .from('usuario')
        .select()
        .eq('idusuario', usuarioId)
        .single()
        .execute();

    return response.data ?? {};
  }
}
