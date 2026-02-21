import 'package:flutter/material.dart';

class EventOverviewPage extends StatefulWidget {
  final Map<String, dynamic> event;

  const EventOverviewPage({super.key, required this.event});

  @override
  State<EventOverviewPage> createState() => _EventOverviewPageState();
}

class _EventOverviewPageState extends State<EventOverviewPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.event['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink[50],
                  child: const Icon(Icons.favorite, color: Colors.pink, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.event['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                          const SizedBox(width: 8),
                          const Icon(Icons.check_circle, color: Colors.green, size: 20),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(widget.event['date'], style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('Raj Palace', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: const Color(0xFF520350),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: const Color(0xFF520350),
                borderRadius: BorderRadius.circular(25),
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: const [
                Tab(text: 'Event Overview'),
                Tab(text: 'Checklist'),
                Tab(text: 'Event Timeline'),
                Tab(text: 'Vendors'),
                Tab(text: 'Guest List'),
                Tab(text: 'Accommodation'),
                Tab(text: 'Other'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEventOverview(),
                const Center(child: Text('Checklist')),
                const Center(child: Text('Event Timeline')),
                const Center(child: Text('Vendors')),
                const Center(child: Text('Guest List')),
                const Center(child: Text('Accommodation')),
                const Center(child: Text('Other')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventOverview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatCard(Icons.people, '0', 'Guest Invited', const Color(0xFF520350)),
              const SizedBox(width: 12),
              _buildStatCard(Icons.check, '0', 'Invitation Accepted', Colors.green),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(Icons.cancel, '0', 'Invitation Declined', Colors.red),
              const SizedBox(width: 12),
              _buildStatCard(Icons.person, '0', 'Confirmation Pending', Colors.orange),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Guest Pickup', '0', 'Required', '0', 'Assigned')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Vendors', '0', 'Hired', '0', 'Shortlisted')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Tasks', '0', 'Pending', '0', 'Completed')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Other', '0', 'VIP Guest', '0', 'Wheelchair')),
            ],
          ),
          const SizedBox(height: 12),
          _buildSingleCard('Event Timeline'),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value1, String label1, String value2, String label2) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(value1, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  Text(label1, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text(value2, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  Text(label2, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSingleCard(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
          const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
