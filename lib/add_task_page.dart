import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  final List<String> assignees;
  
  const AddTaskPage({super.key, required this.assignees});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String title = '', priority = 'Medium', addedDate = '20-Feb-2026';
  String? assignedTo, dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text('Add Task', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Title *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            const SizedBox(height: 8),
            TextField(onChanged: (value) => title = value, decoration: InputDecoration(hintText: 'e.g. Confirm catering menu', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), contentPadding: const EdgeInsets.all(12))),
            const SizedBox(height: 16),
            const Text('Description', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            const SizedBox(height: 8),
            TextField(onChanged: (value) {}, maxLines: 4, decoration: InputDecoration(hintText: 'Add task details, notes, or instructions...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), contentPadding: const EdgeInsets.all(12))),
            const SizedBox(height: 16),
            const Text('Assigned To', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final result = await showModalBottomSheet<String>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.4,
                    maxChildSize: 0.9,
                    expand: false,
                    builder: (context, scrollController) => Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(decoration: InputDecoration(hintText: 'Search...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView(
                              controller: scrollController,
                              children: widget.assignees.where((a) => a != 'All').map((assignee) => ListTile(
                                title: Text(assignee, style: const TextStyle(fontFamily: 'Inter')),
                                trailing: assignedTo == assignee ? const Text('Press to select', style: TextStyle(color: Colors.grey, fontSize: 12)) : null,
                                onTap: () => Navigator.pop(context, assignee),
                              )).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                if (result != null) setState(() => assignedTo = result);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(assignedTo ?? 'Select User', style: TextStyle(color: assignedTo == null ? Colors.grey : Colors.black, fontFamily: 'Inter')),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Priority', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(initialValue: priority, items: const ['Low', 'Medium', 'High', 'Critical'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (value) => setState(() => priority = value ?? 'Medium'), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), contentPadding: const EdgeInsets.all(12))),
            const SizedBox(height: 16),
            const Text('Due Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            const SizedBox(height: 8),
            TextField(readOnly: true, onTap: () async { final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100)); if (date != null) setState(() => dueDate = '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}'); }, decoration: InputDecoration(hintText: 'Select date', prefixIcon: const Icon(Icons.calendar_today, size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), contentPadding: const EdgeInsets.all(12))),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('Close', style: TextStyle(fontFamily: 'Inter')))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(onPressed: () { if (title.isNotEmpty) Navigator.pop(context, {'title': title, 'priority': priority, 'assignedTo': assignedTo, 'addedDate': addedDate, 'dueDate': dueDate}); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF520350), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('Add Task', style: TextStyle(fontFamily: 'Inter')))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
