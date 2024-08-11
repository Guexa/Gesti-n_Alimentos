import 'package:flutter/material.dart';

class CorredoresScreen extends StatelessWidget {
  final List<int> mesasAsignadas;
  final List<int> mesasParaLimpieza;

  const CorredoresScreen({
    super.key,
    required this.mesasAsignadas,
    required this.mesasParaLimpieza,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corredores'),
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
          itemCount: mesasAsignadas.length,
          itemBuilder: (context, index) {
            return _buildTableCard(mesasAsignadas[index], context);
          },
        ),
      ),
    );
  }

  Widget _buildTableCard(int mesaNumber, BuildContext context) {
    final isForCleaning = mesasParaLimpieza.contains(mesaNumber);
    final cardColor = isForCleaning ? Colors.red : Colors.grey;
    final statusText = isForCleaning ? 'Limpieza' : 'Asignada';

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text('Mesa $mesaNumber'),
        subtitle: Text(statusText),
        trailing: isForCleaning
            ? IconButton(
                icon: const Icon(Icons.cleaning_services),
                color: Colors.white,
                onPressed: () {
                },
              )
            : null,
      ),
    );
  }
}
