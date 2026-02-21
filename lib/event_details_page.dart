import 'package:flutter/material.dart';
import 'edit_event_page.dart';

class EventDetailsPage extends StatefulWidget {
  final Map<String, dynamic> event;
  final Function(Map<String, dynamic>)? onEventUpdated;
  
  const EventDetailsPage({super.key, required this.event, this.onEventUpdated});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Map<String, dynamic> _event;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Event Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF520350)),
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              
              final updatedEvent = await navigator.push(
                MaterialPageRoute(builder: (_) => EditEventPage(event: _event)),
              );
              
              if (updatedEvent != null && mounted) {
                setState(() {
                  _event = updatedEvent;
                });
                if (widget.onEventUpdated != null) {
                  widget.onEventUpdated!(updatedEvent);
                }
                messenger.showSnackBar(
                  const SnackBar(content: Text('Event updated successfully!')),
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
            Text(_event['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            const SizedBox(height: 24),
            _buildDetailRow(Icons.calendar_today, 'Date', _event['date']),
            _buildDetailRow(Icons.person, 'Client', _event['client']),
            _buildDetailRow(Icons.phone, 'Phone', _event['phone']),
            _buildDetailRow(Icons.category, 'Type', _event['type']),
            _buildDetailRow(Icons.attach_money, 'Budget', _event['budget']),
            if (_event.containsKey('location')) _buildDetailRow(Icons.location_on, 'Location', _event['location']),
            if (_event.containsKey('guests')) _buildDetailRow(Icons.people, 'Expected Guests', _event['guests']),
            _buildDetailRow(Icons.manage_accounts, 'Manager', _event['manager']),
            if (_event.containsKey('status')) _buildDetailRow(Icons.info, 'Status', _event['status']),
            if (_event.containsKey('tag') && _event['tag'] != '-') _buildDetailRow(Icons.local_offer, 'Tag', _event['tag']),
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
