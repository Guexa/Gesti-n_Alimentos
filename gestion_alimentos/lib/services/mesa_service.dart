import 'package:supabase_flutter/supabase_flutter.dart';

class MesaService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllMesas() async {
    final response = await _supabaseClient.from('mesa').select().execute();

    return List<Map<String, dynamic>>.from(response.data ?? []);
  }

  Future<void> assignTable(int idMesa, String meseroNombre) async {
    await _supabaseClient.from('mesa').update({
      'status': 'Asignada',
      'asignada_para': meseroNombre,
    }).eq('idmesa', idMesa).execute();
  }
}
