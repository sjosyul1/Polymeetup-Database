use master
go

--*****************************************************************************************************************
--DDL
--*****************************************************************************************************************

--Dropping Database if exists
IF EXISTS(select * from sys.databases where name='Final_Project')
DROP DATABASE Final_Project

--Creating Database
CREATE DATABASE Final_Project
go
  use Final_Project;

--Dropping Users table if exists and Creating Users table
  IF OBJECT_ID('Users') is not null
     drop table Users;
  create  Table Users
  (UserID         INT NOT NULL PRIMARY KEY IDENTITY(1,1),
   UserFName       Varchar(30)  NOT NULL,
   UserLName       Varchar(30)  NOT NULL,
   StreetAddress   Varchar(50)  NULL,
   City            Varchar(50)  NULL,
   State           Varchar(50)  NULL,
   Country         Varchar(50)  NULL,
   ZipCode         Varchar(50)  NULL,
   PhoneNumber     BigInt  Null,
   EmailID         Varchar(90) NOT NUll UNIQUE,
   UserName        Varchar(30) NOT NULL unique,
   Password        Varchar(30) not null);

--Dropping Groups table if exists and Creating Groups table
    IF OBJECT_ID('Groups') is not null
     drop table Groups;
	create table Groups
	 (GroupID    Int NOT NULL PRIMARY KEY,
	  GroupName   Varchar(30) Not Null,
	  GroupDescription  varchar(70)  Null);

--Dropping Membership table if exists and Creating Membership table
    IF OBJECT_ID('Membership') is not null
     drop table Membership;
    create  Table Membership
    ( UserID     INT  NOT NULL
                References Users(UserID),
     GroupID    Int  NOT NULL
	            References Groups(GroupID));

--Dropping Location table if exists and Creating Location table
	 IF OBJECT_ID('Location') is not null
     drop table Location;
   create  Table Location
   (LocationID     INT  NOT NULL Primary Key,
	LocationCampus varchar(40) not null
	CONSTRAINT CHK_Campus CHECK (LocationCampus in ('Poly','Tempe','West','Downtown')),
    LocationName   Varchar(40)  NOT NULL,
    Capacity       Int  NOT NULL,
	LocationDescription  Varchar(80) Null
	);
	 
--Dropping Categories table if exists and Creating Categories table
	 IF OBJECT_ID('Categories') is not null
     drop table Categories;
	 create table Categories
	 (CategoryID    Int NOT NULL PRIMARY KEY,
	  CategoryName   Varchar(30) Not Null,
	  CategoryDescription  varchar(70)  Null);

--Dropping MeetUP table if exists and Creating MeetUP table
	 IF OBJECT_ID('MeetUP') is not null
     drop table MeetUP;
	   create  Table MeetUp
	   (
	   MeetUpID   Int  NOT NULL Primary Key IDENTITY(8000,1),
	   MeetUpName varchar(30)   NOT NUll,            
	   MeetUpDescription  Varchar(max) Not NULL,
	   LocationID      Int NOT NULL 
					   References Location(LocationID),
		UserID      Int NOT NULL 
					   References Users(UserID),
	   CategoryID  Int NOT NULL
					   References Categories(CategoryID),
	   MeetUpDate  DateTime,
	   Timings  varchar(30) );


--Dropping Rating table if exists and Creating Rating table
    IF OBJECT_ID('Rating') is not null
     drop table Rating;
   create  Table Rating
   (UserID     INT  NOT NULL
                References Users(UserID),
   MeetUpID   Int  NOT NULL
                References MeetUp( MeetUpID),
    Rating    Int Not NULL
	CONSTRAINT CHK_Rating CHECK (Rating in (1,2,3,4,5)));

--Dropping MeetUpNotes table if exists and Creating MeetUpNotes table
   IF OBJECT_ID('MeetUpNotes') is not null
     drop table MeetUpNotes;
   create  Table MeetUpNotes
   (MeetUpID   Int  NOT NULL
                References MeetUp( MeetUpID),
   Notes  Varchar(Max),
   OverAllRating  float not null );

--Dropping FeedBack table if exists and Creating FeedBack table
    IF OBJECT_ID('FeedBack') is not null
     drop table FeedBack;
	 create table FeedBack
	 (MeetUpID    Int NOT NULL 
	              References MeetUP(MeetUpID),
	  ContentData   Varchar(max) Not Null,
	  UserID  Int  Not Null
	           References Users(UserID));

--Dropping TechBlog table if exists and Creating TechBlog table
    IF OBJECT_ID('TechBlog') is not null
     drop table TechBlog;
	 create table TechBlog
	 (UserID    Int NOT NULL 
	            References Users(UserID),
	  BlogContent   Varchar(max) Not Null,
	  BlogAdded     DateTime,
	  CategoryID  int  NOT Null
	              References Categories(CategoryID));

-- Find an existing index named IX_TechBlog_UserID and delete it if found.   
IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'IX_TechBlog_UserID')   
    DROP INDEX IX_TechBlog_UserID ON TechBlog;   
GO  

-- Create a nonclustered index called IX_TechBlog_UserID  
-- on the TechBlog table using the UserID column.   
CREATE NONCLUSTERED INDEX IX_TechBlog_UserID   
    ON TechBlog (UserID);   
GO  
	          
