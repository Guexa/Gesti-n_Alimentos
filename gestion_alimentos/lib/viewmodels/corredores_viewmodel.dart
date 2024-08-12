import 'package:flutter/material.dart';
import 'package:gestion_alimentos/services/corredores_service.dart';

class CorredoresViewModel extends ChangeNotifier {
  final CorredoresService _corredoresService = CorredoresService();

  List<Map<String, dynamic>> _mesasLimpieza = [];

  List<Map<String, dynamic>> get mesasLimpieza => _mesasLimpieza;

  Future<void> fetchMesasLimpieza() async {
    try {
      _mesasLimpieza = await _corredoresService.getMesasLimpieza();
      notifyListeners();
    } catch (err) {
      print('Error fetching mesas de limpieza: $err');
    }
  }

  Future<void> limpiarMesa(int idMesa) async {
    try {
      await _corredoresService.limpiarMesa(idMesa);
      _mesasLimpieza.removeWhere((mesa) => mesa['idmesa'] == idMesa);
      notifyListeners();
    } catch (err) {
      print('Error cleaning mesa: $err');
    }
  }
}
