import 'package:supabase_flutter/supabase_flutter.dart';

class MenuService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMenu() async {
    final response = await _supabaseClient.from('menu').select().execute();

    return List<Map<String, dynamic>>.from(response.data ?? []);
  }
}
