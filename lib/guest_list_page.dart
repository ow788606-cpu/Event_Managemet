import 'dart:async';
import 'package:flutter/material.dart';
import 'edit_guest_page.dart';
import 'add_guest_page.dart';
import 'services/database_service.dart';

class GuestListPage extends StatefulWidget {
  const GuestListPage({super.key});

  @override
  State<GuestListPage> createState() => _GuestListPageState();
}

class _GuestListPageState extends State<GuestListPage> {
  List<Map<String, dynamic>> _guests = [];
  bool _isLoading = true;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadGuests();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadGuests();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadGuests() async {
    try {
      final guests = await DatabaseService.getEventAttendees();
      if (mounted) {
        setState(() {
          _guests = guests;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      body: Column(
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
                  onPressed: _exportGuestList,
                  child: const Text('Export List', style: TextStyle(fontFamily: 'Inter', fontSize: 14)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddGuestPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                  ),
                  child: const Text('Add Guest', style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 14)),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _guests.isEmpty
                    ? const Center(child: Text('No guests found', style: TextStyle(fontFamily: 'Inter')))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _guests.length,
                        itemBuilder: (context, index) {
                          final guest = _guests[index];
                          return _buildGuestCard(
                            guest['full_name']?.toString() ?? '',
                            guest['phone']?.toString() ?? '',
                            guest['email']?.toString() ?? '',
                            guest['gender']?.toString() ?? '',
                            guest['age']?.toString() ?? '',
                            guest['food_preference']?.toString() ?? '',
                            guest['arrival_datetime']?.toString() ?? '',
                            guest['departure_datetime']?.toString() ?? '',
                            guest['is_vip']?.toString() == '1',
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _exportGuestList() {
    final csvData = StringBuffer();
    csvData.writeln('Name,Phone,Email,Gender,Age,Food,Arrival,Departure,VIP');
    
    csvData.writeln('Guest 01,+91 90000 00001,guest01@test.com,Male,28,Veg,A: Feb 3 08:00 AM,D: Feb 6 10:00 AM,No');
    csvData.writeln('Guest 02,+91 90000 00002,guest02@test.com,Female,31,Non-Veg,A: Feb 3 10:00 AM,D: Feb 6 10:00 AM,Yes');
    csvData.writeln('Guest 03,+91 90000 00003,guest03@test.com,Male,40,Veg,A: Feb 4 08:00 AM,D: Feb 7 09:00 AM,No');
    csvData.writeln('Guest 04,+91 90000 00004,guest04@test.com,Female,35,Jain,A: Feb 4 09:00 AM,D: Feb 6 11:00 AM,No');
    csvData.writeln('Guest 05,+91 90000 00005,guest05@test.com,Male,65,Veg,A: Feb 5 07:30 AM,D: Feb 7 10:00 AM,No');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Guest list exported to CSV', style: TextStyle(fontFamily: 'Inter'))),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        bool foodExpanded = false;
        bool vipExpanded = false;
        bool genderExpanded = false;
        bool ageExpanded = false;
        bool otherExpanded = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
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
                          hintText: 'Search by name or phone...',
                          suffixIcon: const Icon(Icons.search, size: 20),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildExpandableSection('FOOD PREFERENCE', ['Veg', 'Non-Veg', 'Jain'], foodExpanded, (val) => setDialogState(() => foodExpanded = val)),
                      const SizedBox(height: 16),
                      _buildExpandableSection('VIP', ['VIP', 'Non-VIP'], vipExpanded, (val) => setDialogState(() => vipExpanded = val)),
                      const SizedBox(height: 16),
                      _buildExpandableSection('GENDER', ['Male', 'Female', 'Other'], genderExpanded, (val) => setDialogState(() => genderExpanded = val)),
                      const SizedBox(height: 16),
                      _buildExpandableSection('AGE GROUP', ['1-15', '15-25', '25-40', '40-60', '60+'], ageExpanded, (val) => setDialogState(() => ageExpanded = val)),
                      const SizedBox(height: 16),
                      _buildExpandableSection('OTHER', ['Wheelchair Required', 'Travel Required', 'Accommodation Required'], otherExpanded, (val) => setDialogState(() => otherExpanded = val)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildExpandableSection(String title, List<String> options, bool isExpanded, Function(bool) onExpand) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onExpand(!isExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Inter')),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...options.map((option) => Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(option, style: const TextStyle(fontSize: 14, fontFamily: 'Inter', color: Color(0xFF520350))),
          )).toList(),
      ],
    );
  }

  Widget _buildGuestCard(String name, String phone, String email, String gender, String age, String food, String arrival, String departure, bool isVIP) {
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
                child: Row(
                  children: [
                    Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter', color: Color(0xFF520350))),
                    if (isVIP) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFF520350)),
                        ),
                        child: const Text('VIP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
                      ),
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
                      builder: (context) => EditGuestPage(
                        name: name,
                        phone: phone,
                        email: email,
                        gender: gender,
                        age: age,
                        food: food,
                        arrival: arrival,
                        departure: departure,
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
              Expanded(child: _buildInfoItem('Phone', phone)),
              Expanded(child: _buildInfoItem('Email', email)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildInfoItem('Gender', gender, textColor: gender == 'Male' ? Colors.blue : Colors.pink)),
              Expanded(child: _buildInfoItem('Age', age)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildInfoItem('Food', food, textColor: food == 'Veg' ? Colors.green : food == 'Non-Veg' ? Colors.red : Colors.orange)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Arrival Info', style: TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter')),
                    const SizedBox(height: 2),
                    Text(arrival, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                    Text(departure, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {Color? textColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter')),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: textColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
