import 'package:flutter/material.dart';
import 'services_page.dart'; // Import services page

class ChecklistDesignPage extends StatefulWidget {
  const ChecklistDesignPage({super.key});

  @override
  State<ChecklistDesignPage> createState() => _ChecklistDesignPageState();
}

class _ChecklistDesignPageState extends State<ChecklistDesignPage> {
  final List<ChecklistItem> _items = [
    ChecklistItem('Venue Booking', false, 'High'),
    ChecklistItem('Catering Service', false, 'High'),
    ChecklistItem('Photography', false, 'Medium'),
    ChecklistItem('Decoration', false, 'Medium'),
    ChecklistItem('Invitations', false, 'Low'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        title: const Text('Event Checklist',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter')),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServicesPage(initialTab: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _addItem,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (context, index) => _buildChecklistCard(_items[index]),
      ),
    );
  }

  Widget _buildChecklistCard(ChecklistItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: item.isCompleted,
            onChanged: (value) {
              setState(() {
                item.isCompleted = value ?? false;
              });
            },
            activeColor: const Color(0xFF520350),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    decoration: item.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(item.priority),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.priority,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _addItem() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String priority = 'Medium';
        return AlertDialog(
          title: const Text('Add Checklist Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => title = value,
                decoration: const InputDecoration(labelText: 'Task Name'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: priority,
                items: ['High', 'Medium', 'Low']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) => priority = value ?? 'Medium',
                decoration: const InputDecoration(labelText: 'Priority'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  setState(() {
                    _items.add(ChecklistItem(title, false, priority));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class ChecklistItem {
  String title;
  bool isCompleted;
  String priority;

  ChecklistItem(this.title, this.isCompleted, this.priority);
}
