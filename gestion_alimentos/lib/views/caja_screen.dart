import 'package:flutter/material.dart';

class CajaScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cuentasPendientes;

  const CajaScreen({super.key, required this.cuentasPendientes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caja'),
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
          itemCount: cuentasPendientes.length,
          itemBuilder: (context, index) {
            return _buildCuentaCard(cuentasPendientes[index], context);
          },
        ),
      ),
    );
  }

  Widget _buildCuentaCard(Map<String, dynamic> cuenta, BuildContext context) {
    final mesaNumber = cuenta['mesa'];
    final total = cuenta['total'];
    final estado = cuenta['estado'];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text('Mesa $mesaNumber'),
        subtitle: Text('Total: \$${total.toStringAsFixed(2)}'),
        trailing: estado == 'Pendiente'
            ? IconButton(
                icon: const Icon(Icons.payment),
                color: Colors.green,
                onPressed: () {
                  _showPaymentConfirmationDialog(context, mesaNumber);
                },
              )
            : null,
      ),
    );
  }

  void _showPaymentConfirmationDialog(BuildContext context, int mesaNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Pago Mesa $mesaNumber'),
          content: const Text('¿Desea confirmar el cobro?'),
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
                _showSuccessDialog(context);
              },
              child: const Text('Confirmar'),
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
          content: const Text('El cobro ha sido registrado exitosamente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
