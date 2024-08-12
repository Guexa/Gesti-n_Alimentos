import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestion_alimentos/viewmodels/caja_viewmodel.dart';

class CajaScreen extends StatelessWidget {
  const CajaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CajaViewModel()..fetchOrdenesCompletadas(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Caja'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Consumer<CajaViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.ordenesCompletadas.isEmpty) {
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
                itemCount: viewModel.ordenesCompletadas.length,
                itemBuilder: (context, index) {
                  final orden = viewModel.ordenesCompletadas[index];
                  final ordenNumber = orden['idorden'] ?? index + 1;
                  final estado = orden['status'] ?? 'Desconocido';
                  final estadoColor = _getEstadoColor(estado);
                  final total = orden['total']?.toString() ?? '0.0';

                  return Card(
                    color: estadoColor,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text('Orden #$ordenNumber'),
                      subtitle: Text(
                        'Total: \$${total}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: estado == 'Completada'
                          ? IconButton(
                              icon: const Icon(Icons.check_circle),
                              color: Colors.green,
                              onPressed: () {
                                _showConfirmationDialog(context, viewModel, ordenNumber);
                              },
                            )
                          : null,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'Completada':
        return const Color.fromARGB(255, 255, 223, 186);
      case 'Pagada':
        return const Color.fromARGB(255, 141, 240, 146);
      default:
        return Colors.grey;
    }
  }

  void _showConfirmationDialog(BuildContext context, CajaViewModel viewModel, int ordenNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Pago'),
          content: Text('¿Desea marcar la Orden #$ordenNumber como pagada?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                viewModel.marcarOrdenComoPagada(ordenNumber);
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
              child: const Text('Pagar'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pago Confirmado'),
          content: const Text('La orden ha sido marcada como pagada.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
