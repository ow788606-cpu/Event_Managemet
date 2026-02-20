import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'favorites_manager.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final favorites = FavoritesManager.getFavorites();
    final filteredFavorites = favorites.where((event) {
      final matchesSearch = event.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.location.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Upcoming' && _isUpcoming(event.date)) ||
          (_selectedFilter == 'Past' && !_isUpcoming(event.date));
      return matchesSearch && matchesFilter;
    }).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        title: const Text('My Favorites', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            onPressed: () {
              if (favorites.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear All', style: TextStyle(fontFamily: 'Inter')),
                    content: const Text('Remove all favorites?', style: TextStyle(fontFamily: 'Inter')),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontFamily: 'Inter'))),
                      TextButton(
                        onPressed: () {
                          setState(() => FavoritesManager.clearAll());
                          Navigator.pop(context);
                        },
                        child: const Text('Clear', style: TextStyle(color: Colors.red, fontFamily: 'Inter')),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF520350),
            padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.04, height * 0.02),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search favorites...',
                    hintStyle: const TextStyle(fontFamily: 'Inter'),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  style: const TextStyle(fontFamily: 'Inter'),
                ),
                SizedBox(height: height * 0.015),
                Row(
                  children: ['All', 'Upcoming', 'Past'].map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFilter = filter),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                          padding: EdgeInsets.symmetric(vertical: height * 0.012),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE7DFE7) : Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            filter,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredFavorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: width * 0.2, color: Colors.grey[300]),
                        SizedBox(height: height * 0.02),
                        Text(
                          favorites.isEmpty ? 'No favorites yet' : 'No results found',
                          style: TextStyle(fontSize: width * 0.045, color: Colors.grey, fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(width * 0.04),
                    itemCount: filteredFavorites.length,
                    itemBuilder: (context, index) {
                      final event = filteredFavorites[index];
                      return _buildFavoriteCard(event, width, height);
                    },
                  ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildFavoriteCard(Event event, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE7DFE7), Color(0xFFF5F0F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Row(
          children: [
            Container(
              width: width * 0.22,
              height: height * 0.11,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(event.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.event, size: 40)),
              ),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  SizedBox(height: height * 0.005),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: width * 0.035, color: Colors.grey[600]),
                      SizedBox(width: width * 0.01),
                      Text(event.date, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[600], fontFamily: 'Inter')),
                    ],
                  ),
                  SizedBox(height: height * 0.003),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: width * 0.035, color: Colors.grey[600]),
                      SizedBox(width: width * 0.01),
                      Text(event.location, style: TextStyle(fontSize: width * 0.032, color: Colors.grey[600], fontFamily: 'Inter')),
                    ],
                  ),
                  SizedBox(height: height * 0.005),
                  Text('\$${event.price.toStringAsFixed(2)}', style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.bold, color: const Color(0xFF520350), fontFamily: 'Inter')),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () => setState(() => FavoritesManager.removeFavorite(event.id)),
            ),
          ],
        ),
      ),
    );
  }

  bool _isUpcoming(String date) {
    try {
      final parts = date.split(' ');
      final day = int.parse(parts[0]);
      final month = _monthToNumber(parts[1]);
      final year = int.parse(parts[2]);
      final eventDate = DateTime(year, month, day);
      return eventDate.isAfter(DateTime.now());
    } catch (_) {
      return true;
    }
  }

  int _monthToNumber(String month) {
    const months = {'January': 1, 'February': 2, 'March': 3, 'April': 4, 'May': 5, 'June': 6, 'July': 7, 'August': 8, 'September': 9, 'October': 10, 'November': 11, 'December': 12};
    return months[month] ?? 1;
  }
}
