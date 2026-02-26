import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final int initialTab;
  const EventsPage({super.key, this.scaffoldKey, required this.initialTab});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DFE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFF520350),
            statusBarIconBrightness: Brightness.light),
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
              const PopupMenuItem(
                  child: Text('Filter', style: TextStyle(fontFamily: 'Inter'))),
              const PopupMenuItem(
                  child: Text('Sort', style: TextStyle(fontFamily: 'Inter'))),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Events Page',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
