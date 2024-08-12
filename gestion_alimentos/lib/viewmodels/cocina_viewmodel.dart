import 'package:flutter/material.dart';
import 'package:gestion_alimentos/services/cocina_service.dart';

class CocinaViewModel extends ChangeNotifier {
  final CocinaService _cocinaService = CocinaService();

  List<Map<String, dynamic>> _commandas = [];

  List<Map<String, dynamic>> get commandas => _commandas;

  Future<void> fetchCommandas() async {
    try {
      _commandas = await _cocinaService.getCommandas();
      notifyListeners();
    } catch (err) {
      print('Error fetching commandas: $err');
    }
  }

  Future<void> completarOrden(int idOrden, int idMesa) async {
    try {
      await _cocinaService.completarOrden(idOrden, idMesa);
      await fetchCommandas(); // Refresca la lista después de actualizar
    } catch (err) {
      print('Error completing order: $err');
    }
  }
}
