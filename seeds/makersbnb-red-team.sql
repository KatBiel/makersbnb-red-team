-- The job of this file is to reset all of our important database tables.
-- And add any data that is needed for the tests to run.
-- This is so that our tests, and application, are always operating from a fresh
-- database state, and that tests don't interfere with each other.

-- First, we must delete (drop) all our tables
DROP TABLE IF EXISTS account CASCADE;
DROP SEQUENCE IF EXISTS account_id_seq CASCADE;

DROP TABLE IF EXISTS listing CASCADE;
DROP SEQUENCE IF EXISTS listing_id_seq CASCADE;

DROP TABLE IF EXISTS availability CASCADE;
DROP SEQUENCE IF EXISTS availability_id_seq CASCADE;

-- Then, we recreate them
CREATE SEQUENCE IF NOT EXISTS account_id_seq;
CREATE TABLE account (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    phone_number VARCHAR(255)
);

CREATE SEQUENCE IF NOT EXISTS listing_id_seq;
CREATE TABLE listing (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    description VARCHAR(255),
    price INT,
    account_id INT,
    CONSTRAINT fk_account FOREIGN KEY(account_id) REFERENCES account(id) ON DELETE CASCADE
);

CREATE SEQUENCE IF NOT EXISTS availability_id_seq;
CREATE TABLE availability (
    id SERIAL PRIMARY KEY,
    listing_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL, -- status can be 'available, 'booked', 'requested' etc.
    CONSTRAINT fk_listing FOREIGN KEY (listing_id) REFERENCES listing(id) ON DELETE CASCADE
);



-- Finally, we add any records that are needed for the tests to run
INSERT INTO account (username, first_name, last_name, email, password, phone_number)
VALUES
    ('JohnD', 'John', 'Doe', 'johndoe@example.com', 'password123', '07973661188'),
    ('RubyS', 'Ruby', 'Seresin', 'ruby@example.com', 'password1234', '07973661100'),
    ('DanG', 'Dan', 'Gullis', 'dan@example.com', 'password1235', '07973661122'),
    ('KatB', 'Kat', 'Biel', 'kat@example.com', 'password1236', '07973661133'),
    ('AmparoG', 'Amparo', 'Guevara', 'amparo@example.com', 'password1237', '07973661144');


INSERT INTO listing (name, address, description, price, account_id)
VALUES
    ('JohnD house', '145 JohnD lane, London', 'Two bedroom flat, next to the sea', 100, 1),
    ('RubyS house', '12 Fairytale lane, London', 'Ten bedroom mansion', 300, 2),
    ('RubyS cottage', '34 Cottage lane, Village', 'Beautiful cottage in the woods', 150, 2),
    ('DanG', '22 High Street, London', 'Modern loft', 350, 3),
    ('KatB', '12 Nowhere lane, Middletown', 'Quiet house in the wilderness', 350, 3);

INSERT INTO availability (listing_id, start_date, end_date, status)
VALUES
    (1, '2024-02-01', '2024-02-10', 'available'),
    (1, '2024-02-01', '2024-02-10', 'available'),
    (2, '2024-02-02', '2024-02-04', 'available'),
    (3, '2024-02-03', '2024-02-05', 'available'),
    (4, '2024-02-20', '2024-02-22', 'available'),
    (5, '2024-02-15', '2024-02-18', 'available'),
    (2, '2024-02-10', '2024-02-11', 'available');


