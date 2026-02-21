import 'package:flutter/material.dart';
import 'services_manager.dart';
import 'checklist_design_page.dart';

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
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTab);
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
      backgroundColor: Colors.white,
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
            Tab(text: 'Event Overview (${pending.length})'),
            Tab(text: 'Checklist (${inProgress.length})'),
            Tab(text: 'Completed (${completed.length})'),
            Tab(text: 'Cancelled (${cancelled.length})'),
          ],
          labelStyle: const TextStyle(fontFamily: 'Inter'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestsList(pending, width, height, ServiceStatus.pending),
          _buildRequestsList(inProgress, width, height, ServiceStatus.inProgress),
          _buildRequestsList(completed, width, height, ServiceStatus.completed),
          _buildRequestsList(cancelled, width, height, ServiceStatus.cancelled),
        ],
      ),
    );
  }

  Widget _buildRequestsList(List<ServiceRequest> requests, double width, double height, ServiceStatus status) {
    if (status == ServiceStatus.pending) {
      return _buildEventOverviewDesign(width, height);
    }
    
    if (status == ServiceStatus.inProgress) {
      return _buildChecklistDesign();
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
              _buildStatCard(Icons.people, '0', 'Guest Invited', const Color(0xFF520350), width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.check, '0', 'Invitation Accepted', Colors.green, width),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(Icons.cancel, '0', 'Invitation Declined', Colors.red, width),
              const SizedBox(width: 12),
              _buildStatCard(Icons.person, '0', 'Confirmation Pending', Colors.orange, width),
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

  Widget _buildChecklistDesign() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return Row(
          children: [
            if (isWide)
              Container(
                width: 250,
                color: Colors.white,
                child: _buildFilters(),
              ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Checklist', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                        Row(
                          children: [
                            if (isWide)
                              OutlinedButton(
                                onPressed: () {},
                                child: const Text('Export Checklist', style: TextStyle(fontSize: 12, fontFamily: 'Inter')),
                              ),
                            if (isWide) const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF520350), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                              child: const Text('Add Task', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Inter')),
                            ),
                            if (!isWide) const SizedBox(width: 8),
                            if (!isWide)
                              IconButton(
                                onPressed: () => _showFilters(context),
                                icon: const Icon(Icons.filter_list),
                                style: IconButton.styleFrom(backgroundColor: Colors.grey.shade200),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: const Color(0xFFF3E5F5),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isWide ? 14 : 12, fontFamily: 'Inter'))),
                        Expanded(flex: 2, child: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isWide ? 14 : 12, fontFamily: 'Inter'))),
                        if (isWide) Expanded(flex: 2, child: Text('Assigned to', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                        if (isWide) Expanded(flex: 2, child: Text('Added Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                        Expanded(flex: 2, child: Text('Due Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isWide ? 14 : 12, fontFamily: 'Inter'))),
                        if (isWide) Expanded(flex: 1, child: Text('Action', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Inter'))),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('No Checklist found!', style: TextStyle(color: Colors.grey, fontFamily: 'Inter')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30)),
                child: const Text('Clear All', style: TextStyle(color: Color(0xFF520350), fontSize: 12, fontFamily: 'Inter')),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: const TextStyle(fontSize: 14),
              prefixIcon: const Icon(Icons.search, size: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
          const SizedBox(height: 24),
          const Text('STATUS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Inter')),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(label: const Text('All', style: TextStyle(fontSize: 12)), selected: true, selectedColor: const Color(0xFF520350), labelStyle: const TextStyle(color: Colors.white)),
              ChoiceChip(label: const Text('Pending', style: TextStyle(fontSize: 12)), selected: false),
              ChoiceChip(label: const Text('Completed', style: TextStyle(fontSize: 12)), selected: false),
            ],
          ),
          const SizedBox(height: 24),
          const Text('ASSIGNED TO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Inter')),
          const SizedBox(height: 12),
          _buildAssigneeItem('All', 0, true),
          _buildAssigneeItem('Unassigned', 0, false),
          _buildAssigneeItem('Amit Shah', 0, false),
          _buildAssigneeItem('Jiya Suthar', 0, false),
          _buildAssigneeItem('Neha Mehta', 0, false),
          _buildAssigneeItem('Pooja Jain', 0, false),
          _buildAssigneeItem('Rohan Patel', 0, false),
          _buildAssigneeItem('Suresh Yadav', 0, false),
        ],
      ),
    );
  }

  Widget _buildAssigneeItem(String name, int count, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(fontSize: 14, color: selected ? const Color(0xFF520350) : Colors.black, fontFamily: 'Inter')),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF520350) : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$count', style: TextStyle(fontSize: 12, color: selected ? Colors.white : Colors.black, fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: _buildFilters(),
      ),
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
