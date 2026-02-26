-- Guest Accommodation Data for Event Overview Card
-- Import this in phpMyAdmin: http://localhost/phpmyadmin

-- Create table if not exists
CREATE TABLE IF NOT EXISTS `event_accommodation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `guest_name` varchar(255) NOT NULL,
  `hotel_name` varchar(255) DEFAULT NULL,
  `room_number` varchar(50) DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `pickup_required` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Clear existing data for event_id = 1
DELETE FROM `event_accommodation` WHERE `event_id` = 1;

-- Insert sample accommodation data
INSERT INTO `event_accommodation` (`event_id`, `guest_name`, `hotel_name`, `room_number`, `check_in_date`, `check_out_date`, `pickup_required`) VALUES
(1, 'Rajesh Kumar', 'Taj Palace Hotel', '201', '2024-02-03', '2024-02-07', 1),
(1, 'Priya Sharma', 'Leela Palace', '305', '2024-02-04', '2024-02-07', 1),
(1, 'Amit Patel', 'Oberoi Hotel', '402', '2024-02-05', '2024-02-07', 0),
(1, 'Sneha Gupta', 'Taj Palace Hotel', '203', '2024-02-06', '2024-02-07', 1),
(1, 'Vikram Singh', 'Leela Palace', '108', '2024-02-07', '2024-02-07', 1),
(1, 'Anita Desai', 'Taj Palace Hotel', '204', '2024-02-03', '2024-02-07', 0),
(1, 'Rahul Verma', 'Oberoi Hotel', '501', '2024-02-04', '2024-02-07', 1),
(1, 'Kavita Reddy', 'Leela Palace', '210', '2024-02-05', '2024-02-07', 0);

-- Verify the data
SELECT * FROM `event_accommodation` WHERE `event_id` = 1;
