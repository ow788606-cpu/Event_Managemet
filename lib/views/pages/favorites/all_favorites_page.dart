import 'package:flutter/material.dart';
import '../../../services/database_service.dart';

class AllFavoritesPage extends StatefulWidget {
  const AllFavoritesPage({super.key});

  @override
  State<AllFavoritesPage> createState() => _AllFavoritesPageState();
}

class _AllFavoritesPageState extends State<AllFavoritesPage> {
  List<dynamic> events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final data = await DatabaseService.getEvents();
      setState(() {
        events = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF520350)));
    }

    return Container(
      color: const Color(0xFFE7DFE7),
      child: events.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: width * 0.2, color: Colors.grey[400]),
                  SizedBox(height: height * 0.02),
                  Text('No events found', style: TextStyle(fontSize: width * 0.045, color: Colors.grey, fontFamily: 'Inter')),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(width * 0.04),
              itemCount: events.length,
              itemBuilder: (context, index) => _buildEventCard(events[index], width, height),
            ),
    );
  }

  Widget _buildEventCard(dynamic event, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event['title']?.toString() ?? 'Event', style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Icon(Icons.calendar_today, size: width * 0.04, color: Colors.grey[600]),
                SizedBox(width: width * 0.02),
                Text('${event['start_date']} - ${event['end_date']}', style: TextStyle(fontSize: width * 0.035, color: Colors.grey[600], fontFamily: 'Inter')),
              ],
            ),
            SizedBox(height: height * 0.005),
            Row(
              children: [
                Icon(Icons.location_on, size: width * 0.04, color: Colors.grey[600]),
                SizedBox(width: width * 0.02),
                Expanded(child: Text(event['venue']?.toString() ?? event['location']?.toString() ?? '', style: TextStyle(fontSize: width * 0.035, color: Colors.grey[600], fontFamily: 'Inter'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
