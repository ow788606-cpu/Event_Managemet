import 'package:flutter/material.dart';
import 'add_event_page.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  final List<Map<String, dynamic>> _events = [
    {'id': 1, 'name': 'Harsh & Nidhi Wedding', 'date': '12 Jan 2024 - 15 Jan 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 16,00,000', 'location': 'External', 'guests': '300-400', 'manager': 'Neha Mehta', 'tag': 'Budget Sensitive', 'tagColor': Colors.teal},
    {'id': 2, 'name': 'Rohan & Neha Wedding', 'date': '10 Feb 2024 - 12 Feb 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Award Ceremony', 'budget': '₹ 54,00,000', 'location': 'External', 'guests': '100-200', 'manager': 'Jiya Suthar', 'tag': 'Flexible Dates', 'tagColor': Colors.teal},
    {'id': 3, 'name': 'Omkar Industries AGM', 'date': '18 Feb 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 98,00,000', 'location': 'Destination', 'guests': '180', 'manager': 'Rohan Patel', 'tag': 'High Budget', 'tagColor': Colors.purple},
    {'id': 4, 'name': 'Mehta Group Annual Meet', 'date': '05 Mar 2024 - 06 Mar 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 44,00,000', 'location': 'Mumbai', 'guests': '200', 'manager': 'Jiya Suthar', 'tag': '-', 'tagColor': Colors.grey},
    {'id': 5, 'name': 'Myra Shah Birthday', 'date': '22 Mar 2024', 'client': 'Rahul Patel', 'phone': '+91 99259 91462', 'type': 'Wedding', 'budget': '₹ 45,00,000', 'location': 'Ahmedabad', 'guests': '55', 'manager': 'Jiya Suthar', 'tag': '-', 'tagColor': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('All Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Inter')),
            Text('View and manage all events in one place.', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, size: 18),
                    label: const Text('Filter', style: TextStyle(fontFamily: 'Inter')),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
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
                    child: const Text('Add New Event', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
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
                    DataColumn(label: Text('Location', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Exp Guest', style: TextStyle(fontWeight: FontWeight.bold))),
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
                        DataCell(Text(event['location'])),
                        DataCell(Text(event['guests'])),
                        DataCell(Text(event['manager'])),
                        DataCell(
                          event['tag'] != '-'
                              ? Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: event['tagColor'].withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(event['tag'], style: TextStyle(color: event['tagColor'], fontSize: 12, fontWeight: FontWeight.w500)),
                                )
                              : const Text('-'),
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
    );
  }
}
