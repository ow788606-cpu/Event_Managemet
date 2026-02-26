import 'package:flutter/material.dart';
import '../../../services/database_service.dart';

class UpcomingFavoritesPage extends StatefulWidget {
  const UpcomingFavoritesPage({super.key});

  @override
  State<UpcomingFavoritesPage> createState() => _UpcomingFavoritesPageState();
}

class _UpcomingFavoritesPageState extends State<UpcomingFavoritesPage> {
  int _selectedDayIndex = DateTime.now().weekday % 7;
  List<dynamic> allEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
    // Set selected day to today
    final now = DateTime.now();
    _selectedDayIndex = now.weekday % 7;
  }

  Future<void> _loadEvents() async {
    try {
      final data = await DatabaseService.getEvents();
      setState(() {
        allEvents = data.where((e) => _isUpcoming(e['start_date']?.toString() ?? '')).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  bool _isUpcoming(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      return date.isAfter(todayStart.subtract(const Duration(days: 1))) || 
             date.isAtSameMomentAs(todayStart);
    } catch (_) {
      return false;
    }
  }

  List<Map<String, dynamic>> _getNext7Days() {
    final now = DateTime.now();
    final List<Map<String, dynamic>> days = [];
    final currentWeekday = now.weekday % 7;
    final sunday = now.subtract(Duration(days: currentWeekday));
    
    for (int i = 0; i < 7; i++) {
      final day = sunday.add(Duration(days: i));
      days.add({
        'date': day,
        'dayName': _getDayName(day.weekday % 7),
        'dayNumber': day.day,
        'month': _getMonthName(day.month),
        'isToday': day.day == now.day && day.month == now.month && day.year == now.year,
      });
    }
    return days;
  }

  String _getDayName(int weekday) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[weekday];
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  List<dynamic> _getEventsForSelectedDay() {
    final days = _getNext7Days();
    final selectedDate = days[_selectedDayIndex]['date'] as DateTime;
    return allEvents.where((event) {
      try {
        final eventDate = DateTime.parse(event['start_date']?.toString() ?? '');
        return eventDate.year == selectedDate.year &&
               eventDate.month == selectedDate.month &&
               eventDate.day == selectedDate.day;
      } catch (_) {
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF520350)));
    }

    final days = _getNext7Days();
    final events = _getEventsForSelectedDay();

    return Container(
      color: const Color(0xFFE7DFE7),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${days[_selectedDayIndex]['month']} ${DateTime.now().year}',
                        style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                  height: height * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      final day = days[index];
                      final isSelected = _selectedDayIndex == index;
                      final isToday = day['isToday'];
                      
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDayIndex = index),
                        child: Container(
                          width: width * 0.13,
                          margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF520350) : (isToday ? const Color(0xFFE7DFE7) : Colors.transparent),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isToday && !isSelected ? const Color(0xFF520350) : Colors.transparent, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                day['dayName'],
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: isSelected ? Colors.white : Colors.grey[600],
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(height: height * 0.005),
                              Text(
                                '${day['dayNumber']}',
                                style: TextStyle(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: events.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy, size: width * 0.2, color: Colors.grey[400]),
                        SizedBox(height: height * 0.02),
                        Text('No events on this day', style: TextStyle(fontSize: width * 0.045, color: Colors.grey, fontFamily: 'Inter')),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(width * 0.04),
                    itemCount: events.length,
                    itemBuilder: (context, index) => _buildEventCard(events[index], width, height),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(dynamic event, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event['title']?.toString() ?? 'Event', style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Icon(Icons.calendar_today, size: width * 0.04, color: Colors.grey[600]),
                SizedBox(width: width * 0.02),
                Text('${event['start_date']} - ${event['end_date']}', style: TextStyle(fontSize: width * 0.035, color: Colors.grey[600], fontFamily: 'Inter')),
              ],
            ),
            SizedBox(height: height * 0.005),
            Row(
              children: [
                Icon(Icons.location_on, size: width * 0.04, color: Colors.grey[600]),
                SizedBox(width: width * 0.02),
                Expanded(child: Text(event['venue']?.toString() ?? event['location']?.toString() ?? '', style: TextStyle(fontSize: width * 0.035, color: Colors.grey[600], fontFamily: 'Inter'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
