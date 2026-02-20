import 'package:flutter/material.dart';
import 'add_employee_page.dart';
import 'edit_employee_page.dart';

class AllEmployeesPage extends StatefulWidget {
  const AllEmployeesPage({super.key});

  @override
  State<AllEmployeesPage> createState() => _AllEmployeesPageState();
}

class _AllEmployeesPageState extends State<AllEmployeesPage> {
  final List<Map<String, dynamic>> _employees = [
    {
      'id': 1,
      'name': 'Suresh Yadav',
      'email': 'suresh.yadav@gmail.com',
      'phone': '9825778899',
      'role': 'Supervisor',
      'department': 'Operations',
      'status': 'Active',
      'created': '30 Jan 2026'
    },
    {
      'id': 2,
      'name': 'Pooja Jain',
      'email': 'pooja.jain@gmail.com',
      'phone': '9909903344',
      'role': 'Accountant',
      'department': 'Client Relations',
      'status': 'Active',
      'created': '30 Jan 2026'
    },
    {
      'id': 3,
      'name': 'Amit Shah',
      'email': 'amit.shah@gmail.com',
      'phone': '9812346677',
      'role': 'Staff',
      'department': 'Logistics',
      'status': 'Active',
      'created': '30 Jan 2026'
    },
    {
      'id': 4,
      'name': 'Neha Mehta',
      'email': 'neha.mehta@gmail.com',
      'phone': '9898981122',
      'role': 'Staff',
      'department': 'Event',
      'status': 'Active',
      'created': '30 Jan 2026'
    },
    {
      'id': 5,
      'name': 'Rohan Patel',
      'email': 'rohan.patel@gmail.com',
      'phone': '9876543210',
      'role': 'Manager',
      'department': 'Operations',
      'status': 'Active',
      'created': '30 Jan 2026'
    },
    {
      'id': 6,
      'name': 'Jiya Suthar',
      'email': 'jiya@gmail.com',
      'phone': '9998887779',
      'role': 'Manager',
      'department': 'Event',
      'status': 'Active',
      'created': '30 Jan 2026'
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
              const Text('All Employees',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text('Manage your organization team members.',
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
                    MaterialPageRoute(builder: (_) => const AddEmployeePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add Employees',
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
                      label: Text('Employee',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Contact',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Role',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Department',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  DataColumn(
                      label: Text('Status',
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
                rows: _employees.map((employee) {
                  return DataRow(
                    cells: [
                      DataCell(Text(employee['id'].toString(),
                          style: const TextStyle(fontSize: 13))),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(employee['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                            Text(employee['email'],
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
                            Text(employee['phone'],
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getRoleColor(employee['role']),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            employee['role'],
                            style: TextStyle(
                              color: _getRoleTextColor(employee['role']),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(employee['department'],
                          style: const TextStyle(fontSize: 13))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            employee['status'],
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      DataCell(Text(employee['created'],
                          style: const TextStyle(fontSize: 13))),
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
                                    builder: (_) => EditEmployeePage(employee: employee),
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

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Supervisor':
        return const Color(0xFFE8D5F2);
      case 'Accountant':
        return const Color(0xFFE8D5F2);
      case 'Staff':
        return const Color(0xFFE8D5F2);
      case 'Manager':
        return const Color(0xFFE8D5F2);
      default:
        return Colors.grey[200]!;
    }
  }

  Color _getRoleTextColor(String role) {
    return const Color(0xFF520350);
  }
}