-- Inserting data into Users table
INSERT INTO Users (UserFName,UserLName,StreetAddress,City,State,Country,ZipCode,PhoneNumber,EmailID,UserName,Password)
VALUES ('Mona','Nichole','6639 Euismod Rd.','Covington','Kentucky','United States','27403',2258746121,'euismod.urna@ligula.co.uk','mona.nichole','temp'),
('MacKenzie','Jason','6619 Commodo Rd.','Kearney','Nebraska','United States','42565',8511890944,'in.cursus.et@velesttempor.com','jason.mackinze','temp'),
('Chadwick','Isabelle','3960 Tempor St.','Tampa','Florida','United States','58146',8284020800,'et.magnis@utmolestie.net','isabell.chadwick','temp'),
('Lacota','Kermit','3025472 Arcu. St.','Casper','Wyoming','United States','84336',9828007434,'Integer.urna@eleifendCrassed.net','kermit.lacota','temp'),
('Buckminster','Evelyn','9556077 Nulla Ave','Kansas City','Missouri','United States','24520',5399455889,'laoreet@magnaa.com','elvyn.buckminster','temp'),
('Vivien','Alden','Ap #6618360 Aliquet St.','Las Vegas','Nevada','United States','29469',9289251032,'feugiat.nec@Phasellusdapibus.net','alden.vivien','temp'),
('Ulysses','Zane','P.O. Box 863, 8046 Tincidunt Rd.','Boston','Massachusetts','United States','36428',3431542654,'vel.arcu@sedsapienNunc.edu','zane.ulysses','temp'),
('Andrew','Virginia','1811323 Nec, Rd.','Oklahoma City','Oklahoma','United States','45443',9318337059,'lorem@egestas.net','virginia.andrew','temp'),
('September','Galvin','8962471 Velit. Road','Dover','Delaware','United States','88884',6854852930,'orci.quis.lectus@viverraMaecenas.net','september.galvin','temp'),
('Carol','Tashya','P.O. Box 767, 9563 Ultricies St.','Springfield','Illinois','United States','30357',8601170254,'aliquet@tempusnonlacinia.edu','tashya.carol','temp'),
('Yuri','Ulla','6017 Dui. St.','Rutland','Vermont','United States','98692',6779618300,'natoque@vitaemaurissit.net','ulla.yuri','temp'),
('Vance','Brock','Ap #3189983 Urna Rd.','Annapolis','Maryland','United States','34940',1632692885,'malesuada.id.erat@purus.ca','brock.vance','temp'),
('Iona','Harrison','P.O. Box 455, 9214 Aliquam Avenue','Madison','Wisconsin','United States','39031',7571601756,'congue.elit.sed@interdumSed.ca','harrison.iona','temp'),
('Stacy','Erin','P.O. Box 876, 862 Leo. St.','Jackson','Mississippi','United States','68779',6434833852,'fringilla.ornare@lectus.org','erin.stacey','temp'),
('Hayes','Tobias','P.O. Box 276, 3743 Imperdiet Street','Eugene','Oregon','United States','86413',5079062782,'lacinia.vitae@lectus.org','tobias.hayes','temp'),
('Darrel','Hedley','P.O. Box 136, 2839 Vitae Road','Sterling Heights','Michigan','United States','89470',7785322910,'gravida.Aliquam.tincidunt@a.org','hedley.darrel','temp'),
('Denise','Karleigh','7916 Proin Rd.','Springfield','Massachusetts','United States','50004',8558466950,'hendrerit@nunc.net','karleigh.denise','temp'),
('Candace','Cynthia','Ap #7941597 Mauris St.','Miami','Florida','United States','31889',9348861315,'ipsum.Suspendisse@dictumProineget.co.uk','cynthia.candace','temp'),
('Judah','Kiona','P.O. Box 966, 8103 Morbi Street','South Burlington','Vermont','United States','45845',5024345081,'ante@Cras.edu','kiona.judah','temp'),
('Barrett','Naida','Ap #8209628 Pharetra. Av.','Kenosha','Wisconsin','United States','13364',3888879088,'nunc.Quisque.ornare@amet.co.uk','nadia.barret','temp'),
('Dennis','Hanae','6635 Molestie. Rd.','South Bend','Indiana','United States','46913',9868943634,'Morbi.non.sapien@Suspendisseacmetus.edu','hanae.dennis','temp'),
('Haley','Galvin','1918 Egestas. Road','Kapolei','Hawaii','United States','32770',6443400239,'risus.quis.diam@rutrum.ca','galvin.haley','temp'),
('TestF','TestL','1918 Egestas. Road','Kapolei','Hawaii','United States','32770',6443400239,'test@asu.com','test','test');
;

--Select * from Users;

-- Inserting data into Groups table
INSERT INTO Groups (GroupID,GroupName,GroupDescription) VALUES (1011,'Briar','nisl. Nulla eu neque pellentesque'),
(1000,'Ina','mollis nec, cursus a, enim.'),(1012,'Marvin','elementum, dui quis accumsan convallis,'),
(1001,'Oprah','ultrices a, auctor non, feugiat'),(1013,'Gwendolyn','ac mi eleifend egestas. Sed'),
(1002,'Thane','eu, ultrices sit amet, risus.'),(1014,'Brendan','orci, consectetuer euismod est arcu'),
(1003,'Dai','lectus pede, ultrices a, auctor'),(1015,'Kibo','sem ut dolor dapibus gravida.'),
(1004,'Castor','eu lacus. Quisque imperdiet, erat'),
(1005,'Maryam','at, velit. Pellentesque ultricies dignissim'),
(1006,'Ezra','porttitor eros nec tellus. Nunc'),(1016,'Anastasia','est, vitae sodales nisi magna'),
(1007,'Liberty','ut, sem. Nulla interdum. Curabitur'),(1017,'Kamal','lacus, varius et, euismod et,'),
(1008,'Priscilla','lobortis risus. In mi pede,'),(1018,'Uma','aliquet, sem ut cursus luctus,'),
(1009,'Desirae','a sollicitudin orci sem eget'),(1019,'Oren','est mauris, rhoncus id, mollis'),
(1010,'Vaughan','et netus et malesuada fames');

