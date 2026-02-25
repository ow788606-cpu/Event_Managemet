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
        ? '$baseUrl/event_checklists.php?event_type_id=$eventId'
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

  // Event Accommodation
  static Future<List<Map<String, dynamic>>> getEventAccommodation({required int eventId}) async {
    final response = await http.get(Uri.parse('$baseUrl/event_accommodation.php?event_id=$eventId'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load event accommodation');
  }

  // Organizations - Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/organizations.php?action=login&email=$email&password=$password'),
      );
      if (response.statusCode == 200) {
        final body = response.body.trim();
        if (body.isEmpty) {
          return {'success': false, 'message': 'Empty response from server'};
        }
        try {
          return json.decode(body);
        } catch (e) {
          return {'success': false, 'message': 'Server returned invalid JSON. Check if Apache/MySQL is running.'};
        }
      }
      return {'success': false, 'message': 'Server error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': 'Cannot connect to server. Check if XAMPP is running.'};
    }
  }

  // Organizations - Register
  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/organizations.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final body = response.body.trim();
        if (body.isEmpty) {
          return {'success': false, 'message': 'Empty response from server'};
        }
        try {
          return json.decode(body);
        } catch (e) {
          return {'success': false, 'message': 'Invalid server response'};
        }
      }
      return {'success': false, 'message': 'Server error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }

  // Organizations - Get All
  static Future<List<Map<String, dynamic>>> getOrganizations() async {
    final response = await http.get(Uri.parse('$baseUrl/organizations.php'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    throw Exception('Failed to load organizations');
  }
}
