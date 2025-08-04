---------1. creating a enum as status_enum--------

CREATE TYPE status_enum AS ENUM ('pending', 'approved', 'rejected')

---------- creating table with above enum----------
CREATE TABLE orders (
   id     SERIAL PRIMARY KEY,
   amount NUMERIC(10,2),
   ship_mode varchar(200),
   status status_enum NOT NULL DEFAULT 'pending'
)

INSERT INTO orders (amount, ship_mode, status)
VALUES
  (153.75, 'Standard',  'pending'),
  (499.00, 'Express',   'approved'),
  (799.99, 'Overnight', 'rejected');

 select * from orders

----------2. adding one more enum with the help of alter--------

CREATE TYPE priority_enum AS ENUM ('low', 'medium', 'high')

ALTER TABLE orders
ADD COLUMN priority priority_enum 

-----------inserting values into new column------------------
INSERT INTO orders (amount, ship_mode, status, priority)
VALUES(299.99, 'Express', 'approved', 'high')


