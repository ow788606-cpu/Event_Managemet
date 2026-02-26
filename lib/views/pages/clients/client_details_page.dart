import 'package:flutter/material.dart';
import 'edit_client_page.dart';

class ClientDetailsPage extends StatefulWidget {
  final Map<String, dynamic> client;
  final Function(Map<String, dynamic>)? onClientUpdated;
  
  const ClientDetailsPage({super.key, required this.client, this.onClientUpdated});

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  late Map<String, dynamic> _client;

  @override
  void initState() {
    super.initState();
    _client = widget.client;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Client Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF520350)),
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              
              final updatedClient = await navigator.push(
                MaterialPageRoute(builder: (_) => EditClientPage(client: _client)),
              );
              
              if (updatedClient != null && mounted) {
                setState(() {
                  _client = updatedClient;
                });
                if (widget.onClientUpdated != null) {
                  widget.onClientUpdated!(updatedClient);
                }
                messenger.showSnackBar(
                  const SnackBar(content: Text('Client updated successfully!')),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_client['name'] ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: 24),
              _buildDetailRow(Icons.email, 'Email', _client['email'] ?? '-'),
              _buildDetailRow(Icons.phone, 'Phone', _client['phone'] ?? '-'),
              _buildDetailRow(Icons.location_city, 'City', _client['city'] ?? '-'),
              _buildDetailRow(Icons.map, 'State', _client['state'] ?? '-'),
              _buildDetailRow(Icons.calendar_today, 'Created', _client['created_at'] ?? '-'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: const Color(0xFF520350)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
