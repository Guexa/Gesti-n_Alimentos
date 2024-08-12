import 'package:flutter/material.dart';
import 'package:gestion_alimentos/viewmodels/mesa_viewmodel.dart';
import 'package:provider/provider.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  @override
  void initState() {
    super.initState();
    final mesasViewModel = Provider.of<MesaViewModel>(context, listen: false);
    mesasViewModel.fetchMesas();
  }

  @override
  Widget build(BuildContext context) {
    final mesasViewModel = Provider.of<MesaViewModel>(context);

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
          itemCount: mesasViewModel.mesas.length,
          itemBuilder: (context, index) {
            final mesa = mesasViewModel.mesas[index];
            final mesaNumber = mesa['idmesa'] ?? index + 1;
            final status = mesa['status'] ?? 'Libre';
            final meseroNombre = mesa['asignada_para'] ?? '';
            final statusColor = _getStatusColor(status);

            return _buildTableCard(mesaNumber, statusColor, status, meseroNombre, context);
          },
        ),
      ),
    );
  }

  Widget _buildTableCard(int mesaNumber, Color statusColor, String status, String meseroNombre, BuildContext context) {
    return GestureDetector(
      onTap: () => _assignTable(context, mesaNumber),
      child: Card(
        color: statusColor,
        child: Center(
          child: Text(
            'Mesa $mesaNumber\n$status\n${status == 'Asignada' ? 'Mesero: $meseroNombre' : ''}',
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

  void _assignTable(BuildContext context, int mesaNumber) {
    final mesasViewModel = Provider.of<MesaViewModel>(context, listen: false);
    final nombreController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Asignar Mesa $mesaNumber'),
          content: TextField(
            controller: nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre del Mesero que Atenderá',
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
              onPressed: () async {
                if (nombreController.text.isNotEmpty) {
                  await mesasViewModel.assignTable(mesaNumber, nombreController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Asignar'),
            ),
          ],
        );
      },
    );
  }
}
