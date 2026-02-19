import 'package:flutter/material.dart';
import 'services_manager.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final requests = ServicesManager.getRequests();
    final pending =
        requests.where((r) => r.status == ServiceStatus.pending).toList();
    final inProgress =
        requests.where((r) => r.status == ServiceStatus.inProgress).toList();
    final completed =
        requests.where((r) => r.status == ServiceStatus.completed).toList();
    final cancelled =
        requests.where((r) => r.status == ServiceStatus.cancelled).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF520350),
          elevation: 0,
          title: const Text('My Services',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFFE7DFE7),
            labelColor: const Color(0xFFE7DFE7),
            unselectedLabelColor: Colors.white70,
            isScrollable: true,
            tabs: [
              Tab(text: 'Pending (${pending.length})'),
              Tab(text: 'In Progress (${inProgress.length})'),
              Tab(text: 'Completed (${completed.length})'),
              Tab(text: 'Cancelled (${cancelled.length})'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildRequestsList(pending, width, height, ServiceStatus.pending),
            _buildRequestsList(
                inProgress, width, height, ServiceStatus.inProgress),
            _buildRequestsList(
                completed, width, height, ServiceStatus.completed),
            _buildRequestsList(
                cancelled, width, height, ServiceStatus.cancelled),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList(List<ServiceRequest> requests, double width,
      double height, ServiceStatus status) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.design_services,
                size: width * 0.2, color: Colors.grey[300]),
            SizedBox(height: height * 0.02),
            Text('No ${status.name} requests',
                style: TextStyle(fontSize: width * 0.045, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(width * 0.04),
      itemCount: requests.length,
      itemBuilder: (context, index) =>
          _buildRequestCard(requests[index], width, height),
    );
  }

  Widget _buildRequestCard(
      ServiceRequest request, double width, double height) {
    final statusColor = request.status == ServiceStatus.pending
        ? Colors.orange
        : request.status == ServiceStatus.inProgress
            ? Colors.blue
            : request.status == ServiceStatus.completed
                ? Colors.green
                : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.04),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt_long,
                        color: statusColor, size: width * 0.05),
                    SizedBox(width: width * 0.02),
                    Text('Request #${request.requestId}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.038)),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.005),
                  decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(request.status.name.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
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
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(request.service.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.design_services, size: 40)),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request.service.title,
                              style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: height * 0.008),
                          Row(
                            children: [
                              Icon(Icons.category,
                                  size: width * 0.035, color: Colors.grey[600]),
                              SizedBox(width: width * 0.01),
                              Text(request.serviceType,
                                  style: TextStyle(
                                      fontSize: width * 0.032,
                                      color: Colors.grey[600])),
                            ],
                          ),
                          SizedBox(height: height * 0.005),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: width * 0.035, color: Colors.grey[600]),
                              SizedBox(width: width * 0.01),
                              Text(request.service.location,
                                  style: TextStyle(
                                      fontSize: width * 0.032,
                                      color: Colors.grey[600])),
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
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.note,
                            size: width * 0.04, color: Colors.grey[600]),
                        SizedBox(width: width * 0.02),
                        Expanded(
                            child: Text(request.notes,
                                style: TextStyle(
                                    fontSize: width * 0.032,
                                    color: Colors.grey[700]))),
                      ],
                    ),
                  ),
                ],
                if (request.status == ServiceStatus.pending) ...[
                  SizedBox(height: height * 0.015),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _cancelRequest(request),
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Cancel Request'),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
        title: const Text('Cancel Request'),
        content:
            const Text('Are you sure you want to cancel this service request?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(
            onPressed: () {
              setState(() => ServicesManager.cancelRequest(request.requestId));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Request cancelled successfully')));
            },
            child:
                const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
