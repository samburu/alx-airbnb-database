-- Enable extension for UUIDs (if needed)
-- CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Seed Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  ('00000000-0000-0000-0000-000000000001', 'Alice', 'Wanjiku', 'alice@example.com', 'hashed_pw1', '0711000001', 'host'),
  ('00000000-0000-0000-0000-000000000002', 'Bob', 'Kamau', 'bob@example.com', 'hashed_pw2', '0711000002', 'guest'),
  ('00000000-0000-0000-0000-000000000003', 'Charlie', 'Omondi', 'charlie@example.com', 'hashed_pw3', NULL, 'guest');

-- Seed Locations
INSERT INTO locations (location_id, city, region, country)
VALUES
  ('10000000-0000-0000-0000-000000000001', 'Nairobi', 'Nairobi County', 'Kenya'),
  ('10000000-0000-0000-0000-000000000002', 'Cape Town', 'Western Cape', 'South Africa');

-- Seed Properties
INSERT INTO properties (property_id, host_id, location_id, name, description, pricepernight)
VALUES
  ('20000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001',
   'Garden Cottage', 'A cozy garden cottage in Nairobi', 50.00),

  ('20000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000002',
   'Ocean View Loft', 'Stylish loft with a view of the ocean', 80.00);

-- Seed Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002',
   '2025-07-01', '2025-07-05', 200.00, 'confirmed'),

  ('30000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003',
   '2025-07-10', '2025-07-12', 160.00, 'pending');

-- Seed Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
  ('40000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 200.00, 'credit_card');

-- Seed Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
  ('50000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002',
   5, 'Wonderful stay, very clean and peaceful!'),

  ('50000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003',
   4, 'Great view but check-in was a bit slow.');

-- Seed Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
  ('60000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   'Hi Alice, is the Garden Cottage available next week?'),

  ('60000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002',
   'Yes, it’s available from July 1st!');
