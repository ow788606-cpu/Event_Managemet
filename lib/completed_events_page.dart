import 'package:flutter/material.dart';

class CompletedEventsPage extends StatelessWidget {
  const CompletedEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Events'),
        backgroundColor: const Color(0xFF520350),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Completed Events Page'),
      ),
    );
  }
}
