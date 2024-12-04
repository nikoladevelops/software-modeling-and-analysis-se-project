USE MarketplaceDB

-- Test 1: Check if there are registered users
SELECT * FROM Users;
-- Verify that only a single user can have an email (unique emails)
SELECT Email, COUNT(*) AS Count FROM Users GROUP BY Email HAVING COUNT(*) > 1;
-- Just a quick way to group users and check how many users are in each group based on a role (seller/premium/admin)
SELECT RoleID, COUNT(*) AS Count FROM Users GROUP BY RoleID HAVING COUNT(*) > 1;

-- Test 2: Check UserRoles Table
SELECT * FROM UserRoles;

-- Ensure RoleID matches Users table:
SELECT ur.RoleID, COUNT(u.UserID) AS UsersCount
FROM UserRoles ur
LEFT JOIN Users u ON ur.RoleID = u.RoleID
GROUP BY ur.RoleID;

-- Test 3: Checking the Categories Table
SELECT * FROM Categories;

-- Ensure all categories have parents if not root:
SELECT c1.CategoryID, c1.CategoryName AS ChildCategory, c2.CategoryName AS ParentCategory
FROM Categories c1
LEFT JOIN Categories c2 ON c1.ParentCategoryID = c2.CategoryID;

-- Test 4: Check Listings Table
SELECT * FROM Listings;
-- Join with Users and Categories to validate foreign keys:
SELECT l.ListingID, l.Title, u.Name AS Seller, c.CategoryName AS Category
FROM Listings l
JOIN Users u ON l.UserID = u.UserID
JOIN Categories c ON l.CategoryID = c.CategoryID;

-- Check for orphaned listings:
SELECT ListingID FROM Listings
WHERE UserID NOT IN (SELECT UserID FROM Users)
   OR CategoryID NOT IN (SELECT CategoryID FROM Categories);

-- Test 5: Check ListingsImages Table
SELECT * FROM Listings;

-- Validate the Foreign Key Relationship 
SELECT l.ListingID, l.Title, c.CategoryName
FROM Listings l
JOIN Categories c ON l.CategoryID = c.CategoryID;

-- Validate the Foreign Key Relationship with Users
SELECT l.ListingID, l.Title, u.Name AS Seller
FROM Listings l
JOIN Users u ON l.UserID = u.UserID;

-- Verify Active Listings (Status Check)
SELECT COUNT(*) AS ActiveListings
FROM Listings
WHERE Status = 'Active';


-- Check Listings with Prices Above a Specific Amount
SELECT ListingID, Title, Price
FROM Listings
WHERE Price > 100;

-- Check Listings Posted in the Last 30 Days
SELECT ListingID, Title, DatePosted
FROM Listings
WHERE DatePosted >= DATEADD(DAY, -30, GETDATE());

-- Get the Most Expensive Listing
SELECT TOP 1 ListingID, Title, Price
FROM Listings
ORDER BY Price DESC;


-- Test 6: Check Favorites Table
SELECT * FROM Favorites;
-- Validate many-to-many relationship between Users and Listings:
SELECT f.UserID, u.Name, f.ListingID, l.Title
FROM Favorites f
JOIN Users u ON f.UserID = u.UserID
JOIN Listings l ON f.ListingID = l.ListingID;

-- Check for orphaned favorites:
SELECT * FROM Favorites
WHERE UserID NOT IN (SELECT UserID FROM Users)
   OR ListingID NOT IN (SELECT ListingID FROM Listings);

-- Test 7: Check UserReviews Table (if applicable)
SELECT * FROM Reviews;
-- Ensure reviewed users and reviewers exist:
SELECT r.ReviewID, r.UserID AS ReviewerID, ur.Name AS Reviewer,
       t.BuyerID AS ReviewedUserID, bu.Name AS ReviewedUser
FROM Reviews r
JOIN Users ur ON r.UserID = ur.UserID -- Join for the reviewer
JOIN Transactions t ON r.TransactionID = t.TransactionID
JOIN Users bu ON t.BuyerID = bu.UserID -- Join for the reviewed user (Buyer)
WHERE t.BuyerID = r.UserID -- Ensures reviewer is the Buyer
UNION
SELECT r.ReviewID, r.UserID AS ReviewerID, ur.Name AS Reviewer,
       t.SellerID AS ReviewedUserID, su.Name AS ReviewedUser
FROM Reviews r
JOIN Users ur ON r.UserID = ur.UserID -- Join for the reviewer
JOIN Transactions t ON r.TransactionID = t.TransactionID
JOIN Users su ON t.SellerID = su.UserID -- Join for the reviewed user (Seller)
WHERE t.SellerID = r.UserID; -- Ensures reviewer is the Seller

-- Test 8: Check Messages Table (if applicable)
SELECT * FROM Messages;
-- Validate sender and receiver relationships:
SELECT m.MessageID, s.Name AS Sender, r.Name AS Receiver, m.Content AS MessageText, m.Timestamp AS SentDate
FROM Messages m
JOIN Users s ON m.SenderID = s.UserID
JOIN Users r ON m.ReceiverID = r.UserID;

-- Check for orphaned messages:
SELECT * FROM Messages
WHERE SenderID NOT IN (SELECT UserID FROM Users)
   OR ReceiverID NOT IN (SELECT UserID FROM Users);