--select * from Groups

-- Inserting data into Location table
INSERT INTO Location (LocationID,LocationCampus,LocationName,Capacity,LocationDescription) VALUES 
(2001,'Tempe','Memorial Union',32,'Room No 201'),(2002,'Tempe','Payne Hall',64,'Room No 213'),
(2003,'Tempe','Murdock Hall',55,'Room No 506'),(2004,'Tempe','Wexler Hall',75,'Room No 101'),
(2005,'Tempe','ISDB2',61,'Room No 281'),(2006,'West','Sands Hall',63,'Room No 18'),
(2007,'West','University Center',72,'Room No 111'),(2008,'West','Fetcher Library',66,'Room No 343'),
(2009,'Downtown','University Center',51,'Room No 301'),(2010,'Downtown','Health North',65,'Room No 22'),
(2011,'Downtown','Health South',59,'Room No 405'),(2012,'Poly','Student Union',60,'Room No 512'),
(2013,'Poly','Peraltha Hall',34,'Room No 312'),(2014,'Poly','AGBC',31,'Room No 12'),
(2015,'Poly','Sutton Hall',64,'Room No 201');

--select * from Location

-- Inserting data into Membership table
insert into Membership (UserID,GroupID) values
(1,1015),(2,1014),(3,1001),(4,1001),(5,1003),(6,1001),
(7,1015),(8,1014),(9,1012),(10,1006),(11,1003),(12,1001),
(13,1009),(14,1014),(15,1013),(16,1002),(17,1001),(18,1001)

--select * from Membership

-- Inserting data into Categories table
insert into Categories(CategoryID,CategoryName,CategoryDescription) values
(5001,'SQL','nisl. Nulla eu neque pellentesque'),(5020,'Database Security','nisl. Nulla eu neque pellentesque'),
(5002,'Big Data','nisl. Nulla eu neque pellentesque'),(5004,'Network Security','nisl. Nulla eu neque pellentesque'),
(5003,'Routing Protocols','nisl. Nulla eu neque pellentesque'),(5005,'Communication Networks','nisl. Nulla eu neque pellentesque'),
(5006,'Unix','nisl. Nulla eu neque pellentesque'),(5007,'Linux','nisl. Nulla eu neque pellentesque'),
(5008,'System Administration','nisl. Nulla eu neque pellentesque'),(5009,'Systems Programming','nisl. Nulla eu neque pellentesque'),
(5010,'Python Programming','nisl. Nulla eu neque pellentesque'),(5011,'PHP','nisl. Nulla eu neque pellentesque'),
(5012,'Scala Programming','nisl. Nulla eu neque pellentesque'),(5013,'Java Programming','nisl. Nulla eu neque pellentesque'),
(5014,'Machine Learning','nisl. Nulla eu neque pellentesque'),(5015,'C Programming','nisl. Nulla eu neque pellentesque'),
(5016,'Datastructures','nisl. Nulla eu neque pellentesque'),(5017,'Computer Systems','nisl. Nulla eu neque pellentesque'),
(5018,'Algorithms','nisl. Nulla eu neque pellentesque'),(5019,'JavaScripts','nisl. Nulla eu neque pellentesque')

-- Inserting data into TechBlog table
insert into TechBlog(userid, blogcontent, blogadded, categoryid) values(1,'Always Encrypted is a new feature included in SQL Server 2016 for encrypting column data at rest and in motion. This represents an important difference from the original column-level encryption, which is concerned only with data at rest. Always Encrypted also differs from Transparent Data Encryption (TDE), which is also limited to data at rest. In addition, TDE can be applied only to the database as a whole, not to individual columns.',getdate(),5001)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(2,'With Always Encrypted, the client application handles the actual data encryption and decryption outside of the SQL Server environment. In this way, you can better control who can access the data in an unencrypted state, allowing you to enforce separation of roles and minimize the risks to sensitive data.',getdate()-1,5002)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(3,'To be able to encrypt and decrypt the data, the application must use an Always Encrypted-enabled driver that interfaces with SQL Server 2016. It is this driver that carries out the actual encryption and decryption processes, rewriting the T-SQL queries as necessary, while keeping these operations transparent to the application.',getdate()-20,5003)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(4,'To implement Always Encrypted on a column, you need to generate a column encryption key and a column master key. The column encryption key encrypts the column data, and the master key encrypts the column encryption key.',getdate()-5,5004)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(5,'The database engine stores the column encryption key on the SQL Server instance where Always Encrypted is implemented. For the master key, the database engine stores only metadata that points to the key’s location. The actual master key is saved to a trusted external key store, such as the Windows certificate store. At no time does the database engine use or store either key in plain text.',getdate()-9,5005)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(6,'You’ll get a better sense of how all this works as we go through the article’s examples, which walk you through the process of implementing Always Encrypted in the test database. The article focuses primarily on the SQL Server side of the equation, demonstrating how to create the two encryption keys and encrypt the columns.',getdate()-22,5006)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(7,'Always Encrypted is a new feature included in SQL Server 2016 for encrypting column data at rest and in motion. This represents an important difference from the original column-level encryption, which is concerned only with data at rest. Always Encrypted also differs from Transparent Data Encryption (TDE), which is also limited to data at rest. In addition, TDE can be applied only to the database as a whole, not to individual columns.',getdate(),5007)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(8,'With Always Encrypted, the client application handles the actual data encryption and decryption outside of the SQL Server environment. In this way, you can better control who can access the data in an unencrypted state, allowing you to enforce separation of roles and minimize the risks to sensitive data.',getdate()-3,5008)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(9,'To be able to encrypt and decrypt the data, the application must use an Always Encrypted-enabled driver that interfaces with SQL Server 2016. It is this driver that carries out the actual encryption and decryption processes, rewriting the T-SQL queries as necessary, while keeping these operations transparent to the application.',getdate()-5,5009)
insert into techblog(userid, blogcontent, blogadded, categoryid) values(10,'To implement Always Encrypted on a column, you need to generate a column encryption key and a column master key. The column encryption key encrypts the column data, and the master key encrypts the column encryption key.',getdate(),5010)


