-- Create customer table
CREATE TABLE customer(
    cust_id SERIAL PRIMARY KEY,
    f_name VARCHAR(50) NOT NULL,
    m_name VARCHAR(50),
    l_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    mobile INTEGER NOT NULL,
    occupation VARCHAR(20),
    date_of_birth DATE NOT NULL
);
ALTER TABLE customer
ALTER COLUMN mobile TYPE NUMERIC;

-- Create branch table with branch_id as SERIAL
CREATE TABLE branch(
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(50),
    branch_city VARCHAR(50)
);

-- Create account table with correct foreign key references
CREATE TABLE account(
    acc_id SERIAL PRIMARY KEY,
    cust_id SERIAL,  -- Reference customer table
    branch_id INT, -- Reference branch table
    opening_balance INTEGER,
    acc_open_date DATE,
    acc_type VARCHAR(20),
    acc_status VARCHAR(20),
    CONSTRAINT acc_cust_id_fk FOREIGN KEY(cust_id) REFERENCES customer(cust_id),
    CONSTRAINT acc_branch_id_fk FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);

-- Create transaction_details table with correct foreign key reference
CREATE TABLE transaction_details(
    trans_id SERIAL PRIMARY KEY,
    acc_id SERIAL,
    date_trans DATE,
    trans_medium VARCHAR(20),
    trans_type VARCHAR(20),
    trans_amount FLOAT,
    CONSTRAINT trd_accnumb_fk FOREIGN KEY(acc_id) REFERENCES account(acc_id)
);

ALTER TABLE transaction_details
ADD CONSTRAINT chk_trans_amount_non_negative CHECK (trans_amount >= 0);

ALTER TABLE account
ADD CONSTRAINT chk_opening_balance_non_negative CHECK (opening_balance >= 0),
ADD CONSTRAINT chk_acc_open_date CHECK (acc_open_date <= CURRENT_DATE),
ADD CONSTRAINT chk_acc_type CHECK (acc_type IN ('Savings', 'Checking', 'Business')),
ADD CONSTRAINT chk_acc_status CHECK (acc_status IN ('Active', 'Inactive', 'Closed'));

ALTER TABLE loan
ADD CONSTRAINT chk_loan_amount_non_negative CHECK (loan_amount >= 0);

-- Create loan table with compound primary key and correct foreign key references
CREATE TABLE loan(
    cust_id SERIAL,  -- Reference customer table
    branch_id SERIAL, -- Reference branch table
    loan_amount FLOAT,
    PRIMARY KEY (cust_id, branch_id),
    CONSTRAINT loan_cust_id_fk FOREIGN KEY(cust_id) REFERENCES customer(cust_id),
    CONSTRAINT loan_branch_id_fk FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);

