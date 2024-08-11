import 'package:flutter/material.dart';

class HostScreen extends StatelessWidget {
  const HostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Host'),
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
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return _buildTableCard(index + 1, context);
          },
        ),
      ),
    );
  }

  Widget _buildTableCard(int tableNumber, BuildContext context) {
    final status = ['Libre', 'Asignada', 'Pedido', 'Comiendo', 'Limpieza'][tableNumber % 5];
    final statusColor = _getStatusColor(status);

    return GestureDetector(
      onTap: () => _assignTable(context, tableNumber),
      child: Card(
        color: statusColor,
        child: Center(
          child: Text(
            'Mesa $tableNumber\n$status',
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

  void _assignTable(BuildContext context, int tableNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Asignar Mesa $tableNumber'),
          content: const TextField(
            decoration: InputDecoration(
              labelText: 'Nombre del Cliente',
            ),
            autofocus: true,
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
                Navigator.of(context).pop();
              },
              child: const Text('Asignar'),
            ),
          ],
        );
      },
    );
  }
}
