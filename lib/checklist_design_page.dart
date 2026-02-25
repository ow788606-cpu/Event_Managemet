import 'dart:async';
import 'package:flutter/material.dart';
import 'add_task_page.dart';
import 'edit_task_page.dart';
import 'services/database_service.dart';

class ChecklistDesignPage extends StatefulWidget {
  const ChecklistDesignPage({super.key});

  @override
  State<ChecklistDesignPage> createState() => _ChecklistDesignPageState();
}

class _ChecklistDesignPageState extends State<ChecklistDesignPage> {
  String _statusFilter = 'All';
  String? _assignedFilter;
  final TextEditingController _searchController = TextEditingController();
  List<ChecklistItem> _items = [];
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadChecklists();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadChecklists();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadChecklists() async {
    try {
      const eventTypeId = 1;

      final checklists =
          await DatabaseService.getEventChecklists(eventId: eventTypeId);
      if (mounted) {
        setState(() {
          _items = checklists
              .map((c) => ChecklistItem(
                    c['task_title']?.toString() ?? '',
                    false,
                    'Medium',
                    null,
                    c['created_at']?.toString().split(' ')[0] ?? '',
                    null,
                    c['task_description']?.toString(),
                  ))
              .toList();
        });
      }
    } catch (e) {
      // Keep empty list on error
    }
  }

  List<String> get _assignees => [
        'All',
        'Unassigned',
        'My Self',
        'Amit Shah',
        'Jiya Suthar',
        'Neha Mehta',
        'Pooja Jain',
        'Rohan Patel',
        'Suresh Yadav'
      ];

  List<ChecklistItem> get _filteredItems {
    return _items.where((item) {
      if (_statusFilter == 'Pending' && item.isCompleted) return false;
      if (_statusFilter == 'Completed' && !item.isCompleted) return false;
      if (_assignedFilter != null &&
          _assignedFilter != 'Unassigned' &&
          item.assignedTo != _assignedFilter) {
        return false;
      }
      if (_assignedFilter == 'Unassigned' && item.assignedTo != null) {
        return false;
      }
      if (_searchController.text.isNotEmpty &&
          !item.title
              .toLowerCase()
              .contains(_searchController.text.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 2,
                  offset: const Offset(0, 1))
            ]),
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: _showFilters),
                const Spacer(),
                OutlinedButton.icon(
                    onPressed: _exportToExcel,
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text('Export',
                        style: TextStyle(fontFamily: 'Inter', fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black)),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add, size: 18, color: Colors.white),
                  label: const Text('Add Task',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    elevation: 2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) =>
                  _buildChecklistCard(_filteredItems[index]),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
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
                      onPressed: () {
                        setModalState(() {
                          _statusFilter = 'All';
                          _assignedFilter = null;
                          _searchController.clear();
                        });
                        setState(() {});
                      },
                      child: const Text('Clear All',
                          style: TextStyle(
                              color: Color(0xFF520350), fontFamily: 'Inter'))),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8)),
                onChanged: (value) {
                  setModalState(() {});
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              const Text('STATUS',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Inter')),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['All', 'Pending', 'Completed']
                    .map((status) => GestureDetector(
                          onTap: () {
                            setModalState(() => _statusFilter = status);
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: _statusFilter == status
                                    ? const Color(0xFF520350)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: _statusFilter == status
                                        ? const Color(0xFF520350)
                                        : Colors.grey)),
                            child: Text(status,
                                style: TextStyle(
                                    color: _statusFilter == status
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 12)),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              const Text('ASSIGNED TO',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Inter')),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _assignees.length,
                  itemBuilder: (context, index) {
                    final assignee = _assignees[index];
                    final count = assignee == 'All'
                        ? 28
                        : assignee == 'Unassigned'
                            ? 25
                            : assignee == 'Neha Mehta'
                                ? 1
                                : 0;
                    final isSelected = (_assignedFilter ?? 'All') == assignee;
                    return ListTile(
                      title: Text(assignee,
                          style: TextStyle(
                              fontSize: 14,
                              color: isSelected
                                  ? const Color(0xFF520350)
                                  : Colors.black,
                              fontFamily: 'Inter')),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF520350)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12)),
                        child: Text('$count',
                            style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : Colors.black,
                                fontFamily: 'Inter')),
                      ),
                      onTap: () {
                        setModalState(() => _assignedFilter =
                            assignee == 'All' ? null : assignee);
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _exportToExcel() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Exported ${_filteredItems.length} items to CSV'),
        duration: const Duration(seconds: 2)));
  }

  void _addTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTaskPage(assignees: _assignees)),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() => _items.add(ChecklistItem(
          result['title'],
          false,
          result['priority'],
          result['assignedTo'],
          result['addedDate'],
          result['dueDate'])));
    }
  }

  void _editTask(ChecklistItem item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditTaskPage(
                assignees: _assignees,
                initialTitle: item.title,
                initialPriority: item.priority,
                initialAssignedTo: item.assignedTo,
                initialDueDate: item.dueDate,
                initialDescription: item.description,
              )),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        item.title = result['title'];
        item.priority = result['priority'];
        item.assignedTo = result['assignedTo'];
        item.dueDate = result['dueDate'];
      });
    }
  }

  Widget _buildChecklistCard(ChecklistItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(item.title,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF520350),
                            fontFamily: 'Inter'))),
                IconButton(
                  icon: Icon(
                      item.isCompleted
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: item.isCompleted ? Colors.green : Colors.grey,
                      size: 20),
                  onPressed: () =>
                      setState(() => item.isCompleted = !item.isCompleted),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 20),
                  padding: EdgeInsets.zero,
                  onSelected: (value) {
                    if (value == 'edit') {
                      _editTask(item);
                    } else if (value == 'mark') {
                      setState(() => item.isCompleted = true);
                    } else if (value == 'delete') {
                      setState(() => _items.remove(item));
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit',
                            style: TextStyle(fontFamily: 'Inter'))),
                    const PopupMenuItem(
                        value: 'mark',
                        child: Text('Mark as Read',
                            style: TextStyle(fontFamily: 'Inter'))),
                    const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete',
                            style: TextStyle(
                                fontFamily: 'Inter', color: Colors.red))),
                  ],
                ),
              ],
            ),
            if (item.description != null && item.description!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(item.description!,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontFamily: 'Inter'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                    child:
                        _buildInfoRow(Icons.flag, 'Priority', item.priority)),
                const SizedBox(width: 4),
                Expanded(
                    child: _buildInfoRow(
                        Icons.person, 'Assigned', item.assignedTo ?? '-')),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                    child: _buildInfoRow(
                        Icons.calendar_today, 'Added', item.addedDate)),
                const SizedBox(width: 4),
                Expanded(
                    child:
                        _buildInfoRow(Icons.event, 'Due', item.dueDate ?? '-')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey[600],
                      fontFamily: 'Inter')),
              Text(value,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter'),
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}

class ChecklistItem {
  String title;
  bool isCompleted;
  String priority;
  String? assignedTo;
  String addedDate;
  String? dueDate;
  String? description;

  ChecklistItem(this.title, this.isCompleted, this.priority, this.assignedTo,
      this.addedDate, this.dueDate,
      [this.description]);
}
