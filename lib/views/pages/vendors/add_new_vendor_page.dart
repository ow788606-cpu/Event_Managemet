import 'package:flutter/material.dart';

class AddNewVendorPage extends StatefulWidget {
  const AddNewVendorPage({super.key});

  @override
  State<AddNewVendorPage> createState() => _AddNewVendorPageState();
}

class _AddNewVendorPageState extends State<AddNewVendorPage> {
  final _formKey = GlobalKey<FormState>();
  final _vendorNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _quoteController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedCategory;
  String _selectedStatus = 'Shortlisted';

  final List<String> _categories = [
    'Venues',
    'Wedding Planners',
    'Event Management',
    'Caterers',
    'Decorator',
    'Tent & Furniture',
    'Lighting',
    'Sound & Audio',
    'DJ',
    'Photography and Video',
    'Cinematography',
    'Mehendi Artist',
    'Makeup Artist',
    'Choreographers',
    'Transportation',
    'Fireworks',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Vendor', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              RichText(
                text: const TextSpan(
                  text: 'Category',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  hintText: 'Select an option',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category, style: const TextStyle(fontFamily: 'Inter')));
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Select Vendor',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _vendorNameController,
                decoration: InputDecoration(
                  hintText: 'Select vendor',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Contact', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Status', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedStatus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: ['Shortlisted', 'Hired'].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status, style: const TextStyle(fontFamily: 'Inter')));
                }).toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
              ),
              const SizedBox(height: 20),
              const Text('Quote Amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              const SizedBox(height: 8),
              TextFormField(
                controller: _quoteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Notes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveVendor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Add Vendor', style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 16)),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveVendor() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vendor added successfully', style: TextStyle(fontFamily: 'Inter'))),
      );
    }
  }

  @override
  void dispose() {
    _vendorNameController.dispose();
    _contactController.dispose();
    _quoteController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
