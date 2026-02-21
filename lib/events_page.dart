import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/event_model.dart';
import 'favorites_manager.dart';
import 'services_manager.dart';

class EventsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final int initialTab;
  const EventsPage({super.key, this.scaffoldKey, required this.initialTab});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  final List<Event> clubEvents = [
    Event(
      id: '1',
      title: 'Music Festival 2024',
      date: '15 February 2025',
      time: '6 PM to 11 PM',
      location: 'Central Park',
      price: 151.00,
      imageUrl: 'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=400',
      description: 'Join us for an amazing night of live music featuring top artists.',
    ),
    Event(
      id: '2',
      title: 'Tech Conference 2024',
      date: '16 February 2025',
      time: '9 AM to 5 PM',
      location: 'Convention Center',
      price: 121.00,
      imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=400',
      description: 'Explore the latest in technology and innovation.',
    ),
    Event(
      id: '3',
      title: 'Food & Wine Expo',
      date: '20 February 2025',
      time: '12 PM to 8 PM',
      location: 'Grand Hotel',
      price: 125.00,
      imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
      description: 'Taste exquisite dishes and premium wines from around the world.',
    ),
    Event(
      id: '4',
      title: 'Art Exhibition',
      date: '25 February 2025',
      time: '10 AM to 6 PM',
      location: 'City Gallery',
      price: 130.00,
      imageUrl: 'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=400',
      description: 'Discover contemporary art from emerging artists.',
    ),
  ];

  final List<Event> localEvents = [
    Event(
      id: '5',
      title: 'Community Yoga Session',
      date: '18 February 2025',
      time: '7 AM to 9 AM',
      location: 'Local Park',
      price: 25.00,
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      description: 'Start your day with a refreshing yoga session.',
    ),
    Event(
      id: '6',
      title: 'Farmers Market',
      date: '19 February 2025',
      time: '8 AM to 2 PM',
      location: 'Town Square',
      price: 0.00,
      imageUrl: 'https://images.unsplash.com/photo-1488459716781-31db52582fe9?w=400',
      description: 'Fresh produce and local crafts from community vendors.',
    ),
    Event(
      id: '7',
      title: 'Book Club Meetup',
      date: '22 February 2025',
      time: '5 PM to 7 PM',
      location: 'Local Library',
      price: 10.00,
      imageUrl: 'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=400',
      description: 'Discuss this month\'s featured book with fellow readers.',
    ),
    Event(
      id: '8',
      title: 'Street Food Festival',
      date: '28 February 2025',
      time: '4 PM to 10 PM',
      location: 'Main Street',
      price: 15.00,
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400',
      description: 'Enjoy delicious street food from local vendors.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Color(0xFF520350), statusBarIconBrightness: Brightness.light),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => widget.scaffoldKey?.currentState?.openDrawer(),
        ),
        title: const Text(
          'Eventam',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(child: Text('Filter', style: TextStyle(fontFamily: 'Inter'))),
              const PopupMenuItem(child: Text('Sort', style: TextStyle(fontFamily: 'Inter'))),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 0 ? const Color(0xFF520350) : Colors.grey[300]!,
                              width: _selectedTab == 0 ? 2 : 1,
                            ),
                          ),
                        ),
                        child: Text(
                          'Club Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                            color: _selectedTab == 0 ? Colors.black : Colors.grey,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 1 ? const Color(0xFF520350) : Colors.grey[300]!,
                              width: _selectedTab == 1 ? 2 : 1,
                            ),
                          ),
                        ),
                        child: Text(
                          'Local Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                            color: _selectedTab == 1 ? Colors.black : Colors.grey,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: height * 0.015),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE7DFE7),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Icon(Icons.calendar_today, size: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              ...(_selectedTab == 0 ? clubEvents : localEvents).map((event) => _buildEventCard(event, width, height)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Event event, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      decoration: BoxDecoration(
        color: const Color(0xFFE7DFE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.04, width * 0.03, width * 0.04, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => FavoritesManager.toggleFavorite(event));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(FavoritesManager.isFavorite(event.id) ? 'Added to favorites' : 'Removed from favorites'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * 0.025),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      FavoritesManager.isFavorite(event.id) ? Icons.bookmark : Icons.bookmark_border,
                      size: 22,
                      color: const Color(0xFF520350),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.04, width * 0.02, width * 0.04, width * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.28,
                  height: width * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      event.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey, size: 40),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: height * 0.012),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: width * 0.04, color: Colors.grey[700]),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            child: Text(
                              event.date,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey[700],
                                fontFamily: 'Inter',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.008),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: width * 0.04, color: Colors.grey[700]),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            child: Text(
                              event.time,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey[700],
                                fontFamily: 'Inter',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.008),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: width * 0.04, color: Colors.grey[700]),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey[700],
                                fontFamily: 'Inter',
                              ),
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.04, width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.price == 0 ? 'FREE' : '\$${event.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF520350),
                    fontFamily: 'Inter',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showServiceDialog(event),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.015),
                    elevation: 0,
                  ),
                  child: Text(
                    'Request Service',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showServiceDialog(Event event) {
    String selectedType = 'Standard';
    final notesController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Request Service', style: TextStyle(fontFamily: 'Inter')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: selectedType,
                decoration: const InputDecoration(labelText: 'Service Type', border: OutlineInputBorder()),
                items: ['Standard', 'Premium', 'VIP'].map((type) => DropdownMenuItem(value: type, child: Text(type, style: const TextStyle(fontFamily: 'Inter')))).toList(),
                onChanged: (value) => setDialogState(() => selectedType = value!),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Additional Notes', border: OutlineInputBorder()),
                style: const TextStyle(fontFamily: 'Inter'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontFamily: 'Inter'))),
            ElevatedButton(
              onPressed: () {
                final requestId = ServicesManager.addRequest(event, selectedType, notesController.text);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Service requested! ID: $requestId')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF520350)),
              child: const Text('Submit Request', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
            ),
          ],
        ),
      ),
    );
  }
}
