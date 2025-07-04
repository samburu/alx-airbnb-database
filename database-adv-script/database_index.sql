-- Index on users.email to optimize authentication and lookups
CREATE INDEX idx_users_email ON users(email);

-- Index on bookings.user_id to improve join and filter performance
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index on bookings.property_id to optimize property-booking relationships
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index on properties.host_id to speed up host-specific queries
CREATE INDEX idx_properties_host_id ON properties(host_id);

-- Index on properties.location_id to accelerate location-based searches
CREATE INDEX idx_properties_location_id ON properties(location_id);

-- Composite index on bookings (user_id, created_at) for time-based user analytics
CREATE INDEX idx_bookings_user_created_at ON bookings(user_id, created_at DESC);
