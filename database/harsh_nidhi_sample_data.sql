-- Sample data for Harsh & Nidhi Wedding (event_id = 36)

-- Add event days first
INSERT INTO event_days (event_id, day_title, event_date) VALUES
(36, 'Day 1 - Mehendi & Sangeet', '2024-01-12'),
(36, 'Day 2 - Haldi', '2024-01-13'),
(36, 'Day 3 - Wedding', '2024-01-14'),
(36, 'Day 4 - Reception', '2024-01-15');

-- Add event functions (using event_id, not event_day_id)
INSERT INTO event_functions (event_id, section_name, section_date, function_name, start_time, end_time, location, notes) VALUES
(36, 'Timeline', '2024-01-12', 'Mehendi Ceremony', '14:00:00', '18:00:00', 'Raj Palace Garden', 'Traditional mehendi ceremony'),
(36, 'Timeline', '2024-01-12', 'Sangeet Night', '19:00:00', '23:00:00', 'Raj Palace Hall', 'Music and dance performances'),
(36, 'Timeline', '2024-01-13', 'Haldi Ceremony', '10:00:00', '12:00:00', 'Raj Palace Lawn', 'Traditional haldi ceremony'),
(36, 'Timeline', '2024-01-14', 'Wedding Ceremony', '10:00:00', '14:00:00', 'Raj Palace Main Hall', 'Main wedding ceremony'),
(36, 'Timeline', '2024-01-15', 'Reception', '19:00:00', '23:00:00', 'Raj Palace Banquet', 'Evening reception');

-- Add event attendees (using full_name, not name)
INSERT INTO event_attendees (event_id, full_name, email, phone, age, gender, food_preference, invitation_status, is_vip, needs_wheelchair, travel_required) VALUES
(36, 'Rahul Sharma', 'rahul@email.com', '9876543210', 28, 'male', 'veg', 'accepted', 0, 0, 1),
(36, 'Priya Singh', 'priya@email.com', '9876543211', 25, 'female', 'non-veg', 'accepted', 1, 0, 0),
(36, 'Amit Kumar', 'amit@email.com', '9876543212', 45, 'male', 'jain', 'pending', 0, 0, 1),
(36, 'Sneha Patel', 'sneha@email.com', '9876543213', 30, 'female', 'veg', 'accepted', 0, 0, 0),
(36, 'Vikram Reddy', 'vikram@email.com', '9876543214', 35, 'male', 'non-veg', 'declined', 0, 0, 1),
(36, 'Anjali Gupta', 'anjali@email.com', '9876543215', 22, 'female', 'jain', 'accepted', 1, 1, 0),
(36, 'Rajesh Verma', 'rajesh@email.com', '9876543216', 50, 'male', 'veg', 'pending', 0, 0, 1),
(36, 'Kavita Joshi', 'kavita@email.com', '9876543217', 28, 'female', 'veg', 'accepted', 0, 0, 0),
(36, 'Suresh Nair', 'suresh@email.com', '9876543218', 65, 'male', 'non-veg', 'accepted', 0, 1, 1),
(36, 'Meera Iyer', 'meera@email.com', '9876543219', 18, 'female', 'veg', 'accepted', 0, 0, 0);

-- Add event vendors (for Vendors page)
INSERT INTO event_vendors (event_id, vendor_id, status) VALUES
(36, 1, 'hired'),
(36, 2, 'shortlisted'),
(36, 3, 'hired');

-- Add event checklists (using event_type_id based on table structure)
INSERT INTO event_checklists (event_type_id, task_name, is_completed, due_date) VALUES
(1, 'Book venue', 1, '2023-12-01'),
(1, 'Send invitations', 1, '2023-12-15'),
(1, 'Finalize menu', 0, '2024-01-05'),
(1, 'Book photographer', 1, '2023-11-20'),
(1, 'Arrange decorations', 0, '2024-01-10'),
(1, 'Book DJ', 0, '2024-01-08');