--select * from TechBlog

-- Inserting data into MeetUp table
Insert into MeetUp (MeetUpName, MeetUpDescription, LocationID, UserID, CategoryID, MeetUpDate, Timings) values
('SQL Joins','Discussion on inner join and outer join', 2001, 3, 5001, getdate()-5,'10 AM to 12 PM' ),
('SQL CTEs','Discussion on where to use CTEs', 2005, 3, 5001, getdate()+14,'2 PM to 4 PM' ),
('SQL Triggers','Discussion on coding efficient Triggers ', 2004, 5, 5001, getdate()+29,'3 PM to 4 PM' ),
('SQL Stored Procedures','Discussion on complex stored procedures', 2015, 7, 5001, getdate()+30,'10 AM to 12 PM' ),
('SQL Injection','Discussion on how to prevent SQL Injections', 2011, 18, 5001, getdate()+28,'9 AM to 12 PM' ),
('SQL Joins','Discussion on inner join and outer join', 2001, 13, 5001, getdate()+33,'10 AM to 11 AM' ),
('Dynamic SQL','Discussion on uses of dynamic SQL', 2009,4, 5001, getdate()+12,'9 AM to 1 PM' ),
('Spark APIs','Using Spark APIs for Big Data Analysis', 2013, 12, 5002, getdate()+21,'11 AM to 12 PM' ),
('Spark GraphX','Discussion on GraphX', 2014, 11, 5002, getdate()-10,'9 AM to 10 AM' )

--select * from MeetUp

-- Inserting data into Rating table
INSERT INTO Rating values
(1,8000,3),(3,8000,4),
(14,8000,2),(5,8000,2),
(7,8000,1),(6,8000,2),
(8,8000,5),(9,8000,4),
(1,8008,3),(3,8008,4),
(2,8008,3),(4,8008,4),
(5,8008,1),(6,8008,4),
(7,8008,1),(8,8008,2),
(11,8008,4),(9,8008,5)

--select * from Rating

-- Inserting data into FeedBack table
Insert into FeedBack values (8008,'Good',1), (8008,'Very Good',2),(8008,'Okay',5),(8008,'It was very informative',9),(8008,'Hard to follow',10),
(8000,'Made it very simple',1),(8000,'Fine',2),(8000,'Notes were very helpful',3),(8000,'Can do better',4),(8000,'Excellent',12),(8000,'Good',15)

--Select * from Feedback


--*****************************************************************************************************************
 -- DML 
--*****************************************************************************************************************

---------------------------------------------STORED PROCEDURES-----------------------------------------------------------------
--*********************************************************************
--Dropping the StoredProcedure sp_InsertUsers if exists and create again
--*********************************************************************
if OBJECT_ID('sp_InsertUsers') is Not null
	drop proc sp_InsertUsers;
go

create procedure sp_InsertUsers 
@UserFName varchar(20),@UserLName varchar(30),
@StreetAddress varchar(50),@City varchar(50),
@State varchar(50),@Country varchar(50),
@ZipCode varchar(50)
,@PhoneNumber bigint ,@EmailID varchar(90),
@UserName varchar(30),@Password varchar(30)
as
if(len(@ZipCode)!=5)
   throw 50002, 'Zipcode has to be 5 digits',1;
if(len(@PhoneNumber)!=10)
   throw 50003, 'phone number has to be 10 digits',1;

if not exists(select * from Users where UserName=@UserName)
    insert Users values(@UserFName ,@UserLName ,
                        @StreetAddress,@City ,@State ,
						@Country ,@ZipCode ,@PhoneNumber,@EmailID,@UserName,@Password);

else
  Throw 50001, 'User already exists',1; 

 --select * from users;

