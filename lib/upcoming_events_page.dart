import 'package:flutter/material.dart';
import 'add_event_page.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({super.key});

  @override
  State<UpcomingEventsPage> createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  String _eventTypeFilter = 'All';
  String _managerFilter = 'Any';

  final List<Map<String, dynamic>> _events = [
    {'id': 1, 'name': 'Harsh & Nidhi Wedding', 'date': '12 Jan 2024 - 15 Jan 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 16,00,000', 'manager': 'Neha Mehta', 'status': 'Completed'},
    {'id': 2, 'name': 'Omkar Industries AGM', 'date': '18 Feb 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 98,00,000', 'manager': 'Rohan Patel', 'status': 'Completed'},
    {'id': 3, 'name': 'Myra Shah Birthday', 'date': '22 Mar 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 45,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 4, 'name': 'Rakesh & Sunita Anniversary', 'date': '02 Apr 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 29,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 5, 'name': 'NextWave Startup Demo Day', 'date': '08 May 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 8,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Active Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('View and manage all events in one place.', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddEventPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add New Event', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Search event or client',
                          prefixIcon: const Icon(Icons.search, size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 140,
                      child: DropdownButtonFormField<String>(
                        initialValue: _eventTypeFilter,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        items: ['All', 'Wedding', 'Corporate', 'Birthday'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                        onChanged: (value) => setState(() => _eventTypeFilter = value!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 140,
                      child: DropdownButtonFormField<String>(
                        initialValue: _managerFilter,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        items: ['Any', 'Neha Mehta', 'Rohan Patel', 'Jiya Suthar'].map((manager) => DropdownMenuItem(value: manager, child: Text(manager))).toList(),
                        onChanged: (value) => setState(() => _managerFilter = value!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF520350),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                      child: const Text('Apply', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _eventTypeFilter = 'All';
                          _managerFilter = 'Any';
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.purple[50]),
                    columns: const [
                      DataColumn(label: Text('#', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Event', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Client Details', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Event Type', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Budget', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Manager', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Tags', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: _events.map((event) {
                      return DataRow(
                        cells: [
                          DataCell(Text(event['id'].toString())),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(event['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text(event['date'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(event['client']),
                                Text(event['phone'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3E5F5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(event['type'], style: const TextStyle(color: Color(0xFF8B1874), fontSize: 12, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          DataCell(Text(event['budget'], style: const TextStyle(fontWeight: FontWeight.w500))),
                          DataCell(Text(event['manager'])),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(event['status'], style: const TextStyle(color: Colors.green, fontSize: 12)),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
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
          ],
        ),
      ),
    );
  }
}
