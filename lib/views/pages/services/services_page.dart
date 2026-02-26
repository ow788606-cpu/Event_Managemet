import 'package:flutter/material.dart';
import '../../../services/database_service.dart';
import '../checklist_design_page.dart';
import '../events/event_timeline_page.dart';
import '../vendors/vendors_page.dart';
import '../guests/guest_list_page.dart';
import '../guests/guest_accommodation_page.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key, required int initialTab});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> timeline = [];
  List<dynamic> guests = [];
  List<dynamic> vendors = [];
  List<dynamic> checklist = [];
  List<dynamic> accommodation = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _loadDynamicData();
  }

  Future<void> _loadDynamicData() async {
    try {
      timeline = await DatabaseService.getEventFunctions(eventId: 1);
      guests = await DatabaseService.getEventAttendees(eventId: 1);
      vendors = await DatabaseService.getEventVendors(eventId: 1);
      checklist = await DatabaseService.getEventChecklists(eventId: 1);
      accommodation = await DatabaseService.getEventAccommodation(eventId: 1);
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        title: const Text('My Services',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter')),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFE7DFE7),
          labelColor: const Color(0xFFE7DFE7),
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          tabs: const [
            Tab(text: 'Event Overview'),
            Tab(text: 'Checklist'),
            Tab(text: 'Event Timeline'),
            Tab(text: 'Vendors'),
            Tab(text: 'Guest List'),
            Tab(text: 'Accommodation'),
            Tab(text: 'Other'),
          ],
          labelStyle: const TextStyle(fontFamily: 'Inter'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventOverviewDesign(width, height),
          const ChecklistDesignPage(eventId: 1, eventTypeId: 1),
          const EventTimelinePage(eventId: 1),
          const VendorsPage(eventId: 1),
          const GuestListPage(eventId: 1),
          const GuestAccommodationPage(eventId: 1),
          const Center(child: Text('Other', style: TextStyle(fontFamily: 'Inter'))),
        ],
      ),
    );
  }

  Widget _buildEventOverviewDesign(double width, double height) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
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
                      const Row(
                        children: [
                          Text('Harsh & Nidhi Wedding',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter')),
                          SizedBox(width: 6),
                          Icon(Icons.check_circle, color: Colors.green, size: 18),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text('12 Jan 2024 - 15 Jan 2024',
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontFamily: 'Inter')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text('Raj Palace',
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontFamily: 'Inter')),
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
              _buildStatCard(Icons.people, guests.length.toString(), 'Guest Invited', const Color(0xFF520350), width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.check, guests.where((g) => g['rsvp_status'] == 'Confirmed').length.toString(), 'Invitation Accepted', Colors.green, width),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(Icons.cancel, guests.where((g) => g['rsvp_status'] == 'Declined').length.toString(), 'Invitation Declined', Colors.red, width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.person, guests.where((g) => g['rsvp_status'] == 'Pending').length.toString(), 'Confirmation Pending', Colors.orange, width),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Guest Pickup', accommodation.where((a) => a['pickup_required'] == '1' || a['pickup_required'] == 1).length.toString(), 'Required', accommodation.where((a) => (a['pickup_required'] == '1' || a['pickup_required'] == 1) && a['pickup_assigned'] != null && a['pickup_assigned'].toString().isNotEmpty).length.toString(), 'Assigned')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Vendors', vendors.where((v) => v['status'] == 'Hired').length.toString(), 'Hired', vendors.where((v) => v['status'] == 'Shortlisted').length.toString(), 'Shortlisted')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Tasks', checklist.where((c) => c['is_completed'] == '0' || c['is_completed'] == 0).length.toString(), 'Pending', checklist.where((c) => c['is_completed'] == '1' || c['is_completed'] == 1).length.toString(), 'Completed')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Other', guests.where((g) => g['is_vip'] == '1' || g['is_vip'] == 1).length.toString(), 'VIP Guest', guests.where((g) => g['wheelchair_required'] == '1' || g['wheelchair_required'] == 1).length.toString(), 'Wheelchair')),
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
          GestureDetector(
            onTap: () => _tabController.animateTo(2),
            child: _buildTimelineCard(),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _tabController.animateTo(5),
            child: _buildAccommodationCard(),
          ),
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

  Widget _buildTimelineCard() {
    return Container(
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
              const Text('Event Timeline', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                onPressed: () => _tabController.animateTo(2),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (timeline.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No timeline events', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
            ))
          else
            ...timeline.take(4).map((t) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF520350),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          t['day_number']?.toString() ?? '01',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                        ),
                        Text(
                          t['day_name']?.toString().substring(0, 3) ?? 'Day',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['function_name']?.toString() ?? 'Event',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '${t['start_time']} - ${t['end_time']}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter'),
                            ),
                          ],
                        ),
                        if (t['location'] != null)
                          const SizedBox(height: 2),
                        if (t['location'] != null)
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 12, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  t['location'].toString(),
                                  style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter'),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }

  Widget _buildAccommodationCard() {
    return Container(
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
              const Text('Guest Accommodation', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                onPressed: () => _tabController.animateTo(5),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (accommodation.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No accommodation data', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
            ))
          else
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 1, child: Text('Day', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter'), textAlign: TextAlign.center)),
                      Expanded(flex: 2, child: Text('Guest', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter'))),
                      Expanded(flex: 2, child: Text('Hotel', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter'))),
                      Expanded(flex: 1, child: Text('Room', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter'), textAlign: TextAlign.center)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ...accommodation.take(5).map((a) {
                  // Extract day from check_in_date
                  String dayText = 'Day';
                  if (a['check_in_date'] != null) {
                    try {
                      final date = DateTime.parse(a['check_in_date'].toString());
                      dayText = date.day.toString().padLeft(2, '0');
                    } catch (e) {
                      dayText = '-';
                    }
                  }
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF520350).withAlpha(25),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              dayText,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Text(
                            a['guest_name']?.toString() ?? 'Guest',
                            style: const TextStyle(fontSize: 11, fontFamily: 'Inter'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            a['hotel_name']?.toString() ?? '-',
                            style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            a['room_number']?.toString() ?? '-',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildGuestAgeRatioChart() {
    // Calculate age groups from guests data
    int age1_15 = 0, age16_30 = 0, age30_45 = 0, age45_60 = 0, age60plus = 0;
    
    for (var guest in guests) {
      if (guest['age'] != null) {
        int age = int.tryParse(guest['age'].toString()) ?? 0;
        if (age >= 1 && age <= 15) {
          age1_15++;
        } else if (age >= 16 && age <= 30) {
          age16_30++;
        } else if (age >= 31 && age <= 45) {
          age30_45++;
        } else if (age >= 46 && age <= 60) {
          age45_60++;
        } else if (age > 60) {
          age60plus++;
        }
      }
    }
    
    final maxCount = [age1_15, age16_30, age30_45, age45_60, age60plus].reduce((a, b) => a > b ? a : b);
    
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Guest Age Ratio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAgeBar('1-15', age1_15, maxCount),
              _buildAgeBar('16-30', age16_30, maxCount),
              _buildAgeBar('30-45', age30_45, maxCount),
              _buildAgeBar('45-60', age45_60, maxCount),
              _buildAgeBar('60+', age60plus, maxCount),
            ],
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text('Age Group', style: TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeBar(String label, int count, int maxCount) {
    final height = maxCount > 0 ? (count / maxCount * 100).clamp(20.0, 100.0) : 20.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$count', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF520350),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey, fontFamily: 'Inter')),
      ],
    );
  }

  Widget _buildGenderChart() {
    final male = guests.where((g) => g['gender']?.toString().toLowerCase() == 'male').length;
    final female = guests.where((g) => g['gender']?.toString().toLowerCase() == 'female').length;
    final total = guests.length;
    final malePercent = total > 0 ? (male / total * 100).round() : 0;
    final femalePercent = total > 0 ? (female / total * 100).round() : 0;
    
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink.shade100,
                    ),
                  ),
                  if (male > 0)
                    ClipPath(
                      clipper: _PieClipper(malePercent / 100),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF520350),
                        ),
                      ),
                    ),
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF520350),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('Male', style: TextStyle(fontSize: 11, fontFamily: 'Inter')),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('$malePercent%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('Female', style: TextStyle(fontSize: 11, fontFamily: 'Inter')),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('$femalePercent%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink.shade100, fontFamily: 'Inter')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodPreferenceChart() {
    final veg = guests.where((g) => g['food_preference']?.toString().toLowerCase() == 'veg' || g['food_preference']?.toString().toLowerCase() == 'vegetarian').length;
    final nonVeg = guests.where((g) => g['food_preference']?.toString().toLowerCase() == 'non-veg' || g['food_preference']?.toString().toLowerCase() == 'non vegetarian').length;
    final jain = guests.where((g) => g['food_preference']?.toString().toLowerCase() == 'jain').length;
    final total = guests.length;
    
    // Calculate percentages
    final jainPercent = total > 0 ? jain / total : 0.0;
    final nonVegPercent = total > 0 ? nonVeg / total : 0.0;
    final vegPercent = total > 0 ? veg / total : 0.0;
    
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Food Preference', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  // Jain segment
                  if (jain > 0)
                    CustomPaint(
                      size: const Size(100, 100),
                      painter: _PieSegmentPainter(
                        startAngle: -90,
                        sweepAngle: jainPercent * 360,
                        color: const Color(0xFF520350),
                      ),
                    ),
                  // Non-Veg segment
                  if (nonVeg > 0)
                    CustomPaint(
                      size: const Size(100, 100),
                      painter: _PieSegmentPainter(
                        startAngle: -90 + (jainPercent * 360),
                        sweepAngle: nonVegPercent * 360,
                        color: Colors.purple.shade300,
                      ),
                    ),
                  // Veg segment
                  if (veg > 0)
                    CustomPaint(
                      size: const Size(100, 100),
                      painter: _PieSegmentPainter(
                        startAngle: -90 + (jainPercent * 360) + (nonVegPercent * 360),
                        sweepAngle: vegPercent * 360,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  // Center white circle
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFoodItem('Jain', jain, const Color(0xFF520350)),
              _buildFoodItem('Non-Veg', nonVeg, Colors.purple.shade300),
              _buildFoodItem('Veg', veg, Colors.grey.shade300),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(String label, int count, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 10, fontFamily: 'Inter')),
          ],
        ),
        const SizedBox(height: 4),
        Text('$count', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
      ],
    );
  }
}

class _PieClipper extends CustomClipper<Path> {
  final double percentage;
  _PieClipper(this.percentage);

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweepAngle = 2 * 3.14159 * percentage;
    
    path.moveTo(center.dx, center.dy);
    path.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      sweepAngle,
      false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_PieClipper oldClipper) => oldClipper.percentage != percentage;
}

class _PieSegmentPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final Color color;

  _PieSegmentPainter({
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startAngleRad = startAngle * 3.14159 / 180;
    final sweepAngleRad = sweepAngle * 3.14159 / 180;

    canvas.drawArc(rect, startAngleRad, sweepAngleRad, true, paint);
  }

  @override
  bool shouldRepaint(_PieSegmentPainter oldDelegate) {
    return oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.color != color;
  }
}

