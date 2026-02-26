import 'dart:async';
import 'package:flutter/material.dart';
import 'edit_vendor_page.dart';
import 'add_new_vendor_page.dart';
import '../../../services/database_service.dart';

class VendorsPage extends StatefulWidget {
  final int eventId;
  
  const VendorsPage({super.key, required this.eventId});

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  String _selectedStatus = 'All';
  String _selectedCategory = 'All';
  List<Map<String, dynamic>> _allVendors = [];
  bool _isLoading = true;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadVendors();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadVendors();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadVendors() async {
    try {
      final vendors = await DatabaseService.getEventVendors(eventId: widget.eventId);
      if (mounted) {
        setState(() {
          _allVendors = vendors;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<Map<String, dynamic>> get _filteredVendors {
    return _allVendors.where((vendor) {
      final statusMatch = _selectedStatus == 'All' || vendor['status']?.toString() == _selectedStatus;
      final categoryMatch = _selectedCategory == 'All' || vendor['category']?.toString() == _selectedCategory;
      return statusMatch && categoryMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _showFilterDialog,
                  icon: const Icon(Icons.filter_list),
                ),
                OutlinedButton(
                  onPressed: _exportVendors,
                  child: const Text('Export Vendors', style: TextStyle(fontFamily: 'Inter', fontSize: 14)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddNewVendorPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                  ),
                  child: const Text('Add Vendor', style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 14)),
                ),
              ],
            ),
          ),
          Expanded(
            child: _allVendors.isEmpty
                ? const Center(child: Text('No vendors found', style: TextStyle(fontFamily: 'Inter')))
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: _filteredVendors.map((vendor) => _buildVendorCard(
                      vendor['vendor_name']?.toString() ?? '',
                      vendor['notes']?.toString() ?? '',
                      vendor['contact']?.toString() ?? '',
                      vendor['category']?.toString() ?? '',
                      vendor['status']?.toString() ?? '',
                      '₹${vendor['quote_amount']?.toString() ?? '0'}',
                    )).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  void _exportVendors() {
    final csvData = StringBuffer();
    csvData.writeln('Vendor Name,Description,Contact,Category,Status,Quote');
    
    for (var vendor in _filteredVendors) {
      csvData.writeln('${vendor['name']},${vendor['description']},${vendor['contact']},${vendor['category']},${vendor['status']},${vendor['quote']}');
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exported ${_filteredVendors.length} vendors to CSV', style: const TextStyle(fontFamily: 'Inter'))),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Clear All', style: TextStyle(color: Colors.red, fontFamily: 'Inter')),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: const Icon(Icons.search, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              const SizedBox(height: 20),
              const Text('STATUS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Inter')),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatusChip('All', _selectedStatus == 'All'),
                  const SizedBox(width: 8),
                  _buildStatusChip('Shortlisted', _selectedStatus == 'Shortlisted'),
                  const SizedBox(width: 8),
                  _buildStatusChip('Hired', _selectedStatus == 'Hired'),
                ],
              ),
              const SizedBox(height: 20),
              const Text('CATEGORY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Inter')),
              const SizedBox(height: 12),
              SizedBox(
                height: 300,
                child: ListView(
                  children: [
                    _buildCategoryItem('All', 19, _selectedCategory == 'All'),
                    _buildCategoryItem('Venues', 1, _selectedCategory == 'Venues'),
                    _buildCategoryItem('Wedding Planners', 1, _selectedCategory == 'Wedding Planners'),
                    _buildCategoryItem('Event Management', 1, _selectedCategory == 'Event Management'),
                    _buildCategoryItem('Caterers', 2, _selectedCategory == 'Caterers'),
                    _buildCategoryItem('Decorator', 2, _selectedCategory == 'Decorator'),
                    _buildCategoryItem('Tent & Furniture', 1, _selectedCategory == 'Tent & Furniture'),
                    _buildCategoryItem('Lighting', 2, _selectedCategory == 'Lighting'),
                    _buildCategoryItem('Sound & Audio', 1, _selectedCategory == 'Sound & Audio'),
                    _buildCategoryItem('DJ', 1, _selectedCategory == 'DJ'),
                    _buildCategoryItem('Photography and Video', 1, _selectedCategory == 'Photography and Video'),
                    _buildCategoryItem('Cinematography', 1, _selectedCategory == 'Cinematography'),
                    _buildCategoryItem('Mehendi Artist', 1, _selectedCategory == 'Mehendi Artist'),
                    _buildCategoryItem('Makeup Artist', 1, _selectedCategory == 'Makeup Artist'),
                    _buildCategoryItem('Choreographers', 1, _selectedCategory == 'Choreographers'),
                    _buildCategoryItem('Transportation', 1, _selectedCategory == 'Transportation'),
                    _buildCategoryItem('Fireworks', 1, _selectedCategory == 'Fireworks'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = label;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF520350) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF520350) : Colors.grey),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontFamily: 'Inter',
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, int count, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? const Color(0xFF520350) : Colors.black,
                fontFamily: 'Inter',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF520350) : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorCard(String name, String description, String contact, String category, String status, String quote) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (name.isNotEmpty) Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditVendorPage(
                        name: name,
                        description: description,
                        contact: contact,
                        category: category,
                        status: status,
                        quote: quote,
                      ),
                    ),
                  );
                },
              ),
              IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem('Contact', contact),
              ),
              Expanded(
                child: _buildInfoItem('Category', category),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem('Status', status, statusColor: status == 'Hired' ? Colors.blue : Colors.orange),
              ),
              Expanded(
                child: _buildInfoItem('Quote', quote),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {Color? statusColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Inter')),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: statusColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
