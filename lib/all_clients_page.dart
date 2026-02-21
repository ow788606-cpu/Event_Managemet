import 'package:flutter/material.dart';
import 'add_client_page.dart';
import 'client_details_page.dart';
import 'services/database_service.dart';

class AllClientsPage extends StatefulWidget {
  const AllClientsPage({super.key});

  @override
  State<AllClientsPage> createState() => _AllClientsPageState();
}

class _AllClientsPageState extends State<AllClientsPage> {
  List<Map<String, dynamic>> _clients = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final clients = await DatabaseService.getClients();
      if (!mounted) return;
      setState(() {
        _clients = clients;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to connect to server. Please check your connection.';
        // Fallback to sample data
        _clients = [
          {'id': 1, 'name': 'Rahul Patel', 'email': 'rahul@example.com', 'phone': '+91 99259 91462', 'city': 'Ahmedabad', 'state': 'Gujarat', 'created_at': '30 Jan 2026'},
          {'id': 2, 'name': 'Priya Shah', 'email': 'priya@example.com', 'phone': '+91 98765 43210', 'city': 'Mumbai', 'state': 'Maharashtra', 'created_at': '30 Jan 2026'},
        ];
      });
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
      ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF520350)))
            : Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('View and manage clients.', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AddClientPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF520350),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: const Text('Add Client', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                        ),
                      ],
                    ),
                  ),
                  if (_errorMessage != null)
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange[300]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.orange[700]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.orange[900], fontFamily: 'Inter'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: _clients.length,
                      itemBuilder: (context, index) {
                        final client = _clients[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ClientDetailsPage(
                                  client: client,
                                  onClientUpdated: (updated) {
                                    setState(() {
                                      final idx = _clients.indexWhere((c) => c['id'] == updated['id']);
                                      if (idx != -1) {
                                        _clients[idx] = updated;
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
                                  Text(client['name'] ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                                  const SizedBox(height: 4),
                                  Text(client['email'] ?? '', style: TextStyle(fontSize: 13, color: Colors.grey[700], fontFamily: 'Inter')),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 16, color: Colors.grey[700]),
                                      const SizedBox(width: 8),
                                      Text(client['phone'] ?? '', style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Inter')),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                                      const SizedBox(width: 8),
                                      Text('${client['city'] ?? ''}, ${client['state'] ?? ''}', style: TextStyle(fontSize: 14, color: Colors.grey[700], fontFamily: 'Inter')),
                                    ],
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
}
