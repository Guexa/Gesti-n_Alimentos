import 'package:flutter/material.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  _ReportesScreenState createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  final List<Map<String, dynamic>> empleados = [
    {'id': 1, 'nombre': 'Juan Pérez', 'usuario': 'juanp', 'rol': 'Host'},
    {'id': 2, 'nombre': 'Ana Gómez', 'usuario': 'anag', 'rol': 'Meseros'},
    // Otros empleados
  ];

  final List<String> roles = ['Host', 'Meseros', 'Cocina', 'Corredores', 'Caja', 'Administrador'];

  void _showEmployeeDialog(BuildContext context, Map<String, dynamic>? empleado, {required bool isEditing}) {
    final nombreController = TextEditingController(text: empleado?['nombre']);
    final usuarioController = TextEditingController(text: empleado?['usuario']);
    final passwordController = TextEditingController(); // Controlador para la contraseña
    String rolSeleccionado = empleado != null && roles.contains(empleado['rol']) ? empleado['rol'] : roles.first;

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
                items: roles.map((String role) {
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
              if (!isEditing) // Mostrar el campo de contraseña solo al agregar
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
              onPressed: () {
                if (isEditing) {
                  _updateEmployee(empleado!['id'], nombreController.text, usuarioController.text, rolSeleccionado);
                } else {
                  _addEmployee(nombreController.text, usuarioController.text, rolSeleccionado, passwordController.text);
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

  void _addEmployee(String nombre, String usuario, String rol, String contrasenia) {
    setState(() {
      empleados.add({'id': empleados.length + 1, 'nombre': nombre, 'usuario': usuario, 'rol': rol, 'contraseña': contrasenia});
    });
  }

  void _updateEmployee(int id, String nombre, String usuario, String rol) {
    setState(() {
      final index = empleados.indexWhere((empleado) => empleado['id'] == id);
      if (index != -1) {
        empleados[index] = {'id': id, 'nombre': nombre, 'usuario': usuario, 'rol': rol};
      }
    });
  }

  void _deleteEmployee(int id) {
    setState(() {
      empleados.removeWhere((empleado) => empleado['id'] == id);
    });
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
                // Lógica para generar el reporte según el periodo seleccionado
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: empleados.length,
                itemBuilder: (context, index) {
                  final empleado = empleados[index];
                  return Card(
                    color: Colors.white.withOpacity(0.85),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: ListTile(
                      title: Text(empleado['nombre'], style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                      subtitle: Text('${empleado['usuario']} - ${empleado['rol']}', style: const TextStyle(color: Colors.black54)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.deepOrange),
                            onPressed: () => _showEmployeeDialog(context, empleado, isEditing: true),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.deepOrange),
                            onPressed: () => _deleteEmployee(empleado['id']),
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
                  foregroundColor: Colors.deepOrange,
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
