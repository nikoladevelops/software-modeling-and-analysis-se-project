-- Create the database
CREATE DATABASE MarketplaceDB;
GO

USE MarketplaceDB;
GO


CREATE TABLE UserRoles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(15),
    RoleID INT NOT NULL,
    RegistrationDate DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (RoleID) REFERENCES UserRoles(RoleID)
);


CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    ParentCategoryID INT NULL,
    FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
);


CREATE TABLE Listings (
    ListingID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CategoryID INT NOT NULL,
    UserID INT NOT NULL,
    DatePosted DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(50) NOT NULL DEFAULT 'Active',
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE Messages (
    MessageID INT IDENTITY(1,1) PRIMARY KEY,
    SenderID INT NOT NULL,
    ReceiverID INT NOT NULL,
    ListingID INT NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    Timestamp DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (SenderID) REFERENCES Users(UserID),
    FOREIGN KEY (ReceiverID) REFERENCES Users(UserID),
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID)
);


CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    BuyerID INT NOT NULL,
    SellerID INT NOT NULL,
    ListingID INT NOT NULL,
    TransactionDate DATETIME NOT NULL DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (BuyerID) REFERENCES Users(UserID),
    FOREIGN KEY (SellerID) REFERENCES Users(UserID),
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID)
);


CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    TransactionID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);


CREATE TABLE Favorites (
    FavoriteID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ListingID INT NOT NULL,
    UNIQUE(UserID, ListingID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID)
);