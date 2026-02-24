import 'dart:async';
import 'package:flutter/material.dart';
import 'add_employee_page.dart';
import 'employee_details_page.dart';
import 'services/database_service.dart';

class AllEmployeesPage extends StatefulWidget {
  const AllEmployeesPage({super.key});

  @override
  State<AllEmployeesPage> createState() => _AllEmployeesPageState();
}

class _AllEmployeesPageState extends State<AllEmployeesPage> {
  List<Map<String, dynamic>> _employees = [];
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadEmployees();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadEmployees() async {
    try {
      final employees = await DatabaseService.getEmployees();
      if (mounted) {
        setState(() {
          _employees = employees;
        });
      }
    } catch (e) {
      // Keep empty list on error
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
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text('View and manage employees.', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddEmployeePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Add Employee', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: _employees.length,
          itemBuilder: (context, index) {
            final employee = _employees[index];
            final name = employee['full_name']?.toString() ?? employee['name']?.toString() ?? '';
            final email = employee['email']?.toString() ?? '';
            final phone = employee['phone']?.toString() ?? '';
            final role = employee['role']?.toString() ?? '';
            final department = employee['department']?.toString() ?? '';
            
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
                  color: Colors.white,
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
                                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                                const SizedBox(height: 4),
                                Text(email, style: TextStyle(fontSize: 13, color: Colors.grey[700], fontFamily: 'Inter')),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getRoleColor(role),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(role, style: TextStyle(color: _getRoleTextColor(role), fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(phone, style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.business, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(department, style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Active', style: TextStyle(color: Colors.green[700], fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
          ),
        ],
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
