# AirBnB Database Schema

This SQL script defines the schema for the normalized AirBnB database used in the project.

## File

- `schema.sql`: Contains all `CREATE TABLE` statements, ENUM types, constraints, and indexes.

## Features

- Fully normalized to **Third Normal Form (3NF)**
- Foreign keys with cascading deletes
- ENUMs for roles, booking status, and payment method
- Proper indexing for optimized queries

## Tables

- `users`
- `locations`
- `properties`
- `bookings`
- `payments`
- `reviews`
- `messages`

## Usage

To create the schema in PostgreSQL:

```bash
psql -U your_user -d your_database -f schema.sql