INSERT INTO customer (f_name, m_name, l_name, city, mobile, occupation, date_of_birth) VALUES
('Paul', '', 'McCartney', 'Tallinn', '3728907654', 'bass player', '1942-06-18'),
('Elon', '', 'Musk', 'Tartu', '37209847568', 'billionaire', '1971-06-28'),
('Elton', 'Hercules', 'John', 'Saaremaa', '37267685894', 'pianist', '1947-03-27'),
('Karoli', '', 'Hindriks', 'Kohtla-Järvel', '37256437485', 'entrepreneur', '1983-06-17'),
('Martin', '', 'Villig', 'Tallinn', '37267668669', 'entrepreneur', '1978-12-04'),
('Anna', 'Marie', 'Smith', 'Tallinn', '37289012345', 'teacher', '1980-01-15'),
('John', 'Michael', 'Doe', 'Tartu', '37209123456', 'engineer', '1975-07-22'),
('Sara', '', 'Johnson', 'Narva', '37265432198', 'nurse', '1989-05-30'),
('David', 'James', 'Brown', 'Tallinn', '37298765432', 'chef', '1982-09-10'),
('Emma', '', 'Wilson', 'Pärnu', '37287654321', 'photographer', '1990-12-02'),
('Lucas', 'Paul', 'Taylor', 'Viljandi', '37254321098', 'musician', '1986-08-17'),
('Olivia', 'Grace', 'Davis', 'Kuressaare', '37276543210', 'artist', '1979-11-23'),
('Ethan', '', 'Moore', 'Jõhvi', '37212345678', 'developer', '1985-06-25'),
('Sophia', '', 'Miller', 'Tallinn', '37223456789', 'journalist', '1992-04-08'),
('James', 'Robert', 'Anderson', 'Tartu', '37234567890', 'analyst', '1978-02-20'),
('Ava', '', 'Taylor', 'Pärnu', '37245678901', 'consultant', '1987-10-11'),
('Michael', 'John', 'White', 'Narva', '37256789012', 'manager', '1980-03-03'),
('Isabella', '', 'Thomas', 'Tallinn', '37267890123', 'architect', '1984-12-19'),
('Alexander', 'Edward', 'Jackson', 'Jõhvi', '37278901234', 'engineer', '1976-11-12'),
('Mia', '', 'Harris', 'Saaremaa', '37289012346', 'designer', '1995-01-09'),
('Benjamin', 'Lee', 'Clark', 'Kohtla-Järve','37289012345', 'musician', '1981-05-21'),
('Charlotte', '', 'Lewis', 'Tallinn', '37201234567', 'writer', '1988-07-30'),
('Daniel', 'Charles', 'Walker', 'Tartu', '37212345679', 'physician', '1973-04-17'),
('Amelia', '', 'Scott', 'Viljandi', '37223456780', 'researcher', '1993-09-05'),
('Matthew', 'George', 'Young', 'Pärnu', '37234567891', 'developer', '1989-06-14'),
('Ella', '', 'Wright', 'Narva', '37245678902', 'manager', '1977-12-29'),
('Oliver', 'Henry', 'King', 'Tallinn', '37256789013', 'teacher', '1983-05-16'),
('Lily', '', 'Lopez', 'Jõhvi', '37267890124', 'photographer', '1994-08-27'),
('Jacob', 'Andrew', 'Hall', 'Saaremaa', '37278901235', 'scientist', '1986-07-04'),
('Harper', '', 'García', 'Kohtla-Järve','37289012346', 'consultant', '1981-11-19'),
('Evelyn', '', 'Martinez', 'Tallinn', '37290123457', 'nurse', '1990-03-24'),
('William', 'David', 'Hernandez', 'Tartu', '37201234568', 'chef', '1979-02-18'),
('Avery', '', 'Robinson', 'Pärnu', '37212345680', 'designer', '1988-12-07'),
('James', 'Samuel', 'Lee', 'Narva', '37223456781', 'analyst', '1992-11-30'),
('Natalie', '', 'Perez', 'Tallinn', '37234567892', 'journalist', '1984-05-23'),
('Henry', 'Robert', 'Walker', 'Jõhvi', '37245678903', 'physician', '1981-09-12'),
('Grace', '', 'Adams', 'Saaremaa', '37256789014', 'developer', '1996-01-14'),
('Ryan', 'James', 'Nelson', 'Kohtla-Järve','37289012346', 'artist', '1987-06-22'),
('Chloe', '', 'Carter', 'Tallinn', '37267890125', 'architect', '1990-03-10'),
('Elijah', 'Matthew', 'Morris', 'Tartu', '37278901236', 'scientist', '1976-04-21'),
('Zoe', '', 'Bailey', 'Viljandi', '37289012348', 'musician', '1989-07-16'),
('Mason', 'William', 'Gonzalez', 'Pärnu', '37290123458', 'consultant', '1983-08-02'),
('Mila', '', 'Wright', 'Narva', '37201234569', 'photographer', '1992-10-14'),
('Carter', 'Joseph', 'Reed', 'Tallinn', '37212345681', 'analyst', '1987-05-19'),
('Ella', '', 'Cook', 'Jõhvi', '37223456782', 'manager', '1995-12-05'),
('Logan', 'Alexander', 'Bell', 'Saaremaa', '37234567893', 'researcher', '1980-11-20'),
('Sophie', '', 'Morgan', 'Kohtla-Järve','37289012346','designer','1991-03-16'),
('Jackson', 'Oliver', 'Cooper', 'Tallinn', '37245678904', 'scientist', '1984-09-01'),
('Aria', '', 'Richardson', 'Tartu', '37256789015', 'physician', '1985-06-23'),
('Liam', 'Daniel', 'Bryant', 'Pärnu', '37267890126', 'consultant', '1997-07-29'),
('Madison', '', 'Cook', 'Narva', '37278901237', 'artist', '1988-10-13');

