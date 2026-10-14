-- E-Commerce Database: SQL Practice Questions with Answers
-- Run this after importing ecommerce_50_each.sql into ecommerce_db.
USE ecommerce_db;

-- 1. CUSTOMERS
-- Q1. Display all customers.
SELECT * FROM Customers;

-- Q2. Find customers whose names contain 'Arun'.
SELECT * FROM Customers WHERE customer_name LIKE '%Arun%';

-- 2. ADDRESSES
-- Q3. Display all addresses in Chennai.
SELECT * FROM Addresses WHERE city = 'Chennai';

-- Q4. Show each customer's name and city.
SELECT c.customer_name, a.city
FROM Customers c JOIN Addresses a ON c.customer_id = a.customer_id;

-- 3. CATEGORIES
-- Q5. Display all categories in alphabetical order.
SELECT * FROM Categories ORDER BY category_name;

-- Q6. Count the total categories.
SELECT COUNT(*) AS total_categories FROM Categories;

-- 4. BRANDS
-- Q7. Display all brand names.
SELECT brand_name FROM Brands ORDER BY brand_name;

-- Q8. Count the total brands.
SELECT COUNT(*) AS total_brands FROM Brands;

-- 5. PRODUCTS
-- Q9. Display products priced above 10000.
SELECT * FROM Products WHERE price > 10000 ORDER BY price DESC;

-- Q10. Show product names, prices, category names, and brand names.
SELECT p.product_name, p.price, c.category_name, b.brand_name
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
JOIN Brands b ON p.brand_id = b.brand_id;

-- 6. PRODUCT_IMAGES
-- Q11. Display all images for product ID 1.
SELECT * FROM Product_Images WHERE product_id = 1;

-- Q12. Count images for each product.
SELECT product_id, COUNT(*) AS image_count
FROM Product_Images GROUP BY product_id ORDER BY product_id;

-- 7. REVIEWS
-- Q13. Display all 5-star reviews.
SELECT * FROM Reviews WHERE rating = 5;

-- Q14. Calculate the average rating for each product.
SELECT product_id, ROUND(AVG(rating), 2) AS average_rating
FROM Reviews GROUP BY product_id ORDER BY product_id;

-- 8. CART
-- Q15. Display all carts.
SELECT * FROM Cart;

-- Q16. Show each cart with the customer's name.
SELECT ca.cart_id, c.customer_name, ca.created_at
FROM Cart ca JOIN Customers c ON ca.customer_id = c.customer_id;

-- 9. CART_ITEMS
-- Q17. Display cart items with quantity greater than 2.
SELECT * FROM Cart_Items WHERE quantity > 2;

-- Q18. Calculate the total number of units in each cart.
SELECT cart_id, SUM(quantity) AS total_units
FROM Cart_Items GROUP BY cart_id ORDER BY cart_id;

-- 10. ORDERS
-- Q19. Display orders whose status is Pending.
SELECT * FROM Orders WHERE order_status = 'Pending';

-- Q20. Calculate the total sales amount across all orders.
SELECT SUM(total_amount) AS total_order_value FROM Orders;

-- 11. ORDER_ITEMS
-- Q21. Show order items with product name, quantity, and item price.
SELECT oi.order_id, p.product_name, oi.quantity, oi.price
FROM Order_Items oi JOIN Products p ON oi.product_id = p.product_id;

-- Q22. Calculate the total quantity of items in each order.
SELECT order_id, SUM(quantity) AS total_items
FROM Order_Items GROUP BY order_id ORDER BY order_id;

-- 12. PAYMENTS
-- Q23. Display payments that are marked Paid.
SELECT * FROM Payments WHERE payment_status = 'Paid';

-- Q24. Summarize payment amounts by payment method.
SELECT payment_method, SUM(payment_amount) AS total_paid
FROM Payments GROUP BY payment_method;

-- 13. SHIPPING
-- Q25. Display shipments that have been Delivered.
SELECT * FROM Shipping WHERE shipping_status = 'Delivered';

-- Q26. Count shipments by shipping status.
SELECT shipping_status, COUNT(*) AS shipment_count
FROM Shipping GROUP BY shipping_status;

-- 14. COUPONS
-- Q27. Display active coupons.
SELECT * FROM Coupons WHERE status = 'Active';

-- Q28. Find coupons with a discount of at least 20 percent.
SELECT * FROM Coupons WHERE discount_percentage >= 20 ORDER BY discount_percentage DESC;

-- 15. INVENTORY
-- Q29. Display inventory with quantity below 200.
SELECT * FROM Inventory WHERE quantity < 200;

-- Q30. Show product names and their inventory quantities.
SELECT p.product_name, i.quantity, i.warehouse_location
FROM Inventory i JOIN Products p ON i.product_id = p.product_id;

-- BONUS QUESTIONS
-- Q31. Find the most expensive product.
SELECT * FROM Products WHERE price = (SELECT MAX(price) FROM Products);

-- Q32. Find the average product price.
SELECT ROUND(AVG(price), 2) AS average_product_price FROM Products;

-- Q33. Find customers who have placed orders.
SELECT DISTINCT c.customer_id, c.customer_name
FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id;

-- Q34. Count orders by status.
SELECT order_status, COUNT(*) AS order_count
FROM Orders GROUP BY order_status;

-- Q35. Show order ID, customer name, and order total.
SELECT o.order_id, c.customer_name, o.total_amount, o.order_status
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id;

-- Q36. Find products that have stock quantity equal to zero.
SELECT * FROM Products WHERE stock_quantity = 0;

-- Q37. Find the highest review rating for each product.
SELECT product_id, MAX(rating) AS highest_rating
FROM Reviews GROUP BY product_id;

-- Q38. Find customers with more than one order.
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;

-- Q39. Find the total number of rows in each table.
SELECT 'Customers' AS table_name, COUNT(*) AS total_rows FROM Customers
UNION ALL SELECT 'Addresses', COUNT(*) FROM Addresses
UNION ALL SELECT 'Categories', COUNT(*) FROM Categories
UNION ALL SELECT 'Brands', COUNT(*) FROM Brands
UNION ALL SELECT 'Products', COUNT(*) FROM Products
UNION ALL SELECT 'Product_Images', COUNT(*) FROM Product_Images
UNION ALL SELECT 'Reviews', COUNT(*) FROM Reviews
UNION ALL SELECT 'Cart', COUNT(*) FROM Cart
UNION ALL SELECT 'Cart_Items', COUNT(*) FROM Cart_Items
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL SELECT 'Order_Items', COUNT(*) FROM Order_Items
UNION ALL SELECT 'Payments', COUNT(*) FROM Payments
UNION ALL SELECT 'Shipping', COUNT(*) FROM Shipping
UNION ALL SELECT 'Coupons', COUNT(*) FROM Coupons
UNION ALL SELECT 'Inventory', COUNT(*) FROM Inventory;

-- Q40. Display the 5 most expensive products.
SELECT product_id, product_name, price
FROM Products ORDER BY price DESC LIMIT 5;
