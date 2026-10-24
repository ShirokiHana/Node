AutoLux - Final Backend Assignment (Node.js API)
===============================================

Student: Jordan
Node.js API repository: https://github.com/ShirokiHana/Node
PHP application repository: https://github.com/ShirokiHana/AutoLux

1. Overview
-----------

This service is the supplier and purchasing API for AutoLux, an automotive
parts warehouse application. It uses Node.js, TypeScript, Express and MySQL.

The companion PHP application renders the user interface and handles
customers, sales and local stock. It calls this API over HTTP to retrieve
suppliers and their parts, create supplier orders and update order status.

This API is intended for local educational demonstration. It does not
provide authentication and should not be exposed as a public production
service. Use demonstration data only.

2. Implemented features
-----------------------

- Supplier listing, retrieval, creation, editing and deletion.
- Parts catalogue lookup for a selected supplier.
- Transactional creation of supplier orders and their items.
- Part prices read from the database rather than supplied by the caller.
- Validation that ordered parts belong to the selected supplier.
- Order listing with supplier, status and date filters.
- Retrieval of individual orders, including items and a calculated total.
- Order-status updates: pending, received or cancelled.
- Positive-integer validation for order item IDs and quantities.

New orders are created with pending status. Expected arrival is calculated
as 30 minutes per ordered unit; this is a demonstration estimate.

3. Architecture and data source
-------------------------------

PHP interface -> Node.js HTTP API -> supplier_db (MySQL).

supplier_db contains:
  suppliers, parts, supplier_orders, supplier_order_items.

The separate autolux_db database stores customers, local stock, payment
methods, sales and supplier-order synchronization records. PHP accesses
that database directly; the Node.js service does not update local PHP stock.

The data source is the supplied MySQL demonstration data. The A/B/C
classification mentioned in the assignment brief is awaiting clarification
from the teacher.

Matching parts in both databases use the same part_id and must represent
the same product. Preserve these mappings when changing the sample data.

4. Requirements
---------------

- Node.js and NPM. Development used Node.js 22.
- A running MySQL server and an account allowed to create/import the
  demonstration database.
- Git.
- For the complete web application: the companion PHP project and its
  requirements, described in that repository's README.txt.

The commands below use a macOS/Linux shell. On Windows, use equivalent
file-copy commands or copy the environment file manually.

5. Install and configure
------------------------

  git clone https://github.com/ShirokiHana/Node.git
  cd Node
  npm install
  cp db.env.example db.env

Edit db.env in the Node repository root:

  DB_HOST=127.0.0.1
  DB_PORT=3306
  DB_USER=root
  DB_PASSWORD=
  DB_NAME=supplier_db

Replace the example host, port, user and password as needed. Leave
DB_PASSWORD empty only if the MySQL account has no password.
Do not commit real credentials.

Keep the development dependencies installed: the start script uses tsx
to execute TypeScript directly.

6. Import the demonstration database
------------------------------------

schema/supplier_db.sql contains both table definitions and sample data.
It does not create or select the database automatically.

With MySQL running, execute these commands from the Node repository root.
Replace root with your MySQL username if different; -p prompts for the
password. Press Enter if the account has no password.

  mysql -h 127.0.0.1 -P 3306 -u root -p -e "CREATE DATABASE IF NOT EXISTS supplier_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
  mysql -h 127.0.0.1 -P 3306 -u root -p supplier_db < schema/supplier_db.sql

WARNING: The export contains DROP TABLE statements. Import only into a
demonstration database: existing tables and their contents will be replaced.
npm install does not create database tables.

The PHP database export is in the companion repository:
  AutoLux/schema/autolux_db.sql

Follow AutoLux/README.txt to import that database and configure PHP.

7. Run the API
---------------

From the Node repository root:

  npm start

The API listens at http://localhost:3030.
Keep this terminal open while using the PHP supplier/restock pages.

For automatic restart when source files change:

  npm run dev

Stop the service with Ctrl+C. Run commands from the repository root because
the application loads ./db.env relative to the working directory.

Optional macOS/Homebrew MySQL service shortcuts:

  npm run startMySQL
  npm run stopMySQL

These shortcuts are not needed if you manage MySQL another way.

8. API endpoints
----------------

Send Content-Type: application/json for requests containing JSON bodies.
Successful data responses are JSON, except a successful DELETE has no body.

Suppliers:

  GET    /supplier             List suppliers.
  GET    /supplier/:id         Retrieve a supplier.
  POST   /supplier             Create a supplier.
  PUT    /supplier/:id         Update a supplier name.
  DELETE /supplier/:id         Delete a supplier, subject to database constraints.
  GET    /supplier/:id/parts   List the supplier's parts.

POST and PUT supplier bodies:

  {"supplier_name":"Example Auto Parts"}

Supplier orders:

  GET    /order                List supplier orders.
  POST   /order                Create a supplier order.
  GET    /order/:id            Retrieve an order, its items and total.
  GET    /order/:id/items      Retrieve an order's items.
  PATCH  /order/:id            Update the order status.

Optional GET /order query parameters:

  supplier_id: positive supplier ID.
  status: pending, received or cancelled.
  from: start date in YYYY-MM-DD format (inclusive).
  to: end date in YYYY-MM-DD format (inclusive).

Example filter:

  /order?supplier_id=1&status=pending&from=2026-10-01&to=2026-10-31

POST /order body:

  {
    "supplier_id": 1,
    "items": [
      {"part_id": 63, "quantity": 2}
    ]
  }

Choose actual IDs from GET /supplier and GET /supplier/:id/parts.
Each item must have a positive integer part_id and quantity. Use one entry
per part. Do not send unit prices; the API reads them from supplier_db.

Successful order creation returns:

  {"order_id":123,"message":"created"}

The order ID above is illustrative; use the ID returned by your request.

PATCH /order/:id body:

  {"status":"received"}

The API does not serve the PHP interface. A request to / or to the retired
/restock pages may return 404; use the documented API routes instead.

9. Quick manual checks
----------------------

Read-only checks, with the API running:

  curl http://localhost:3030/supplier
  curl http://localhost:3030/supplier/1/parts
  curl http://localhost:3030/order

To demonstrate the full integration, start the PHP application at
http://localhost:3000 and open /management/order. Choose a supplier, add
parts and submit the restock cart.

That operation writes demonstration records: PHP creates an order through
this API, reads its items, increases local stock and updates the supplier
order to received.

10. Error handling and troubleshooting
--------------------------------------

Validation errors generally return HTTP 400, missing records return 404,
and unexpected errors return 500. Error bodies may be plain text, so callers
should check the status before attempting to decode a successful JSON result.
Server errors are logged in the terminal.

- Database connection failure: check MySQL, db.env and the account's access
  to supplier_db.
- Missing table: import schema/supplier_db.sql into supplier_db.
- Missing tsx or other dependencies: run npm install, including development
  dependencies.
- Port 3030 already in use: stop the previous API instance before restarting.
- 404 at /: use /supplier or /order; the API root is not a web page.
- Order rejected: check that items are non-empty, quantities are positive
  integers and every part belongs to the selected supplier.
- PHP cannot reach the service: set NODE_URL=http://localhost:3030 in the
  PHP project's db.env and keep both servers running.
