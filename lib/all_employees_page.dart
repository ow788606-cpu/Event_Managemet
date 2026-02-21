import 'package:flutter/material.dart';
import 'add_employee_page.dart';
import 'employee_details_page.dart';

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
    return Scaffold(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF520350),
                      fontFamily: 'Inter')),
              Text('Manage your organization team members.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
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
                    style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: _employees.length,
          itemBuilder: (context, index) {
            final employee = _employees[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EmployeeDetailsPage(
                      employee: employee,
                      onEmployeeUpdated: (updated) {
                        setState(() {
                          final idx = _employees.indexWhere((e) => e['id'] == updated['id']);
                          if (idx != -1) {
                            _employees[idx] = updated;
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
                  color: const Color(0xFFE7DFE7),
                  borderRadius: BorderRadius.circular(20),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(employee['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                                const SizedBox(height: 4),
                                Text(employee['email'], style: TextStyle(fontSize: 13, color: Colors.grey[700], fontFamily: 'Inter')),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getRoleColor(employee['role']),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(employee['role'], style: TextStyle(color: _getRoleTextColor(employee['role']), fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(employee['phone'], style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.business, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(employee['department'], style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(employee['status'], style: TextStyle(color: Colors.green[700], fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
