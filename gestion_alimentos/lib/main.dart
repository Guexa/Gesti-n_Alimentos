import 'package:flutter/material.dart';
import 'package:gestion_alimentos/viewmodels/caja_viewmodel.dart';
import 'package:gestion_alimentos/viewmodels/cocina_viewmodel.dart';
import 'package:gestion_alimentos/viewmodels/corredores_viewmodel.dart';
import 'package:gestion_alimentos/viewmodels/mesa_viewmodel.dart';
import 'package:gestion_alimentos/viewmodels/mesero_viewmodel.dart';
import 'package:gestion_alimentos/viewmodels/perfil_viewmodel.dart';
import 'package:gestion_alimentos/viewmodels/reporte_viewmodel.dart';
import 'package:gestion_alimentos/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'viewmodels/empleado_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: '',
    anonKey: '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmpleadoViewModel()),
        ChangeNotifierProvider(create: (_) => MesaViewModel()),
        ChangeNotifierProvider(create: (_) => MeseroViewModel()),
        ChangeNotifierProvider(create: (_) => CajaViewModel()),
        ChangeNotifierProvider(create: (_) => CocinaViewModel()),
        ChangeNotifierProvider(create: (_) => CorredoresViewModel()),
        ChangeNotifierProvider(create: (_) => PerfilViewModel()),
        ChangeNotifierProvider(create: (_) => ReporteViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sistema de Cocina',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
