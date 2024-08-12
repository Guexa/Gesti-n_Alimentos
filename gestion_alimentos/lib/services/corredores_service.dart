import 'package:supabase_flutter/supabase_flutter.dart';

class CorredoresService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMesasLimpieza() async {
    final response = await _supabaseClient
        .from('mesa')
        .select()
        .eq('status', 'Limpieza')
        .execute();

    return List<Map<String, dynamic>>.from(response.data ?? []);
  }

  Future<void> limpiarMesa(int idMesa) async {
    await _supabaseClient.from('mesa').update({
      'status': 'Libre',
      'asignada_para': null,
    }).eq('idmesa', idMesa).execute();
  }
}
