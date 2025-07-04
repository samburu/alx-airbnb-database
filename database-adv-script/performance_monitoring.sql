-- Get all bookings with user and property info for 2024
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.email,
    p.name AS property_name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND b.status = 'confirmed';

-- Recommended Schema Improvements
-- Add index on bookings.status for faster filtering
CREATE INDEX idx_bookings_status ON bookings(status);

-- Add index on bookings.start_date for faster date filtering
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- Consider composite index for frequent filters:
CREATE INDEX idx_bookings_start_status ON bookings(start_date, status);
