import 'package:flutter/material.dart';
import 'edit_tag_page.dart';

class TagDetailsPage extends StatefulWidget {
  final Map<String, dynamic> tag;
  final Function(Map<String, dynamic>)? onTagUpdated;
  
  const TagDetailsPage({super.key, required this.tag, this.onTagUpdated});

  @override
  State<TagDetailsPage> createState() => _TagDetailsPageState();
}

class _TagDetailsPageState extends State<TagDetailsPage> {
  late Map<String, dynamic> _tag;

  @override
  void initState() {
    super.initState();
    _tag = widget.tag;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Tag Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF520350)),
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              
              final updatedTag = await navigator.push(
                MaterialPageRoute(builder: (_) => EditTagPage(tag: _tag)),
              );
              
              if (updatedTag != null && mounted) {
                setState(() {
                  _tag = updatedTag;
                });
                if (widget.onTagUpdated != null) {
                  widget.onTagUpdated!(updatedTag);
                }
                messenger.showSnackBar(
                  const SnackBar(content: Text('Tag updated successfully!')),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_tag['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: 24),
              _buildDetailRow(Icons.description, 'Description', _tag['description']),
              _buildDetailRow(Icons.palette, 'Color Code', _tag['colorHex']),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.color_lens, size: 24, color: Color(0xFF520350)),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Color Preview', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _tag['color'],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: const Color(0xFF520350)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
