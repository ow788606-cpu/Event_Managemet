import 'package:flutter/material.dart';
import 'services_manager.dart';
import 'checklist_design_page.dart';
import 'event_timeline_page.dart';
import 'vendors_page.dart';
import 'guest_list_page.dart';

class ServicesPage extends StatefulWidget {
  final int initialTab;
  const ServicesPage({super.key, this.initialTab = 0});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this, initialIndex: widget.initialTab);
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
              _buildStatCard(Icons.people, '121', 'Guest Invited', const Color(0xFF520350), width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.check, '65', 'Invitation Accepted', Colors.green, width),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(Icons.cancel, '21', 'Invitation Declined', Colors.red, width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.person, '35', 'Confirmation Pending', Colors.orange, width),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Guest Pickup', '30', 'Required', '0', 'Assigned')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Vendors', '12', 'Hired', '7', 'Shortlisted')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Tasks', '24', 'Pending', '18', 'Completed')),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Other', '25', 'VIP Guest', '12', 'Wheelchair')),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
          const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildGuestAgeRatioChart() {
    const ageData = [
      {'range': '1-15', 'count': 6},
      {'range': '16-30', 'count': 31},
      {'range': '30-45', 'count': 68},
      {'range': '45-60', 'count': 17},
      {'range': '60+', 'count': 11},
    ];
    const maxCount = 68;

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
                      final height = (data['count'] as int) / maxCount * 150;
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
                painter: DonutChartPainter([54, 46], [const Color(0xFF520350), Colors.grey[300]!]),
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
                  const Text('54%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text('Female', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter')),
                  Text('46%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600], fontFamily: 'Inter')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodPreferenceChart() {
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
                painter: DonutChartPainter([20, 30, 50], [const Color(0xFF520350), const Color(0xFF8B4789), Colors.grey[300]!]),
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
                  const Text('24', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text('Non-Veg', style: TextStyle(fontSize: 10, color: Colors.grey[600], fontFamily: 'Inter')),
                  const Text('36', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B4789), fontFamily: 'Inter')),
                ],
              ),
              Column(
                children: [
                  Text('Veg', style: TextStyle(fontSize: 10, color: Colors.grey[600], fontFamily: 'Inter')),
                  Text('61', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600], fontFamily: 'Inter')),
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
    final events = [
      {'date': '03\nFeb', 'title': 'Guest Arrival & Check-In', 'time': '12:00 - 18:00', 'location': 'Resort Lobby'},
      {'date': '03\nFeb', 'title': 'Welcome Lunch', 'time': '13:30 - 15:30', 'location': 'Dining Restaurant'},
      {'date': '03\nFeb', 'title': 'Welcome Soirée', 'time': '18:00 - 20:30', 'location': 'Poolside / Beachfront'},
      {'date': '03\nFeb', 'title': 'Night meet & gala', 'time': '20:00 - 21:30', 'location': 'party hall'},
    ];

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
              const Text('Event Timeline', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: Icon(Icons.open_in_new, size: 14, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...events.map((event) => Padding(
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
                  child: Center(
                    child: Text(
                      event['date']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event['title']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(event['time']!, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter')),
                          const SizedBox(width: 12),
                          Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Expanded(child: Text(event['location']!, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Inter'))),
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

  Widget _buildGuestAccommodationCard() {
    final accommodations = [
      {'day': 'Day\n1', 'title': 'Welcome', 'date': '03 Feb\n2026', 'guests': '48', 'rooms': '0'},
      {'day': 'Day\n2', 'title': 'Colors &\nCulture', 'date': '04 Feb\n2026', 'guests': '89', 'rooms': '0'},
      {'day': 'Day\n3', 'title': 'Music &\nCellus', 'date': '05 Feb\n2026', 'guests': '121', 'rooms': '0'},
      {'day': 'Day\n4', 'title': 'The Grand\nUnion', 'date': '06 Feb\n2026', 'guests': '97', 'rooms': '0'},
      {'day': 'Day\n5', 'title': 'Farewell\nwith Love', 'date': '07 Feb\n2026', 'guests': '57', 'rooms': '0'},
    ];

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
              const Text('Guest Accommodation', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF520350), fontFamily: 'Inter')),
              GestureDetector(
                onTap: () => _tabController.animateTo(2),
                child: Icon(Icons.open_in_new, size: 14, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
              ...accommodations.map((acc) => TableRow(
                children: [
                  _buildTableCell(acc['day']!),
                  _buildTableCell(acc['title']!),
                  _buildTableCell(acc['date']!),
                  _buildTableCell(acc['guests']!),
                  _buildTableCell(acc['rooms']!),
                ],
              )),
            ],
          ),
        ],
      ),
    );
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
    
    double startAngle = -90 * 3.14159 / 180;
    
    for (int i = 0; i < values.length; i++) {
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
