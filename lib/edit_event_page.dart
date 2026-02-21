import 'package:flutter/material.dart';

class EditEventPage extends StatefulWidget {
  final Map<String, dynamic> event;
  
  const EditEventPage({super.key, required this.event});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _clientController;
  late TextEditingController _phoneController;
  late TextEditingController _typeController;
  late TextEditingController _budgetController;
  late TextEditingController _managerController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.event['name']);
    _dateController = TextEditingController(text: widget.event['date']);
    _clientController = TextEditingController(text: widget.event['client']);
    _phoneController = TextEditingController(text: widget.event['phone']);
    _typeController = TextEditingController(text: widget.event['type']);
    _budgetController = TextEditingController(text: widget.event['budget']);
    _managerController = TextEditingController(text: widget.event['manager']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _clientController.dispose();
    _phoneController.dispose();
    _typeController.dispose();
    _budgetController.dispose();
    _managerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Edit Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Event Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Client', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _clientController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Phone', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Type', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Budget', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _budgetController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Manager', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _managerController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    final updatedEvent = Map<String, dynamic>.from(widget.event);
                    updatedEvent['name'] = _nameController.text;
                    updatedEvent['date'] = _dateController.text;
                    updatedEvent['client'] = _clientController.text;
                    updatedEvent['phone'] = _phoneController.text;
                    updatedEvent['type'] = _typeController.text;
                    updatedEvent['budget'] = _budgetController.text;
                    updatedEvent['manager'] = _managerController.text;
                    
                    Navigator.pop(context, updatedEvent);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Update Event', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
