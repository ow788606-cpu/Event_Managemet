import 'package:flutter/material.dart';
import 'services_manager.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
            const Tab(text: 'Checklist'),
            Tab(text: 'In Progress (${inProgress.length})'),
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
          const Center(child: Text('No Checklist found!', style: TextStyle(fontFamily: 'Inter'))),
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
