import 'package:flutter/material.dart';
import 'package:gestion_alimentos/services/mesa_service.dart';

class MesaViewModel extends ChangeNotifier {
  final MesaService _mesasService = MesaService();

  List<Map<String, dynamic>> _mesas = [];

  List<Map<String, dynamic>> get mesas => _mesas;

  Future<void> fetchMesas() async {
    try {
      _mesas = await _mesasService.getAllMesas();
      notifyListeners();
    } catch (err) {
      print('Error fetching mesas: $err');
    }
  }

  Future<void> assignTable(int idMesa, String meseroNombre) async {
    try {
      await _mesasService.assignTable(idMesa, meseroNombre);
      await fetchMesas();
    } catch (err) {
      print('Error assigning table: $err');
    }
  }
}
