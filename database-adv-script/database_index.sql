-- ============================================
-- Query 1: Filter bookings by a user_id
-- ============================================

-- BEFORE Index
-- This will likely trigger a Seq Scan
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE user_id = '11111111-1111-1111-1111-111111111111';

-- ADD INDEX
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);

-- AFTER Index
-- Should use Index Scan
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE user_id = '11111111-1111-1111-1111-111111111111';

-- ============================================
-- Query 2: Search properties by location_id
-- ============================================

-- BEFORE Index
EXPLAIN ANALYZE
SELECT * FROM properties
WHERE location_id = '22222222-2222-2222-2222-222222222222';

-- ADD INDEX
CREATE INDEX IF NOT EXISTS idx_properties_location_id ON properties(location_id);

-- AFTER Index
EXPLAIN ANALYZE
SELECT * FROM properties
WHERE location_id = '22222222-2222-2222-2222-222222222222';

-- ============================================
-- Query 3: Bookings for a user, ordered by created_at
-- ============================================

-- BEFORE Composite Index
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE user_id = '11111111-1111-1111-1111-111111111111'
ORDER BY created_at DESC;

-- ADD COMPOSITE INDEX
CREATE INDEX IF NOT EXISTS idx_bookings_user_created_at ON bookings(user_id, created_at DESC);

-- AFTER Composite Index
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE user_id = '11111111-1111-1111-1111-111111111111'
ORDER BY created_at DESC;
