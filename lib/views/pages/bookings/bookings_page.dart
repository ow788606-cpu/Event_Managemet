import 'package:flutter/material.dart';
import 'bookings_manager.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final bookings = BookingsManager.getBookings();
    final upcoming =
        bookings.where((b) => b.status == BookingStatus.upcoming).toList();
    final completed =
        bookings.where((b) => b.status == BookingStatus.completed).toList();
    final cancelled =
        bookings.where((b) => b.status == BookingStatus.cancelled).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: const Color(0xFF520350),
        elevation: 0,
        title: const Text('My Bookings',
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFE7DFE7),
          labelColor: const Color(0xFFE7DFE7),
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Upcoming (${upcoming.length})'),
            Tab(text: 'Completed (${completed.length})'),
            Tab(text: 'Cancelled (${cancelled.length})'),
          ],
          labelStyle: const TextStyle(fontFamily: 'Inter'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(upcoming, width, height, BookingStatus.upcoming),
          _buildBookingsList(completed, width, height, BookingStatus.completed),
          _buildBookingsList(cancelled, width, height, BookingStatus.cancelled),
        ],
      ),
      ),
    );
  }

  Widget _buildBookingsList(List<Booking> bookings, double width, double height,
      BookingStatus status) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: width * 0.2, color: Colors.grey[300]),
            SizedBox(height: height * 0.02),
            Text('No ${status.name} bookings',
                style: TextStyle(fontSize: width * 0.045, color: Colors.grey, fontFamily: 'Inter')),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(width * 0.04),
      itemCount: bookings.length,
      itemBuilder: (context, index) =>
          _buildBookingCard(bookings[index], width, height),
    );
  }

  Widget _buildBookingCard(Booking booking, double width, double height) {
    final statusColor = booking.status == BookingStatus.upcoming
        ? Colors.green
        : booking.status == BookingStatus.completed
            ? Colors.blue
            : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.04),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.confirmation_number,
                        color: statusColor, size: width * 0.05),
                    SizedBox(width: width * 0.02),
                    Text('Booking #${booking.bookingId}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.038,
                            fontFamily: 'Inter')),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.005),
                  decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(booking.status.name.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(booking.event.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.event, size: 40)),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(booking.event.title,
                              style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter')),
                          SizedBox(height: height * 0.008),
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: width * 0.035, color: Colors.grey[600]),
                              SizedBox(width: width * 0.01),
                              Text(booking.event.date,
                                  style: TextStyle(
                                      fontSize: width * 0.032,
                                      color: Colors.grey[600],
                                      fontFamily: 'Inter')),
                            ],
                          ),
                          SizedBox(height: height * 0.005),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: width * 0.035, color: Colors.grey[600]),
                              SizedBox(width: width * 0.01),
                              Text(booking.event.time,
                                  style: TextStyle(
                                      fontSize: width * 0.032,
                                      color: Colors.grey[600],
                                      fontFamily: 'Inter')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.015),
                Container(
                  padding: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tickets',
                              style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Colors.grey[600],
                                  fontFamily: 'Inter')),
                          Text('${booking.ticketCount}x',
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter')),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Total Amount',
                              style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: Colors.grey[600],
                                  fontFamily: 'Inter')),
                          Text('\$${booking.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF520350),
                                  fontFamily: 'Inter')),
                        ],
                      ),
                    ],
                  ),
                ),
                if (booking.status == BookingStatus.upcoming) ...[
                  SizedBox(height: height * 0.015),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showQRCode(booking),
                          icon: const Icon(Icons.qr_code, size: 18),
                          label: const Text('View Ticket', style: TextStyle(fontFamily: 'Inter')),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF520350),
                            side: const BorderSide(color: Color(0xFF520350)),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _cancelBooking(booking),
                          icon: const Icon(Icons.cancel, size: 18),
                          label: const Text('Cancel', style: TextStyle(fontFamily: 'Inter')),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showQRCode(Booking booking) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Your Ticket',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const Icon(Icons.qr_code_2,
                        size: 150, color: Color(0xFF520350)),
                    const SizedBox(height: 10),
                    Text('Booking #${booking.bookingId}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(booking.event.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: 5),
              Text('${booking.event.date} • ${booking.event.time}',
                  style: TextStyle(color: Colors.grey[600], fontFamily: 'Inter')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF520350)),
                child: const Text('Close', style: TextStyle(fontFamily: 'Inter')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cancelBooking(Booking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking', style: TextStyle(fontFamily: 'Inter')),
        content: const Text('Are you sure you want to cancel this booking?', style: TextStyle(fontFamily: 'Inter')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('No', style: TextStyle(fontFamily: 'Inter'))),
          TextButton(
            onPressed: () {
              setState(() => BookingsManager.cancelBooking(booking.bookingId));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Booking cancelled successfully')));
            },
            child:
                const Text('Yes, Cancel', style: TextStyle(color: Colors.red, fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }
}
