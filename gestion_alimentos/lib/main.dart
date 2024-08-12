import 'package:flutter/material.dart';
import 'package:gestion_alimentos/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'viewmodels/empleado_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fpzdxobcjjdrkxshvrqu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwemR4b2Jjampkcmt4c2h2cnF1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM0MTk2MzEsImV4cCI6MjAzODk5NTYzMX0.Pc1oxCJWFkAFeTqAeRLqNGrSn4FwK1tlavrlfbWCJGU',
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sistema de Cocina',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
