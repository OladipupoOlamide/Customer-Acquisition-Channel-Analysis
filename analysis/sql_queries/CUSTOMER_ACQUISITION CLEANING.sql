CREATE TABLE customer_data(
	customer_id SERIAL PRIMARY KEY,
	channel VARCHAR(50),
	cost DECIMAL(10,6),
	conversion_rate DECIMAL(10,5),
	revenue DECIMAL(10,1)
);
SELECT * FROM customer_data

UPDATE customer_data
SET channel = 'email'
WHERE channel = 'email marketing'

UPDATE customer_data
SET channel = 'paid ad'
WHERE channel = 'paid advertising'

SELECT * FROM customer_date
WHERE cost > (SELECT AVG(cost)+3*STDDEV(cost) FROM customer_data) OR
      revenue <  (SELECT AVG(revenue)-3*STDDEV(revenue) FROM customer_data)

SELECT * FROM customer_data WHERE conversion_rate < 0 OR conversion_rate > 1;

WITH stats AS (
  SELECT 
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cost) AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cost) AS q3
  FROM customer_data)
SELECT * FROM customer_data, stats
WHERE cost < (q1 - 1.5*(q3-q1)) 
   OR cost > (q3 + 1.5*(q3-q1));

WITH stats AS (
  SELECT 
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) AS q3
  FROM customer_data)
SELECT * FROM customer_data, stats
WHERE revenue < (q1 - 1.5*(q3-q1)) 
   OR revenue > (q3 + 1.5*(q3-q1));


WITH stats AS (
  SELECT 
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) AS q3
  FROM customer_data)
SELECT * FROM customer_data, stats
WHERE revenue < (q1 - 1.5*(q3-q1)) 
   OR revenue > (q3 + 1.5*(q3-q1));