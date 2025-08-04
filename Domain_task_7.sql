------- 3. creating domains for order table---------

---------creating domain positive_amount where value should >= 0--------

CREATE DOMAIN positive_amount AS NUMERIC(10,2)
CHECK (VALUE >= 0)

-------- Domain where shipmode only be in this range---------------

CREATE DOMAIN order_ship_mode AS VARCHAR(200)
CHECK (value in('Standard','Express','Overnight'))

-------- Domain that allows only below values as status--------------
CREATE DOMAIN order_status AS status_enum
CHECK  (value in('pending','approved','rejected'))


-------------------------------------------------------------------------------------------