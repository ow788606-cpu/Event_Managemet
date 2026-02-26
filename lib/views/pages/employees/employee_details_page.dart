import 'package:flutter/material.dart';
import 'edit_employee_page.dart';

class EmployeeDetailsPage extends StatefulWidget {
  final Map<String, dynamic> employee;
  final Function(Map<String, dynamic>)? onEmployeeUpdated;
  
  const EmployeeDetailsPage({super.key, required this.employee, this.onEmployeeUpdated});

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  late Map<String, dynamic> _employee;

  @override
  void initState() {
    super.initState();
    _employee = widget.employee;
  }

  @override
  Widget build(BuildContext context) {
    final name = _employee['full_name']?.toString() ?? _employee['name']?.toString() ?? '';
    final email = _employee['email']?.toString() ?? '';
    final phone = _employee['phone']?.toString() ?? '';
    final role = _employee['role']?.toString() ?? '';
    final department = _employee['department']?.toString() ?? '';
    final created = _employee['created_at']?.toString() ?? _employee['created']?.toString() ?? '';
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Employee Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF520350)),
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              
              final updatedEmployee = await navigator.push(
                MaterialPageRoute(builder: (_) => EditEmployeePage(employee: _employee)),
              );
              
              if (updatedEmployee != null && mounted) {
                setState(() {
                  _employee = updatedEmployee;
                });
                if (widget.onEmployeeUpdated != null) {
                  widget.onEmployeeUpdated!(updatedEmployee);
                }
                messenger.showSnackBar(
                  const SnackBar(content: Text('Employee updated successfully!')),
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
              Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: 24),
              _buildDetailRow(Icons.email, 'Email', email),
              _buildDetailRow(Icons.phone, 'Phone', phone),
              _buildDetailRow(Icons.work, 'Role', role),
              _buildDetailRow(Icons.business, 'Department', department),
              _buildDetailRow(Icons.info, 'Status', 'Active'),
              if (created.isNotEmpty) _buildDetailRow(Icons.calendar_today, 'Created', created),
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
