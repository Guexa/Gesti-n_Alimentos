import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/empleado_viewmodel.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  _ReportesScreenState createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmpleadoViewModel>(context, listen: false).fetchEmployees();
    });
  }

  void _showEmployeeDialog(BuildContext context, Map<String, dynamic>? empleado, {required bool isEditing}) {
    final viewModel = Provider.of<EmpleadoViewModel>(context, listen: false);
    final nombreController = TextEditingController(text: empleado?['name'] ?? '');
    final usuarioController = TextEditingController(text: empleado?['users'] ?? '');
    final passwordController = TextEditingController();
    String rolSeleccionado = empleado != null && viewModel.roles.contains(empleado['role']) ? empleado['role'] : viewModel.roles.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.orange[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            isEditing ? 'Editar Empleado' : 'Agregar Empleado',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: usuarioController,
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: rolSeleccionado,
                items: viewModel.roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    rolSeleccionado = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Rol'),
              ),
              if (!isEditing)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                  ],
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.deepOrange)),
            ),
            TextButton(
              onPressed: () async {
                if (isEditing) {
                  await viewModel.updateEmployee(
                    empleado!['idusuario'],
                    nombreController.text,
                    usuarioController.text,
                    rolSeleccionado,
                  );
                } else {
                  await viewModel.addEmployee(
                    nombreController.text,
                    usuarioController.text,
                    rolSeleccionado,
                    passwordController.text,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(isEditing ? 'Actualizar' : 'Agregar', style: const TextStyle(color: Colors.deepOrange)),
            ),
          ],
        );
      },
    );
  }

  void _showReportDialog(BuildContext context) {
    String selectedPeriod = 'Día';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.orange[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('Generar Reporte', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: selectedPeriod,
                items: ['Día', 'Semana', 'Mes'].map((String period) {
                  return DropdownMenuItem<String>(
                    value: period,
                    child: Text(period),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPeriod = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Seleccionar Periodo'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.deepOrange)),
            ),
            TextButton(
              onPressed: () {
                print('Reporte generado para: $selectedPeriod');
                Navigator.of(context).pop();
              },
              child: const Text('Generar', style: TextStyle(color: Colors.deepOrange)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EmpleadoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios | Reportes'),
        backgroundColor: Colors.lime,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 235, 211, 76), Color.fromARGB(255, 3, 82, 1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: viewModel.empleados.length,
                itemBuilder: (context, index) {
                  final empleado = viewModel.empleados[index];
                  final nombre = empleado['name'] ?? 'Nombre no disponible';
                  final usuario = empleado['users'] ?? 'Usuario no disponible';
                  final rol = empleado['role'] ?? 'Rol no disponible';

                  return Card(
                    color: Colors.white.withOpacity(0.85),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: ListTile(
                      title: Text(nombre, style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                      subtitle: Text('$usuario - $rol', style: const TextStyle(color: Colors.black54)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.deepOrange),
                            onPressed: () => _showEmployeeDialog(context, empleado, isEditing: true),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.deepOrange),
                            onPressed: () async {
                              await viewModel.deleteEmployee(empleado['idusuario']);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () => _showEmployeeDialog(context, null, isEditing: false),
                child: const Text('Agregar Empleado'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 1, 66, 14),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () => _showReportDialog(context),
                child: const Text('Generar Reportes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
