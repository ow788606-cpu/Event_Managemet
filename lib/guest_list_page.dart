import 'package:flutter/material.dart';
import 'edit_guest_page.dart';
import 'add_guest_page.dart';

class GuestListPage extends StatefulWidget {
  const GuestListPage({super.key});

  @override
  State<GuestListPage> createState() => _GuestListPageState();
}

class _GuestListPageState extends State<GuestListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildGuestCard('Guest 01', '+91 90000 00001', 'guest01@test.com', 'Male', '28', 'Veg', 'A: Feb 3, 08:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 02', '+91 90000 00002', 'guest02@test.com', 'Female', '31', 'Non-Veg', 'A: Feb 3, 10:00 AM', 'D: Feb 6, 10:00 AM', true),
                _buildGuestCard('Guest 03', '+91 90000 00003', 'guest03@test.com', 'Male', '40', 'Veg', 'A: Feb 4, 08:00 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 04', '+91 90000 00004', 'guest04@test.com', 'Female', '35', 'Jain', 'A: Feb 4, 09:00 AM', 'D: Feb 6, 11:00 AM', false),
                _buildGuestCard('Guest 05', '+91 90000 00005', 'guest05@test.com', 'Male', '65', 'Veg', 'A: Feb 5, 07:30 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 06', '+91 90000 00006', 'guest06@test.com', 'Male', '18', 'Non-Veg', 'A: Feb 3, 11:00 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 07', '+91 90000 00007', 'guest07@test.com', 'Male', '66', 'Veg', 'A: Feb 4, 09:30 AM', 'D: Feb 6, 12:00 PM', true),
                _buildGuestCard('Guest 08', '+91 90000 00008', 'guest08@test.com', 'Female', '33', 'Jain', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 09', '+91 90000 00009', 'guest09@test.com', 'Male', '38', 'Veg', 'A: Feb 3, 07:00 AM', 'D: Feb 6, 09:30 AM', false),
                _buildGuestCard('Guest 10', '+91 90000 00010', 'guest10@test.com', 'Female', '27', 'Non-Veg', 'A: Feb 4, 08:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 101', '+91 90000 00101', 'guest101@test.com', 'Male', '34', 'Veg', 'A: Feb 3, 09:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 102', '+91 90000 00102', 'guest102@test.com', 'Female', '29', 'Non-Veg', 'A: Feb 3, 10:00 AM', 'D: Feb 6, 11:00 AM', true),
                _buildGuestCard('Guest 103', '+91 90000 00103', 'guest103@test.com', 'Male', '41', 'Veg', 'A: Feb 4, 08:30 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 104', '+91 90000 00104', 'guest104@test.com', 'Female', '36', 'Jain', 'A: Feb 4, 09:30 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 105', '+91 90000 00105', 'guest105@test.com', 'Male', '52', 'Veg', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 106', '+91 90000 00106', 'guest106@test.com', 'Female', '27', 'Non-Veg', 'A: Feb 3, 11:00 AM', 'D: Feb 6, 09:00 AM', false),
                _buildGuestCard('Guest 107', '+91 90000 00107', 'guest107@test.com', 'Male', '39', 'Veg', 'A: Feb 4, 10:00 AM', 'D: Feb 6, 10:00 AM', true),
                _buildGuestCard('Guest 108', '+91 90000 00108', 'guest108@test.com', 'Female', '31', 'Jain', 'A: Feb 5, 09:00 AM', 'D: Feb 7, 11:00 AM', false),
                _buildGuestCard('Guest 109', '+91 90000 00109', 'guest109@test.com', 'Male', '45', 'Veg', 'A: Feb 3, 08:00 AM', 'D: Feb 6, 09:30 AM', false),
                _buildGuestCard('Guest 11', '+91 90000 00011', 'guest11@test.com', 'Male', '34', 'Veg', 'A: Feb 3, 09:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 110', '+91 90000 00110', 'guest110@test.com', 'Female', '28', 'Non-Veg', 'A: Feb 4, 09:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 111', '+91 90000 00111', 'guest111@test.com', 'Male', '33', 'Veg', 'A: Feb 3, 08:00 AM', 'D: Feb 6, 09:00 AM', false),
                _buildGuestCard('Guest 112', '+91 90000 00112', 'guest112@test.com', 'Female', '35', 'Non-Veg', 'A: Feb 4, 08:00 AM', 'D: Feb 6, 12:00 PM', true),
                _buildGuestCard('Guest 113', '+91 90000 00113', 'guest113@test.com', 'Male', '47', 'Veg', 'A: Feb 5, 07:30 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 114', '+91 90000 00114', 'guest114@test.com', 'Female', '30', 'Jain', 'A: Feb 3, 10:00 AM', 'D: Feb 6, 11:00 AM', false),
                _buildGuestCard('Guest 115', '+91 90000 00115', 'guest115@test.com', 'Male', '54', 'Veg', 'A: Feb 4, 09:30 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 116', '+91 90000 00116', 'guest116@test.com', 'Female', '26', 'Non-Veg', 'A: Feb 5, 08:30 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 117', '+91 90000 00117', 'guest117@test.com', 'Male', '38', 'Veg', 'A: Feb 4, 08:00 AM', 'D: Feb 6, 09:00 AM', false),
                _buildGuestCard('Guest 118', '+91 90000 00118', 'guest118@test.com', 'Female', '32', 'Jain', 'A: Feb 4, 09:00 AM', 'D: Feb 7, 11:00 AM', true),
                _buildGuestCard('Guest 119', '+91 90000 00119', 'guest119@test.com', 'Male', '44', 'Veg', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 12', '+91 90000 00012', 'guest12@test.com', 'Male', '15', 'Non-Veg', 'A: Feb 4, 09:30 AM', 'D: Feb 7, 11:00 AM', true),
                _buildGuestCard('Guest 120', '+91 90000 00120', 'guest120@test.com', 'Female', '29', 'Non-Veg', 'A: Feb 3, 09:30 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 121', '+91 90000 00121', 'guest121@test.com', 'Male', '36', 'Veg', 'A: Feb 3, 09:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 122', '+91 90000 00122', 'guest122@test.com', 'Female', '28', 'Non-Veg', 'A: Feb 4, 09:30 AM', 'D: Feb 6, 10:00 AM', true),
                _buildGuestCard('Guest 123', '+91 90000 00123', 'guest123@test.com', 'Male', '42', 'Veg', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 124', '+91 90000 00124', 'guest124@test.com', 'Female', '34', 'Jain', 'A: Feb 3, 10:30 AM', 'D: Feb 6, 11:00 AM', false),
                _buildGuestCard('Guest 125', '+91 90000 00125', 'guest125@test.com', 'Male', '50', 'Veg', 'A: Feb 4, 09:30 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 126', '+91 90000 00126', 'guest126@test.com', 'Female', '27', 'Non-Veg', 'A: Feb 5, 09:00 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 127', '+91 90000 00127', 'guest127@test.com', 'Male', '39', 'Veg', 'A: Feb 3, 08:00 AM', 'D: Feb 6, 09:00 AM', false),
                _buildGuestCard('Guest 128', '+91 90000 00128', 'guest128@test.com', 'Female', '31', 'Jain', 'A: Feb 4, 09:00 AM', 'D: Feb 7, 11:00 AM', true),
                _buildGuestCard('Guest 129', '+91 90000 00129', 'guest129@test.com', 'Male', '45', 'Veg', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 13', '+91 90000 00013', 'guest13@test.com', 'Male', '42', 'Veg', 'A: Feb 5, 07:00 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 130', '+91 90000 00130', 'guest130@test.com', 'Female', '29', 'Non-Veg', 'A: Feb 3, 09:30 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 131', '+91 90000 00131', 'guest131@test.com', 'Male', '37', 'Veg', 'A: Feb 3, 09:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 132', '+91 90000 00132', 'guest132@test.com', 'Female', '33', 'Non-Veg', 'A: Feb 4, 08:30 AM', 'D: Feb 7, 10:00 AM', true),
                _buildGuestCard('Guest 133', '+91 90000 00133', 'guest133@test.com', 'Male', '48', 'Veg', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 134', '+91 90000 00134', 'guest134@test.com', 'Female', '30', 'Jain', 'A: Feb 3, 10:00 AM', 'D: Feb 6, 11:00 AM', false),
                _buildGuestCard('Guest 135', '+91 90000 00135', 'guest135@test.com', 'Male', '53', 'Veg', 'A: Feb 4, 08:00 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 136', '+91 90000 00136', 'guest136@test.com', 'Female', '26', 'Non-Veg', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 10:00 AM', false),
                _buildGuestCard('Guest 137', '+91 90000 00137', 'guest137@test.com', 'Male', '40', 'Veg', 'A: Feb 3, 08:00 AM', 'D: Feb 6, 09:00 AM', false),
                _buildGuestCard('Guest 138', '+91 90000 00138', 'guest138@test.com', 'Female', '32', 'Jain', 'A: Feb 4, 09:00 AM', 'D: Feb 7, 11:00 AM', true),
                _buildGuestCard('Guest 139', '+91 90000 00139', 'guest139@test.com', 'Male', '44', 'Veg', 'A: Feb 5, 08:00 AM', 'D: Feb 7, 09:00 AM', false),
                _buildGuestCard('Guest 14', '+91 90000 00014', 'guest14@test.com', 'Female', '30', 'Jain', 'A: Feb 4, 08:00 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Guest 140', '+91 90000 00140', 'guest140@test.com', 'Female', '28', 'Non-Veg', 'A: Feb 3, 09:30 AM', 'D: Feb 6, 10:00 AM', false),
                _buildGuestCard('Sunil Mistry', '+91 99130 99411', 'mistrysam1@gmail.com', 'Male', '32', 'Veg', 'A: Feb 4, 10:00 AM', 'D: Feb 6, 08:00 PM', true),
              ],
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
