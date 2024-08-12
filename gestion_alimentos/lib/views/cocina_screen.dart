import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestion_alimentos/viewmodels/cocina_viewmodel.dart';

class CocinaScreen extends StatelessWidget {
  const CocinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CocinaViewModel()..fetchCommandas(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cocina'),
          backgroundColor: Colors.lime,
        ),
        body: Consumer<CocinaViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.commandas.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 235, 211, 76), Color.fromARGB(255, 3, 82, 1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: viewModel.commandas.length,
                itemBuilder: (context, index) {
                  final pedido = viewModel.commandas[index];
                  return _buildPedidoCard(pedido, context, viewModel);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPedidoCard(Map<String, dynamic> pedido, BuildContext context, CocinaViewModel viewModel) {
    final estado = pedido['status'];
    final estadoColor = _getEstadoColor(estado);

    return Card(
      color: estadoColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text('Comanda #${pedido['idorden']}'),
        subtitle: Text(pedido['items']),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle),
          color: Colors.green,
          onPressed: () async {
            await viewModel.completarOrden(pedido['idorden'], pedido['idmesa']);
          },
        ),
      ),
    );
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'En preparación':
        return const Color.fromARGB(255, 247, 192, 110);
      case 'Completada':
        return const Color.fromARGB(255, 141, 240, 146);
      default:
        return Colors.grey;
    }
  }
}
