import 'package:flutter/material.dart';
import 'package:gestion_alimentos/views/caja_screen.dart';
import 'package:gestion_alimentos/views/cocina_screen.dart';
import 'package:gestion_alimentos/views/corredores_screen.dart';
import 'package:gestion_alimentos/views/host_screen.dart';
import 'package:gestion_alimentos/views/login_screen.dart';
import 'package:gestion_alimentos/views/meseros_screen.dart';
import 'package:gestion_alimentos/views/perfil_screen.dart';
import 'package:gestion_alimentos/views/reportes_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        backgroundColor: Colors.lime,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 7, 62, 42),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.restaurant_menu,
                            size: 80, color: Colors.white),
                        SizedBox(height: 10),
                        Text(
                          'Nombre de Usuario',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading:
                        const Icon(Icons.table_chart, color: Color.fromARGB(255, 7, 62, 42)),
                    title: const Text('Host'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HostScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Color.fromARGB(255, 7, 62, 42)),
                    title: const Text('Meseros'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MeserosScreen(meseroNombre: 'Mesero 1',)),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.kitchen, color: Color.fromARGB(255, 7, 62, 42)),
                    title: const Text('Cocina'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CocinaScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.cleaning_services,
                        color: Color.fromARGB(255, 7, 62, 42)),
                    title: const Text('Corredores'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CorredoresScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.money, color: Color.fromARGB(255, 7, 62, 42)),
                    title: const Text('Caja'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CajaScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.ad_units_rounded,
                        color: Color.fromARGB(255, 7, 62, 42)),
                    title: const Text('Gestión de Usuarios'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportesScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_outline,
                        color: Color.fromARGB(255, 7, 62, 42)),
                    title: const Text('Perfil'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PerfilScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app,
                  color: Color.fromARGB(255, 55, 55, 55)),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 235, 211, 76), Color.fromARGB(255, 3, 82, 1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Text(
            'Bienvenidx al sistema de cocina integral',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}


