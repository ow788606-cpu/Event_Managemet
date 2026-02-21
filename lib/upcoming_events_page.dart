import 'package:flutter/material.dart';
import 'add_event_page.dart';
import 'event_details_page.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({super.key});

  @override
  State<UpcomingEventsPage> createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  final List<Map<String, dynamic>> _events = [
    {'id': 1, 'name': 'Harsh & Nidhi Wedding', 'date': '12 Jan 2024 - 15 Jan 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 16,00,000', 'manager': 'Neha Mehta', 'status': 'Upcoming'},
    {'id': 2, 'name': 'Omkar Industries AGM', 'date': '18 Feb 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Corporate', 'budget': '₹ 98,00,000', 'manager': 'Rohan Patel', 'status': 'Upcoming'},
    {'id': 3, 'name': 'Myra Shah Birthday', 'date': '22 Mar 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Birthday', 'budget': '₹ 45,00,000', 'manager': 'Jiya Suthar', 'status': 'Upcoming'},
    {'id': 4, 'name': 'Rakesh & Sunita Anniversary', 'date': '02 Apr 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Anniversary', 'budget': '₹ 29,00,000', 'manager': 'Jiya Suthar', 'status': 'Upcoming'},
    {'id': 5, 'name': 'NextWave Startup Demo Day', 'date': '08 May 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Corporate', 'budget': '₹ 8,00,000', 'manager': 'Jiya Suthar', 'status': 'Upcoming'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upcoming Events', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
            Text('View and manage upcoming events.', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddEventPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF520350),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Add New Event', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];
            return _buildEventCard(event);
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailsPage(event: event)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFE7DFE7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF520350),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      event['type'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    event['date'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    event['client'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.attach_money, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    event['budget'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF520350),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.manage_accounts, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    'Manager: ${event['manager']}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
