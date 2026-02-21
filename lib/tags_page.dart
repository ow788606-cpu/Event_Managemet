import 'package:flutter/material.dart';
import 'add_tag_page.dart';
import 'tag_details_page.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  final List<Map<String, dynamic>> _tags = [
    {'id': 1, 'name': 'New Client', 'description': 'Recently added client', 'color': const Color(0xFF3498DB), 'colorHex': '#3498DB'},
    {'id': 2, 'name': 'Returning Client', 'description': 'Client with past events', 'color': const Color(0xFF1ABC9C), 'colorHex': '#1ABC9C'},
    {'id': 3, 'name': 'VIP Client', 'description': 'High value or priority client', 'color': const Color(0xFF8E44AD), 'colorHex': '#8E44AD'},
    {'id': 4, 'name': 'Budget Sensitive', 'description': 'Prefers budget-friendly options', 'color': const Color(0xFF27AE60), 'colorHex': '#27AE60'},
    {'id': 5, 'name': 'Premium Client', 'description': 'Prefers premium services', 'color': const Color(0xFF520350), 'colorHex': '#520350'},
    {'id': 6, 'name': 'Wedding Client', 'description': 'Client planning a wedding', 'color': const Color(0xFFC0392B), 'colorHex': '#C0392B'},
    {'id': 7, 'name': 'Corporate Client', 'description': 'Corporate or business client', 'color': const Color(0xFF2C3E50), 'colorHex': '#2C3E50'},
    {'id': 8, 'name': 'Repeat Potential', 'description': 'Likely to book again', 'color': const Color(0xFF16A085), 'colorHex': '#16A085'},
    {'id': 9, 'name': 'Decision Pending', 'description': 'Client yet to finalize', 'color': const Color(0xFFF39C12), 'colorHex': '#F39C12'},
    {'id': 10, 'name': 'Confirmed Client', 'description': 'Booking confirmed', 'color': const Color(0xFF27AE60), 'colorHex': '#27AE60'},
    {'id': 11, 'name': 'High Budget', 'description': 'Client with high budget expectations', 'color': const Color(0xFF9B59B6), 'colorHex': '#9B59B6'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('All Tags', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
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
                    child: Text('Organize leads with tags for easier tracking.', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddTagPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF520350),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Add Tag', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _tags.length,
                itemBuilder: (context, index) {
                  final tag = _tags[index];
                  return _buildTagCard(tag);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagCard(Map<String, dynamic> tag) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TagDetailsPage(
              tag: tag,
              onTagUpdated: (updated) {
                setState(() {
                  final index = _tags.indexWhere((t) => t['id'] == updated['id']);
                  if (index != -1) {
                    _tags[index] = updated;
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
                      tag['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tag['color'],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.description, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tag['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.palette, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    tag['colorHex'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF520350),
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
