import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  String _foodPreference = 'Veg';
  bool _alcoholServed = true;
  final _clientController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _budgetController = TextEditingController();
  final _guestsController = TextEditingController();
  final _tagsController = TextEditingController();
  final _managerController = TextEditingController();
  String? _eventType;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _clientController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _budgetController.dispose();
    _guestsController.dispose();
    _tagsController.dispose();
    _managerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
            Text('Create a new event.', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF520350),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('All Events', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              _buildLabel('Client', required: true),
              const SizedBox(height: 8),
              _buildTextField(_clientController, 'Select or Add New', Icons.arrow_drop_down, required: true),
              const SizedBox(height: 20),
              _buildLabel('Event Title', required: true),
              const SizedBox(height: 8),
              _buildTextField(_titleController, 'Event title', Icons.event, required: true),
              const SizedBox(height: 20),
              _buildLabel('Event Type', required: true),
              const SizedBox(height: 8),
              _buildDropdown(),
              const SizedBox(height: 20),
              _buildLabel('Event Description'),
              const SizedBox(height: 8),
              _buildTextField(_descriptionController, 'Brief event description', null, maxLines: 4),
              const SizedBox(height: 20),
              _buildLabel('Start Date', required: true),
              const SizedBox(height: 8),
              _buildDateField('Select date', true),
              const SizedBox(height: 20),
              _buildLabel('End Date', required: true),
              const SizedBox(height: 8),
              _buildDateField('Select date', false),
              const SizedBox(height: 20),
              _buildLabel('Client Budget'),
              const SizedBox(height: 8),
              _buildTextField(_budgetController, 'Estimated budget', Icons.attach_money),
              const SizedBox(height: 20),
              _buildLabel('Event Location'),
              const SizedBox(height: 8),
              _buildTextField(_locationController, 'Select Location', Icons.location_on),
              const SizedBox(height: 20),
              _buildLabel('Expected Guests'),
              const SizedBox(height: 8),
              _buildTextField(_guestsController, 'Approx guest count', Icons.people),
              const SizedBox(height: 20),
              _buildLabel('Food Preference'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                children: [
                  _buildRadio('Veg'),
                  _buildRadio('Non-Veg'),
                  _buildRadio('Jain'),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel('Alcohol Served'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                children: [
                  _buildAlcoholRadio('Yes', true),
                  _buildAlcoholRadio('No', false),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel('Tags'),
              const SizedBox(height: 8),
              _buildTextField(_tagsController, 'Add tags...', null),
              const SizedBox(height: 20),
              _buildLabel('Event Manager'),
              const SizedBox(height: 8),
              _buildTextField(_managerController, 'Event Manager', Icons.arrow_drop_down),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_startDate == null || _endDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select start and end dates')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Event Created Successfully!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF520350),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Create Event', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter')),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildLabel(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: 'Inter'),
        children: required
            ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))]
            : [],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData? icon, {int maxLines = 1, bool required = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: required ? (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      } : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey[600], size: 20) : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _eventType,
      hint: Text('Event Type', style: TextStyle(color: Colors.grey[400])),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select event type';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: ['Wedding', 'Corporate', 'Birthday', 'Conference']
          .map((type) => DropdownMenuItem(value: type, child: Text(type, style: const TextStyle(fontFamily: 'Inter'))))
          .toList(),
      onChanged: (value) => setState(() => _eventType = value),
    );
  }

  Widget _buildDateField(String hint, bool isStart) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (date != null) {
          setState(() => isStart ? _startDate = date : _endDate = date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          errorText: (isStart && _startDate == null) || (!isStart && _endDate == null) ? null : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          prefixIcon: Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
        ),
        child: Text(
          (isStart ? _startDate : _endDate)?.toString().split(' ')[0] ?? hint,
          style: TextStyle(color: (isStart ? _startDate : _endDate) == null ? Colors.grey[400] : Colors.black, fontFamily: 'Inter'),
        ),
      ),
    );
  }

  Widget _buildRadio(String value) {
    return InkWell(
      onTap: () => setState(() => _foodPreference = value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _foodPreference == value ? const Color(0xFF520350) : Colors.grey,
                width: 2,
              ),
            ),
            child: _foodPreference == value
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF520350),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAlcoholRadio(String label, bool value) {
    return InkWell(
      onTap: () => setState(() => _alcoholServed = value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _alcoholServed == value ? const Color(0xFF520350) : Colors.grey,
                width: 2,
              ),
            ),
            child: _alcoholServed == value
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF520350),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14, fontFamily: 'Inter')),
        ],
      ),
    );
  }
}
