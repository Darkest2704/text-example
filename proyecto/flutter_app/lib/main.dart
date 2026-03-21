import 'package:flutter/material.dart';
// Asegúrate de que las rutas de importación coincidan con tu estructura de carpetas
import 'ui/screens/login_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/status_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto SENA - Full Stack',
      
      // Tema visual de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Activa el diseño moderno de Material 3
      ),

      // Definimos la ruta inicial (Login)
      initialRoute: '/',

      // Mapa de rutas para que Navigator.pushReplacementNamed funcione
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/status': (context) => const StatusScreen(),
      },
      
      // Manejo de errores en caso de que una ruta no exista
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      },
    );
  }
}