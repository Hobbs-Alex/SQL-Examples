--Examples based on lectures and assignments from 
--DB2 UDB programming course at Gateway Technical College
--Spring 2024 (instructor Saad Yousuf)

-- ApparelItems Table setup --
CREATE TABLE ApparelItems
(
    apparel_id INTEGER        NOT NULL,
    style      CHARACTER (12) NOT NULL,
    category   CHARACTER (8)  NOT NULL,
    color      CHARACTER (6)  NOT NULL,
    cost       DECIMAL (5,2)
);

ALTER TABLE ApparelItems
  ADD CONSTRAINT ApparelItems_apparel_id_pk 
  PRIMARY KEY(apparel_id);
  
INSERT INTO ApparelItems
VALUES(1001, 'LogoBold', 'Tshirt', 'Red', 4.99),
      (1002, 'LogoBold', 'Hoodie', 'Blue', 11.28),
      (1003, 'Mascot', 'Tshirt', 'Black', 5.09),    
      (1004, 'LogoTiled', 'Tshirt', 'White', 4.89),
      (1005, 'Striped', 'Shorts', 'Black', 6.78);

-- Suppliers Table setup --
CREATE TABLE Suppliers
(
    supplier_id CHARACTER(5) NOT NULL PRIMARY KEY,
    sName       CHARACTER(15) NOT NULL,
    sState      CHARACTER(2) NOT NULL
);

INSERT INTO Suppliers
VALUES('23KWH', 'PRINTPROS', 'WI'),
      ('22JWL', 'TEE FACTORY', 'IL'),
      ('23JWB', 'NOT TALLS', 'WI');

-- ItemSuppliers Table setup --
CREATE TABLE ItemSuppliers
(
    apparel_id  INTEGER      NOT NULL PRIMARY KEY,
    supplier_id CHARACTER(5) NOT NULL
);

INSERT INTO ItemSuppliers
VALUES(1001, '23KWH'),
      (1002, '23KWH'),
      (1003, '22JWL'),
      (1004, '22JWL'),
      (1005, '23JWB');
      
-- Add retail price column into ApparelItems table
ALTER TABLE ApparelItems
ADD retail DECIMAL(5,2);

SELECT * FROM ApparelItems;

UPDATE ApparelItems
SET Retail = 10.99
WHERE APPAREL_ID = 1001; --etc.

-- Display markup for each style
SELECT apparel_id, style, retail-cost AS "Markup"
FROM ApparelItems;

--INNER JOINS 
--Display supplier information for each apparel item
SELECT A.apparel_id AS "Apparel ID", A.style, A.category, 
       S.supplier_id AS "Supplier ID", S.SName AS "Supplier Name"
FROM ApparelItems A INNER JOIN ItemSuppliers I on A.Apparel_id = I.Apparel_id
                    INNER JOIN Suppliers S on I.Supplier_id = S.Supplier_id;
                    
--Display all items from a single supplier
SELECT A.apparel_id AS "Apparel ID", A.style, A.category, 
       S.supplier_id AS "Supplier ID", S.SName AS "Supplier Name"
FROM ApparelItems A INNER JOIN ItemSuppliers I on A.Apparel_id = I.Apparel_id
                    INNER JOIN Suppliers S on I.Supplier_id = S.Supplier_id
WHERE S.SNAME = 'TEE FACTORY';
                    

--Display all tshirts
SELECT apparel_id, style, category, color, cost, retail 
FROM ApparelItems
WHERE category = 'Tshirt';

--SUBQUERY 
--Display items where retail cost is above average retail cost
SELECT * FROM ApparelItems 
WHERE RETAIL > 
              (SELECT AVG(RETAIL) FROM ApparelItems);

