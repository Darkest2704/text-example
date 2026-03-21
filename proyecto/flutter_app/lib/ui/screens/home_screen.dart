import 'package:flutter/material.dart';
import 'status_screen.dart'; // Asegúrate de que el nombre del archivo sea correcto

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Agregado const y super.key para quitar warnings

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel de Control"), // Agregado const
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Agregado const
            onPressed: () {
              // Regresa al Login y limpia la pila de navegación
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Agregado const
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.blue,
              ), // Agregado const
              const SizedBox(height: 20), // Agregado const
              const Text(
                "¡Bienvenido al Sistema!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ), // Agregado const
              const SizedBox(height: 10), // Agregado const
              const Text(
                "Desde aquí puedes gestionar tu información.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ), // Agregado const
              const SizedBox(height: 40), // Agregado const
              
              // Botón solicitado en el requerimiento (v)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.edit_note), // Agregado const
                label: const Text(
                  "Gestionar User Status",
                  style: TextStyle(fontSize: 16),
                ), // Agregado const
                onPressed: () {
                  // Navegación hacia la pantalla de registro de estado
                  Navigator.pushNamed(context, '/status');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}