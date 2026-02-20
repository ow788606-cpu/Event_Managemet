import 'package:flutter/material.dart';
import 'add_client_page.dart';
import 'edit_client_page.dart';
import 'services/database_service.dart';

class AllClientsPage extends StatefulWidget {
  const AllClientsPage({super.key});

  @override
  State<AllClientsPage> createState() => _AllClientsPageState();
}

class _AllClientsPageState extends State<AllClientsPage> {
  List<Map<String, dynamic>> _clients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    setState(() => _isLoading = true);
    try {
      final clients = await DatabaseService.getClients();
      setState(() {
        _clients = clients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading clients: $e')),
        );
      }
    }
  }

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
              const Text('All Clients',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF520350),
                      fontFamily: 'Inter')),
              Text('Manage your organization clients.',
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
                    MaterialPageRoute(builder: (_) => const AddClientPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add Client',
                    style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF520350)))
            : SingleChildScrollView(
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
                              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                  DataColumn(
                      label: Text('Client',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                  DataColumn(
                      label: Text('Contact',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                  DataColumn(
                      label: Text('City',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                  DataColumn(
                      label: Text('State',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                  DataColumn(
                      label: Text('Created',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                  DataColumn(
                      label: Text('Action',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                ],
                rows: _clients.map((client) {
                  return DataRow(
                    cells: [
                      DataCell(Text((client['id'] ?? '').toString(),
                          style: const TextStyle(fontSize: 13, fontFamily: 'Inter'))),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(client['name'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Inter')),
                            Text(client['email'] ?? '',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Icon(Icons.phone,
                                size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Text(client['phone'] ?? '',
                                style: const TextStyle(fontSize: 13, fontFamily: 'Inter')),
                          ],
                        ),
                      ),
                      DataCell(Text(client['city'] ?? '',
                          style: const TextStyle(fontSize: 13, fontFamily: 'Inter'))),
                      DataCell(Text(client['state'] ?? '',
                          style: const TextStyle(fontSize: 13, fontFamily: 'Inter'))),
                      DataCell(Text(client['created_at'] ?? '',
                          style: const TextStyle(fontSize: 13, fontFamily: 'Inter'))),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit,
                              size: 18, color: Color(0xFF520350)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditClientPage(client: client),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
  }
}
