import 'package:flutter/material.dart';
import '../../data/providers/api_service.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  // Las variables deben ir aquí, dentro del State
  final _statusCtrl = TextEditingController();
  final _api = ApiService();
  bool _isLoading = false;
  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  void _loadStatus() async {
    String? currentStatus = await _api.getStatus(1);
    if (mounted && currentStatus != null) {
      setState(() {
        _statusCtrl.text = currentStatus;
      });
    }
    if (mounted) {
      setState(() {
        _isFetching = false;
      });
    }
  }

  void _saveStatus() async {
    // Punto a.iv.2: Validar campo requerido
    if (_statusCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("El campo es obligatorio"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Llamada a la API (Usamos el ID 1 por defecto para la prueba)
    bool ok = await _api.registerStatus(1, _statusCtrl.text);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (ok) {
      // Punto a.iv.1: Notificación de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("¡Nuevo estado de usuario registrado!"),
          backgroundColor: Colors.green,
        ),
      );
      // Removed _statusCtrl.clear() to keep the saved text visible
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al conectar con el servidor"),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Estado"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Estado Actual",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (_isFetching)
              const Center(child: CircularProgressIndicator())
            else
              TextField(
                controller: _statusCtrl,
                decoration: InputDecoration(
                  hintText: "Escribe cómo te sientes o qué haces...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                maxLines: 3,
              ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveStatus,
                icon: _isLoading 
                    ? const SizedBox(
                        width: 20, 
                        height: 20, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : const Icon(Icons.save),
                label: Text(_isLoading ? "Guardando..." : "Guardar Estado"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}