/*
 --working case
 exec sp_InsertUsers @UserFName = 'Pramod', @UserLName = 'Mekapothula', @StreetAddress = 'Rural Road', @City = 'Tempe',
                    @State='Arizona', @Country= 'United States', @ZipCode = '85281', @PhoneNumber = 9876543210,
					@EmailID = 'test1@asu.com', @UserName = 'test1', @Password = 'test'

--error scenario Zipcode
 exec sp_InsertUsers @UserFName = 'Pramod', @UserLName = 'Mekapothula', @StreetAddress = 'Rural Road', @City = 'Tempe',
                    @State='Arizona', @Country= 'United States', @ZipCode = '852811', @PhoneNumber = 9876543210,
					@EmailID = 'test@asu.com', @UserName = 'test', @Password = 'test'

--error scenario PhoneNumber
 exec sp_InsertUsers @UserFName = 'Pramod', @UserLName = 'Mekapothula', @StreetAddress = 'Rural Road', @City = 'Tempe',
                    @State='Arizona', @Country= 'United States', @ZipCode = '85281', @PhoneNumber = 987654321098,
					@EmailID = 'test@asu.com', @UserName = 'test', @Password = 'test'

 --error scenario Duplicate user
 exec sp_InsertUsers @UserFName = 'Pramod', @UserLName = 'Mekapothula', @StreetAddress = 'Rural Road', @City = 'Tempe',
                    @State='Arizona', @Country= 'United States', @ZipCode = '85281', @PhoneNumber = 9876543210,
					@EmailID = 'test1@asu.com', @UserName = 'test1', @Password = 'test'

*/

--*********************************************************************
--Dropping the StoredProcedure sp_InsertMeetUp if exists and create again
--*********************************************************************
if OBJECT_ID('sp_InsertMeetUp')is not null
  drop proc sp_InsertMeetUp  ;
  go
create procedure sp_InsertMeetUp 
      @MeetUPName varchar(30),@MeetUPDesc varchar(max),
   @LocationCampus varchar(30), @LocationName varchar(30), @userName varchar(30),@CategoryName varchar(30),
   @meetupdate datetime,@timings varchar(30)
as
declare @LocationID INT
declare @userID INT
declare @CategoryID INT

SET @LocationID=(select LocationID from Location where (Location.LocationCampus = @LocationCampus and Location.LocationName = @LocationName))
SET @userID=(select userID from Users where Users.UserName = @userName)
SET @CategoryID = (select CategoryID from Categories where Categories.CategoryName = @CategoryName)

if not exists (select * from MeetUp where ( MeetUp.MeetUpDate = @meetupdate and (MeetUP.LocationID = @LocationID) and (MeetUp.timings = @timings))
             or (MeetUp.UserID = @userID and MeetUp.MeetUpName = @MeetUPName))					
  insert MeetUP (MeetUPName,MeetUpDescription,LocationID,UserID,CategoryID,MeetUpDate,Timings) 
              values ( @MeetUPName,@MeetUPDesc,@LocationID,@userID,@CategoryID, @meetupdate,@timings );
else
   throw 50005,'Same MeetUP previously created by User! or Location and Time Conflict ',1

--select * from MeetUp
--select * from Users
--select * from Location
--select * from categories

/*
--working scenario Insert new meetup record
exec sp_InsertMeetUp @MeetUPName='SQL Joins' , @MeetUPDesc = 'Discussion on inner join and outer join' ,
                     @LocationCampus = 'Tempe', @LocationName ='Memorial Union', @userName ='test',
					 @CategoryName='SQL', @meetupdate = '2019-04-07 16:38:00.000', @timings ='10AM to 12 PM'

--Date and Location Conflict
exec sp_InsertMeetUp @MeetUPName='SQL Joins' , @MeetUPDesc = 'Discussion on inner join and outer join' ,
                     @LocationCampus = 'Tempe', @LocationName ='Memorial Union', @userName ='test',
					 @CategoryName='SQL', @meetupdate = '2017-04-07 16:38:00.000', @timings ='10AM to 12 PM'

--Same User and Meetup Conflict
exec sp_InsertMeetUp @MeetUPName='SQL Joins' , @MeetUPDesc = 'Discussion on inner join and outer join' ,
                     @LocationCampus = 'Poly', @LocationName ='Student Union', @userName ='test',
					 @CategoryName='SQL', @meetupdate = '2018-04-07 16:38:00.000', @timings ='10AM to 12 PM'
*/

--*********************************************************************
--Dropping the StoredProcedure SP_ShowAllMeetUps_Date if exists and create again
--*********************************************************************
IF Object_ID('SP_ShowAllMeetUps_Date') IS NOT NULL
DROP Proc SP_ShowAllMeetUps_Date
go
-- STORED PROCEDURE
 CREATE PROC SP_ShowAllMeetUps_Date @Date DateTime
 AS
 BEGIN
 BEGIN TRY
 BEGIN TRANSACTION;

 SELECT m.MeetUpName,m.MeetUpDescription,m.MeetUpDate,m.Timings,l.LocationName,l.LocationCampus,
c.CategoryName,u.UserName
FROM MeetUp m
INNER JOIN Location l
ON l.LocationID=m.LocationID
INNER JOIN  Categories c
ON m.CategoryID=c.CategoryID
INNER JOIN Users u
ON u.UserID=m.UserID
WHERE DateAdd(day, datediff(day,0, m.MeetUpDate), 0)= @Date
COMMIT TRANSACTION;

END TRY

BEGIN CATCH

    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    DECLARE @ErrorLine INT = ERROR_LINE();
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();
 
    PRINT 'Actual error number: ' + CAST(@ErrorNumber AS VARCHAR(10));
    PRINT 'Actual line number: ' + CAST(@ErrorLine AS VARCHAR(10));
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
END

/*
-- CHECKING 
SELECT * FROM MeetUp
EXEC SP_ShowAllMeetUps_Date @Date='2017-04-07';
EXEC SP_ShowAllMeetUps_Date @Date='66-227-11';
exec SP_ShowAllMeetUps_Date @date='RFR'

*/
--*********************************************************************
--Dropping the StoredProcedure sp_InsertTechBlog if exists and create again
--*********************************************************************
if OBJECT_ID('sp_InsertTechBlog') is Not null
	drop proc sp_InsertTechBlog;
