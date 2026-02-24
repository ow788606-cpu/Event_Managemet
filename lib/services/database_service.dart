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

  // Event Functions
  static Future<List<Map<String, dynamic>>> getEventFunctions({int? eventId}) async {
    final url = eventId != null 
        ? '$baseUrl/event_functions.php?event_id=$eventId'
        : '$baseUrl/event_functions.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load event functions');
  }

  // Tags
  static Future<List<Map<String, dynamic>>> getTags() async {
    final response = await http.get(Uri.parse('$baseUrl/tags.php'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load tags');
  }

  // Vendors
  static Future<List<Map<String, dynamic>>> getVendors() async {
    final response = await http.get(Uri.parse('$baseUrl/vendors.php'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load vendors');
  }

  // Employees
  static Future<List<Map<String, dynamic>>> getEmployees() async {
    final response = await http.get(Uri.parse('$baseUrl/employees.php'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load employees');
  }

  // Events
  static Future<List<Map<String, dynamic>>> getEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events.php'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load events');
  }

  // Event Days
  static Future<List<Map<String, dynamic>>> getEventDays({int? eventId}) async {
    final url = eventId != null 
        ? '$baseUrl/event_days.php?event_id=$eventId'
        : '$baseUrl/event_days.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load event days');
  }

  // Event Checklists
  static Future<List<Map<String, dynamic>>> getEventChecklists({int? eventId}) async {
    final url = eventId != null 
        ? '$baseUrl/event_checklists.php?event_id=$eventId'
        : '$baseUrl/event_checklists.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load event checklists');
  }

  // Event Vendors
  static Future<List<Map<String, dynamic>>> getEventVendors({int? eventId}) async {
    final url = eventId != null 
        ? '$baseUrl/event_vendors.php?event_id=$eventId'
        : '$baseUrl/event_vendors.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load event vendors');
  }

  // Event Attendees
  static Future<List<Map<String, dynamic>>> getEventAttendees({int? eventId}) async {
    final url = eventId != null 
        ? '$baseUrl/event_attendees.php?event_id=$eventId'
        : '$baseUrl/event_attendees.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load event attendees');
  }
}
