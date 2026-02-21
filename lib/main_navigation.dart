import 'package:flutter/material.dart';
import 'home_page.dart';
import 'favorites_page.dart';
import 'services_page.dart';

class MainNavigation extends StatefulWidget {
  final String userName;

  const MainNavigation({super.key, required this.userName});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage(userName: widget.userName, initialTab: 0);
      case 1:
        return const FavoritesPage();
      case 2:
        return const ServicesPage(initialTab: 0);
      default:
        return HomePage(userName: widget.userName, initialTab: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF520350),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.design_services), label: 'Services'),
        ],
        selectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
      ),
    );
  }
}