go

create procedure sp_InsertTechBlog 
@UserName varchar(20),@blogcontent varchar(max),
@blogadded datetime,@CategoryName varchar(30)
as

declare @userID INT
declare @CategoryID INT

SET @userID=(select userID from Users where Users.UserName = @userName)
SET @CategoryID = (select CategoryID from Categories where Categories.CategoryName = @CategoryName)

if not exists(select * from TechBlog where UserID=@userID)
    insert TechBlog values(@userID, @blogcontent, @blogadded, @CategoryID);

else
  Throw 50001, 'User Blog already exists!',1; 


--select * from TechBlog
--select * from Categories

/*
--Working scenario New Insertion
DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec sp_InsertTechBlog @UserName = 'test' , @blogcontent= 'New Blog for test user' , @blogadded= @tmp, @CategoryName='SQL'

--Error Scenario Duplicate Insertions
DECLARE @tmp1 DATETIME
SET @tmp1 = GETDATE()
exec sp_InsertTechBlog @UserName = 'test' , @blogcontent= 'New Blog for test user' , @blogadded= @tmp1, @CategoryName='SQL'

*/

--*********************************************************************
--Dropping the StoredProcedure sp_InsertMeetUpNotes if exists and create again
--*********************************************************************
if OBJECT_ID('sp_InsertMeetUpNotes') is Not null
	drop proc sp_InsertMeetUpNotes;
go

create procedure sp_InsertMeetUpNotes 
@MeetUpName varchar(20),@Notes varchar(max), @userName varchar(20),
@OverAllRating float = 0.00
as

declare @meetupid INT
declare @userID INT


SET @userID=(select userID from Users where Users.UserName = @userName)
SET @meetupid = (select meetupid from MeetUp where (MeetUpName = @MeetUpName and UserID = @userID))

if not exists(select * from MeetUpNotes where MeetUpID=@meetupid)
    insert MeetUpNotes values(@meetupid, @Notes, @OverAllRating);

else
  Throw 50001, 'MeetupNotes already exists!',1; 

--select * from MeetUp
--select * from MeetUpNotes
--select * from users;

/*
--working scenario
exec sp_InsertMeetUpNotes @MeetUpName= 'SQL Joins', @userName='test', @Notes='Sql optimization improvement area'

--Error Scenario Duplicate Insertion
exec sp_InsertMeetUpNotes @MeetUpName= 'SQL Joins', @userName='test', @Notes='Sql optimization improvement area'
*/

--*********************************************************************
--Dropping the StoredProcedure SP_ShowAllMeetUps_Locations if exists and create again
--*********************************************************************

IF Object_ID('SP_ShowAllMeetUps_Locations') IS NOT NULL
DROP Proc SP_ShowAllMeetUps_Locations
go

 CREATE PROC SP_ShowAllMeetUps_Locations @loc VARCHAR(50)
 AS
 BEGIN
 BEGIN TRY

 DECLARE @recordsCount int
Set @recordsCount =(SELECT count(m.MeetUpName)
FROM MeetUp m
INNER JOIN Location l
ON l.LocationID=m.LocationID
WHERE l.LocationCampus=@loc)

if @recordsCount>0
SELECT m.MeetUpName,m.MeetUpDescription,m.MeetUpDate,m.Timings,l.LocationName,l.LocationCampus,
c.CategoryName,u.UserName
FROM MeetUp m
INNER JOIN Location l
ON l.LocationID=m.LocationID
INNER JOIN  Categories c
ON m.CategoryID=c.CategoryID
INNER JOIN Users u
ON u.UserID=m.UserID
WHERE l.LocationCampus=@loc
else
PRINT 'No MeetUPs Found at this location';   

END TRY

BEGIN CATCH


    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    DECLARE @ErrorLine INT = ERROR_LINE();
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();
 
    PRINT 'Actual error number: ' + CAST(@ErrorNumber AS VARCHAR(10));
    PRINT 'Actual line number: ' + CAST(@ErrorLine AS VARCHAR(10));
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
END

/*
-- CHECKING
EXEC  SP_ShowAllMeetUps_Locations @loc= 'Downtown'

EXEC  SP_ShowAllMeetUps_Locations @loc= 'sbkjdsbjk'
*/

--*********************************************************************
--Dropping the StoredProcedure sp_UpdateMeetUpLocation if exists and create again
--*********************************************************************
if OBJECT_ID('sp_UpdateMeetUpLocation')is not null
  drop proc sp_UpdateMeetUpLocation  ;
  go
create procedure sp_UpdateMeetUpLocation 
   @MeetUPName varchar(30), @userName varchar(30),
   @NewLocationCampus varchar(30), @NewLocationName varchar(30)
as
declare @UserID int
declare @NewLocationID INT
declare @MeetUpID INT
declare @rowCount int

SET @UserID =(Select UserID from Users where UserName = @userName)
SET @NewLocationID=(select LocationID from Location where (Location.LocationCampus = @NewLocationCampus and Location.LocationName = @NewLocationName))
SET @MeetUpID=(select MeetUpID from MeetUp where MeetUp.UserID= @UserID and MeetUp.MeetUpName=@MeetUPName)
SET @rowCount =(select Count(MeetUpID) from MeetUp where MeetUp.UserID= @UserID and MeetUp.MeetUpName=@MeetUPName Group by MeetUpID)