-- Inserting sample data into the branch table for SEB branches in the Baltic region
INSERT INTO branch (branch_name, branch_city) VALUES
('SEB Tallinn Main Branch', 'Tallinn'),
('SEB Tallinn City Branch', 'Tallinn'),
('SEB Tartu Branch', 'Tartu'),
('SEB Pärnu Branch', 'Pärnu'),
('SEB Riga Main Branch', 'Riga'),
('SEB Riga City Branch', 'Riga'),
('SEB Daugavpils Branch', 'Daugavpils'),
('SEB Liepāja Branch', 'Liepāja'),
('SEB Vilnius Main Branch', 'Vilnius'),
('SEB Vilnius City Branch', 'Vilnius'),
('SEB Kaunas Branch', 'Kaunas'),
('SEB Klaipėda Branch', 'Klaipėda');

-- Inserting sample data into the account table for 50 customers and 12 branches
-- Assuming cust_id ranges from 1 to 50 and branch_id ranges from 1 to 12

INSERT INTO account (cust_id, branch_id, opening_balance, acc_open_date, acc_type, acc_status) VALUES
(1, 1, 1200, '2024-01-10', 'Savings', 'Active'),
(2, 2, 3000, '2024-02-15', 'Checking', 'Active'),
(3, 3, 500, '2024-03-20', 'Savings', 'Inactive'),
(4, 4, 1500, '2024-04-05', 'Checking', 'Active'),
(5, 5, 2700, '2024-05-15', 'Savings', 'Active'),
(6, 6, 1000, '2024-06-10', 'Checking', 'Inactive'),
(7, 7, 3200, '2024-07-25', 'Savings', 'Active'),
(8, 8, 4000, '2024-08-15', 'Checking', 'Active'),
(9, 9, 2200, '2024-09-05', 'Savings', 'Inactive'),
(10, 10, 5400, '2024-10-15', 'Checking', 'Active'),
(11, 11, 1600, '2024-01-20', 'Savings', 'Active'),
(12, 12, 3300, '2024-02-25', 'Checking', 'Inactive'),
(13, 1, 2400, '2024-03-15', 'Savings', 'Active'),
(14, 2, 1900, '2024-04-10', 'Checking', 'Active'),
(15, 3, 3800, '2024-05-20', 'Savings', 'Inactive'),
(16, 4, 2600, '2024-06-25', 'Checking', 'Active'),
(17, 5, 3000, '2024-07-10', 'Savings', 'Active'),
(18, 6, 2900, '2024-08-05', 'Checking', 'Inactive'),
(19, 7, 4300, '2024-09-15', 'Savings', 'Active'),
(20, 8, 3700, '2024-10-25', 'Checking', 'Active'),
(21, 9, 2100, '2024-01-30', 'Savings', 'Inactive'),
(22, 10, 2200, '2024-02-20', 'Checking', 'Active'),
(23, 11, 2500, '2024-03-10', 'Savings', 'Active'),
(24, 12, 3500, '2024-04-15', 'Checking', 'Inactive'),
(25, 1, 2800, '2024-05-20', 'Savings', 'Active'),
(26, 2, 3100, '2024-06-05', 'Checking', 'Active'),
(27, 3, 4000, '2024-07-10', 'Savings', 'Inactive'),
(28, 4, 2700, '2024-08-20', 'Checking', 'Active'),
(29, 5, 2200, '2024-09-05', 'Savings', 'Active'),
(30, 6, 3300, '2024-10-15', 'Checking', 'Inactive'),
(31, 7, 4100, '2024-01-15', 'Savings', 'Active'),
(32, 8, 4500, '2024-02-25', 'Checking', 'Active'),
(33, 9, 3600, '2024-03-30', 'Savings', 'Inactive'),
(34, 10, 2900, '2024-04-20', 'Checking', 'Active'),
(35, 11, 3400, '2024-05-10', 'Savings', 'Active'),
(36, 12, 2300, '2024-06-30', 'Checking', 'Inactive'),
(37, 1, 2600, '2024-07-25', 'Savings', 'Active'),
(38, 2, 2800, '2024-08-15', 'Checking', 'Active'),
(39, 3, 3500, '2024-09-10', 'Savings', 'Inactive'),
(40, 4, 4000, '2024-10-05', 'Checking', 'Active'),
(41, 5, 3200, '2024-01-10', 'Savings', 'Active'),
(42, 6, 3600, '2024-02-15', 'Checking', 'Inactive'),
(43, 7, 2900, '2024-03-20', 'Savings', 'Active'),
(44, 8, 3700, '2024-04-25', 'Checking', 'Active'),
(45, 9, 4200, '2024-05-30', 'Savings', 'Inactive'),
(46, 10, 3800, '2024-06-15', 'Checking', 'Active'),
(47, 11, 4500, '2024-07-10', 'Savings', 'Active'),
(48, 12, 3900, '2024-08-20', 'Checking', 'Inactive'),
(49, 1, 3400, '2024-09-25', 'Savings', 'Active'),
(50, 2, 3300, '2024-10-05', 'Checking', 'Active');

