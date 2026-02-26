import 'package:flutter/material.dart';
import '../../../services/database_service.dart';

class GuestAccommodationPage extends StatefulWidget {
  final int eventId;

  const GuestAccommodationPage({super.key, required this.eventId});

  @override
  State<GuestAccommodationPage> createState() => _GuestAccommodationPageState();
}

class _GuestAccommodationPageState extends State<GuestAccommodationPage> {
  List<dynamic> accommodationData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAccommodationData();
  }

  Future<void> _loadAccommodationData() async {
    try {
      final data = await DatabaseService.getEventAccommodation(eventId: widget.eventId);
      setState(() {
        accommodationData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF520350)));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Guest Accommodation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
          const SizedBox(height: 16),
          _buildAccommodationTable(),
        ],
      ),
    );
  }

  Widget _buildAccommodationTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          ...accommodationData.map((item) => _buildTableRow(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFF520350),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: const Row(
        children: [
          Expanded(flex: 1, child: Text('Day', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Inter'))),
          Expanded(flex: 2, child: Text('Title', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Inter'))),
          Expanded(flex: 2, child: Text('Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Inter'))),
          Expanded(flex: 1, child: Text('Guests', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Inter'), textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text('Rooms', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Inter'), textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildTableRow(dynamic item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('Day ${item['id']}', style: const TextStyle(fontSize: 12, fontFamily: 'Inter'))),
          Expanded(flex: 2, child: Text(item['day_title'] ?? '', style: const TextStyle(fontSize: 12, fontFamily: 'Inter'))),
          Expanded(flex: 2, child: Text(item['event_date'] ?? '', style: const TextStyle(fontSize: 12, fontFamily: 'Inter'))),
          Expanded(flex: 1, child: Text('${item['guest_count'] ?? 0}', style: const TextStyle(fontSize: 12, fontFamily: 'Inter'), textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text('${item['rooms_required'] ?? 0}', style: const TextStyle(fontSize: 12, fontFamily: 'Inter'), textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
