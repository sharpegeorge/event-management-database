# event-management-database

### Overview

A relational database system designed to manage events, bookings, customers, and ticketing operations efficiently using SQL and ER modeling.

### Features

- SQL script to initialize all necessary tables and relationships
- Query script to retrieve event, booking, and customer information
- Update script to modify records, including ticket availability and booking deletions

### How to run

1. Clone the repository
   ```bash
   git clone https://github.com/sharpegeorge/event-management-database.git
   cd event-management-database
   ```
2. Initialise the database by running
   ```bash
   ticket_init.sql
   ```

3. Run either program to perform predefined queries or update operations
   ```bash
   ticket_query.sql
   ticket_update.sql
   ```

4. Reset the database by running
   ```bash
   delete_all.sql
   ```

### Files included
- `ticket_init.sql`
- `ticket_query.sql`
- `ticket_update.sql`
- `delete_all.sql`
