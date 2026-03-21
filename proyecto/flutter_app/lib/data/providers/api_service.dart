import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class ApiService {
  // Ajusta automáticamente la IP según la plataforma para evitar errores de red
  String get baseUrl {
    if (kIsWeb) return "http://localhost:3000/api";
    if (defaultTargetPlatform == TargetPlatform.android) return "http://10.0.2.2:3000/api";
    return "http://localhost:3000/api";
  }

  // Lógica de Login (Punto a.ii)
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": "Error de conexión"};
    }
  }

  // Lógica de Registro de Estado (Punto a.iv)
  Future<bool> registerStatus(int userId, String statusText) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user-status'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_id": userId, "status_text": statusText}),
      );
      return response.statusCode == 201;
    } catch (e) {
      print("Error in registerStatus: $e");
      return false;
    }
  }

  // Lógica para Obtener el Estado Actual
  Future<String?> getStatus(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user-status/$userId'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status_text'];
      }
      return null;
    } catch (e) {
      print("Error in getStatus: $e");
      return null;
    }
  }
}