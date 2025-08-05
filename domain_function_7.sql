--------------------task7----------------------------

-- Age must be between 18 and 65
CREATE DOMAIN age_domain AS INT
CHECK (VALUE BETWEEN 18 AND 65);

-- Email format validation
CREATE DOMAIN email_domain AS TEXT
CHECK (VALUE ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- Mobile number: exactly 10 digits
CREATE DOMAIN phone_domain AS TEXT
CHECK (VALUE ~ '^[0-9]{10}$');


-- Create base table
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name TEXT,
    age age_domain,
    email email_domain,
    phone phone_domain,
    salary NUMERIC(10,2)
);

select * from employees

INSERT INTO employees (name, age, email, phone, salary)
VALUES ('Alice Johnson', 30, 'alice.johnson@example.com', '9876543210', 55000.00);

INSERT INTO employees (name, age, email, phone, salary)
VALUES ('Bob Smith', 45, 'bob.smith@example.com', '9123456789', 72000.00);

INSERT INTO employees (name, age, email, phone, salary)
VALUES ('Charlie Patel', 28, 'charlie.patel@example.com', '9012345678', 48000.00);


select * from employees


-- Add salary CHECK constraint
ALTER TABLE employees
ADD CONSTRAINT chk_salary_positive CHECK (salary > 0);

-- Add UNIQUE constraint for email
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

---------------------------------------------------------------------------------------------
--function--

CREATE OR REPLACE FUNCTION evaluate_employee_status(age INT, salary NUMERIC)
RETURNS TEXT AS $$
BEGIN
    -- IF checks first
    IF age IS NULL OR salary IS NULL THEN
        RETURN 'Missing input data';
    ELSIF age < 18 THEN
        RETURN 'Underage - Not eligible for employment';
    ELSIF salary < 10000 THEN
        RETURN 'Below minimum wage';
    END IF;
	-- Extra fallback using CASE (like switch)
    RETURN CASE 
        WHEN p_salary >= 100000 THEN 'High Earner'
        WHEN p_salary >= 70000 THEN 'Well Paid'
        WHEN p_salary >= 40000 THEN 'Average Paid'
        ELSE 'Entry Level Salary'
    END;
END;
$$ LANGUAGE plpgsql;
