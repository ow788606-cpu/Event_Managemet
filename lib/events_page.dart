import 'package:flutter/material.dart';
import '../models/event_model.dart';

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
              // Tabs
              Row(
                children: [
                  // ignore: prefer_const_constructors
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: const Color(0xFF520350), width: 2),
                          ),
                        ),
                        child: Text(
                          'Club Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.037,
                            color: Colors.grey,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                          ),
                        ),
                        child: Text(
                          'Local Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.037,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
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
                          Text(
                            'TODAY',
                            style: TextStyle(
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          const Icon(Icons.arrow_drop_down, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              // Events List
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
          // Card Header with Icon
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(width * 0.02),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bookmark, size: 20, color: Color(0xFF520350)),
                  ),
                ),
              ],
            ),
          ),
          // Card Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                // Image
                Container(
                  width: width * 0.2,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Image.network(
                    event.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
                SizedBox(width: width * 0.04),
                // Event Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.date,
                        style: TextStyle(
                          fontSize: width * 0.03,
                          color: Colors.grey,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        event.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: width * 0.034,
                          color: Colors.black,
                          height: 1.4,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          Text(
                            event.location,
                            style: TextStyle(
                              fontSize: width * 0.032,
                              color: Colors.grey,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          const Text('•', style: TextStyle(color: Colors.grey)),
                          SizedBox(width: width * 0.02),
                          Text(
                            event.time,
                            style: TextStyle(
                              fontSize: width * 0.032,
                              color: Colors.grey,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width * 0.02),
                // Price
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${event.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF520350),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.015),
        ],
      ),
    );
  }
}
