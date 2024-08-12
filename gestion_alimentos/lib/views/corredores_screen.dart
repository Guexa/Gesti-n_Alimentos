import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestion_alimentos/viewmodels/corredores_viewmodel.dart';

class CorredoresScreen extends StatelessWidget {
  const CorredoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CorredoresViewModel()..fetchMesasLimpieza(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Corredores'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Consumer<CorredoresViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.mesasLimpieza.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

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
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: viewModel.mesasLimpieza.length,
                itemBuilder: (context, index) {
                  final mesa = viewModel.mesasLimpieza[index];
                  final mesaNumber = mesa['idmesa'] ?? index + 1;
                  
                  return _buildTableCard(mesaNumber, viewModel, context);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTableCard(int mesaNumber, CorredoresViewModel viewModel, BuildContext context) {
    final cardColor = Colors.red; // Color para mesas en 'Limpieza'

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text('Mesa $mesaNumber'),
        subtitle: const Text('Limpieza'),
        trailing: IconButton(
          icon: const Icon(Icons.cleaning_services),
          color: Colors.white,
          onPressed: () {
            _confirmLimpiarMesa(context, mesaNumber, viewModel);
          },
        ),
      ),
    );
  }

  void _confirmLimpiarMesa(BuildContext context, int mesaNumber, CorredoresViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: Text('¿Terminaste de limpiar la mesa número: $mesaNumber?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await viewModel.limpiarMesa(mesaNumber);
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
