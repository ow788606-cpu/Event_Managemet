import 'package:flutter/material.dart';

class HelpDeskPage extends StatelessWidget {
  const HelpDeskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Help Desk',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Inter')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF520350),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Make A Complain',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Inter')),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildContactCard('Milan Kotadiya', 'Parking Department', '+91 6351457991'),
            const SizedBox(height: 12),
            _buildContactCard('Krish Kakadiya', 'Security Department', '+91 7265874451'),
            const SizedBox(height: 12),
            _buildContactCard('Krishna Veipara', 'Hotel Department', '+91 9537070752'),
            const SizedBox(height: 12),
            _buildContactCard('Rahul Radadiya', 'Pickup &Amp; Drop Department', '+91 6352710979'),
            const SizedBox(height: 12),
            _buildContactCard('Parth Devani', 'Food Department', '+91 7567731684'),
            const SizedBox(height: 12),
            _buildContactCard('Srushti Lodaliya', 'Grooming Department', '+91 6354771644'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, String department, String phone) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE7DFE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter')),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5E6F5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(department,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF520350),
                        fontFamily: 'Inter')),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone, color: Color(0xFF520350), size: 16),
              const SizedBox(width: 4),
              Text(phone,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontFamily: 'Inter')),
            ],
          ),
        ],
      ),
    );
  }
}
