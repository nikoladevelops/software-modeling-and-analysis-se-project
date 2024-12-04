USE MarketplaceDB

-- UserRoles Table Inserts
INSERT INTO UserRoles (RoleName)
VALUES 
    ('Admin'),
    ('Seller'),
    ('Premium Seller');

-- Users Table Inserts
INSERT INTO Users (Name, Email, Password, RoleID)
VALUES 
    ('Admin One', 'admin1@example.com', 'hashed_password_admin1', 1),
    ('Admin Two', 'admin2@example.com', 'hashed_password_admin2', 1),
    ('Admin Three', 'admin3@example.com', 'hashed_password_admin3', 1),
    ('Seller One', 'seller1@example.com', 'hashed_password_seller1', 2),
    ('Seller Two', 'seller2@example.com', 'hashed_password_seller2', 2),
    ('Seller Three', 'seller3@example.com', 'hashed_password_seller3', 2),
    ('Premium Seller One', 'premium1@example.com', 'hashed_password_premium1', 3),
    ('Premium Seller Two', 'premium2@example.com', 'hashed_password_premium2', 3),
    ('Premium Seller Three', 'premium3@example.com', 'hashed_password_premium3', 3),
    ('Seller Four', 'seller4@example.com', 'hashed_password_seller4', 2),
    ('Seller Five', 'seller5@example.com', 'hashed_password_seller5', 2),
    ('Premium Seller Four', 'premium4@example.com', 'hashed_password_premium4', 3),
    ('Seller Six', 'seller6@example.com', 'hashed_password_seller6', 2),
    ('Premium Seller Five', 'premium5@example.com', 'hashed_password_premium5', 3),
    ('Premium Seller Six', 'premium6@example.com', 'hashed_password_premium6', 3),
    ('Seller Seven', 'seller7@example.com', 'hashed_password_seller7', 2),
    ('Premium Seller Seven', 'premium7@example.com', 'hashed_password_premium7', 3),
    ('Admin Four', 'admin4@example.com', 'hashed_password_admin4', 1),
    ('Seller Eight', 'seller8@example.com', 'hashed_password_seller8', 2),
    ('Premium Seller Eight', 'premium8@example.com', 'hashed_password_premium8', 3);

