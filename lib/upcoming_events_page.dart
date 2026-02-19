import 'package:flutter/material.dart';

class UpcomingEventsPage extends StatelessWidget {
  const UpcomingEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        backgroundColor: const Color(0xFF520350),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Upcoming Events Page'),
      ),
    );
  }
}
