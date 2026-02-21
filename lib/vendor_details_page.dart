import 'package:flutter/material.dart';
import 'edit_vendor_page.dart';

class VendorDetailsPage extends StatefulWidget {
  final Map<String, dynamic> vendor;
  final Function(Map<String, dynamic>)? onVendorUpdated;
  
  const VendorDetailsPage({super.key, required this.vendor, this.onVendorUpdated});

  @override
  State<VendorDetailsPage> createState() => _VendorDetailsPageState();
}

class _VendorDetailsPageState extends State<VendorDetailsPage> {
  late Map<String, dynamic> _vendor;

  @override
  void initState() {
    super.initState();
    _vendor = widget.vendor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Vendor Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF520350)),
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              
              final updatedVendor = await navigator.push(
                MaterialPageRoute(builder: (_) => EditVendorPage(vendor: _vendor)),
              );
              
              if (updatedVendor != null && mounted) {
                setState(() {
                  _vendor = updatedVendor;
                });
                if (widget.onVendorUpdated != null) {
                  widget.onVendorUpdated!(updatedVendor);
                }
                messenger.showSnackBar(
                  const SnackBar(content: Text('Vendor updated successfully!')),
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
              Text(_vendor['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: 24),
              _buildDetailRow(Icons.category, 'Category', _vendor['category']),
              _buildDetailRow(Icons.phone, 'Phone', _vendor['phone']),
              _buildDetailRow(Icons.email, 'Email', _vendor['email']),
              _buildDetailRow(Icons.location_on, 'Address', _vendor['address']),
              _buildDetailRow(Icons.info, 'Status', _vendor['status']),
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
