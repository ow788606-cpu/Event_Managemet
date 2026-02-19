import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'favorites_manager.dart';
import 'bookings_manager.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final List<Event> events = [
    Event(
      id: '1',
      title: 'CR Summit East - 2020',
      date: '15 February 2020',
      time: '2 PM to 4 PM',
      location: 'Ommeago In',
      price: 151.00,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    Event(
      id: '2',
      title: 'CR Summit West - 2020',
      date: '16 February 2020',
      time: '2 PM to 4 PM',
      location: 'Ommeago In',
      price: 121.00,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    Event(
      id: '3',
      title: 'CR Summit East - 2020',
      date: '14 February 2020',
      time: '2 PM to 4 PM',
      location: 'Ommeago In',
      price: 125.00,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    Event(
      id: '4',
      title: 'CR Summit East - 2020',
      date: '17 February 2020',
      time: '2 PM to 4 PM',
      location: 'Ommeago In',
      price: 130.00,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
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
        title: Text(
          'Club Events',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(child: Text('Filter')),
              const PopupMenuItem(child: Text('Sort')),
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
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFF520350), width: 2)),
                        ),
                        child: Text(
                          'Club Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: width * 0.037, color: Colors.grey, fontFamily: 'Inter'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
                        ),
                        child: Text(
                          'Local Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: width * 0.037, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Inter'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: height * 0.015),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE7DFE7),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('TODAY', style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Inter')),
                          SizedBox(width: width * 0.01),
                          const Icon(Icons.arrow_drop_down, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              ...events.map((event) => _buildEventCard(event, width, height)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Event event, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.018),
      decoration: BoxDecoration(
        color: const Color(0xFFE7DFE7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Inter'),
                ),
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
                    padding: EdgeInsets.all(width * 0.02),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      FavoritesManager.isFavorite(event.id) ? Icons.bookmark : Icons.bookmark_border,
                      size: 20,
                      color: const Color(0xFF520350),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  height: height * 0.1,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      event.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: width * 0.035, color: Colors.grey[700]),
                          SizedBox(width: width * 0.015),
                          Text(event.date, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[700], fontFamily: 'Inter')),
                        ],
                      ),
                      SizedBox(height: height * 0.005),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: width * 0.035, color: Colors.grey[700]),
                          SizedBox(width: width * 0.015),
                          Text(event.time, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[700], fontFamily: 'Inter')),
                        ],
                      ),
                      SizedBox(height: height * 0.005),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: width * 0.035, color: Colors.grey[700]),
                          SizedBox(width: width * 0.015),
                          Text(event.location, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[700], fontFamily: 'Inter')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.015),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${event.price.toStringAsFixed(2)}', style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.bold, color: const Color(0xFF520350), fontFamily: 'Inter')),
                ElevatedButton(
                  onPressed: () => _showBookingDialog(event),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.012),
                  ),
                  child: Text('Book Now', style: TextStyle(color: Colors.white, fontSize: width * 0.035, fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.015),
        ],
      ),
    );
  }

  void _showBookingDialog(Event event) {
    int ticketCount = 1;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Book Tickets'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of Tickets:'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (ticketCount > 1) setDialogState(() => ticketCount--);
                        },
                      ),
                      Text('$ticketCount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setDialogState(() => ticketCount++),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Amount:'),
                  Text('\$${(event.price * ticketCount).toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF520350))),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final bookingId = BookingsManager.addBooking(event, ticketCount);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking confirmed! ID: $bookingId')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF520350)),
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
