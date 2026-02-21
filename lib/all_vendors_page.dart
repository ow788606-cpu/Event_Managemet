import 'package:flutter/material.dart';
import 'add_vendor_page.dart';
import 'vendor_details_page.dart';

class AllVendorsPage extends StatefulWidget {
  const AllVendorsPage({super.key});

  @override
  State<AllVendorsPage> createState() => _AllVendorsPageState();
}

class _AllVendorsPageState extends State<AllVendorsPage> {
  final List<Map<String, dynamic>> _vendors = [
    {'id': 1, 'name': 'Dj Jay', 'initial': 'D', 'category': 'DJ', 'phone': '9988556622', 'email': 'jay@jay.com', 'address': '-', 'status': 'Active'},
    {'id': 2, 'name': 'Custom Event Services', 'initial': 'C', 'category': 'Other', 'phone': '9999999999', 'email': 'custom@gmail.com', 'address': 'Surat', 'status': 'Active'},
    {'id': 3, 'name': 'Honeymoon Planners', 'initial': 'H', 'category': 'Honeymoon', 'phone': '9811113344', 'email': 'honeymoon@gmail.com', 'address': 'Citylight', 'status': 'Active'},
    {'id': 4, 'name': 'Event License Helpdesk', 'initial': 'E', 'category': 'License & Permission', 'phone': '9909904455', 'email': 'eventlicense@gmail.com', 'address': 'Nanpura', 'status': 'Active'},
    {'id': 5, 'name': 'Shree Ved Pandit', 'initial': 'S', 'category': 'Pandit / Priest', 'phone': '9876512211', 'email': 'vedpandit@gmail.com', 'address': 'Athwa Lines', 'status': 'Active'},
    {'id': 6, 'name': 'Fresh Leaf Florist', 'initial': 'F', 'category': 'Florist', 'phone': '9825776655', 'email': 'freshleaf@gmail.com', 'address': 'Katargam', 'status': 'Active'},
    {'id': 7, 'name': 'Theme Craft Studio', 'initial': 'T', 'category': 'Theme Setup', 'phone': '9812347788', 'email': 'themecraft@gmail.com', 'address': 'Piplod', 'status': 'Active'},
    {'id': 8, 'name': 'Spark FX Events', 'initial': 'S', 'category': 'Fireworks', 'phone': '9876609988', 'email': 'sparkfx@gmail.com', 'address': 'Vesu', 'status': 'Active'},
    {'id': 9, 'name': 'Elite Bartenders', 'initial': 'E', 'category': 'Bartender', 'phone': '9898011199', 'email': 'elitebartenders@gmail.com', 'address': 'Citylight', 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('All Vendors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text('View and manage all vendors.', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddVendorPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF520350),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Add Vendor', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _vendors.length,
                itemBuilder: (context, index) {
                  final vendor = _vendors[index];
                  return _buildVendorCard(vendor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorCard(Map<String, dynamic> vendor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VendorDetailsPage(
              vendor: vendor,
              onVendorUpdated: (updated) {
                setState(() {
                  final index = _vendors.indexWhere((v) => v['id'] == updated['id']);
                  if (index != -1) {
                    _vendors[index] = updated;
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
          borderRadius: BorderRadius.circular(16),
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
                    child: Text(
                      vendor['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF520350),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      vendor['category'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    vendor['phone'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.email, size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      vendor['email'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
              if (vendor['address'] != '-') ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.black54),
                    const SizedBox(width: 8),
                    Text(
                      vendor['address'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      vendor['status'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
