USE event;

-- Insert sample clients
INSERT INTO clients (name, email, phone, city, state) VALUES
('Rahul Patel', 'rahulpatel005@gmail.com', '9925991462', 'Ahmedabad', 'Gujarat'),
('Priya Shah', 'priyashah@gmail.com', '9876543210', 'Mumbai', 'Maharashtra'),
('Amit Kumar', 'amitkumar@gmail.com', '9988776655', 'Delhi', 'Delhi');

-- Insert sample employees
INSERT INTO employees (full_name, email, phone, role, department, password) VALUES
('John Doe', 'john@example.com', '9876543210', 'Manager', 'Operations', 'password123'),
('Jane Smith', 'jane@example.com', '9876543211', 'Coordinator', 'Events', 'password123');

-- Insert sample vendors
INSERT INTO vendors (business_name, contact_name, phone, category, email, address, state, city, zip, notes) VALUES
('ABC Catering', 'Rajesh Kumar', '9876543210', 'Catering', 'abc@catering.com', '123 Main St', 'Gujarat', 'Ahmedabad', '380001', 'Best catering service'),
('XYZ Decorators', 'Priya Sharma', '9876543211', 'Decoration', 'xyz@decor.com', '456 Park Ave', 'Maharashtra', 'Mumbai', '400001', 'Premium decorations');

-- Insert sample tags
INSERT INTO tags (name, description, color) VALUES
('VIP Client', 'High value client', '#520350'),
('New Client', 'Recently added client', '#3498DB'),
('Wedding', 'Wedding events', '#C0392B');

-- Insert sample events
INSERT INTO events (event_name, event_type, event_date, venue, client_name, phone, email, guest_count, food_preference, alcohol_served, status) VALUES
('Wedding Ceremony', 'Wedding', '2025-03-15', 'Grand Hotel', 'Rahul Patel', '9925991462', 'rahul@example.com', 200, 'Vegetarian', 0, 'pending'),
('Corporate Event', 'Corporate', '2025-04-20', 'Convention Center', 'Priya Shah', '9876543210', 'priya@example.com', 150, 'Non-Vegetarian', 1, 'confirmed');

-- Insert sample event functions
INSERT INTO event_functions (event_id, section_name, section_date, function_name, start_time, end_time, location, notes) VALUES
(1, 'Timeline', '2026-02-03', 'Welcome', '12:00:00', '16:00:00', 'Resort Lobby', 'Welcome drinks, room allocation, leisure time'),
(1, 'Timeline', '2026-02-03', 'Welcome Lunch', '13:30:00', '15:30:00', 'Dining Restaurant', 'Casual lunch, relaxed dress code'),
(1, 'Timeline', '2026-02-03', 'Welcome Soiree', '18:00:00', '20:30:00', 'Poolside / Beachfront', 'Light music, cocktails, sunset gathering'),
(1, 'Colors & Culture', '2026-02-04', 'Haldi Ceremony', '09:00:00', '11:00:00', 'Garden Lawn', 'Yellow theme, floral decor, organic colors'),
(1, 'Colors & Culture', '2026-02-04', 'Mehndi by the Pool', '13:00:00', '17:00:00', 'Poolside Cabana', 'Henna artists, live music, relaxed daytime event'),
(1, 'Music & Magic', '2026-02-05', 'Sangeet Night', '19:00:00', '23:00:00', 'Grand Ballroom', 'Dance performances, DJ, cocktail night'),
(1, 'The Grand Union', '2026-02-06', 'Wedding Ceremony', '16:30:00', '18:30:00', 'Beach Mandap', 'Main wedding ceremony'),
(1, 'The Grand Union', '2026-02-06', 'Reception Gala', '20:00:00', '23:59:00', 'Banquet Hall', 'Formal reception, dinner & celebrations');
