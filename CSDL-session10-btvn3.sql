CREATE DATABASE IF NOT EXISTS session10_btvn3_InventoryManagement;
USE session10_btvn3_InventoryManagement;

CREATE TABLE products(
	productID INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE inventoryChanges(
	changeID INT AUTO_INCREMENT PRIMARY KEY,
    oldQuantity INT NOT NULL,
    newQuantity INT NOT NULL,
    changeDate DATETIME,
    productID INT,
    FOREIGN KEY(productID) REFERENCES products(productID)
);

DELIMITER $$
	CREATE TRIGGER BeforeInsertProduct
	BEFORE INSERT ON products
    FOR EACH ROW
    BEGIN
		IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Loi Trigger: khong the them moi san pham';
        END IF;
    END $$
DELIMITER ;

-- bat che do safe mode
SET SQL_SAFE_UPDATES = 1;

INSERT INTO products(productName, quantity)
VALUES 
	('milk', 12),
    ('apple', 7),
    ('orange', -3);