-- Inserting sample data into the transaction_details table
INSERT INTO transaction_details (acc_id, date_trans, trans_medium, trans_type, trans_amount) VALUES
(1, '2024-01-15', 'Online', 'Deposit', 500.00),
(1, '2024-02-10', 'ATM', 'Withdrawal', 200.00),
(2, '2024-02-20', 'Branch', 'Deposit', 1500.00),
(2, '2024-03-15', 'Online', 'Withdrawal', 700.00),
(3, '2024-03-25', 'ATM', 'Deposit', 300.00),
(3, '2024-04-10', 'Online', 'Withdrawal', 150.00),
(4, '2024-04-05', 'Branch', 'Deposit', 1000.00),
(4, '2024-05-01', 'Online', 'Withdrawal', 500.00),
(5, '2024-05-15', 'ATM', 'Deposit', 1200.00),
(5, '2024-06-10', 'Branch', 'Withdrawal', 800.00),
(6, '2024-06-20', 'Online', 'Deposit', 900.00),
(6, '2024-07-15', 'ATM', 'Withdrawal', 300.00),
(7, '2024-07-25', 'Branch', 'Deposit', 1500.00),
(7, '2024-08-10', 'Online', 'Withdrawal', 600.00),
(8, '2024-08-15', 'ATM', 'Deposit', 1000.00),
(8, '2024-09-05', 'Branch', 'Withdrawal', 400.00),
(9, '2024-09-10', 'Online', 'Deposit', 700.00),
(9, '2024-10-01', 'ATM', 'Withdrawal', 200.00),
(10, '2024-10-05', 'Branch', 'Deposit', 1200.00),
(10, '2024-10-20', 'Online', 'Withdrawal', 500.00);

-- Inserting sample data into the loan table
INSERT INTO loan (cust_id, branch_id, loan_amount) VALUES
(1, 1, 5000.00),
(2, 1, 15000.00),
(3, 2, 7500.00),
(4, 3, 20000.00),
(5, 4, 10000.00),
(6, 5, 12000.00),
(7, 6, 18000.00),
(8, 7, 16000.00),
(9, 8, 22000.00),
(10, 9, 13000.00),
(11, 10, 14000.00),
(12, 11, 17000.00),
(13, 12, 19000.00),
(14, 1, 21000.00),
(15, 2, 23000.00),
(16, 3, 26000.00),
(17, 4, 24000.00),
(18, 5, 25000.00),
(19, 6, 27000.00),
(20, 7, 28000.00),
(21, 8, 29000.00),
(22, 9, 30000.00),
(23, 10, 31000.00),
(24, 11, 32000.00),
(25, 12, 33000.00),
(26, 1, 34000.00),
(27, 2, 35000.00),
(28, 3, 36000.00),
(29, 4, 37000.00),
(30, 5, 38000.00);

SELECT *
FROM customer c
LEFT JOIN  loan l
ON c.cust_id = l.cust_id;