import 'package:flutter/material.dart';
import 'add_tag_page.dart';
import 'tag_details_page.dart';
import 'services/database_service.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  List<Map<String, dynamic>> _tags = [];

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  Future<void> _loadTags() async {
    try {
      final tags = await DatabaseService.getTags();
      if (mounted) {
        setState(() {
          _tags = tags.map((tag) {
            final colorHex = tag['tag_class'] ?? tag['color'] ?? '#520350';
            return {
              ...tag,
              'color': Color(int.parse(colorHex.replaceFirst('#', '0xFF'))),
              'colorHex': colorHex,
            };
          }).toList();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _tags = [
            {'id': 1, 'name': 'VIP Client', 'description': 'High value client', 'color': const Color(0xFF520350), 'colorHex': '#520350'},
            {'id': 2, 'name': 'New Client', 'description': 'Recently added client', 'color': const Color(0xFF3498DB), 'colorHex': '#3498DB'},
            {'id': 3, 'name': 'Wedding', 'description': 'Wedding events', 'color': const Color(0xFFC0392B), 'colorHex': '#C0392B'},
          ];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
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
          color: Colors.white,
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
