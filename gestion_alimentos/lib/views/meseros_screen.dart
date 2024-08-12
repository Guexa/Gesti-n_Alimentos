import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestion_alimentos/viewmodels/mesero_viewmodel.dart';

class MeserosScreen extends StatelessWidget {
  final String meseroNombre;

  const MeserosScreen({super.key, required this.meseroNombre});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MeseroViewModel()..fetchMesasAsignadas(meseroNombre),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meseros'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Consumer<MeseroViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.mesasAsignadas.isEmpty) {
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
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: viewModel.mesasAsignadas.length,
                itemBuilder: (context, index) {
                  final mesa = viewModel.mesasAsignadas[index];
                  final mesaNumber = mesa['idmesa'] ?? index + 1;
                  final status = mesa['status'] ?? 'Libre';
                  final statusColor = _getStatusColor(status);

                  return GestureDetector(
                    onTap: () =>
                        _showOrderDialog(context, mesaNumber, viewModel),
                    child: Card(
                      color: statusColor,
                      child: Center(
                        child: Text(
                          'Mesa $mesaNumber\n$status',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
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

  void _showOrderDialog(BuildContext context, int mesaNumber, MeseroViewModel viewModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController descriptionController = TextEditingController();

      return AlertDialog(
        title: Text('Comanda Mesa $mesaNumber'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FutureBuilder<void>(
                future: viewModel.fetchMenu(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final menu = viewModel.menu;

                  if (menu.isEmpty) {
                    return const Text('El menú está vacío.');
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: menu.length,
                      itemBuilder: (context, index) {
                        final item = menu[index];
                        final itemName = item['nombre'] ?? 'Sin Nombre';
                        final itemPrice = item['precio']?.toString() ?? '0.0';
                        final itemOptions = item['opciones']?.split(',') ?? [];

                        return ListTile(
                          title: Text(itemName),
                          subtitle: Text('\$${itemPrice}'),
                          trailing: Checkbox(
                            value: viewModel.selectedItems.any((i) => i['nombre'] == itemName),
                            onChanged: (bool? checked) {
                              if (checked == true) {
                                viewModel.addSelectedItem(item);
                              } else {
                                viewModel.removeSelectedItem(item);
                              }
                            },
                          ),
                          onTap: () {
                            if (itemOptions.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Opciones para $itemName'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: itemOptions.map((option) {
                                        return CheckboxListTile(
                                          title: Text(option),
                                          value: viewModel.selectedItems.any((i) =>
                                              i['nombre'] == itemName &&
                                              i['opciones']?.contains(option) == true),
                                          onChanged: (bool? selected) {
                                            if (selected == true) {
                                              viewModel.addSelectedItem({
                                                'nombre': itemName,
                                                'opciones': [option],
                                              });
                                            } else {
                                              viewModel.removeSelectedItem({
                                                'nombre': itemName,
                                                'opciones': [option],
                                              });
                                            }
                                          },
                                        );
                                      }).toList(),
                                    ),
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
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción del Pedido',
                ),
                autofocus: true,
              ),
            ],
          ),
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
              List<Map<String, dynamic>> selectedItems = viewModel.selectedItems.map((item) {
                final itemName = item['nombre'] ?? '';
                final options = item['opciones']?.join(', ') ?? '';
                return {
                  'nombre': itemName,
                  'opciones': options,
                };
              }).toList();

              final orderDescription = selectedItems.map((item) {
                final itemName = item['nombre'] ?? '';
                final options = item['opciones'] ?? '';
                return options.isNotEmpty ? '$itemName ($options)' : itemName;
              }).join(', ');

              double total = selectedItems.fold(0.0, (sum, item) {
                final itemPrice = viewModel.menu.firstWhere((m) => m['nombre'] == item['nombre'], orElse: () => {})['precio'] ?? 0.0;
                return sum + itemPrice;
              });

              viewModel.addOrder(mesaNumber, viewModel.selectedItems, total);

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
