import 'package:supabase_flutter/supabase_flutter.dart';

class ReporteService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getOrdenesPagadas() async {
    final response = await _supabaseClient
        .from('ordenes')
        .select()
        .eq('status', 'Pagada')
        .execute();

    return List<Map<String, dynamic>>.from(response.data ?? []);
  }
}
