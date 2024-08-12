import 'package:flutter/material.dart';
import 'package:gestion_alimentos/services/caja_service.dart';

class CajaViewModel extends ChangeNotifier {
  final CajaService _cajaService = CajaService();

  List<Map<String, dynamic>> _ordenesCompletadas = [];

  List<Map<String, dynamic>> get ordenesCompletadas => _ordenesCompletadas;

  Future<void> fetchOrdenesCompletadas() async {
    try {
      _ordenesCompletadas = await _cajaService.getOrdenesCompletadas();
      notifyListeners();
    } catch (err) {
      print('Error fetching órdenes completadas: $err');
    }
  }

  Future<void> marcarOrdenComoPagada(int idOrden) async {
    try {
      await _cajaService.marcarOrdenComoPagada(idOrden);
      _ordenesCompletadas = _ordenesCompletadas.where((orden) => orden['idorden'] != idOrden).toList();
      notifyListeners();
    } catch (err) {
      print('Error marking order as paid: $err');
    }
  }
}
