import 'package:supabase_flutter/supabase_flutter.dart';

class MeseroService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMesasAsignadas(String meseroNombre) async {
  final response = await _supabaseClient
      .from('mesa')
      .select()
      .eq('asignada_para', meseroNombre)
      .in_('status', ['Asignada', 'Pedido', 'Comiendo'])
      .execute();

  return List<Map<String, dynamic>>.from(response.data ?? []);
}


  Future<void> addOrder(int idMesa, List<Map<String, dynamic>> items, double total) async {
    await _supabaseClient.from('orden').insert({
      'idmesa': idMesa,
      'items': items.map((item) => item['nombre']).join(', '),
      'total': total,
      'status': 'Pedido',
    }).execute();

    await _supabaseClient.from('mesa').update({
      'status': 'Pedido',
    }).eq('idmesa', idMesa).execute();
  }
}
