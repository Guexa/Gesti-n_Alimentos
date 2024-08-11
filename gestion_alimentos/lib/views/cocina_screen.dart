import 'package:flutter/material.dart';

class CocinaScreen extends StatelessWidget {
  const CocinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocina'),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: _getPedidos().length,
          itemBuilder: (context, index) {
            return _buildPedidoCard(_getPedidos()[index], context);
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getPedidos() {
    return [
      {'numero': 1, 'descripcion': 'Pizza Margarita', 'estado': 'En Preparación'},
      {'numero': 2, 'descripcion': 'Ensalada César', 'estado': 'Listo'},
      {'numero': 3, 'descripcion': 'Tacos al Pastor', 'estado': 'En Preparación'},
    ];
  }

  Widget _buildPedidoCard(Map<String, dynamic> pedido, BuildContext context) {
    final estado = pedido['estado'];
    final estadoColor = _getEstadoColor(estado);

    return Card(
      color: estadoColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text('Comanda #${pedido['numero']}'),
        subtitle: Text(pedido['descripcion']),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle),
          color: Colors.green,
          onPressed: () {
          },
        ),
      ),
    );
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'En Preparación':
        return const Color.fromARGB(255, 247, 192, 110);
      case 'Listo':
        return const Color.fromARGB(255, 141, 240, 146);
      default:
        return Colors.grey;
    }
  }
}
