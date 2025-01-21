/* NIVELL 1 */
/* EXERCICI 2*/
SELECT distinct country
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id;

SELECT COUNT(DISTINCT country) /* alias */
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id;

SELECT company_name, round(avg(transaction.amount),2)
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id
WHERE declined = 0
GROUP BY company_name
ORDER BY 2 DESC
LIMIT 1;

/*EXERCICI 3*/
select country from company;

SELECT id
FROM transaction
WHERE company_id IN (
	SELECT id
    FROM company
    WHERE country = "Germany") ; /* tabulacion*/
    
SELECT company_name
FROM company
WHERE id in (
	select company_id
    from transaction
    where amount > (
		SELECT avg(amount)
        FROM transaction)
   ); /*oder*/
    
SELECT company_name
FROM company
WHERE id NOT IN (
	SELECT company_id
    FROM transaction); /*distinct*/
    
Select * from transaction;

/*NIVELL 2*/
/*EXERCICI 1*/
SELECT date(timestamp), sum(amount)
FROM transaction
WHERE declined=0
group by 1
order by 2
LIMIT 5;

/*EXERCICI 2*/
SELECT avg(transaction.amount), company.country
FROM transaction
LEFT JOIN company 
ON transaction.company_id = company.id
group by company.country
order by 1 DESC;

/*EXERCICI 3*/
SELECT transaction.id, transaction.company_id, transaction.amount
FROM transaction
LEFT JOIN company
ON transaction.company_id = company.id
WHERE company.country in (
	SELECT country
    FROM company
    WHERE company_name = "Non Institute");
    
/*Subconsulta*/

/* NIVELL 3*/
/* EXERCICI 1*/
SELECT company.company_name, company.phone, company.country, DATE(transaction.timestamp) as time, transaction.amount
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id
WHERE transaction.amount  BETWEEN 100 AND 200 AND DATE(transaction.timestamp) IN ('2021-04-29','2021-07-20','2022-03-13')   
ORDER BY transaction.amount DESC;

/*EXERCICI 2*/
SELECT count(transaction.id), transaction.company_id,
CASE
	WHEN count(transaction.id) >= 4 THEN "Té més o igual a 4 transaccions"
    ELSE "Té menys de 4 transaccions"
END as 4_transaccions
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id
GROUP BY 2
;