if @rowCount=1					
  update MeetUP 
  set LocationID = @NewLocationID
  where MeetUpID=@MeetUpID;
else
   throw 50005,'No such MeetUp exists!',1

--select * from MeetUp
--select * from Users
--select * from Location

/*
--working case
 exec sp_UpdateMeetUpLocation @MeetUpName = 'SQL Triggers', @userName=laoreet,
 @NewLocationCampus='Tempe',@NewLocationName='Payne Hall'
 --error case
  exec sp_UpdateMeetUpLocation @MeetUpName = 'SQL', @userName=laoreet,
 @NewLocationCampus='Tempe',@NewLocationName='Payne Hall'

 */

--*********************************************************************
--Dropping the StoredProcedure sp_UpdateMeetUpDateTime if exists and create again
--*********************************************************************
 if OBJECT_ID('sp_UpdateMeetUpDateTime')is not null
  drop proc sp_UpdateMeetUpDateTime  ;
  go
create procedure sp_UpdateMeetUpDateTime 
   @MeetUPName varchar(30), @userName varchar(30),
   @NewDate Datetime, @NewTime varchar(30)
as
declare @UserID int
declare @MeetUpID INT
declare @rowCount int

SET @UserID =(Select UserID from Users where UserName = @userName)
SET @MeetUpID=(select MeetUpID from MeetUp where MeetUp.UserID= @UserID and MeetUp.MeetUpName=@MeetUPName)
SET @rowCount =(select Count(MeetUpID) from MeetUp where MeetUp.UserID= @UserID and MeetUp.MeetUpName=@MeetUPName Group by MeetUpID)
if @NewDate<getdate()
throw 50005,'New Date cannot be a past date.',1

if @rowCount=1				
  update MeetUP 
  set MeetUpDate = @NewDate,
		 Timings = @NewTime
  where MeetUpID=@MeetUpID;
else
   throw 50005,'No such MeetUp exists!',1

/*
 --working case
 exec sp_UpdateMeetUpDateTime @MeetUpName = 'SQL Triggers', @userName=laoreet,@NewTime='4 PM to 5 PM',
 @NewDate= '4/18/2017'
 --error case
   exec sp_UpdateMeetUpDateTime @MeetUpName = 'SQL Triggers', @userName=laoreet,@NewTime='4 PM to 5 PM',
 @NewDate= '4/11/2017'

 */

--*********************************************************************
--Dropping the StoredProcedure sp_UpdateTechBlogContent if exists and create again
--*********************************************************************
 if OBJECT_ID('sp_UpdateTechBlogContent')is not null
  drop proc sp_UpdateTechBlogContent  ;
  go

create procedure sp_UpdateTechBlogContent 
  @UserName varchar(20),@newblogcontent varchar(max)
as 

declare @UserID int
declare @rowCount int

SET @UserID =(Select UserID from Users where UserName = @userName)
SET @rowCount =(select Count(useriD) from TechBlog where TechBlog.UserID= @UserID)
if @rowCount=1				
  update TechBlog 
  set BlogContent = @newblogcontent
  where UserID=@UserID;
else
   throw 50005,'MeetUpNotes Not Exists!',1

--select * from TechBlog
--select * from Users

/*
--Working Scenario
exec sp_UpdateTechBlogContent @UserName = 'test', @newblogcontent = 'Updated using Stored Procedure'
*/

--------------------------------------------Dynamic SQL-----------------------------------------
--************************************ 
--Dynamic SQL for searching MeetUPs
--************************************

if OBJECT_ID('meetupSearch') is Not null
	drop proc meetupSearch;
go

CREATE PROC meetupSearch @MeetupName VARCHAR(32)  = NULL 
AS 
  BEGIN 
    DECLARE  @SQL NVARCHAR(MAX) 
    SELECT @SQL = ' SELECT MeetUPName=MeetUpName, MeetUpDescription, MeetUpDate ' + 
CHAR(10)+ 
                  ' FROM MeetUp' + CHAR(10)+ 
                  ' WHERE 1 = 1 ' + CHAR(10) 
    IF @MeetupName IS NOT NULL 
      SELECT @SQL = @SQL + ' AND MeetUpName LIKE @pMeetupName' 
    PRINT @SQL  
-- parametrized execution 
    EXEC sp_executesql @SQL, N'@pMeetupName varchar(32)', @MeetupName  
  END 
GO 
/*
-- Execute dynamic SQL stored procedure with parameter 
--Wild card search
EXEC meetupSearch '%SQL%'  
EXEC meetupSearch '%Spark%'

--single search
Exec meetupSearch 'SQL Joins'

--Error Scenario (empty)
Exec meetupSearch 'Joins'
*/
------------------------------------------------TRIGGERS-----------------------------------------------------------------
--*********************************************************************
--Dropping the Trigger MeetUp_Date_Check if exists and create again
--*********************************************************************
IF OBJECT_ID('MeetUp_Date_Check') is not null
DROP TRIGGER MeetUp_Date_Check
go
CREATE TRIGGER MeetUp_Date_Check
ON dbo.MeetUp
AFTER INSERT,UPDATE
AS
BEGIN
DECLARE @MeetUpDate Datetime
SET @MeetUpDate = (SELECT MeetUpDate from inserted)
IF  @MeetupDate<=getdate()
Begin
       RAISERROR ('Meetup date has to be a future date!', 16, 10) WITH LOG
    ROLLBACK TRAN
End
END

