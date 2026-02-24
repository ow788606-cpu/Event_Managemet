import 'dart:async';
import 'package:flutter/material.dart';
import 'services_manager.dart';
import 'checklist_design_page.dart';
import 'event_timeline_page.dart';
import 'vendors_page.dart';
import 'guest_list_page.dart';
import 'services/database_service.dart';

class ServicesPage extends StatefulWidget {
  final int initialTab;
  const ServicesPage({super.key, this.initialTab = 0});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _eventFunctions = [];
  List<Map<String, dynamic>> _eventDays = [];
  List<Map<String, dynamic>> _eventAttendees = [];
  List<Map<String, dynamic>> _eventVendors = [];
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this, initialIndex: widget.initialTab);
    _loadEventFunctions();
    _loadEventDays();
    _loadEventAttendees();
    _loadEventVendors();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadEventFunctions();
      _loadEventDays();
      _loadEventAttendees();
      _loadEventVendors();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadEventFunctions() async {
    try {
      final functions = await DatabaseService.getEventFunctions();
      if (mounted) {
        setState(() {
          _eventFunctions = functions;
        });
      }
    } catch (e) {
      // Keep empty list on error
    }
  }

  Future<void> _loadEventDays() async {
    try {
      final days = await DatabaseService.getEventDays();
      if (mounted) {
        setState(() {
          _eventDays = days;
        });
      }
    } catch (e) {
      // Keep empty list on error
    }
  }

  Future<void> _loadEventAttendees() async {
    try {
      final attendees = await DatabaseService.getEventAttendees();
      if (mounted) {
        setState(() {
          _eventAttendees = attendees;
        });
      }
    } catch (e) {
      // Keep empty list on error
    }
  }

  Future<void> _loadEventVendors() async {
    try {
      final vendors = await DatabaseService.getEventVendors();
      if (mounted) {
        setState(() {
          _eventVendors = vendors;
        });
      }
    } catch (e) {
      // Keep empty list on error
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final requests = ServicesManager.getRequests();
    final pending = requests.where((r) => r.status == ServiceStatus.pending).toList();
    final inProgress = requests.where((r) => r.status == ServiceStatus.inProgress).toList();
    final completed = requests.where((r) => r.status == ServiceStatus.completed).toList();
    final cancelled = requests.where((r) => r.status == ServiceStatus.cancelled).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        title: const Text('My Services', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFE7DFE7),
          labelColor: const Color(0xFFE7DFE7),
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          tabs: [
            const Tab(text: 'Event Overview'),
            const Tab(text: 'Checklist'),
            const Tab(text: 'Event Timeline'),
            const Tab(text: 'Vendors'),
            const Tab(text: 'Guest List'),
            const Tab(text: 'Accommodation'),
            const Tab(text: 'Other'),
          ],
          labelStyle: const TextStyle(fontFamily: 'Inter'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestsList(pending, width, height, ServiceStatus.pending),
          _buildChecklistDesign(),
          const EventTimelinePage(),
          const VendorsPage(),
          const GuestListPage(),
          _buildPlaceholder('Accommodation'),
          _buildPlaceholder('Other'),
        ],
      ),
    );
  }

  Widget _buildRequestsList(List<ServiceRequest> requests, double width, double height, ServiceStatus status) {
    if (status == ServiceStatus.pending) {
      return _buildEventOverviewDesign(width, height);
    }
    
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.design_services, size: width * 0.2, color: Colors.grey[300]),
            SizedBox(height: height * 0.02),
            Text('No ${status.name} requests', style: TextStyle(fontSize: width * 0.045, color: Colors.grey, fontFamily: 'Inter')),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: requests.length,
      itemBuilder: (context, index) => _buildRequestCard(requests[index], width, height),
    );
  }

  Widget _buildEventOverviewDesign(double width, double height) {
    final totalGuests = _eventAttendees.length;
    final acceptedGuests = _eventAttendees.where((g) => g['invitation_status'] == 'accepted').length;
    final declinedGuests = _eventAttendees.where((g) => g['invitation_status'] == 'declined').length;
    final pendingGuests = _eventAttendees.where((g) => g['invitation_status'] == 'pending').length;
    
    final travelRequired = _eventAttendees.where((g) => g['travel_required'].toString() == '1').length;
    final travelAssigned = 0;
    
    final hiredVendors = _eventVendors.where((v) => v['status']?.toString().toLowerCase() == 'hired').length;
    final shortlistedVendors = _eventVendors.where((v) => v['status']?.toString().toLowerCase() == 'shortlisted').length;
    
    final vipGuests = _eventAttendees.where((g) => g['is_vip'].toString() == '1').length;
    final wheelchairGuests = _eventAttendees.where((g) => g['needs_wheelchair'].toString() == '1').length;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink.shade50,
                  child: const Icon(Icons.favorite, color: Colors.pink, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Harsh & Nidhi Wedding', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                          const SizedBox(width: 6),
                          const Icon(Icons.check_circle, color: Colors.green, size: 18),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text('12 Jan 2024 - 15 Jan 2024', style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text('Raj Palace', style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontFamily: 'Inter')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(Icons.people, '$totalGuests', 'Guest Invited', const Color(0xFF520350), width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.check, '$acceptedGuests', 'Invitation Accepted', Colors.green, width),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(Icons.cancel, '$declinedGuests', 'Invitation Declined', Colors.red, width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.person, '$pendingGuests', 'Confirmation Pending', Colors.orange, width),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Guest Pickup', '$travelRequired', 'Required', '$travelAssigned', 'Assigned')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Vendors', '$hiredVendors', 'Hired', '$shortlistedVendors', 'Shortlisted')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Tasks', '24', 'Pending', '18', 'Completed')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Other', '$vipGuests', 'VIP Guest', '$wheelchairGuests', 'Wheelchair')),
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
          _buildEventTimelineCard(),
          const SizedBox(height: 12),
          _buildGuestAccommodationCard(),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String count, String label, Color color, double width) {
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
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
              ),
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
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
          const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildGuestAgeRatioChart() {
    final ageGroups = {
      '1-15': 0,
      '16-30': 0,
      '30-45': 0,
      '45-60': 0,
      '60+': 0,
    };
    
    for (var guest in _eventAttendees) {
      final age = int.tryParse(guest['age']?.toString() ?? '0') ?? 0;
      if (age >= 1 && age <= 15) ageGroups['1-15'] = (ageGroups['1-15'] ?? 0) + 1;
      else if (age >= 16 && age <= 30) ageGroups['16-30'] = (ageGroups['16-30'] ?? 0) + 1;
      else if (age >= 31 && age <= 45) ageGroups['30-45'] = (ageGroups['30-45'] ?? 0) + 1;
      else if (age >= 46 && age <= 60) ageGroups['45-60'] = (ageGroups['45-60'] ?? 0) + 1;
      else if (age > 60) ageGroups['60+'] = (ageGroups['60+'] ?? 0) + 1;
    }
    
    final ageData = ageGroups.entries.map((e) => {'range': e.key, 'count': e.value}).toList();
    final maxCount = ageGroups.values.isEmpty ? 1 : ageGroups.values.reduce((a, b) => a > b ? a : b).toDouble();
    final safeMaxCount = maxCount > 0 ? maxCount : 1.0;

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
              const Text('Guest Age Ratio', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: Icon(Icons.open_in_new, size: 14, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 20),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text('Number of Guests', style: TextStyle(fontSize: 10, color: Colors.grey[600], fontFamily: 'Inter')),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: ageData.map((data) {
                      final height = (data['count'] as int) / safeMaxCount * 150;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${data['count']} Guests', style: const TextStyle(fontSize: 9, fontFamily: 'Inter')),
                              const SizedBox(height: 4),
                              Container(
                                height: height,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF520350),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(data['range'] as String, style: const TextStyle(fontSize: 10, fontFamily: 'Inter')),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(child: Text('Age Group', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter'))),
        ],
      ),
    );
  }

  Widget _buildGenderChart() {
    final maleCount = _eventAttendees.where((g) => g['gender']?.toString().toLowerCase() == 'male').length;
    final femaleCount = _eventAttendees.where((g) => g['gender']?.toString().toLowerCase() == 'female').length;
    final total = maleCount + femaleCount;
    final malePercent = total > 0 ? (maleCount / total * 100).round() : 0;
    final femalePercent = total > 0 ? (femaleCount / total * 100).round() : 0;
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
              const Text('Gender', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: Icon(Icons.open_in_new, size: 14, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: CustomPaint(
                size: const Size(120, 120),
                painter: DonutChartPainter([malePercent.toDouble(), femalePercent.toDouble()], [const Color(0xFF520350), Colors.grey[300]!]),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(const Color(0xFF520350), 'Male'),
              const SizedBox(width: 16),
              _buildLegend(Colors.grey[300]!, 'Female'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Male', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter')),
                  Text('$malePercent%', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text('Female', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter')),
                  Text('$femalePercent%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600], fontFamily: 'Inter')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodPreferenceChart() {
    final jainCount = _eventAttendees.where((g) => g['food_preference']?.toString().toLowerCase() == 'jain').length;
    final nonVegCount = _eventAttendees.where((g) => g['food_preference']?.toString().toLowerCase() == 'non-veg').length;
    final vegCount = _eventAttendees.where((g) => g['food_preference']?.toString().toLowerCase() == 'veg').length;
    final total = jainCount + nonVegCount + vegCount;
    final jainPercent = total > 0 ? (jainCount / total * 100).round() : 0;
    final nonVegPercent = total > 0 ? (nonVegCount / total * 100).round() : 0;
    final vegPercent = total > 0 ? (vegCount / total * 100).round() : 0;
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
              const Text('Food Preference', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: Icon(Icons.open_in_new, size: 14, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: CustomPaint(
                size: const Size(120, 120),
                painter: DonutChartPainter([jainPercent.toDouble(), nonVegPercent.toDouble(), vegPercent.toDouble()], [const Color(0xFF520350), const Color(0xFF8B4789), Colors.grey[300]!]),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              _buildLegend(const Color(0xFF520350), 'Jain'),
              _buildLegend(const Color(0xFF8B4789), 'Non-Veg'),
              _buildLegend(Colors.grey[300]!, 'Veg'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Jain', style: TextStyle(fontSize: 10, color: Colors.grey[600], fontFamily: 'Inter')),
                  Text('$jainCount', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text('Non-Veg', style: TextStyle(fontSize: 10, color: Colors.grey[600], fontFamily: 'Inter')),
                  Text('$nonVegCount', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B4789), fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text('Veg', style: TextStyle(fontSize: 10, color: Colors.grey[600], fontFamily: 'Inter')),
                  Text('$vegCount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600], fontFamily: 'Inter')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, fontFamily: 'Inter')),
      ],
    );
  }

  Widget _buildEventTimelineCard() {
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
              const Text('Event Timeline', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: Icon(Icons.open_in_new, size: 14, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_eventFunctions.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No events scheduled', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
              ),
            )
          else
            ...(_eventFunctions.take(4).map((event) {
              final title = event['function_name']?.toString() ?? '';
              final startTime = event['start_time']?.toString().substring(0, 5) ?? '';
              final endTime = event['end_time']?.toString().substring(0, 5) ?? '';
              final time = '$startTime - $endTime';
              final location = event['location']?.toString() ?? '';
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF520350),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.event, color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter')),
                              const SizedBox(width: 12),
                              Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Expanded(child: Text(location, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter'))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })),
        ],
      ),
    );
  }

  Widget _buildGuestAccommodationCard() {
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
              const Text('Guest Accommodation', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: Icon(Icons.open_in_new, size: 14, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_eventDays.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No accommodation data', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
              ),
            )
          else
            Table(
              border: TableBorder.all(color: Colors.grey.shade300, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(1.2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(1.3),
                4: FlexColumnWidth(1.3),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  children: [
                    _buildTableHeader('Day'),
                    _buildTableHeader('Title'),
                    _buildTableHeader('Date'),
                    _buildTableHeader('No of\nGuest'),
                    _buildTableHeader('Room\nBooked'),
                  ],
                ),
                ..._eventDays.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final day = entry.value;
                  final title = day['day_title']?.toString() ?? '';
                  final date = day['event_date']?.toString() ?? '';
                  final guests = '0';
                  final rooms = '0';
                  
                  return TableRow(
                    children: [
                      _buildTableCell('Day\n$index'),
                      _buildTableCell(title),
                      _buildTableCell(date.split('-').length >= 3 ? '${date.split('-')[2]} ${_getMonthName(date.split('-')[1])}\n${date.split('-')[0]}' : date),
                      _buildTableCell(guests),
                      _buildTableCell(rooms),
                    ],
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }

  String _getMonthName(String month) {
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final monthNum = int.tryParse(month) ?? 0;
    return monthNum > 0 && monthNum <= 12 ? months[monthNum] : month;
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, fontFamily: 'Inter'),
      ),
    );
  }

  Widget _buildChecklistDesign() {
    return const ChecklistDesignPage();
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Text('$title Page', style: const TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'Inter')),
    );
  }



  Widget _buildRequestCard(ServiceRequest request, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      decoration: BoxDecoration(
        color: const Color(0xFFE7DFE7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.04),
            decoration: const BoxDecoration(
              color: Color(0xFF520350),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long, color: Colors.white, size: 20),
                    SizedBox(width: width * 0.02),
                    Text('Request #${request.requestId}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white, fontFamily: 'Inter')),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.005),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Text(request.status.name.toUpperCase(), style: const TextStyle(color: Color(0xFF520350), fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.1,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(request.service.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.design_services, size: 40)),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request.service.title, style: TextStyle(fontSize: width * 0.042, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                          SizedBox(height: height * 0.008),
                          Row(
                            children: [
                              Icon(Icons.category, size: width * 0.035, color: Colors.grey[600]),
                              SizedBox(width: width * 0.01),
                              Text(request.serviceType, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[600], fontFamily: 'Inter')),
                            ],
                          ),
                          SizedBox(height: height * 0.005),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: width * 0.035, color: Colors.grey[600]),
                              SizedBox(width: width * 0.01),
                              Text(request.service.location, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[600], fontFamily: 'Inter')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (request.notes.isNotEmpty) ...[
                  SizedBox(height: height * 0.015),
                  Container(
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.note, size: width * 0.04, color: const Color(0xFF520350)),
                        SizedBox(width: width * 0.02),
                        Expanded(child: Text(request.notes, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[700], fontFamily: 'Inter'))),
                      ],
                    ),
                  ),
                ],
                if (request.status == ServiceStatus.pending) ...[
                  SizedBox(height: height * 0.015),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _cancelRequest(request),
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Cancel Request', style: TextStyle(fontFamily: 'Inter')),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF520350),
                        side: const BorderSide(color: Color(0xFF520350), width: 2),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _cancelRequest(ServiceRequest request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Request', style: TextStyle(fontFamily: 'Inter')),
        content: const Text('Are you sure you want to cancel this service request?', style: TextStyle(fontFamily: 'Inter')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No', style: TextStyle(fontFamily: 'Inter'))),
          TextButton(
            onPressed: () {
              setState(() => ServicesManager.cancelRequest(request.requestId));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request cancelled successfully')));
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: Color(0xFF520350), fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  DonutChartPainter(this.values, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 60.0;
    const innerRadius = radius * 0.6;
    final total = values.reduce((a, b) => a + b);
    
    if (total == 0) {
      final paint = Paint()
        ..color = Colors.grey[300]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius - innerRadius;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: (radius + innerRadius) / 2),
        0,
        2 * 3.14159,
        false,
        paint,
      );
      return;
    }
    
    double startAngle = -90 * 3.14159 / 180;
    
    for (int i = 0; i < values.length; i++) {
      if (values[i] == 0) continue;
      final sweepAngle = (values[i] / total) * 2 * 3.14159;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius - innerRadius;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: (radius + innerRadius) / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

