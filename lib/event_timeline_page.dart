import 'package:flutter/material.dart';
import 'add_function_page.dart';
import 'edit_function_page.dart';

class EventTimelinePage extends StatefulWidget {
  const EventTimelinePage({super.key});

  @override
  State<EventTimelinePage> createState() => _EventTimelinePageState();
}

class _EventTimelinePageState extends State<EventTimelinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: _showFilterDialog,
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter',
                      style: TextStyle(fontFamily: 'Inter', fontSize: 14)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _downloadCSV,
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Download',
                      style: TextStyle(fontFamily: 'Inter', fontSize: 14)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection('Timeline', '03 Feb 2026', [
              _buildEvent(
                  'Welcome',
                  '12:00-16:00',
                  'Resort Lobby',
                  'Welcome drinks, room allocation, leisure time',
                  Colors.purple),
              _buildEvent('Welcome Lunch', '13:30-15:30', 'Dining Restaurant',
                  'Casual lunch, relaxed dress code', Colors.purple),
              _buildEvent(
                  'Welcome Soiree',
                  '18:00-20:30',
                  'Poolside / Beachfront',
                  'Light music, cocktails, sunset gathering',
                  Colors.purple),
              _buildEvent('night meet & gala', '20:00-21:30',
                  'party hall noters', '', Colors.purple),
            ]),
            const SizedBox(height: 16),
            _buildSection('Colors & Culture', '04 Feb 2026', [
              _buildEvent('Haldi Ceremony', '09:00-11:00', 'Garden Lawn',
                  'Yellow theme, floral decor, organic colors', Colors.purple),
              _buildEvent(
                  'Mehndi by the Pool',
                  '13:00-17:00',
                  'Poolside Cabana',
                  'Henna artists, live music, relaxed daytime event',
                  Colors.purple),
              _buildEvent(
                  'Sundowner Chaat Party',
                  '18:30-20:30',
                  'Terrace Lounge',
                  'Street food counters, casual gathering',
                  Colors.purple),
            ]),
            const SizedBox(height: 16),
            _buildSection('Music & Magic', '05 Feb 2026', [
              _buildEvent('Family Brunch', '10:30-12:30', 'Resort Cafe',
                  'Close family brunch', Colors.purple),
              _buildEvent(
                  'Sangeet Rehearsals & Sound Check',
                  '15:00-17:00',
                  'Ballroom',
                  'Performers and family coordination',
                  Colors.purple),
              _buildEvent('Sangeet Night', '19:00-23:00', 'Grand Ballroom',
                  'Dance performances, DJ, cocktail night', Colors.purple),
            ]),
            const SizedBox(height: 16),
            _buildSection('The Grand Union', '06 Feb 2026', [
              _buildEvent(
                  'Wedding Rituals & Preparations',
                  '09:00-11:00',
                  'Bride & Groom Suites',
                  'Hair, makeup, traditional rituals',
                  Colors.purple),
              _buildEvent('Wedding Ceremony', '16:30-18:30', 'Beach Mandap',
                  'Main wedding ceremony', Colors.purple),
              _buildEvent('Reception Gala', '20:00-23:59', 'Banquet Hall',
                  'Formal reception, dinner & celebrations', Colors.purple),
            ]),
            const SizedBox(height: 16),
            _buildSection('Farewell with Love', '07 Feb 2026', [
              _buildEvent(
                  'Post-Wedding Brunch',
                  '10:00-12:00',
                  'Beachside Cafe',
                  'Relaxed brunch with family and friends',
                  Colors.purple),
              _buildEvent('Vidaai Ceremony', '12:30-13:30', 'Resort Entrance',
                  'Emotional farewell ceremony', Colors.purple),
              _buildEvent('Guest Departures', '14:00-18:00', 'Resort Lobby',
                  'Check-out and transport assistance', Colors.purple),
            ]),
          ],
        ),
      ),
    );
  }

  void _downloadCSV() {
    final csvData = StringBuffer();
    csvData.writeln('Event Day,Function Name,Start Time,End Time,Location,Notes');
    csvData.writeln('Timeline (03 Feb 2026),Welcome,12:00,16:00,Resort Lobby,Welcome drinks room allocation leisure time');
    csvData.writeln('Timeline (03 Feb 2026),Welcome Lunch,13:30,15:30,Dining Restaurant,Casual lunch relaxed dress code');
    csvData.writeln('Timeline (03 Feb 2026),Welcome Soiree,18:00,20:30,Poolside / Beachfront,Light music cocktails sunset gathering');
    csvData.writeln('Timeline (03 Feb 2026),night meet & gala,20:00,21:30,party hall noters,');
    csvData.writeln('Colors & Culture (04 Feb 2026),Haldi Ceremony,09:00,11:00,Garden Lawn,Yellow theme floral decor organic colors');
    csvData.writeln('Colors & Culture (04 Feb 2026),Mehndi by the Pool,13:00,17:00,Poolside Cabana,Henna artists live music relaxed daytime event');
    csvData.writeln('Colors & Culture (04 Feb 2026),Sundowner Chaat Party,18:30,20:30,Terrace Lounge,Street food counters casual gathering');
    csvData.writeln('Music & Magic (05 Feb 2026),Family Brunch,10:30,12:30,Resort Cafe,Close family brunch');
    csvData.writeln('Music & Magic (05 Feb 2026),Sangeet Rehearsals & Sound Check,15:00,17:00,Ballroom,Performers and family coordination');
    csvData.writeln('Music & Magic (05 Feb 2026),Sangeet Night,19:00,23:00,Grand Ballroom,Dance performances DJ cocktail night');
    csvData.writeln('The Grand Union (06 Feb 2026),Wedding Rituals & Preparations,09:00,11:00,Bride & Groom Suites,Hair makeup traditional rituals');
    csvData.writeln('The Grand Union (06 Feb 2026),Wedding Ceremony,16:30,18:30,Beach Mandap,Main wedding ceremony');
    csvData.writeln('The Grand Union (06 Feb 2026),Reception Gala,20:00,23:59,Banquet Hall,Formal reception dinner & celebrations');
    csvData.writeln('Farewell with Love (07 Feb 2026),Post-Wedding Brunch,10:00,12:00,Beachside Cafe,Relaxed brunch with family and friends');
    csvData.writeln('Farewell with Love (07 Feb 2026),Vidaai Ceremony,12:30,13:30,Resort Entrance,Emotional farewell ceremony');
    csvData.writeln('Farewell with Love (07 Feb 2026),Guest Departures,14:00,18:00,Resort Lobby,Check-out and transport assistance');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded: ${csvData.toString().split('\n').length - 2} events', style: const TextStyle(fontFamily: 'Inter'))),
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

  Widget _buildSection(String title, String date, List<Widget> events) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('$title ($date)',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter')),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddFunctionPage(sectionTitle: title)),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('+ Add Function',
                      style: TextStyle(fontSize: 12, fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
          ...events,
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