/*
Insert into MeetUp (MeetUpName, MeetUpDescription, LocationID, UserID, CategoryID, MeetUpDate, Timings) values
('SQL Joins','Discussion on inner join and outer join', 2001, 3, 5001, getdate()-5,'10 AM to 12 PM' )

select * from Rating
*/
--*********************************************************************
--Dropping the Trigger Rating_Check if exists and create again
--*********************************************************************
IF OBJECT_ID('Rating_Check') is not null
DROP TRIGGER Rating_Check
go
CREATE TRIGGER Rating_Check
ON Rating
AFTER INSERT,UPDATE
AS
BEGIN
DECLARE @MeetUpDate Datetime
DECLARE @MeetUpID int
DECLARE @UserID int
SET @UserID=(SELECT UserID from inserted)
SET @MeetUpID=(SELECT MeetUpID from inserted)
SET @MeetUpDate = (SELECT MeetUpDate from MeetUp where MeetUpID = @MeetUpID)
IF  @MeetupDate>getdate() 
Begin
       RAISERROR ('Meetup is not over yet!', 16, 10) WITH LOG
End
else IF (Select Count(UserID) from Rating where MeetUpID=@MeetUpID and UserID=@UserID group by UserID)=2
Begin
print(CAST(@userID as varchar))
print(CAST(@MeetUpID as varchar))
       RAISERROR ('You have already submitted a rating for this MeetUp!', 16, 10) WITH LOG
End
else
Begin
DECLARE @RatingSum float
DECLARE @NoOfRatings float
DECLARE @NewOverallRating float
SET @RatingSum=(select sum(Rating) from Rating where MeetUpID=@MeetUpID group by MeetUpID)
SET @NoOfRatings=(select count(Rating) from Rating where MeetUpID=@MeetUpID group by MeetUpID )
SET @NewOverallRating =@RatingSum/@NoOfRatings;
if @MeetUpID in (Select MeetUpID from MeetUpNotes)
Update MeetUpNotes
set OverAllRating = @NewOverallRating where MeetUpID=@MeetUpID;
else
insert into MeetUpNotes(MeetUpID,OverAllRating)
values(@MeetUpID,@NewOverallRating);
end
END

/*
INSERT INTO Rating values
(1,8003,3)

INSERT INTO Rating values
(1,8000,3)

INSERT INTO Rating values
(15,8000,4)
*/
------------------------------------------------USER DEFINED FUNCTIONS-----------------------------------------------------------------
--*********************************************************************
--Dropping the user defined functions (UDF) UDF_ShowAllMeetUps if exists and create again
--*********************************************************************

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'UDF_ShowAllMeetUps') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION UDF_ShowAllMeetUps
GO

CREATE FUNCTION UDF_ShowAllMeetUps()
RETURNS TABLE
AS
RETURN
(
SELECT m.MeetUpName,m.MeetUpDescription,m.MeetUpDate,m.Timings,l.LocationName,l.LocationCampus,
c.CategoryName,u.UserName
FROM MeetUp m
INNER JOIN Location l
ON l.LocationID=m.LocationID
INNER JOIN  Categories c
ON m.CategoryID=c.CategoryID
INNER JOIN Users u
ON u.UserID=m.UserID)
go

/*
-- working scenario 
SELECT * FROM UDF_ShowAllMeetUps()
*/

------------------------------------------------ VIEWS -----------------------------------------------------------------
--*********************************************************************
--Create View for getting userslist. This is for security purpose as only username and emailid are exposed outside.
--*********************************************************************
create view vw_userslist
as
select Username, EmailID from users;
go
/*
-- working scenario 
SELECT * FROM vw_userslist
*/

------------------------------------------------ CURSORS  -----------------------------------------------------------------
--*********************************************************************
--Cursor to show users and No of meetups organized.
--*********************************************************************
/*
select * from vw_userslist
select * from meetup
*/
declare @userName varchar(20), 
        @meetupCount int;

declare meetcount cursor static for
 select Username, count(MeetUpID) as NoofMeetUPs
  from Meetup JOIN vw_userslist
    on MeetUp.UserID = (select UserID from Users where users.UserName = vw_userslist.Username)
  group by Username;
open meetcount;

fetch next from meetcount INTO @userName, @meetupCount;
while @@FETCH_STATUS = 0
  begin
    print convert(varchar, @userName, 1) + ' has organized ' + convert(varchar, @meetupCount, 1) +' MeetUPs' ;
    fetch next from meetcount INTO @userName, @meetupCount;
  end;

close meetcount;
deallocate meetcount;


--*****************************************************************************************************************
--DCL
--*****************************************************************************************************************

--*********************************************************************
--Creating login and user.
--Granting permissions.
--Primary use is in Production database to connect with separate login other than 'sa' (SQL admin)
--JDBC connection
--*********************************************************************
create login polylogin with password= 'polylog'
go
create user polyuser for login polylogin
go
exec sp_addrolemember N'db_datareader', N'polyuser' 
go



--*********************************************************************
--Exporting Entire DBSchema as xml. 
--Can be used in Middleware code to know the structure while designing UI
--*********************************************************************

DECLARE @listStr VARCHAR(MAX)
SELECT @listStr = COALESCE(@listStr+',' ,'') + TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
print @listStr
EXEC('
  DECLARE @schema xml
  SET @schema = (SELECT TOP 0 * FROM ' + 
     @listStr + 
     ' FOR XML AUTO, ELEMENTS, XMLSCHEMA(''polySchema''))
  SELECT @schema
     ');