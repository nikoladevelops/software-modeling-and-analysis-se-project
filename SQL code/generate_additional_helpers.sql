USE MarketplaceDB;
GO

-- Procedure to retrieve all listings for a specific category
CREATE PROCEDURE GetListingsByCategory
    @CategoryID INT
AS
BEGIN
    SELECT 
        L.ListingID, 
        L.Title, 
        L.Description, 
        L.Price, 
        U.Name AS Seller, 
        L.DatePosted, 
        L.Status
    FROM Listings L
    INNER JOIN Users U ON L.UserID = U.UserID
    WHERE L.CategoryID = @CategoryID;
END;
GO

-- Function to calculate the average rating for a specific user
CREATE FUNCTION GetAverageRating (@UserID INT)
RETURNS DECIMAL(3, 2)
AS
BEGIN
    RETURN (
        SELECT AVG(CAST(Rating AS DECIMAL(3, 2))) 
        FROM Reviews R
        INNER JOIN Transactions T ON R.TransactionID = T.TransactionID
        WHERE T.SellerID = @UserID
    );
END;
GO

-- Trigger to set a listing's status to 'Expired' after 30 days if it is still 'Active'
CREATE TRIGGER SetListingExpired
ON Listings
AFTER INSERT
AS
BEGIN
    UPDATE Listings
    SET Status = 'Expired'
    WHERE DATEDIFF(DAY, DatePosted, GETDATE()) > 30 AND Status = 'Active';
END;
GO


-- BONUS

-- Lists all active listings along with details about the seller, such as their name and average rating
CREATE VIEW ActiveListingsWithSellers AS
SELECT 
    L.ListingID,
    L.Title,
    L.Description,
    L.Price,
    L.DatePosted,
    U.Name AS SellerName,
    dbo.GetAverageRating(U.UserID) AS SellerRating,
    C.CategoryName
FROM Listings L
JOIN Users U ON L.UserID = U.UserID
JOIN Categories C ON L.CategoryID = C.CategoryID
WHERE L.Status = 'Active';
GO


-- This view summarizes all transactions, showing buyer and seller names, the listing involved, and the transaction details
CREATE VIEW TransactionHistory AS
SELECT 
    T.TransactionID,
    L.Title AS ListingTitle,
    B.Name AS BuyerName,
    S.Name AS SellerName,
    T.TransactionDate,
    T.Amount
FROM Transactions T
JOIN Listings L ON T.ListingID = L.ListingID
JOIN Users B ON T.BuyerID = B.UserID
JOIN Users S ON T.SellerID = S.UserID;
GO


-- This view consolidates user reviews, showing the reviewer, the reviewed user, the associated transaction, and the review details
CREATE VIEW UserReviewsOverview AS
SELECT 
    R.ReviewID,
    Reviewer.Name AS ReviewerName,
    Reviewed.Name AS ReviewedUserName,
    T.TransactionDate,
    R.Rating,
    R.Comment
FROM Reviews R
JOIN Transactions T ON R.TransactionID = T.TransactionID
JOIN Users Reviewer ON T.BuyerID = Reviewer.UserID
JOIN Users Reviewed ON T.SellerID = Reviewed.UserID;
GO



-- TESTING --

-- 1. TESTING THE PROCEDURE

-- Test the procedure with a specific CategoryID (replace 1 with an actual CategoryID)
EXEC GetListingsByCategory @CategoryID = 1;

-- Verify with a direct SELECT query
SELECT 
    L.ListingID, 
    L.Title, 
    L.Description, 
    L.Price, 
    U.Name AS Seller, 
    L.DatePosted, 
    L.Status
FROM Listings L
INNER JOIN Users U ON L.UserID = U.UserID
WHERE L.CategoryID = 1;


-- 2. TESTING THE FUNCTION

-- Test the function with a specific UserID (replace 1 with an actual UserID)
SELECT dbo.GetAverageRating(1) AS AverageRating;

-- Verify with a manual calculation
SELECT 
    AVG(CAST(R.Rating AS DECIMAL(3, 2))) AS AverageRating
FROM Reviews R
INNER JOIN Transactions T ON R.TransactionID = T.TransactionID
WHERE T.SellerID = 1;


-- 3. TESTING THE TRIGGER

-- Insert a listing with an older DatePosted
INSERT INTO Listings (Title, Description, Price, CategoryID, UserID, DatePosted, Status)
VALUES ('Old Listing', 'Description for old listing', 100.00, 1, 1, DATEADD(DAY, -31, GETDATE()), 'Active');

-- Insert a listing with a recent DatePosted
INSERT INTO Listings (Title, Description, Price, CategoryID, UserID, DatePosted, Status)
VALUES ('Recent Listing', 'Description for recent listing', 200.00, 1, 1, GETDATE(), 'Active');

-- Check the status of both listings
SELECT ListingID, Title, DatePosted, Status
FROM Listings
WHERE Title IN ('Old Listing', 'Recent Listing');


-- 4. BONUS TESTING THE VIEWS

SELECT * FROM ActiveListingsWithSellers;
SELECT * FROM TransactionHistory;
SELECT * FROM UserReviewsOverview;