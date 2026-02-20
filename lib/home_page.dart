import 'package:flutter/material.dart';
import 'events_page.dart';
import 'login_page.dart';
import 'add_event_page.dart';
import 'add_client_page.dart';
import 'add_vendor_page.dart';
import 'all_clients_page.dart';
import 'upcoming_events_page.dart';
import 'all_events_page.dart';
import 'completed_events_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: _buildDrawer(context),
        body: EventsPage(scaffoldKey: scaffoldKey),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF520350), Color(0xFF8B1874)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white24,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            _drawerItem(context, Icons.home, 'Home', () => Navigator.pop(context)),
            ExpansionTile(
              leading: const Icon(Icons.event, color: Colors.white),
              title: const Text('Events', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              children: [
                _drawerSubItem(context, Icons.add_circle_outline, 'Add Event', () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEventPage()));
                }),
                _drawerSubItem(context, Icons.upcoming, 'Upcoming', () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UpcomingEventsPage()));
                }),
                _drawerSubItem(context, Icons.list, 'All Events', () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AllEventsPage()));
                }),
                _drawerSubItem(context, Icons.check_circle_outline, 'Completed', () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CompletedEventsPage()));
                }),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.people, color: Colors.white),
              title: const Text('Clients', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              children: [
                _drawerSubItem(context, Icons.person_add, 'Add Client', () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddClientPage()));
                }),
                _drawerSubItem(context, Icons.people_outline, 'All Clients', () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AllClientsPage()));
                }),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.store, color: Colors.white),
              title: const Text('Vendors', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              children: [
                _drawerSubItem(context, Icons.add_business, 'Add Vendor', () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddVendorPage()));
                }),
                _drawerSubItem(context, Icons.storefront, 'All Vendors', () {
                  Navigator.pop(context);
                }),
              ],
            ),
            const Divider(color: Colors.white24),
            _drawerItem(context, Icons.settings, 'Settings', () => Navigator.pop(context)),
            _drawerItem(context, Icons.logout, 'Logout', () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              await prefs.remove('userName');
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white, fontFamily: 'Inter')),
      onTap: onTap,
    );
  }

  Widget _drawerSubItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 20),
      title: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14, fontFamily: 'Inter')),
      contentPadding: const EdgeInsets.only(left: 72, right: 16),
      onTap: onTap,
    );
  }
}
