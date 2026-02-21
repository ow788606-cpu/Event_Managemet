import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;
  
  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Event Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            const SizedBox(height: 24),
            _buildDetailRow(Icons.calendar_today, 'Date', event['date']),
            _buildDetailRow(Icons.person, 'Client', event['client']),
            _buildDetailRow(Icons.phone, 'Phone', event['phone']),
            _buildDetailRow(Icons.category, 'Type', event['type']),
            _buildDetailRow(Icons.attach_money, 'Budget', event['budget']),
            if (event.containsKey('location')) _buildDetailRow(Icons.location_on, 'Location', event['location']),
            if (event.containsKey('guests')) _buildDetailRow(Icons.people, 'Expected Guests', event['guests']),
            _buildDetailRow(Icons.manage_accounts, 'Manager', event['manager']),
            if (event.containsKey('status')) _buildDetailRow(Icons.info, 'Status', event['status']),
            if (event.containsKey('tag') && event['tag'] != '-') _buildDetailRow(Icons.local_offer, 'Tag', event['tag']),
          ],
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
