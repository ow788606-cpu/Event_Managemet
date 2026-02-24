import 'package:flutter/material.dart';

class EditVendorPage extends StatefulWidget {
  final String? name;
  final String? description;
  final String? contact;
  final String? category;
  final String? status;
  final String? quote;

  const EditVendorPage({
    super.key,
    this.name,
    this.description,
    this.contact,
    this.category,
    this.status,
    this.quote,
  });

  @override
  State<EditVendorPage> createState() => _EditVendorPageState();
}

class _EditVendorPageState extends State<EditVendorPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _contactController;
  late TextEditingController _categoryController;
  late TextEditingController _quoteController;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name ?? '');
    _descriptionController = TextEditingController(text: widget.description ?? '');
    _contactController = TextEditingController(text: widget.contact ?? '');
    _categoryController = TextEditingController(text: widget.category ?? '');
    _quoteController = TextEditingController(text: widget.quote ?? '');
    _selectedStatus = widget.status ?? 'Active';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Vendor', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Vendor Name',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Description', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Contact',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Category',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Status',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedStatus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: ['Hired', 'Shortlisted', 'Active', 'Inactive'].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status, style: const TextStyle(fontFamily: 'Inter')));
                }).toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Quote',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _quoteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text('Close', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _saveVendor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF520350),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Update Vendor', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveVendor() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vendor updated successfully', style: TextStyle(fontFamily: 'Inter'))),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    _categoryController.dispose();
    _quoteController.dispose();
    super.dispose();
  }
}
