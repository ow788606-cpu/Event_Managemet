import 'package:flutter/material.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
        backgroundColor: const Color(0xFF520350),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Add Event Page'),
      ),
    );
  }
}
