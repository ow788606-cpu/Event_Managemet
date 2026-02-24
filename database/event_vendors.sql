USE event;

-- Create event_vendors table
CREATE TABLE IF NOT EXISTS event_vendors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  event_id INT,
  vendor_name VARCHAR(255) NOT NULL,
  description TEXT,
  contact VARCHAR(20),
  category VARCHAR(100),
  status VARCHAR(50),
  quote VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

-- Insert sample event vendors
INSERT INTO event_vendors (event_id, vendor_name, description, contact, category, status, quote) VALUES
(1, 'Sanjay Desai', 'Destination wedding resort, suitable for multi-day events', '9876543245', 'Venues', 'Hired', '₹850000'),
(1, 'Neha Kapoor', 'Luxury destination wedding planning', '9811112233', 'Wedding Planners', 'Hired', '₹300000'),
(1, 'Neeraj Shah', 'On-ground coordination & logistics', '9658585211', 'Event Management', 'Shortlisted', '₹200000'),
(1, 'Ramesh Patel', 'Pure veg & Jain food for all functions', '9876543210', 'Caterers', 'Hired', '₹1200000'),
(1, 'Nitin Patel', 'Backup caterer option with Jain menu', '9825777188', 'Caterers', 'Shortlisted', '₹950000'),
(1, 'Imran Shaikh', 'Royal palace theme decor', '9898989898', 'Decorator', 'Hired', '₹600000'),
(1, 'Neha Kapoor', 'Modern pastel decor option', '9909902344', 'Decorator', 'Shortlisted', '₹450000'),
(1, 'Mukesh Bhai', 'Premium tents and seating', '9825502345', 'Tent & Furniture', 'Hired', '₹250000'),
(1, 'Aakash Jain', 'Premium architectural & stage lighting', '9909905544', 'Lighting', 'Hired', '₹180000'),
(1, 'Nilesh Patel', 'Decorative lighting backup', '9825508888', 'Lighting', 'Shortlisted', '₹120000'),
(1, 'Saurabh Patel', 'Wedding ceremony & sangeet sound setup', '9909902211', 'Sound & Audio', 'Hired', '₹80000'),
(1, 'Rahul Verma', 'Bollywood DJ for sangeet & reception', '9898072345', 'DJ', 'Hired', '₹75000'),
(1, 'Aakash Jain', 'Premium wedding photography', '9909906677', 'Photography and Video', 'Hired', '₹350000'),
(1, 'Neha Mehta', 'Luxury cinematic wedding film', '9909902344', 'Cinematography', 'Shortlisted', '₹400000'),
(1, 'Farah Khan', 'Luxury bridal makeup for multiple events', '9898076566', 'Mehendi Artist', 'Hired', '₹45000'),
(1, 'Makeup Artist Name', 'Professional makeup services', '9898884455', 'Makeup Artist', 'Hired', '₹80000'),
(1, 'Rahul Verma', 'Sangeet choreography for family', '9898072345', 'Choreographers', 'Shortlisted', '₹60000'),
(1, 'Sanjay Yadav', 'Guest transportation for 5 days', '9876558765', 'Transportation', 'Hired', '₹150000'),
(1, 'Aakash Desai', 'Cold pyros for entry & varmala', '9876609988', 'Fireworks', 'Shortlisted', '₹70000');
