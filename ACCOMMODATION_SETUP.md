# Guest Accommodation Database Setup

## Step 1: Import the Table Structure

1. Open phpMyAdmin: http://localhost/phpmyadmin
2. Select your `event` database from the left sidebar
3. Click on the "SQL" tab at the top
4. Copy and paste the SQL below
5. Click "Go" to execute

## SQL to Execute:

```sql
-- Drop existing table if you want to recreate
-- DROP TABLE IF EXISTS `event_accommodation`;

CREATE TABLE IF NOT EXISTS `event_accommodation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `attendee_id` int(11) DEFAULT NULL,
  `guest_name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `hotel_name` varchar(255) DEFAULT NULL,
  `room_number` varchar(50) DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `room_type` enum('Single','Double','Suite','Deluxe') DEFAULT 'Double',
  `pickup_required` tinyint(1) DEFAULT 0,
  `pickup_location` varchar(255) DEFAULT NULL,
  `pickup_date` date DEFAULT NULL,
  `pickup_time` time DEFAULT NULL,
  `pickup_assigned` varchar(255) DEFAULT NULL,
  `drop_required` tinyint(1) DEFAULT 0,
  `drop_location` varchar(255) DEFAULT NULL,
  `drop_date` date DEFAULT NULL,
  `drop_time` time DEFAULT NULL,
  `special_requirements` text DEFAULT NULL,
  `status` enum('Pending','Confirmed','Checked-In','Checked-Out','Cancelled') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data
INSERT INTO `event_accommodation` (`event_id`, `guest_name`, `phone`, `hotel_name`, `room_number`, `check_in_date`, `check_out_date`, `room_type`, `pickup_required`, `pickup_location`, `pickup_date`, `pickup_time`, `pickup_assigned`, `drop_required`, `status`) VALUES
(1, 'Rajesh Kumar', '9876543210', 'Taj Palace Hotel', '201', '2024-01-12', '2024-01-15', 'Deluxe', 1, 'Airport Terminal 3', '2024-01-12', '14:30:00', 'Driver: Ramesh (Car: DL-01-AB-1234)', 0, 'Confirmed'),
(1, 'Priya Sharma', '9876543211', 'Taj Palace Hotel', '202', '2024-01-12', '2024-01-15', 'Double', 1, 'Railway Station', '2024-01-12', '10:00:00', NULL, 1, 'Confirmed'),
(1, 'Amit Patel', '9876543212', 'Leela Palace', '305', '2024-01-11', '2024-01-16', 'Suite', 1, 'Airport Terminal 2', '2024-01-11', '18:00:00', 'Driver: Suresh (Car: DL-02-CD-5678)', 1, 'Confirmed'),
(1, 'Sneha Gupta', '9876543213', 'Taj Palace Hotel', '203', '2024-01-12', '2024-01-15', 'Double', 0, NULL, NULL, NULL, NULL, 0, 'Confirmed'),
(1, 'Vikram Singh', '9876543214', 'Oberoi Hotel', '401', '2024-01-12', '2024-01-15', 'Deluxe', 1, 'Airport Terminal 3', '2024-01-12', '16:00:00', NULL, 1, 'Pending'),
(1, 'Anita Desai', '9876543215', 'Taj Palace Hotel', '204', '2024-01-12', '2024-01-15', 'Single', 1, 'Bus Stand', '2024-01-12', '12:00:00', 'Driver: Mohan (Car: DL-03-EF-9012)', 0, 'Confirmed'),
(1, 'Rahul Verma', '9876543216', 'Leela Palace', '306', '2024-01-12', '2024-01-15', 'Suite', 0, NULL, NULL, NULL, NULL, 0, 'Confirmed'),
(1, 'Kavita Reddy', '9876543217', 'Taj Palace Hotel', '205', '2024-01-12', '2024-01-15', 'Double', 1, 'Airport Terminal 1', '2024-01-12', '20:00:00', NULL, 1, 'Pending'),
(1, 'Suresh Iyer', '9876543218', 'Oberoi Hotel', '402', '2024-01-11', '2024-01-16', 'Deluxe', 1, 'Railway Station', '2024-01-11', '22:00:00', 'Driver: Ravi (Car: DL-04-GH-3456)', 1, 'Confirmed'),
(1, 'Meera Joshi', '9876543219', 'Taj Palace Hotel', '206', '2024-01-12', '2024-01-15', 'Double', 0, NULL, NULL, NULL, NULL, 0, 'Confirmed');
```

## Step 2: Verify the Data

After importing, you should see:
- **10 guest accommodation records** for event_id = 1
- **6 guests need pickup** (pickup_required = 1)
- **4 pickups assigned** with driver details
- **2 pickups pending** (not yet assigned)

## Step 3: Test in Your App

1. Do a **Hot Restart** of your Flutter app (Shift + R)
2. Navigate to Services → Event Overview
3. Scroll to the "Guest Accommodation" card
4. You should see:
   - Total Guests: 10
   - Need Pickup: 6

## Table Structure Explanation:

### Key Fields:
- `pickup_required`: 1 = needs pickup, 0 = no pickup needed
- `pickup_assigned`: Contains driver and vehicle details when assigned
- `drop_required`: 1 = needs drop, 0 = no drop needed
- `status`: Pending, Confirmed, Checked-In, Checked-Out, Cancelled

### The app calculates:
- **Total Guests**: COUNT of all records
- **Need Pickup**: COUNT where pickup_required = 1
- **Pickup Assigned**: COUNT where pickup_required = 1 AND pickup_assigned IS NOT NULL

## Troubleshooting:

If the card still shows 0:
1. Check if XAMPP MySQL is running
2. Verify the data was imported: `SELECT * FROM event_accommodation WHERE event_id = 1`
3. Check the API endpoint: http://192.168.29.159/event_api/event_accommodation.php?event_id=1
4. Do a complete app restart (not just hot reload)
