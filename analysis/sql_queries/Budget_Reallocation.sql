--REALLOCATING COSTS
WITH current_metric AS(
	SELECT
		channel,COUNT(*) AS customer_count,SUM(revenue),
		SUM(cost) AS total_cost, AVG(cost) AS CPA,
		SUM(revenue)/ COUNT(*) AS average_revenue_per_customer	
	FROM
		customer_data
	GROUP BY channel
),
new_cost AS
(SELECT
	channel,
	CASE
		WHEN channel = 'paid ad' THEN total_cost*0.5
		WHEN channel = 'email' THEN total_cost*1.5
		ELSE total_cost
	END AS projected_cost,
	CPA
FROM
	current_metric),
projected_customers AS
(SELECT 
	c.channel,
	CASE
		WHEN c.channel = 'email'THEN FLOOR(n.projected_cost*1.1/c.CPA)
		WHEN c.channel = 'paid ad' THEN FLOOR(n.projected_cost/c.CPA)
		ELSE c.customer_count
	END AS projected_customers
		
FROM
	current_metric AS c JOIN new_cost n ON c.channel=n.channel)


SELECT
	c.channel,
	c.total_cost AS old_cost,
	n.projected_cost AS projected_cost,
	c.customer_count AS old_customers,
	p.projected_customers AS projectedd_customers
FROM current_metric c JOIN new_cost n ON c.channel=n.channel
JOIN projected_customers p ON c.channel=p.channel

SELECT
	SUM(cost) AS total_cost,
	ROUND(SUM(revenue)/(537.61+1),2) AS targeted_total_cost,
	ROUND(SUM(revenue)/(537.61+1)/COUNT(*),2) AS targted_CPA
FROM
	customer_data
WHERE channel = 'paid ad'
	