-- Root Categories (this is literally parent categories and then we have subcategories which are children of the root/parent category that's the main idea here)
-- In total all category inserts are 20 as well
INSERT INTO Categories (CategoryName, ParentCategoryID)
VALUES 
    ('Electronics', NULL),
    ('Home and Garden', NULL),
    ('Vehicles', NULL),
    ('Fashion', NULL),
    ('Jobs', NULL);

-- Subcategories under Electronics
INSERT INTO Categories (CategoryName, ParentCategoryID)
VALUES 
    ('Mobile Phones', 1),
    ('Laptops', 1),
    ('Cameras', 1);

-- Subcategories under Home and Garden
INSERT INTO Categories (CategoryName, ParentCategoryID)
VALUES 
    ('Furniture', 2),
    ('Kitchen Appliances', 2),
    ('Decor', 2);

-- Subcategories under Vehicles
INSERT INTO Categories (CategoryName, ParentCategoryID)
VALUES 
    ('Cars', 3),
    ('Motorcycles', 3),
    ('Bicycles', 3);

-- Subcategories under Fashion
INSERT INTO Categories (CategoryName, ParentCategoryID)
VALUES 
    ('Clothing', 4),
    ('Shoes', 4),
    ('Accessories', 4);

-- Subcategories under Jobs
INSERT INTO Categories (CategoryName, ParentCategoryID)
VALUES 
    ('Full-Time', 5),
    ('Part-Time', 5),
    ('Freelance', 5);



-- Insert Listings
INSERT INTO Listings (Title, Description, Price, DatePosted, UserID, CategoryID, Status)
VALUES
('iPhone 13 Pro', 'Almost new, barely used.', 1200, '2024-02-01', 1, 1, 'Active'),
('Nike Air Max', 'Brand new sneakers, size 42.', 150, '2024-02-02', 2, 2, 'Active'),
('Wooden Dining Table', 'Seats 6 people, excellent condition.', 300, '2024-02-03', 3, 3, 'Active'),
('Toyota Corolla 2015', 'Well-maintained, 80k miles.', 8000, '2024-02-04', 4, 4, 'Sold'),
('Harry Potter Box Set', 'Complete set, hardcover edition.', 100, '2024-02-05', 5, 5, 'Active'),
('Lego Star Wars', 'Rare collector’s item.', 200, '2024-02-06', 6, 6, 'Active'),
('Tennis Racket', 'High-quality racket, lightly used.', 120, '2024-02-07', 7, 7, 'Active'),
('Yoga Mat', 'Non-slip, extra thick.', 50, '2024-02-08', 8, 8, 'Active'),
('Apartment for Rent', '2-bedroom apartment in downtown.', 900, '2024-02-09', 9, 9, 'Active'),
('Cat Scratching Post', 'Brand new, sturdy design.', 40, '2024-02-10', 10, 10, 'Active'),
('Gold Necklace', '14K gold with a diamond pendant.', 500, '2024-02-11', 11, 11, 'Active'),
('Landscape Painting', 'Original art by local artist.', 350, '2024-02-12', 12, 12, 'Active'),
('Guitar', 'Acoustic guitar, great for beginners.', 180, '2024-02-13', 13, 13, 'Active'),
('Organic Honey', 'Pure, unprocessed honey.', 25, '2024-02-14', 14, 14, 'Active'),
('Cordless Drill', 'Brand new with warranty.', 100, '2024-02-15', 15, 15, 'Active'),
('Rose Plants', 'Freshly potted, different colors.', 30, '2024-02-16', 16, 16, 'Active'),
('Website Development', 'Professional website services.', 1500, '2024-02-17', 17, 17, 'Active'),
('Wedding Planner Services', 'Experienced event organizer.', 3000, '2024-02-18', 18, 18, 'Active'),
('Stamp Collection', 'Vintage stamps from around the world.', 800, '2024-02-19', 19, 19, 'Active'),
('Antique Clock', 'Beautiful piece from the 19th century.', 700, '2024-02-20', 20, 20, 'Active');

-- Insert Transactions
INSERT INTO Transactions (ListingID, BuyerID, SellerID, TransactionDate, Amount)
VALUES
(1, 2, 1, '2024-02-21', 1200),
(2, 3, 2, '2024-02-22', 150),
(3, 4, 3, '2024-02-23', 300),
(4, 5, 4, '2024-02-24', 8000),
(5, 6, 5, '2024-02-25', 100),
(6, 7, 6, '2024-02-26', 200),
(7, 8, 7, '2024-02-27', 120),
(8, 9, 8, '2024-02-28', 50),
(9, 10, 9, '2024-03-01', 900),
(10, 11, 10, '2024-03-02', 40),
(11, 12, 11, '2024-03-03', 500),
(12, 13, 12, '2024-03-04', 350),
(13, 14, 13, '2024-03-05', 180),
(14, 15, 14, '2024-03-06', 25),
(15, 16, 15, '2024-03-07', 100),
(16, 17, 16, '2024-03-08', 30),
(17, 18, 17, '2024-03-09', 1500),
(18, 19, 18, '2024-03-10', 3000),
(19, 20, 19, '2024-03-11', 800),
(20, 1, 20, '2024-03-12', 700);

-- Insert Favorites
INSERT INTO Favorites (UserID, ListingID)
VALUES
(1, 2), (1, 3), (1, 4), (1, 5), (1, 6),
(2, 1), (2, 3), (2, 7), (2, 8), (2, 9),
(3, 10), (3, 12), (3, 14), (3, 16), (3, 18),
(4, 19), (4, 20), (4, 1), (4, 2), (4, 5),
(5, 3), (5, 4), (5, 6), (5, 7), (5, 9),
(6, 8), (6, 11), (6, 13), (6, 15), (6, 17),
(7, 19), (7, 20), (7, 2), (7, 4), (7, 5),
(8, 1), (8, 3), (8, 6), (8, 10), (8, 12),
(9, 14), (9, 16), (9, 18), (9, 20), (9, 5),
(10, 7), (10, 9), (10, 11), (10, 13), (10, 15);

-- Insert User Reviews
INSERT INTO Reviews (UserID, TransactionID, Rating, Comment)
VALUES
(1, 1, 5, 'Excellent seller, quick response!'),
(2, 2, 4, 'Smooth transaction, product as described.'),
(3, 3, 3, 'Item arrived late but in good condition.'),
(4, 4, 5, 'Very professional and polite.'),
(5, 5, 2, 'Item not as described, disappointing.'),
(6, 6, 4, 'Overall good experience.'),
(7, 7, 5, 'Highly recommended!'),
(8, 8, 4, 'Quick and easy process.'),
(9, 9, 3, 'Mediocre experience.'),
(10, 10, 5, 'Exceptional service.'),
(11, 11, 4, 'Would transact with again.'),
(12, 12, 3, 'Average communication.'),
(13, 13, 5, 'Perfect transaction.'),
(14, 14, 4, 'Everything went smoothly.'),
(15, 15, 2, 'Not satisfied with the response time.'),
(16, 16, 5, 'Very satisfied.'),
(17, 17, 3, 'Neutral experience.'),
(18, 18, 4, 'Overall good experience.'),
(19, 19, 5, 'Great product and service.'),
(20, 20, 3, 'Could have been better.');

-- Insert Messages
INSERT INTO Messages (SenderID, ReceiverID, ListingID, Content, Timestamp)
VALUES
(1, 2, 1, 'Is the iPhone still available?', '2024-02-01'),
(2, 1, 1, 'Yes, it is.', '2024-02-01'),
(3, 4, 2, 'Can I see more pictures of the car?', '2024-02-02'),
(4, 3, 2, 'Sure, I will send them shortly.', '2024-02-02'),
(5, 6, 3, 'Do you offer delivery for the furniture?', '2024-02-03'),
(6, 5, 3, 'Yes, for an additional fee.', '2024-02-03'),
(7, 8, 4, 'Is the price negotiable?', '2024-02-04'),
(8, 7, 4, 'Yes, feel free to make an offer.', '2024-02-04'),
(9, 10, 5, 'When can I pick up the item?', '2024-02-05'),
(10, 9, 5, 'Anytime after 5 PM.', '2024-02-05'),
(11, 12, 6, 'Is the item still available?', '2024-02-06'),
(12, 11, 6, 'Yes, it is.', '2024-02-06'),
(13, 14, 7, 'What is the condition of the product?', '2024-02-07'),
(14, 13, 7, 'It’s in excellent condition.', '2024-02-07'),
(15, 16, 8, 'Can you ship to another city?', '2024-02-08'),
(16, 15, 8, 'Yes, shipping costs apply.', '2024-02-08'),
(17, 18, 9, 'Can I reserve the item?', '2024-02-09'),
(18, 17, 9, 'Yes, I can hold it for you until tomorrow.', '2024-02-09'),
(19, 20, 10, 'Can you provide more details?', '2024-02-10'),
(20, 19, 10, 'Sure, what do you need to know?', '2024-02-10');