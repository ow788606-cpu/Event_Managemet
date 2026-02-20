import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseService {
  static const String baseUrl = 'http://192.168.29.159/event_api'; // For physical device
  // Use 'http://10.0.2.2/event_api' for Android emulator

  // Clients
  static Future<List<Map<String, dynamic>>> getClients() async {
    final response = await http.get(Uri.parse('$baseUrl/clients.php'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load clients');
  }

  static Future<void> addClient(Map<String, dynamic> client) async {
    await http.post(
      Uri.parse('$baseUrl/clients.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client),
    );
  }

  static Future<void> updateClient(int id, Map<String, dynamic> client) async {
    client['id'] = id;
    await http.put(
      Uri.parse('$baseUrl/clients.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client),
    );
  }

  static Future<void> deleteClient(int id) async {
    await http.delete(Uri.parse('$baseUrl/clients.php?id=$id'));
  }
}
