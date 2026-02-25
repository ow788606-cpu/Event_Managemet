import 'dart:async';
import 'package:flutter/material.dart';
import 'edit_function_page.dart';
import 'services/database_service.dart';

class EventTimelinePage extends StatefulWidget {
  final int eventId;
  
  const EventTimelinePage({super.key, required this.eventId});

  @override
  State<EventTimelinePage> createState() => _EventTimelinePageState();
}

class _EventTimelinePageState extends State<EventTimelinePage> {
  List<Map<String, dynamic>> _functions = [];
  Map<String, List<Map<String, dynamic>>> _groupedFunctions = {};
  bool _isLoading = true;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadFunctions();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadFunctions();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadFunctions() async {
    try {
      final functions = await DatabaseService.getEventFunctions(eventId: widget.eventId);
      if (mounted) {
        setState(() {
          _functions = functions;
          _groupedFunctions = _groupByDate(functions);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Map<String, List<Map<String, dynamic>>> _groupByDate(List<Map<String, dynamic>> functions) {
    final grouped = <String, List<Map<String, dynamic>>>{};
    for (var func in functions) {
      final date = func['function_date']?.toString() ?? '';
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(func);
    }
    return grouped;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 2, offset: const Offset(0, 1))]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: _showFilterDialog,
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter', style: TextStyle(fontFamily: 'Inter', fontSize: 14)),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _downloadCSV,
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Download', style: TextStyle(fontFamily: 'Inter', fontSize: 14)),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                ),
              ],
            ),
          ),
          Expanded(
            child: _groupedFunctions.isEmpty
                ? const Center(child: Text('No timeline data', style: TextStyle(fontFamily: 'Inter')))
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: _groupedFunctions.entries.map((entry) {
                      return _buildSection(entry.key, entry.value);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  void _downloadCSV() {
    final csvData = StringBuffer();
    csvData.writeln('Date,Function Name,Start Time,End Time,Location,Notes');
    for (var func in _functions) {
      csvData.writeln('${func['function_date']},${func['function_name']},${func['start_time']},${func['end_time']},${func['location']},${func['notes'] ?? ''}');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exported ${_functions.length} functions', style: const TextStyle(fontFamily: 'Inter'))),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Filters',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter')),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Clear All',
                        style: TextStyle(
                            color: Colors.deepPurple, fontFamily: 'Inter')),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: const Icon(Icons.search, size: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              const SizedBox(height: 20),
              const Text('EVENT DAYS',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Inter')),
              const SizedBox(height: 12),
              _buildFilterItem('All Days', null),
              _buildFilterItem('Welcome', 4),
              _buildFilterItem('Colors & Culture', 3),
              _buildFilterItem('Music & Magic', 3),
              _buildFilterItem('The Grand Union', 3),
              _buildFilterItem('Farewell with Love', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterItem(String title, int? count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 14,
                  color: title == 'All Days'
                      ? const Color(0xFF520350)
                      : Colors.black,
                  fontFamily: 'Inter')),
          if (count != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('$count',
                  style: const TextStyle(fontSize: 12, fontFamily: 'Inter')),
            ),
        ],
      ),
    );
  }

  Widget _buildSection(String date, List<Map<String, dynamic>> functions) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(date, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
          ),
          ...functions.map((func) => _buildEvent(
            func['function_name']?.toString() ?? '',
            '${func['start_time']}-${func['end_time']}',
            func['location']?.toString() ?? '',
            func['notes']?.toString() ?? '',
            Colors.purple,
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildEvent(String title, String time, String location,
      String description, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Inter'),
                          children: [
                            TextSpan(text: title),
                            TextSpan(
                                text: ' ($time)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                            if (location.isNotEmpty)
                              TextSpan(
                                  text: ' - ',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.normal)),
                            if (location.isNotEmpty)
                              TextSpan(
                                  text: location,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditFunctionPage(
                              functionName: title,
                              startTime: time.split('-')[0].trim(),
                              endTime: time.split('-').length > 1
                                  ? time.split('-')[1].trim()
                                  : '',
                              location: location,
                              notes: description,
                            ),
                          ),
                        );
                      },
                      child:
                          const Icon(Icons.edit, size: 16, color: Colors.grey),
                    ),
                  ],
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(description,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontFamily: 'Inter')),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
