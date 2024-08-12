import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestion_alimentos/viewmodels/perfil_viewmodel.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const usuarioId = '12';

    return ChangeNotifierProvider(
      create: (context) => PerfilViewModel()..fetchPerfil(usuarioId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Consumer<PerfilViewModel>(
          builder: (context, viewModel, child) {
            final perfil = viewModel.perfil;

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildProfileField('Nombre Completo', perfil['name'] ?? 'No disponible'),
                    const SizedBox(height: 20),
                    _buildProfileField('Usuario', perfil['users'] ?? 'No disponible'),
                    const SizedBox(height: 20),
                    _buildProfileField('Rol', perfil['role'] ?? 'No disponible'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
