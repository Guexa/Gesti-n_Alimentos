import 'package:flutter/material.dart';
import 'package:gestion_alimentos/services/menu_service.dart';
import 'package:gestion_alimentos/services/mesero_service.dart';

class MeseroViewModel extends ChangeNotifier {
  final MeseroService _meseroService = MeseroService();
  final MenuService _menuService = MenuService();

  List<Map<String, dynamic>> _mesasAsignadas = [];
  List<Map<String, dynamic>> _menu = [];
  final List<Map<String, dynamic>> _selectedItems = [];

  List<Map<String, dynamic>> get mesasAsignadas => _mesasAsignadas;
  List<Map<String, dynamic>> get menu => _menu;
  List<Map<String, dynamic>> get selectedItems => _selectedItems;

  Future<void> fetchMesasAsignadas(String meseroNombre) async {
    try {
      _mesasAsignadas = await _meseroService.getMesasAsignadas(meseroNombre);
      notifyListeners();
    } catch (err) {
      print('Error fetching mesas asignadas: $err');
    }
  }

  Future<void> fetchMenu() async {
    try {
      _menu = await _menuService.getMenu();
      notifyListeners();
    } catch (err) {
      print('Error fetching menu: $err');
    }
  }

  Future<void> addOrder(int idMesa, List<Map<String, dynamic>> items, double total) async {
    try {
      await _meseroService.addOrder(idMesa, items, total);
      notifyListeners();
    } catch (err) {
      print('Error adding order: $err');
    }
  }

  void addSelectedItem(Map<String, dynamic> item) {
    final existingItem = _selectedItems.firstWhere(
      (i) => i['nombre'] == item['nombre'],
      orElse: () => {},
    );

    if (existingItem.isNotEmpty) {
      existingItem['opciones'] = [
        ...existingItem['opciones'] ?? [],
        ...(item['opciones'] ?? []),
      ];
    } else {
      _selectedItems.add(item);
    }

    notifyListeners();
  }

  void removeSelectedItem(Map<String, dynamic> item) {
    final existingItem = _selectedItems.firstWhere(
      (i) => i['nombre'] == item['nombre'],
      orElse: () => {},
    );

    if (existingItem.isNotEmpty) {
      final updatedOptions = (existingItem['opciones'] ?? []).where(
        (option) => !((item['opciones'] ?? []).contains(option)),
      ).toList();

      if (updatedOptions.isEmpty) {
        _selectedItems.remove(existingItem);
      } else {
        existingItem['opciones'] = updatedOptions;
      }
    }

    notifyListeners();
  }
}
