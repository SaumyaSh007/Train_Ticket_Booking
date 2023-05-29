-- Create the database
CREATE DATABASE train_booking;

-- Switch to the created database
USE train_booking;

-- Create the table to store the seat information
CREATE TABLE seats (
  id INT PRIMARY KEY AUTO_INCREMENT,
  seat_number INT NOT NULL,
  is_booked BOOLEAN DEFAULT FALSE
);

-- Insert seat data for a coach with 80 seats
INSERT INTO seats (seat_number) VALUES
  (1), (2), (3), (4), (5), (6), (7),   -- Row 1
  (8), (9), (10), (11), (12), (13), (14), -- Row 2
  (15), (16), (17), (18), (19), (20), (21),  -- Row 3
  (22), (23), (24), (25), (26), (27), (28),  -- Row 4
  (29), (30), (31), (32), (33), (34), (35), -- Row 5
  (36), (37), (38), (39), (40), (41), (42),  -- Row 6
  (43), (44), (45), (46), (47), (48), (49),  -- Row 7 
  (50), (51), (52), (53), (54), (55), (56),  -- Row 8
  (57), (58), (59), (60), (61), (62), (63),  -- Row 9
  (64), (65), (66), (67), (68), (69), (70),  -- Row 10
  (71), (72), (73), (74), (75), (76), (77), -- Row 11
  (78), (79), (80); -- Row 12

-- Create a stored procedure to handle seat booking
DELIMITER //

CREATE PROCEDURE book_seats (
  IN num_seats INT,
  OUT success BOOLEAN,
  OUT booked_seats VARCHAR(255)
)
BEGIN
  DECLARE start_seat INT;
  DECLARE i INT;

  SET success = FALSE;
  SET booked_seats = '';

  -- Find available seats in one row
  SELECT MIN(seat_number)
  INTO start_seat
  FROM seats
  WHERE is_booked = FALSE
  GROUP BY FLOOR((seat_number - 1) / 7)
  HAVING COUNT(*) >= num_seats;

  IF start_seat IS NULL THEN
    -- Find adjacent seats
    SELECT MIN(seat_number)
    INTO start_seat
    FROM seats
    WHERE is_booked = FALSE
    GROUP BY FLOOR((seat_number - 1) / 7)
    HAVING COUNT(*) + num_seats <= 7;

    IF start_seat IS NULL THEN
      SET success = FALSE;
      RETURN;
    END IF;
  END IF;

  SET i = start_seat;
  WHILE i < start_seat + num_seats DO
    UPDATE seats SET is_booked = TRUE WHERE seat_number = i;
    SET booked_seats = CONCAT(booked_seats, i, ', ');
    SET i = i + 1;
  END WHILE;

  SET success = TRUE;
  SET booked_seats = TRIM(TRAILING ', ' FROM booked_seats);
END //

DELIMITER ;
