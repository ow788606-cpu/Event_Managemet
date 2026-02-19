import '../models/event_model.dart';

class FavoritesManager {
  static final List<Event> _favorites = [];

  static List<Event> getFavorites() => List.unmodifiable(_favorites);

  static bool isFavorite(String eventId) => _favorites.any((e) => e.id == eventId);

  static void addFavorite(Event event) {
    if (!isFavorite(event.id)) _favorites.add(event);
  }

  static void removeFavorite(String eventId) {
    _favorites.removeWhere((e) => e.id == eventId);
  }

  static void toggleFavorite(Event event) {
    isFavorite(event.id) ? removeFavorite(event.id) : addFavorite(event);
  }

  static void clearAll() => _favorites.clear();
}
