-----------Creating Tables-----------
create table Territory(
        TerritoryID int identity(1,1) primary key,
        Country varchar(20),
        City varchar(30)
);

create table Customer(
        CustomerID int identity(1,1) primary key,
        FirstName varchar(20),
        LastName varchar(20),
        Gender bit,-- 0 for male ; 1 for female ;
        Phone varchar(13),--+98 9** *** **** or +98(***)‌ ** ** ***
        TerritoryID int,
        Address varchar(100),
        PostalCode varchar(10),     
        foreign key(TerritoryID) references Territory(TerritoryID)
);

create table Category(
        ParentID int,
        CategoryID int identity(1,1) primary key,
        CategoryName varchar(50),
        foreign key(ParentID) references Category(CategoryID)
);

create table Product(
        ProductID int identity(1,1) primary key,
        ProductName varchar(20),
        CategoryID int,
        BrandName varchar(10),
        ProductColor varchar(10),
        ProductSize varchar(10),
        ProductWeight decimal(7,3),-- maxWeight is 1000Kg
        Price decimal(6,2),-- maxPrice is 999999.99
        UsersOpinionID int,
        Explanation text,
        Likes int,
        Dislikes int,
        foreign key(CategoryID) references Category(CategoryID)
);

create table SalesOrderHeader(
        SalesOrderID int identity(1,1) primary key,
        status bit,-- 0 for notCompleted and 1 for Done
        OrderDate timestamp,
        CustomerID int,
        SubTotal decimal(6,2),
        DueTotal decimal(6,2),-- total cost with offs , taxes and so on
        foreign key(CustomerID) references Customer(CustomerID)
);

create table SalesOrderDetail(
        SalesOrderID int,
        SalesOrderDetailID int identity(1,1) primary key,
        ProductID int,
        OrderQty int,
        UnitPrice decimal(6,2),
        LineTotal decimal(6,2),
        foreign key(SalesOrderID) references SalesOrderHeader(SalesOrderID),
        foreign key(ProductID) references Product(ProductID)
);

create table Comments(
        CommentID int identity(1,1) primary key,
        ProductID int,
        CustomerID int,
        CommentText text,
        Recomended bit,-- 0 for not-recommended and 1 for recommended
        Advantages text,
        Disadvantages text,
        CommentTime timestamp,    
        foreign key(ProductID) references Product(ProductID),
        foreign key(CustomerID) references Customer(CustomerID)
);
------------------------------------
-----------Inserting Data-----------
/*ALTER SEQUENCE Category_CategoryID_seq RESTART WITH 1*/
insert into Category (ParentID,CategoryName) values (NULL,'Digital'),(NULL,'Cosmetics'),(NULL,'Cars and Tools'),
                     (NULL,'Fashion'),(NULL,'Home and Kitchen'),(NULL,'Stationery and Art'),(NULL,'Toys and Kids'),
                     (NULL,'Sport and Trip'),(NULL,'Food and Drinks');

insert into Category (ParentID,CategoryName) values (1,'Mobile'),(1,'Laptop'),(1,'Tablet'),
                     (1,'Camera'),(1,'Personal Computer'),(1,'Smart Watches'),(1,'Ministrative Machines'),
                     (1,'Fixtures'),(1,'Game Consoles');
                     
insert into Category (ParentID,CategoryName) values (2,'Cosmetics'),(2,'Medical Instruments'),(2,'Electrical Appliances'),
                     (2,'Perfume'),(2,'Health Tools');
                     
insert into Category (ParentID,CategoryName) values (3,'Car'),(3,'Car Accessories'),(3,'Motorcycle'),
                     (3,'Gargening'),(3,'Electrical Appliances'),(3,'Office Decoration');
                     
insert into Category (ParentID,CategoryName) values (4,'Womens Outfit'),(4,'Mens Outfit'),(4,'Kids Outfit'),
                     (4,'Womens Excess'),(4,'Mens Excess'),(4,'Womens Shoes'),(4,'Mens Shoes'),(4,'Kids Shoes');
                     
insert into Category (ParentID,CategoryName) values (5,'Decoration'),(5,'Washing and Grooming'),(5,'Audio-Visual'),
                     (5,'House Party'),(5,'Electrical Home Appliances'),(5,'Carpet');
                     
insert into Category (ParentID,CategoryName) values (6,'Books'),(6,'Stationary'),(6,'Handcrafts'),(6,'Musical Instruments'),
                     (6,'Music'),(6,'Movie'),(6,'Application and Games');
                     
insert into Category (ParentID,CategoryName) values (7,'Protection and Safety'),(7,'Personal tools'),(7,'Entertainment');

insert into Category (ParentID,CategoryName) values (8,'Sport Suit'),(8,'Sport Tools'),(8,'Trip Equipments');

insert into Category (ParentID,CategoryName) values (9,'Groceries'),(9,'Dairy'),(9,'Proteinaceous'),(9,'Breakfast'),
                     (9,'Drinks'),(9,'Tinnedfood'),(9,'Proteinaceous'),(9,'Cookies'),(9,'Snacks'),(9,'Fruit and Vegetable');
                     
                     
insert into Territory (Country,City) values ('Iran','Isfahan'),('Iran','Tehran'),('Iran','Shiraz'),('Iran','Hamedan'),
                      ('USA','NewYork'),('USA','LosAngeles');