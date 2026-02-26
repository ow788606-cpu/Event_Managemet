import 'package:flutter/material.dart';

class AddFunctionPage extends StatefulWidget {
  final String sectionTitle;
  
  const AddFunctionPage({super.key, required this.sectionTitle});

  @override
  State<AddFunctionPage> createState() => _AddFunctionPageState();
}

class _AddFunctionPageState extends State<AddFunctionPage> {
  final _formKey = GlobalKey<FormState>();
  final _functionNameController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

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
        title: const Text('Add Function', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
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
                  text: 'Function Name',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _functionNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Start Time',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _startTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: '--:--',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  suffixIcon: const Icon(Icons.access_time),
                ),
                onTap: () => _selectTime(context, _startTimeController),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'End Time',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _endTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: '--:--',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  suffixIcon: const Icon(Icons.access_time),
                ),
                onTap: () => _selectTime(context, _endTimeController),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Location',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter', color: Colors.black),
                  children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
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
                    onPressed: _saveFunction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF520350),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Add Function', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext pickerContext, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: pickerContext,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;
    final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
    final minute = picked.minute.toString().padLeft(2, '0');
    final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
    if (!mounted) return;
    controller.text = '$hour:$minute $period';
  }

  void _saveFunction() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'functionName': _functionNameController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
        'location': _locationController.text,
        'notes': _notesController.text,
      });
    }
  }

  @override
  void dispose() {
    _functionNameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
