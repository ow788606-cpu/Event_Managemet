import 'package:flutter/material.dart';

class AllEventsPage extends StatelessWidget {
  const AllEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
        backgroundColor: const Color(0xFF520350),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('All Events Page'),
      ),
    );
  }
}
