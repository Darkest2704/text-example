import 'package:flutter/material.dart';
import '../../data/providers/api_service.dart'; // Verifica que esta ruta sea exacta

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _api = ApiService();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  void _handleLogin() async {
    // Validar que no estén vacíos antes de llamar a la API
    if (_emailCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor llena todos los campos")),
      );
      return;
    }

    final res = await _api.login(_emailCtrl.text, _passCtrl.text);

    if (!mounted) return;

    if (res['success'] == true) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res['message'] ?? "Datos incorrectos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login SENA")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _handleLogin, child: const Text("Entrar")),
          ],
        ),
      ),
    );
  }
}