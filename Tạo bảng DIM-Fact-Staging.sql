-- Import Database DAP305_Schem
USE DAP305_Schem;

-- Create Dimension Tables
CREATE TABLE [Order_DIM] (
  [STT] integer identity(1,1),
  [OrderID] varchar(255) PRIMARY KEY,
)

CREATE TABLE [PostalCode_DIM] (
  [STT] integer identity(1,1),
  [Postalcode] varchar(255) PRIMARY KEY
  )

CREATE TABLE [ShipMode_DIM] (
  [SMID] integer identity(1,1) PRIMARY KEY,
  [ShipMode] varchar(255)
)

CREATE TABLE [Customer_DIM] (
  [STT] integer identity(1,1),
  [CustomerID] varchar(255) PRIMARY KEY,
  [CustomerName] varchar(255)
)

CREATE TABLE [Segment_DIM] (
  [SegmentID] integer identity(1,1) PRIMARY KEY,
  [Segment] varchar(255)
)

CREATE TABLE [Country_DIM] (
  [CountryID] integer identity(1,1) PRIMARY KEY,
  [Country] varchar(255)
)

CREATE TABLE [City_DIM] (
  [CityID] integer identity(1,1) PRIMARY KEY,
  [City] varchar(255)
)

CREATE TABLE [State_DIM] (
  [StateID] integer identity(1,1) PRIMARY KEY,
  [State] varchar(255)
)

CREATE TABLE [Region_DIM] (
  [RegionID] integer identity(1,1) PRIMARY KEY,
  [Region] varchar(255)
)

CREATE TABLE [Product_DIM] (
  STT integer identity(1,1),
  [ProductID] varchar(255) PRIMARY KEY ,
  [ProductName] varchar(255)
)

CREATE TABLE [Category_DIM] (
  [CategoryID] integer identity(1,1) PRIMARY KEY,
  [Category] varchar(255)
)

CREATE TABLE [SubCategory_DIM] (
  [SubCategoryID] integer identity(1,1) PRIMARY KEY,
  [SubCategory] varchar(255)
)

-- Create Fact table
CREATE TABLE [Fact_Table] (
  STT integer PRIMARY KEY,
  [RowID] varchar(255),
  [OrderID] varchar(255),
  PostalCode varchar(255),
  [Order date] date,
  [Ship date] date,
  [SMID] integer,
  [CustomerID] varchar(255),
  [SegmentID] integer,
  [CountryID] integer,
  [CityID] integer,
  [StateID] integer,
  [RegionID] integer,
  [ProductID] varchar(255),
  [CategoryID] integer,
  [SubCategoryID] integer,
  [Sales] float,
  Quantity integer,
  Discount float,
  Profit float
FOREIGN KEY ([OrderID]) REFERENCES [Order_DIM] ([OrderID]),
FOREIGN KEY (PostalCode) REFERENCES [PostalCode_DIM] (PostalCode),
FOREIGN KEY ([SMID]) REFERENCES [ShipMode_DIM] ([SMID]),
FOREIGN KEY ([CustomerID]) REFERENCES [Customer_DIM] ([CustomerID]),
FOREIGN KEY ([SegmentID]) REFERENCES [Segment_DIM] ([SegmentID]),
FOREIGN KEY ([CountryID]) REFERENCES [Country_DIM] ([CountryID]),
FOREIGN KEY ([CityID]) REFERENCES [City_DIM] ([CityID]),
FOREIGN KEY ([StateID]) REFERENCES [State_DIM] ([StateID]),
FOREIGN KEY ([RegionID]) REFERENCES [Region_DIM] ([RegionID]),
FOREIGN KEY ([ProductID]) REFERENCES [Product_DIM] ([ProductID]),
FOREIGN KEY ([CategoryID]) REFERENCES [Category_DIM] ([CategoryID]),
FOREIGN KEY ([SubCategoryID]) REFERENCES [SubCategory_DIM] ([SubCategoryID])
)

-- Create Staging table
CREATE TABLE Staging_table(
  STT integer identity(1,1) PRIMARY KEY,
  [RowID] varchar(255),
  [OrderID] varchar(255),
  [Order date] date,
  [Ship date] date,
  Postal_code varchar(255),
  [SMID] integer,
  ShipMode varchar(255),
  [CustomerID] varchar(255),
  CustomerName varchar(255),
  [SegmentID] integer,
  Segment varchar(255),
  [CountryID] integer,
  Country varchar(255),
  [CityID] integer,
  City varchar(255),
  [StateID] integer,
  [State] varchar(255),
  [RegionID] integer,
  Region varchar(255),
  [ProductID] varchar(255),
  ProductName varchar(255),
  [CategoryID] integer,
  Category varchar(255),
  [SubCategoryID] integer,
  SubCategory varchar(255),
  [Sales] float,
  Quantity integer,
  Discount float,
  Profit float
  )
  drop table Staging_table

-- Insert ID into Staging table

-- Update SMID
UPDATE Staging_table
SET Staging_table.SMID = ShipMode_DIM.SMID
FROM Staging_table
INNER JOIN ShipMode_DIM ON ShipMode_DIM.ShipMode = Staging_table.ShipMode

-- Update CustomerID
UPDATE Staging_table
SET Staging_table. CustomerID =  Customer_DIM. CustomerID
FROM Staging_table
INNER JOIN  Customer_DIM ON  Customer_DIM.CustomerName = Staging_table.CustomerName

-- Update SegmentID
UPDATE Staging_table
SET Staging_table.SegmentID = Segment_DIM.SegmentID
FROM Staging_table
INNER JOIN Segment_DIM ON Segment_DIM.Segment = Staging_table.Segment

-- Update CountryID
UPDATE Staging_table
SET Staging_table.CountryID = Country_DIM.CountryID
FROM Staging_table
INNER JOIN Country_DIM ON Country_DIM.Country = Staging_table.Country

-- Update CityID
UPDATE Staging_table
SET Staging_table.CityID = City_DIM.CityID
FROM Staging_table
INNER JOIN City_DIM ON City_DIM.City = Staging_table.City

-- Update StateID
UPDATE Staging_table
SET Staging_table.StateID = State_DIM.StateID
FROM Staging_table
INNER JOIN State_DIM ON State_DIM.[State] = Staging_table.[State]

-- Update RegionID
UPDATE Staging_table
SET Staging_table.RegionID = Region_DIM.RegionID
FROM Staging_table
INNER JOIN Region_DIM ON Region_DIM.Region = Staging_table.Region

-- Update ProductID
UPDATE Staging_table
SET Staging_table.ProductID = Product_DIM.ProductID
FROM Staging_table
INNER JOIN Product_DIM ON Product_DIM.ProductName = Staging_table.ProductName

-- Update CategoryID
UPDATE Staging_table
SET Staging_table.CategoryID =Category_DIM.CategoryID
FROM Staging_table
INNER JOIN Category_DIM ON Category_DIM.Category = Staging_table.Category

-- Update SubCategoryID
UPDATE Staging_table
SET Staging_table.SubCategoryID =SubCategory_DIM.SubCategoryID
FROM Staging_table
INNER JOIN SubCategory_DIM ON SubCategory_DIM.SubCategory = Staging_table.SubCategory

