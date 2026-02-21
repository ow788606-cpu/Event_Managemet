import 'package:flutter/material.dart';
import 'add_event_page.dart';
import 'event_details_page.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  final List<Map<String, dynamic>> _events = [
    {
      'id': 1,
      'name': 'Harsh & Nidhi Wedding',
      'date': '12 Jan 2024 - 15 Jan 2024',
      'client': 'Rahul Patel',
      'phone': '+91 99259 91462',
      'type': 'Wedding',
      'budget': '₹ 16,00,000',
      'location': 'External',
      'guests': '300-400',
      'manager': 'Neha Mehta',
      'tag': 'Budget Sensitive'
    },
    {
      'id': 2,
      'name': 'Rohan & Neha Wedding',
      'date': '10 Feb 2024 - 12 Feb 2024',
      'client': 'Rahul Patel',
      'phone': '+91 99259 91462',
      'type': 'Award Ceremony',
      'budget': '₹ 54,00,000',
      'location': 'External',
      'guests': '100-200',
      'manager': 'Jiya Suthar',
      'tag': 'Flexible Dates'
    },
    {
      'id': 3,
      'name': 'Omkar Industries AGM',
      'date': '18 Feb 2024',
      'client': 'Rahul Patel',
      'phone': '+91 99259 91462',
      'type': 'Corporate',
      'budget': '₹ 98,00,000',
      'location': 'Destination',
      'guests': '180',
      'manager': 'Rohan Patel',
      'tag': 'High Budget'
    },
    {
      'id': 4,
      'name': 'Mehta Group Annual Meet',
      'date': '05 Mar 2024 - 06 Mar 2024',
      'client': 'Rahul Patel',
      'phone': '+91 99259 91462',
      'type': 'Corporate',
      'budget': '₹ 44,00,000',
      'location': 'Mumbai',
      'guests': '200',
      'manager': 'Jiya Suthar',
      'tag': '-'
    },
    {
      'id': 5,
      'name': 'Myra Shah Birthday',
      'date': '22 Mar 2024',
      'client': 'Rahul Patel',
      'phone': '+91 99259 91462',
      'type': 'Birthday',
      'budget': '₹ 45,00,000',
      'location': 'Ahmedabad',
      'guests': '55',
      'manager': 'Jiya Suthar',
      'tag': '-'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('All Events',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF520350),
                fontFamily: 'Inter')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text('View and manage all events in one place.',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: 'Inter')),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddEventPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF520350),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Add Event',
                        style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return _buildEventCard(event);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailsPage(
              event: event,
              onEventUpdated: (updated) {
                setState(() {
                  final index = _events.indexWhere((e) => e['id'] == updated['id']);
                  if (index != -1) {
                    _events[index] = updated;
                  }
                });
              },
            ),
          ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  const Icon(Icons.calendar_today,
                      size: 16, color: Colors.black54),
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
                  const Icon(Icons.location_on,
                      size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    event['location'],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.attach_money,
                          size: 16, color: Colors.black54),
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
                  if (event['tag'] != '-')
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.teal.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        event['tag'],
                        style: const TextStyle(
                          color: Colors.teal,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
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
