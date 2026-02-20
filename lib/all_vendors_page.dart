import 'package:flutter/material.dart';
import 'add_vendor_page.dart';
import 'edit_vendor_page.dart';

class AllVendorsPage extends StatefulWidget {
  const AllVendorsPage({super.key});

  @override
  State<AllVendorsPage> createState() => _AllVendorsPageState();
}

class _AllVendorsPageState extends State<AllVendorsPage> {
  final _searchController = TextEditingController();
  String? _selectedCategory;

  final List<Map<String, dynamic>> _vendors = [
    {
      'id': 1,
      'name': 'Dj Jay',
      'initial': 'D',
      'category': 'DJ',
      'phone': '9988556622',
      'email': 'jay@jay.com',
      'address': '-',
      'status': 'Active'
    },
    {
      'id': 2,
      'name': 'Custom Event Services',
      'initial': 'C',
      'category': 'Other',
      'phone': '9999999999',
      'email': 'custom@gmail.com',
      'address': 'Surat',
      'status': 'Active'
    },
    {
      'id': 3,
      'name': 'Honeymoon Planners',
      'initial': 'H',
      'category': 'Honeymoon',
      'phone': '9811113344',
      'email': 'honeymoon@gmail.com',
      'address': 'Citylight',
      'status': 'Active'
    },
    {
      'id': 4,
      'name': 'Event License Helpdesk',
      'initial': 'E',
      'category': 'License & Permission',
      'phone': '9909904455',
      'email': 'eventlicense@gmail.com',
      'address': 'Nanpura',
      'status': 'Active'
    },
    {
      'id': 5,
      'name': 'Shree Ved Pandit',
      'initial': 'S',
      'category': 'Pandit / Priest',
      'phone': '9876512211',
      'email': 'vedpandit@gmail.com',
      'address': 'Athwa Lines',
      'status': 'Active'
    },
    {
      'id': 6,
      'name': 'Fresh Leaf Florist',
      'initial': 'F',
      'category': 'Florist',
      'phone': '9825776655',
      'email': 'freshleaf@gmail.com',
      'address': 'Katargam',
      'status': 'Active'
    },
    {
      'id': 7,
      'name': 'Theme Craft Studio',
      'initial': 'T',
      'category': 'Theme Setup',
      'phone': '9812347788',
      'email': 'themecraft@gmail.com',
      'address': 'Piplod',
      'status': 'Active'
    },
    {
      'id': 8,
      'name': 'Spark FX Events',
      'initial': 'S',
      'category': 'Fireworks',
      'phone': '9876609988',
      'email': 'sparkfx@gmail.com',
      'address': 'Vesu',
      'status': 'Active'
    },
    {
      'id': 9,
      'name': 'Elite Bartenders',
      'initial': 'E',
      'category': 'Bartender',
      'phone': '9898011199',
      'email': 'elitebartenders@gmail.com',
      'address': 'Citylight',
      'status': 'Active'
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
              const Text('All Vendors',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Inter')),
              Text('View and manage all vendors.',
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
                    MaterialPageRoute(builder: (_) => const AddVendorPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add Vendor',
                    style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 280,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Search',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by name, email or phone',
                              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey[400], size: 20),
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Category',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedCategory,
                            hint: const Text('All', style: TextStyle(fontSize: 13, fontFamily: 'Inter')),
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                            items: [
                              'All',
                              'DJ',
                              'Catering',
                              'Decoration',
                              'Photography',
                              'Venue'
                            ]
                                .map((category) => DropdownMenuItem(
                                    value: category, child: Text(category, style: const TextStyle(fontSize: 13, fontFamily: 'Inter'))))
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _selectedCategory = value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 19),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF520350),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Apply',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter')),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 19),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _selectedCategory = null;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          side: BorderSide(color: Colors.grey[400]!),
                        ),
                        child: Text('Reset',
                            style: TextStyle(color: Colors.grey[700], fontSize: 14, fontFamily: 'Inter')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
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
                      headingRowColor:
                          WidgetStateProperty.all(const Color(0xFFF5F0F5)),
                      columnSpacing: 40,
                      horizontalMargin: 24,
                      columns: const [
                        DataColumn(
                            label: Text('Vendor',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        DataColumn(
                            label: Text('Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        DataColumn(
                            label: Text('Phone',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        DataColumn(
                            label: Text('Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        DataColumn(
                            label: Text('Address',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        DataColumn(
                            label: Text('Status',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        DataColumn(
                            label: Text('Actions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                      ],
                      rows: _vendors.map((vendor) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor:
                                        _getAvatarColor(vendor['initial']),
                                    child: Text(
                                      vendor['initial'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(vendor['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            DataCell(Text(vendor['category'],
                                style: const TextStyle(fontSize: 13))),
                            DataCell(
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 14, color: Colors.grey[600]),
                                  const SizedBox(width: 6),
                                  Text(vendor['phone'],
                                      style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 14, color: Colors.grey[600]),
                                  const SizedBox(width: 6),
                                  Text(vendor['email'],
                                      style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  if (vendor['address'] != '-')
                                    Icon(Icons.location_on,
                                        size: 14, color: Colors.grey[600]),
                                  if (vendor['address'] != '-')
                                    const SizedBox(width: 6),
                                  Text(vendor['address'],
                                      style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  vendor['status'],
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
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
                                          builder: (_) => EditVendorPage(vendor: vendor),
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
          ],
        ),
      );
  }

  Color _getAvatarColor(String initial) {
    final colors = {
      'D': const Color(0xFFE8D5F2),
      'C': const Color(0xFFFFF4E0),
      'H': const Color(0xFFD4F4DD),
      'E': const Color(0xFFFFE4E8),
      'S': const Color(0xFFD4F1F4),
      'F': const Color(0xFFFFE8F5),
      'T': const Color(0xFFFFF8DC),
    };
    return colors[initial] ?? Colors.grey[300]!;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
