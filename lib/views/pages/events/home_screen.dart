import 'package:flutter/material.dart';
import 'all_events_page.dart';
import '../dashboard/dashboardpage.dart';
import '../../../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: _buildStatCard('59', 'Total Events',
                        Icons.calendar_today, Colors.purple)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildStatCard('14', 'Upcoming Events',
                        Icons.access_time, Colors.orange)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: _buildStatCard(
                        '2', 'Ongoing Events', Icons.refresh, Colors.blue)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildStatCard('0', 'Completed Events',
                        Icons.check_circle, Colors.green)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildMyTasksCard()),
                const SizedBox(width: 12),
                Expanded(child: _buildEventsByMonthCard()),
              ],
            ),
            const SizedBox(height: 20),
            _buildRecentEventsTable(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String count, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(count,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter')),
              Icon(icon, color: color.withValues(alpha: 0.3), size: 28),
            ],
          ),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
        ],
      ),
    );
  }

  Widget _buildMyTasksCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('My Tasks',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter')),
              Icon(Icons.list, color: Colors.grey[400], size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text('Overview',
              style: TextStyle(
                  fontSize: 12, color: Colors.grey[500], fontFamily: 'Inter')),
          const SizedBox(height: 20),
          _buildTaskItem('0', 'Today\'s Tasks'),
          const SizedBox(height: 16),
          _buildTaskItem('8', 'Overdue Tasks'),
          const SizedBox(height: 16),
          _buildTaskItem('0', 'Active Tasks'),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String count, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(count,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter')),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 12, color: Colors.grey[600], fontFamily: 'Inter')),
      ],
    );
  }

  Widget _buildEventsByMonthCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Events by Month',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter')),
          const SizedBox(height: 100),
          Center(
              child: Text('Chart Placeholder',
                  style:
                      TextStyle(color: Colors.grey[400], fontFamily: 'Inter'))),
        ],
      ),
    );
  }

  Widget _buildRecentEventsTable(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Events',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter')),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllEventsPage()),
                  );
                },
                child: const Text('View All',
                    style: TextStyle(
                        color: Color(0xFF520350), fontFamily: 'Inter')),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseService.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No events found'));
              }
              
              final events = snapshot.data!.take(5).toList();
              
              return Table(
                columnWidths: const {
                  0: FixedColumnWidth(40),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                  3: FixedColumnWidth(60),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    children: [
                      _buildTableHeader('#'),
                      _buildTableHeader('Event'),
                      _buildTableHeader('Client Details'),
                      _buildTableHeader(''),
                    ],
                  ),
                  ...events.asMap().entries.map((entry) {
                    final event = entry.value;
                    return TableRow(
                      children: [
                        _buildTableCell('${entry.key + 1}'),
                        _buildTableCell(
                          event['title']?.toString() ?? 'N/A',
                          subtitle: '${event['start_date']?.toString() ?? ''} - ${event['end_date']?.toString() ?? ''}',
                        ),
                        _buildTableCell(
                          event['client_name']?.toString() ?? 'N/A',
                          subtitle: event['manager_name']?.toString() ?? '',
                        ),
                        _buildTableCell('', icon: Icons.visibility_outlined, context: context, event: event),
                      ],
                    );
                  }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
    );
  }

  Widget _buildTableCell(String text, {String? subtitle, IconData? icon, BuildContext? context, Map<String, dynamic>? event}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: icon != null
          ? GestureDetector(
              onTap: () {
                if (context != null && event != null) {
                  final eventId = int.tryParse(event['id']?.toString() ?? '0') ?? 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ServicesPage(initialTab: 0, eventId: eventId)),
                  );
                }
              },
              child: Icon(icon, size: 18, color: Colors.grey[600]),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                    style: const TextStyle(fontSize: 12, fontFamily: 'Inter')),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                          fontFamily: 'Inter')),
                ],
              ],
            ),
    );
  }
}
