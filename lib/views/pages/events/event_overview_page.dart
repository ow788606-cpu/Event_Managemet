import 'package:flutter/material.dart';
import '../../../services/database_service.dart';
import '../checklist_design_page.dart';
import 'event_timeline_page.dart';
import '../vendors/vendors_page.dart';
import '../guests/guest_list_page.dart';

class EventOverviewPage extends StatefulWidget {
  final Map<String, dynamic> event;

  const EventOverviewPage({super.key, required this.event});

  @override
  State<EventOverviewPage> createState() => _EventOverviewPageState();
}

class _EventOverviewPageState extends State<EventOverviewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> guests = [];
  List<dynamic> vendors = [];
  List<dynamic> checklist = [];
  List<dynamic> timeline = [];
  List<dynamic> accommodation = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final eventId = int.parse(widget.event['id'].toString());
      final eventTypeId = int.parse(widget.event['event_type_id'].toString());
      guests = await DatabaseService.getEventAttendees(eventId: eventId);
      vendors = await DatabaseService.getEventVendors(eventId: eventId);
      checklist = await DatabaseService.getEventChecklists(eventId: eventTypeId);
      timeline = await DatabaseService.getEventFunctions(eventId: eventId);
      accommodation = await DatabaseService.getEventAccommodation(eventId: eventId);
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.event['name'],
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter')),
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
                  child:
                      const Icon(Icons.favorite, color: Colors.pink, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.event['name'],
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter')),
                          const SizedBox(width: 8),
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 20),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(widget.event['date'],
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('Raj Palace',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Inter')),
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
                ChecklistDesignPage(eventId: int.parse(widget.event['id'].toString()), eventTypeId: int.parse(widget.event['event_type_id'].toString())),
                EventTimelinePage(eventId: int.parse(widget.event['id'].toString())),
                VendorsPage(eventId: int.parse(widget.event['id'].toString())),
                GuestListPage(eventId: int.parse(widget.event['id'].toString())),
                const Center(child: Text('Accommodation - Coming Soon', style: TextStyle(fontFamily: 'Inter'))),
                const Center(child: Text('Other - Coming Soon', style: TextStyle(fontFamily: 'Inter'))),
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
              _buildStatCard(Icons.people, guests.length.toString(),
                  'Guest Invited', const Color(0xFF520350)),
              const SizedBox(width: 12),
              _buildStatCard(
                  Icons.check,
                  guests
                      .where((g) => g['rsvp_status'] == 'Confirmed')
                      .length
                      .toString(),
                  'Invitation Accepted',
                  Colors.green),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(
                  Icons.cancel,
                  guests
                      .where((g) => g['rsvp_status'] == 'Declined')
                      .length
                      .toString(),
                  'Invitation Declined',
                  Colors.red),
              const SizedBox(width: 12),
              _buildStatCard(
                  Icons.person,
                  guests
                      .where((g) => g['rsvp_status'] == 'Pending')
                      .length
                      .toString(),
                  'Confirmation Pending',
                  Colors.orange),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _buildSummaryCard(
                      'Guest Pickup', 
                      accommodation.where((a) => a['pickup_required'] == '1' || a['pickup_required'] == 1).length.toString(), 
                      'Required', 
                      accommodation.where((a) => (a['pickup_required'] == '1' || a['pickup_required'] == 1) && a['pickup_assigned'] != null && a['pickup_assigned'].toString().isNotEmpty).length.toString(), 
                      'Assigned')),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildSummaryCard('Vendors', 
                      vendors.where((v) => v['status'] == 'Hired').length.toString(),
                      'Hired', 
                      vendors.where((v) => v['status'] == 'Shortlisted').length.toString(), 
                      'Shortlisted')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: _buildSummaryCard('Tasks', 
                      checklist.where((c) => c['is_completed'] == '0' || c['is_completed'] == 0).length.toString(),
                      'Pending', 
                      checklist.where((c) => c['is_completed'] == '1' || c['is_completed'] == 1).length.toString(), 
                      'Completed')),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildSummaryCard(
                      'Other', 
                      guests.where((g) => g['is_vip'] == '1' || g['is_vip'] == 1).length.toString(), 
                      'VIP Guest', 
                      guests.where((g) => g['wheelchair_required'] == '1' || g['wheelchair_required'] == 1).length.toString(), 
                      'Wheelchair')),
            ],
          ),
          const SizedBox(height: 12),
          _buildGuestAgeRatioChart(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildGenderChart()),
              const SizedBox(width: 12),
              Expanded(child: _buildFoodPreferenceChart()),
            ],
          ),
          const SizedBox(height: 12),
          _buildSingleCard('Event Timeline (${timeline.length} events)'),
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
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(count, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontFamily: 'Inter'), maxLines: 2),
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
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(value1, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  const SizedBox(height: 4),
                  Text(label1, style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text(value2, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  const SizedBox(height: 4),
                  Text(label2, style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuestAgeRatioChart() {
    final children = guests.where((g) => (g['age_group'] == 'Child' || (g['age'] != null && int.tryParse(g['age'].toString()) != null && int.parse(g['age'].toString()) < 18))).length;
    final adults = guests.where((g) => (g['age_group'] == 'Adult' || (g['age'] != null && int.tryParse(g['age'].toString()) != null && int.parse(g['age'].toString()) >= 18))).length;
    final total = guests.length;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Guest Age Ratio',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF520350),
                  fontFamily: 'Inter')),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAgeItem('Children', children, total),
              _buildAgeItem('Adults', adults, total),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgeItem(String label, int count, int total) {
    final percentage = total > 0 ? (count / total * 100).toStringAsFixed(0) : '0';
    return Column(
      children: [
        Text('$count', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
        const SizedBox(height: 4),
        Text('$percentage%', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF520350), fontFamily: 'Inter')),
      ],
    );
  }

  Widget _buildGenderChart() {
    final male = guests.where((g) => g['gender']?.toString().toLowerCase() == 'male').length;
    final female = guests.where((g) => g['gender']?.toString().toLowerCase() == 'female').length;
    final other = guests.length - male - female;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gender',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF520350),
                  fontFamily: 'Inter')),
          const SizedBox(height: 16),
          _buildGenderRow('Male', male, Colors.blue),
          const SizedBox(height: 8),
          _buildGenderRow('Female', female, Colors.pink),
          if (other > 0) const SizedBox(height: 8),
          if (other > 0) _buildGenderRow('Other', other, Colors.grey),
        ],
      ),
    );
  }

  Widget _buildGenderRow(String label, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontFamily: 'Inter')),
        const Spacer(),
        Text('$count', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
      ],
    );
  }

  Widget _buildFoodPreferenceChart() {
    final veg = guests.where((g) => g['food_preference']?.toString().toLowerCase() == 'veg' || g['food_preference']?.toString().toLowerCase() == 'vegetarian').length;
    final nonVeg = guests.where((g) => g['food_preference']?.toString().toLowerCase() == 'non-veg' || g['food_preference']?.toString().toLowerCase() == 'non vegetarian').length;
    final other = guests.length - veg - nonVeg;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Food Preference',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF520350),
                  fontFamily: 'Inter')),
          const SizedBox(height: 16),
          _buildGenderRow('Veg', veg, Colors.green),
          const SizedBox(height: 8),
          _buildGenderRow('Non-Veg', nonVeg, Colors.red),
          if (other > 0) const SizedBox(height: 8),
          if (other > 0) _buildGenderRow('Other', other, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildSingleCard(String title) {
    return InkWell(
      onTap: () => _tabController.animateTo(2),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
            if (timeline.isNotEmpty) const SizedBox(height: 12),
            if (timeline.isNotEmpty)
              ...timeline.take(3).map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF520350),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${t['function_name']} - ${t['start_time']}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }
}
