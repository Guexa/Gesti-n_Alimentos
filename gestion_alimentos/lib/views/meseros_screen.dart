import 'package:flutter/material.dart';

class MeserosScreen extends StatelessWidget {
  final List<int> mesasAsignadas;

  const MeserosScreen({super.key, required this.mesasAsignadas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meseros'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: mesasAsignadas.length,
          itemBuilder: (context, index) {
            return _buildTableCard(mesasAsignadas[index], context);
          },
        ),
      ),
    );
  }

  Widget _buildTableCard(int mesaNumber, BuildContext context) {
    final status = ['Libre', 'Asignada', 'Pedido', 'Comiendo', 'Limpieza'][mesaNumber % 5];
    final statusColor = _getStatusColor(status);

    return GestureDetector(
      onTap: () => _showOrderDialog(context, mesaNumber),
      child: Card(
        color: statusColor,
        child: Center(
          child: Text(
            'Mesa $mesaNumber\n$status',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Libre':
        return const Color.fromARGB(255, 3, 155, 8);
      case 'Asignada':
        return const Color.fromARGB(173, 237, 230, 171);
      case 'Pedido':
        return const Color.fromARGB(255, 144, 86, 0);
      case 'Comiendo':
        return const Color.fromARGB(255, 16, 70, 114);
      case 'Limpieza':
        return const Color.fromARGB(255, 0, 0, 0);
      default:
        return Colors.grey;
    }
  }

  void _showOrderDialog(BuildContext context, int mesaNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comanda Mesa $mesaNumber'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Número de Comanda: 12345'),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Descripción del Pedido',
                ),
                autofocus: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Implementar lógica para enviar el pedido a cocina
                Navigator.of(context).pop();
              },
              child: const Text('Enviar Pedido'),
            ),
          ],
        );
      },
    );
  }
}
