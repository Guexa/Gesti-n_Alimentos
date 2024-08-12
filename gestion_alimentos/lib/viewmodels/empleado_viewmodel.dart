import 'package:flutter/material.dart';
import '../services/empleado_service.dart';

class EmpleadoViewModel extends ChangeNotifier {
  final EmpleadoService _empleadoService = EmpleadoService();

  List<Map<String, dynamic>> _empleados = [];
  final List<String> roles = ['Host', 'Meseros', 'Cocina', 'Corredores', 'Caja', 'Administrador'];

  List<Map<String, dynamic>> get empleados => _empleados;

  Future<void> fetchEmployees() async {
    try {
      _empleados = await _empleadoService.getAllEmployees();
      notifyListeners();
    } catch (err) {
      print('Error fetching employees: $err');
    }
  }

  Future<void> addEmployee(String nombre, String usuario, String rol, String contrasenia) async {
    try {
      await _empleadoService.addEmployee(nombre, usuario, rol, contrasenia);
      await fetchEmployees();
    } catch (err) {
      print('Error adding employee: $err');
    }
  }

  Future<void> updateEmployee(int id, String nombre, String usuario, String rol) async {
    try {
      await _empleadoService.updateEmployee(id, nombre, usuario, rol);
      await fetchEmployees();
    } catch (err) {
      print('Error updating employee: $err');
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      await _empleadoService.deleteEmployee(id);
      await fetchEmployees();
    } catch (err) {
      print('Error deleting employee: $err');
    }
  }

  Future<void> authenticateUser(String username, String password) async {
    try {
      await _empleadoService.authenticateUser(username, password);
    } catch (err) {
      throw err.toString();
    }
  }
}
