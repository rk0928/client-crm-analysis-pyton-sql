DROP DATABASE IF EXISTS Client_Project;
CREATE DATABASE Client_Project;
USE Client_Project;
CREATE TABLE client_crm (
Client_ID VARCHAR(10) PRIMARY KEY,
Bra_size VARCHAR(10),
Last_contact DATE,
Date_added DATE,
Active_Dormant VARCHAR(20)
);
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE '/Users/renoodle/client_crm_mysql.csv'
INTO TABLE client_crm
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*)
FROM client_crm;
SELECT Client_ID, COUNT(*)
FROM client_crm
GROUP BY Client_ID
HAVING COUNT(*) > 1;
DROP TABLE client_crm;
CREATE TABLE client_crm (
Client_ID VARCHAR(10) PRIMARY KEY,
Bra_size VARCHAR(10),
Last_contacted DATE,
Date_added DATE,
Active_Dormant VARCHAR(20)
);
LOAD DATA LOCAL INFILE '/Users/renoodle/client_crm_mysql.csv'
INTO TABLE client_crm
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*)
FROM client_crm;
SELECT *
FROM client_crm
LIMIT 10;
## 1. Active vs Dormant Clients
SELECT Active_Dormant,
COUNT(*) AS Client_Count
FROM client_crm
GROUP BY Active_Dormant;
## 2. Clients added by year
SELECT YEAR(Date_added) AS Year_Added,
COUNT(*) AS Clients_Added
FROM client_crm
GROUP BY YEAR(Date_added)
ORDER BY Year_added;
## 3. Most recent client additions
SELECT Client_ID,
Date_added
FROM client_crm
ORDER BY Date_added DESC
LIMIT 10;
## 4. Dormant client percentage
SELECT
ROUND(
SUM(CASE WHEN Active_Dormant = 'Dormant' THEN 1 ELSE 0 END)
* 100.0 / COUNT(*),
2
) AS Dormant_Percentage
FROM client_crm;
