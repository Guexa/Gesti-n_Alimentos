import 'package:supabase_flutter/supabase_flutter.dart';

class CocinaService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getCommandas() async {
    final response = await _supabaseClient
        .from('orden')
        .select()
        .eq('status', 'Pedido')
        .execute();

    return List<Map<String, dynamic>>.from(response.data ?? []);
  }

  Future<void> completarOrden(int idOrden, int idMesa) async {
    await _supabaseClient.from('orden').update({
      'status': 'Completada',
    }).eq('idorden', idOrden).execute();

    await _supabaseClient.from('mesa').update({
      'status': 'Comiendo',
    }).eq('idmesa', idMesa).execute();
  }
}
