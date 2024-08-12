import 'package:supabase_flutter/supabase_flutter.dart';

class CajaService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getOrdenesCompletadas() async {
    final response = await _supabaseClient
        .from('orden')
        .select()
        .eq('status', 'Completada')
        .execute();

    return List<Map<String, dynamic>>.from(response.data ?? []);
  }

  Future<void> marcarOrdenComoPagada(int idOrden) async {
    await _supabaseClient
        .from('orden')
        .update({'status': 'Pagada'})
        .eq('idorden', idOrden)
        .execute();
  }
}
