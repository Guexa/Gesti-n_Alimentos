import 'package:flutter/material.dart';
import 'package:gestion_alimentos/services/perfil_service.dart';

class PerfilViewModel extends ChangeNotifier {
  final PerfilService _perfilService = PerfilService();
  Map<String, dynamic> _perfil = {};

  Map<String, dynamic> get perfil => _perfil;

  Future<void> fetchPerfil(String usuarioId) async {
    try {
      _perfil = await _perfilService.getUsuarioPerfil(usuarioId);
      notifyListeners();
    } catch (err) {
      print('Error fetching user profile: $err');
    }
  }
}
