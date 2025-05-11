SELECT * FROM customer_data
--TOTAL CUSTOMERS ACQUIRED FOR EACH MARKETING CHANNEL
SELECT channel,COUNT(customer_id) AS customer_acquired FROM customer_data
GROUP BY channel
ORDER BY COUNT(customer_id) DESC

--TOTAL COST PER MARKETING CHANNEL
SELECT channel,ROUND(SUM(cost),2) AS total_cost
FROM customer_data
GROUP BY channel
ORDER BY SUM(cost) DESC

--REVENUE GAINED PER CHANNEL
SELECT channel,COUNT(*),SUM(revenue) AS total_revenue
FROM customer_data
GROUP BY channel
ORDER BY SUM(revenue) DESC

-- AVERAGE CONVERSION RATES PER CHANNEL
SELECT channel,COUNT(*),AVG(conversion_rate) AS Average_Conversion_Rate
FROM customer_data
GROUP BY channel
ORDER BY AVG(conversion_rate) DESC

--COST PER ACQUISITION
SELECT channel,AVG(COST) AS CPA
FROM customer_data
GROUP BY channel
ORDER BY CPA DESC

--RETURN ON INVESTMENT
SELECT channel,ROUND((((SUM(revenue)-SUM(cost))/SUM(cost))*100),2) AS ROI
FROM customer_data
GROUP BY channel 
ORDER BY ROI DESC

--CPA vs average revenue per customer for each 
SELECT channel,AVG(cost),((SUM(revenue))/COUNT(*)) AS average_revenue
FROM customer_data
GROUP BY channel
ORDER BY average_revenue DESC

-- Conversion Rate vs. Revenue Correlation
SELECT channel,AVG(conversion_rate),SUM(revenue) AS total_revenue
FROM customer_data
GROUP BY channel
ORDER BY avg DESC

--High value customers
SELECT channel,COUNT(*),AVG(revenue) AS average_high_revenue
FROM customer_data
WHERE revenue > (SELECT PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY revenue)FROM customer_data)
GROUP BY channel
ORDER BY average_high_revenue DESC


---