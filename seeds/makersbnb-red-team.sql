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

DROP TABLE IF EXISTS booking CASCADE;
DROP SEQUENCE IF EXISTS booking_id_seq CASCADE;


-- Then, we recreate them
CREATE SEQUENCE IF NOT EXISTS account_id_seq;
CREATE TABLE account (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255)
);

CREATE SEQUENCE IF NOT EXISTS listing_id_seq;
CREATE TABLE listing (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    price INT NOT NULL,
    account_id INT,
    image_filename VARCHAR(255),
    CONSTRAINT fk_account FOREIGN KEY(account_id) REFERENCES account(id) ON DELETE CASCADE
);

CREATE SEQUENCE IF NOT EXISTS availability_id_seq;
CREATE TABLE availability (
    id SERIAL PRIMARY KEY,
    listing_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    available BOOLEAN NOT NULL,
    CONSTRAINT fk_listing FOREIGN KEY (listing_id) REFERENCES listing(id) ON DELETE CASCADE
);

CREATE SEQUENCE IF NOT EXISTS booking_id_seq;
CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    listing_id INT NOT NULL,
    account_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(255) NOT NULL,
    CONSTRAINT fk_listing_listing FOREIGN KEY (listing_id) REFERENCES listing(id) ON DELETE CASCADE,
    CONSTRAINT fk_listing_account FOREIGN KEY (account_id) REFERENCES account(id) ON DELETE CASCADE
);



-- Finally, we add any records that are needed for the tests to run
INSERT INTO account (username, first_name, last_name, email, password, phone_number)
VALUES
    ('JohnD', 'John', 'Doe', 'johndoe@example.com', 'password123', '07973661188'),
    ('RubyS', 'Ruby', 'Seresin', 'ruby@example.com', 'password1234', '07973661100'),
    ('DanG', 'Dan', 'Gullis', 'dan@example.com', 'password1235', '07973661122'),
    ('KatB', 'Kat', 'Biel', 'kat@example.com', 'password1236', '07973661133'),
    ('AmparoG', 'Amparo', 'Guevara', 'amparo@example.com', 'password1237', '07973661144');


INSERT INTO listing (name, address, description, price, account_id, image_filename)
VALUES
    ('Vibrant Seaside Apartment', '145 JohnD Lane, London', 'Two bedroom flat, next to the sea.', 100, 1, 'listing-1.jpg'),
    ('Victorian Family House', '12 Fairytale Lane, London', 'Ten bedroom mansion', 300, 2, 'listing-2.jpg'),
    ('Woodland Cottage', '34 Cottage Lane, Village', 'Located in the middle of the Sørland wilderness between two lakes far from people and roads. Treetop cabin with 4 floors - a real return to nature experience! Great level of comfort with great beds, panoramic views, and well-equipped kitchen.', 150, 2, 'listing-3.jpeg'),
    ('Urban Apartment Loft', '22 High Street, London', 'Lovely studio apartment located in the famous Notting Hill Area in London.', 350, 3, 'listing-4.jpg'),
    ('Quiet Secluded House', '12 Nowhere Lane, Middletown', 'We welcome you to come and stay in one of our newly renovated Airbnb rooms set within our beautiful converted barn in the Whicham Valley. A peaceful, picturesque location with rural open views of the Combes.', 350, 3, 'listing-5.jpg');

INSERT INTO availability (listing_id, start_date, end_date, available)
VALUES
    (1, '2024-02-01', '2024-02-10', true),
    (1, '2024-02-15', '2024-02-19', true),
    (2, '2024-02-02', '2024-02-04', true),
    (3, '2024-02-03', '2024-02-05', true),
    (4, '2024-02-20', '2024-02-22', true),
    (5, '2024-02-15', '2024-02-18', true),
    (2, '2024-02-10', '2024-02-11', true);

INSERT INTO booking (listing_id, account_id, start_date, end_date, status)
VALUES
    (1, 2, '2024-02-10', '2024-02-15', 'Confirmed'),
    (1, 5, '2024-02-15', '2024-02-19', 'Requested'),
    (1, 3, '2024-02-10', '2024-02-12', 'Denied'),
    (2, 1, '2024-02-02', '2024-02-04', 'Requested'),
    (3, 1, '2024-02-21', '2024-02-27', 'Confirmed');