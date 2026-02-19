import 'package:flutter/material.dart';
import 'add_event_page.dart';

class CompletedEventsPage extends StatefulWidget {
  const CompletedEventsPage({super.key});

  @override
  State<CompletedEventsPage> createState() => _CompletedEventsPageState();
}

class _CompletedEventsPageState extends State<CompletedEventsPage> {
  String _eventTypeFilter = 'All';
  String _managerFilter = 'All';

  final List<Map<String, dynamic>> _events = [
    {'id': 1, 'name': 'Harsh & Nidhi Wedding', 'date': '12 Jan 2024 - 15 Jan 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 16,00,000', 'manager': 'Neha Mehta', 'status': 'Completed'},
    {'id': 2, 'name': 'Omkar Industries AGM', 'date': '18 Feb 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 98,00,000', 'manager': 'Rohan Patel', 'status': 'Completed'},
    {'id': 3, 'name': 'Myra Shah Birthday', 'date': '22 Mar 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 45,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 4, 'name': 'Rakesh & Sunita Anniversary', 'date': '02 Apr 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 29,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 5, 'name': 'NextWave Startup Demo Day', 'date': '08 May 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 8,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 6, 'name': 'Yash & Komal Engagement', 'date': '02 Jun 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 49,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 7, 'name': 'Aniket & Pallavi Wedding', 'date': '18 Jul 2024 - 21 Jul 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 25,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 8, 'name': 'BrightTech Sales Meet', 'date': '14 Aug 2024 - 15 Aug 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 74,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 9, 'name': 'Patel Family Reunion', 'date': '20 Sep 2024 - 21 Sep 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 98,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 10, 'name': 'Karan & Alisha Wedding', 'date': '05 Nov 2024 - 08 Nov 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 68,00,000', 'manager': 'Jiya Suthar', 'status': 'Completed'},
    {'id': 11, 'name': 'Naveen & Shradha Wedding', 'date': '06 Feb 2026 - 08 Feb 2026', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 48,00,000', 'manager': 'Jiya Suthar', 'status': 'Ongoing'},
    {'id': 12, 'name': 'RetailX Trade Expo', 'date': '05 Feb 2026 - 08 Feb 2026', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 33,00,000', 'manager': 'Jiya Suthar', 'status': 'Ongoing'},
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
              const Text('Completed Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('View and manage completed events.', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
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
                          labelText: 'Event Type',
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
                          labelText: 'Event Manager',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        items: ['All', 'Neha Mehta', 'Rohan Patel', 'Jiya Suthar'].map((manager) => DropdownMenuItem(value: manager, child: Text(manager))).toList(),
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
                          _managerFilter = 'All';
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: event['status'] == 'Completed' ? Colors.green[50] : Colors.orange[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(event['status'], style: TextStyle(color: event['status'] == 'Completed' ? Colors.green : Colors.orange, fontSize: 12, fontWeight: FontWeight.w500)),
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
