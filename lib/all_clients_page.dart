import 'package:flutter/material.dart';
import 'add_client_page.dart';

class AllClientsPage extends StatefulWidget {
  const AllClientsPage({super.key});

  @override
  State<AllClientsPage> createState() => _AllClientsPageState();
}

class _AllClientsPageState extends State<AllClientsPage> {
  final List<Map<String, dynamic>> _clients = [
    {
      'id': 1,
      'name': 'Rahul Patel',
      'email': 'rahulpatel005@gmail.com',
      'phone': '9925991462',
      'city': 'Ahmedabad',
      'state': 'Gujarat',
      'created': '30 Jan 2026'
    },
    {
      'id': 2,
      'name': 'Priya Shah',
      'email': 'priyashah@gmail.com',
      'phone': '9876543210',
      'city': 'Mumbai',
      'state': 'Maharashtra',
      'created': '15 Feb 2026'
    },
    {
      'id': 3,
      'name': 'Amit Kumar',
      'email': 'amitkumar@gmail.com',
      'phone': '9988776655',
      'city': 'Delhi',
      'state': 'Delhi',
      'created': '20 Feb 2026'
    },
    {
      'id': 4,
      'name': 'Neha Mehta',
      'email': 'nehamehta@gmail.com',
      'phone': '9123456789',
      'city': 'Pune',
      'state': 'Maharashtra',
      'created': '25 Feb 2026'
    },
    {
      'id': 5,
      'name': 'Rohan Desai',
      'email': 'rohandesai@gmail.com',
      'phone': '9898989898',
      'city': 'Surat',
      'state': 'Gujarat',
      'created': '01 Mar 2026'
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
              const Text('All Clients',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text('Manage your organization clients.',
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
                    MaterialPageRoute(builder: (_) => const AddClientPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add Client',
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
                headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
                columnSpacing: 60,
                horizontalMargin: 24,
                columns: const [
                  DataColumn(
                      label: Text('#',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Client',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Contact',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('City',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('State',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Created',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Action',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                ],
                rows: _clients.map((client) {
                  return DataRow(
                    cells: [
                      DataCell(Text(client['id'].toString(),
                          style: const TextStyle(fontSize: 13))),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(client['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                            Text(client['email'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Icon(Icons.phone,
                                size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Text(client['phone'],
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      DataCell(Text(client['city'],
                          style: const TextStyle(fontSize: 13))),
                      DataCell(Text(client['state'],
                          style: const TextStyle(fontSize: 13))),
                      DataCell(Text(client['created'],
                          style: const TextStyle(fontSize: 13))),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit,
                              size: 18, color: Color(0xFF520350)),
                          onPressed: () {},
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
