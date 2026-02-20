import 'package:flutter/material.dart';
import 'add_tag_page.dart';
import 'edit_tag_page.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  final List<Map<String, dynamic>> _tags = [
    {
      'id': 1,
      'name': 'New Client',
      'description': 'Recently added client',
      'color': const Color(0xFF3498DB),
      'colorHex': '#3498DB'
    },
    {
      'id': 2,
      'name': 'Returning Client',
      'description': 'Client with past events',
      'color': const Color(0xFF1ABC9C),
      'colorHex': '#1ABC9C'
    },
    {
      'id': 3,
      'name': 'VIP Client',
      'description': 'High value or priority client',
      'color': const Color(0xFF8E44AD),
      'colorHex': '#8E44AD'
    },
    {
      'id': 4,
      'name': 'Budget Sensitive',
      'description': 'Prefers budget-friendly options',
      'color': const Color(0xFF27AE60),
      'colorHex': '#27AE60'
    },
    {
      'id': 5,
      'name': 'Premium Client',
      'description': 'Prefers premium services',
      'color': const Color(0xFF520350),
      'colorHex': '#520350'
    },
    {
      'id': 6,
      'name': 'Wedding Client',
      'description': 'Client planning a wedding',
      'color': const Color(0xFFC0392B),
      'colorHex': '#C0392B'
    },
    {
      'id': 7,
      'name': 'Corporate Client',
      'description': 'Corporate or business client',
      'color': const Color(0xFF2C3E50),
      'colorHex': '#2C3E50'
    },
    {
      'id': 8,
      'name': 'Repeat Potential',
      'description': 'Likely to book again',
      'color': const Color(0xFF16A085),
      'colorHex': '#16A085'
    },
    {
      'id': 9,
      'name': 'Decision Pending',
      'description': 'Client yet to finalize',
      'color': const Color(0xFFF39C12),
      'colorHex': '#F39C12'
    },
    {
      'id': 10,
      'name': 'Confirmed Client',
      'description': 'Booking confirmed',
      'color': const Color(0xFF27AE60),
      'colorHex': '#27AE60'
    },
    {
      'id': 11,
      'name': 'High Budget',
      'description': 'Client with high budget expectations',
      'color': const Color(0xFF9B59B6),
      'colorHex': '#9B59B6'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('All Tags',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(
                  'Organize leads with tags for easier tracking and better reports.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddTagPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add Tag',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF5F0F5)),
                columnSpacing: 80,
                horizontalMargin: 24,
                columns: const [
                  DataColumn(
                      label: Text('#',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Tag Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Color',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Actions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                ],
                rows: _tags.map((tag) {
                  return DataRow(
                    cells: [
                      DataCell(Text(tag['id'].toString(),
                          style: const TextStyle(fontSize: 13))),
                      DataCell(Text(tag['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14))),
                      DataCell(Text(tag['description'],
                          style: const TextStyle(fontSize: 13))),
                      DataCell(
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: tag['color'],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(tag['colorHex'],
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  size: 18, color: Color(0xFF520350)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditTagPage(tag: tag),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 18, color: Colors.red),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
