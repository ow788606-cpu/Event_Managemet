import '../models/event_model.dart';

enum BookingStatus { upcoming, completed, cancelled }

class Booking {
  final String bookingId;
  final Event event;
  final int ticketCount;
  final double totalAmount;
  BookingStatus status;
  final DateTime bookingDate;

  Booking({
    required this.bookingId,
    required this.event,
    required this.ticketCount,
    required this.totalAmount,
    required this.status,
    required this.bookingDate,
  });
}

class BookingsManager {
  static final List<Booking> _bookings = [];
  static int _bookingCounter = 1000;

  static List<Booking> getBookings() => List.unmodifiable(_bookings);

  static String addBooking(Event event, int ticketCount) {
    final bookingId = 'BK${_bookingCounter++}';
    final booking = Booking(
      bookingId: bookingId,
      event: event,
      ticketCount: ticketCount,
      totalAmount: event.price * ticketCount,
      status: BookingStatus.upcoming,
      bookingDate: DateTime.now(),
    );
    _bookings.insert(0, booking);
    return bookingId;
  }

  static void cancelBooking(String bookingId) {
    final booking = _bookings.firstWhere((b) => b.bookingId == bookingId);
    booking.status = BookingStatus.cancelled;
  }

  static void completeBooking(String bookingId) {
    final booking = _bookings.firstWhere((b) => b.bookingId == bookingId);
    booking.status = BookingStatus.completed;
  }
}
