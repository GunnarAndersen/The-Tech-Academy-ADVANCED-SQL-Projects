USE Library

/*v1*/
/*Foreign keys on BookID, BranchID, CardNo, PublisherName */

/*Foreign Key Syntax:         PersonID int FOREIGN KEY REFERENCES Persons(PersonID)

*/

/*-- /*SYNTAAX EXEC sp_RENAME 'table_name.old_name', 'new_name', 'COLUMN'*/
*/

/*DROP ORDER: 
1.Book_Authors
2.Book_Copies
3.Book_Loans
4.Borrower
5. Books
6. Publisher
7. Library_Branch
*/
DROP TABLE tbl_Book_Authors
DROP TABLE tbl_Book_Copies
DROP TABLE tbl_Book_Loans
DROP TABLE tbl_Borrower
DROP TABLE tbl_Books
DROP TABLE tbl_Publisher
DROP TABLE tbl_Library_Branch


CREATE TABLE tbl_Library_Branch (
BranchID INT PRIMARY KEY NOT NULL, /*To revert, change it back to IDENTITY (1,1)*/
BranchName VARCHAR(50) NOT NULL,
[Address] VARCHAR(50) NOT NULL
);

SELECT * FROM tbl_Library_Branch

CREATE TABLE tbl_Publisher (
PublisherName VARCHAR(50) PRIMARY KEY NOT NULL,
[Address] VARCHAR(50) NOT NULL,
Phone VARCHAR(50) NOT NULL
);

SELECT PublisherName FROM tbl_Publisher

SELECT * FROM tbl_Publisher

/*[EXEC sp_RENAME 'table_name.old_name', 'new_name', 'COLUMN'] reNAMING SYNTAX */

CREATE TABLE tbl_Books (
BookID INT PRIMARY KEY NOT NULL, /*Putting identity here seems like a bad idea*/
Title VARCHAR(50) NOT NULL UNIQUE, 
PublisherName VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES tbl_Publisher(PublisherName)	
/*Foreign Key Syntax: PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
PRIMARY KEY																							column, datatype, FK, REferences, F Table, F column*/
);

CREATE TABLE tbl_Book_Authors 
(BookID INT NOT NULL FOREIGN KEY REFERENCES tbl_Books(BookID),
AuthorName VARCHAR(50) NOT NULL,
);

SELECT * FROM tbl_Book_Authors
-- column, datatype, FK, REferences, F Table, F column --
/*The first 4 can be executed in any order. The last 3 need to be executed starting in descending order like 3, 2, 1*/

/*Use [] to turn commands into names*/
CREATE TABLE tbl_Borrower ( 
CardNo INT PRIMARY KEY NOT NULL,
[Name] VARCHAR(50) NOT NULL,
[Address] VARCHAR(50) NOT NULL,
Phone VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_Book_Loans (
BookID VARCHAR(50) FOREIGN KEY REFERENCES tbl_Books(Title) NOT NULL,
BranchID INT FOREIGN KEY REFERENCES tbl_Library_Branch(BranchID) NOT NULL, /*NOT UNIQUE*/ /*To revert to the last state, make this AND CardNo UNIQUE and NULL*/
CardNo INT FOREIGN KEY REFERENCES tbl_Borrower(CardNo) NOT NULL, /*Needed to make these NOT unique*/
DateOut DATETIME NOT NULL DEFAULT(GETDATE()),
DateDue DATETIME NOT NULL DEFAULT (GETDATE())
);

CREATE TABLE tbl_Book_Copies (
BookID VARCHAR(50) FOREIGN KEY REFERENCES tbl_Books(Title) NOT NULL,
BranchID INT FOREIGN KEY REFERENCES tbl_Library_Branch(BranchID), 
Number_Of_Copies INT NOT NULL
);

SELECT * FROM tbl_Book_Loans

ALTER TABLE tbl_Book_Loans
  ALTER COLUMN BranchID INT NOT NULL;
SELECT * FROM tbl_Book_Loans

/*"sp_rename "table_name"
Change "column 1" "column 2" ["Data Type"];*/

SELECT * FROM tbl_Borrower
--ALL TABLES CREATED START NEXT THING--

--DATA INSERTION--


INSERT INTO tbl_Library_Branch /*We need 4 branches*/
(BranchID, BranchName, [Address])
VALUES
('1', 'Sharpstown','1250 W 43rd Ave'),
('2', 'Central','00000 Central Ave'),
('3', 'Council Tree','1280 E 420th Ave'),
('4','Public Library','5555 S 69th Ave')
;
SELECT * FROM tbl_Library_Branch
INSERT INTO tbl_Publisher /*(8 Required)*/
(PublisherName, [Address], Phone)
VALUES
('Stephen King Press', '103113 Spooky Street', '207-669-6919'),
('Nabokov Press', '1250 Karen Avenue', '970-669-6919'),
('Canis Press', '1488 Black Lab Lane', '970-660-6034'),
('Scumbag Press', '42069 W Scumbag Road', '479-273-6463'),
('Miracle Press', '42050 E Miracle Ave', '450-123-4509'),
('FuntimeEX Press', '420599 Singapore Ct', '420-500-1234'),
('Nasty Coatrack Press', '4590 Yeet Street', '421-509-6525'),
('TTA Press', '1337 Oregon Ct', '105-896-7531'),
('Samuse Press', '3561 Quebec St', '458-633-8987')
;
SELECT * FROM tbl_Publisher
SELECT * FROM tbl_Library_Branch
SELECT * FROM tbl_Books

INSERT INTO tbl_Books /*(20 required)*/
(BookID, /*INT*/  Title, /*VARCHAR*/ PublisherName /*VARCHAR*/)
VALUES
('1', 'The Lost Tribe','Miracle Press'),
('2', 'Endgames', 'Samuse Press'), 
('3', 'Encylopedia of dogs', 'Canis Press'),
('4','Saccarhine nights', 'Canis Press'),
('5','The story of Yefim', 'Scumbag Press'),
('6','The nastiest coat rack of them all', 'Nasty Coatrack Press'),
('7','Technology Basics Dictionary', 'TTA Press'),
('8','Lolita', 'Nabokov Press'),
('9','Welcome to the Monkey House', 'Nasty Coatrack Press'),
('10','Shtivelband King', 'FuntimeEX Press'),
('11','Come on Come on', 'Canis Press'),
('12','Eurobeat extravaganza', 'Scumbag Press'),
('13','The Watchmaker', 'Scumbag Press'),
('14','The Shining', 'Stephen King Press'),
('15','Pet Sematary', 'Stephen King Press'),
('16','Secrets of the galaxy', 'Miracle Press'),
('17','Pride and Prejudice', 'Samuse Press'),
('18','The Luhzin Defense', 'Nabokov Press'),
('19','The waxiest candle', 'Samuse Press'),
('20','Learn to speak Ukrainian in 10 EASY STEPS', 'Scumbag Press')
;

SELECT * FROM tbl_Book_Authors

/*sp_help 'dbo.tbl_Books'*/

INSERT INTO tbl_Book_Authors /*(10 required)*/
(BookID, AuthorName /*VARCHAR*/)
VALUES /*THIS ONLY NOW WORKS IT WASNT WORKING BEFORE*/
('1', 'Edward Mariott'),
('2', 'Karsten Muller'),
('3', 'Mr. Peanutbutter'),
('4', 'Mr. Peanutbutter'),
('5', 'Scumbag Steve'),
('6', 'Danny Joelson'),
('7', 'Erik Gross & Jack Stanley'),
('8', 'Vladimir Nabokov'),
('9', 'Kurt Vonnegut'),
('10', 'Brian Wall'),
('11', 'Dr. Dalmatia'),
('12', 'Scumbag Chauncey'),
('13', 'Scumbag Solomon'),
('14','Stephen King'),
('15', 'Stephen King'),
('16', 'Michael Adams'),
('17', 'Fyodor Dostoevsky'),
('18', 'Vladimir Nabokov'),
('19', 'Richard Mastersson'),
('20', 'Yuval Krainyan')
;

SELECT * FROM tbl_Book_Authors
/*sp_help 'dbo.tbl_Book_Loans'*/
SELECT * FROM tbl_Book_Copies


INSERT INTO tbl_Book_Copies

(BookID, BranchID, Number_Of_Copies)
VALUES
('The Lost Tribe', '1', '7'),
('The Lost Tribe', '2', '7'),
('The Lost Tribe', '3', '7'),
('Endgames', '1', '7'),
('Endgames', '2', '7'),
('Encylopedia of Dogs', '3','5'),
('Saccarhine nights','3','6'),
('The story of Yefim','4','3'),
('The nastiest coat rack of them all','3','3'),
('The nastiest coat rack of them all','4','3'),
('The nastiest coat rack of them all','2','3'),
('The nastiest coat rack of them all','1','3'),
('Technology Basics Dictionary','3','4'),
('Lolita','3','10'),
('Welcome to the Monkey House','3','5'),
('Shtivelband King','3','60'),
('Come on Come on','3','5'),
('Eurobeat Extravaganza','3','6'),
('The Watchmaker','3','4'),
('The Shining','3','2'),
('Pet Sematary','3','5'),
('Secrets of the galaxy','3','5'),
('Pride and Prejudice','3','4'),
('The Luhzin Defense','3','5'),
('The waxiest candle','3','4'),
('Endgames','2','7'),
('Encylopedia of Dogs','2','5'),
('Saccarhine nights','2','6'),
('The story of Yefim','2','3'),
('Technology Basics Dictionary','2','4'),
('Lolita','2','10'),
('Welcome to the Monkey House','2','5'),
('Shtivelband King','2','60'),
('Come on Come on','2','5'),
('Eurobeat Extravaganza','2','6'),
('The Watchmaker','2','4'),
('The Shining','2','2'),
('Pet Sematary','2','5'),
('Secrets of the galaxy','2','5'),
('Pride and Prejudice','2','4'),
('The Luhzin Defense','2','5'),
('The waxiest candle','2','4'),
('Endgames','1','7'),
('Encylopedia of Dogs','1','5'),
('Saccarhine nights','1','6'),
('The story of Yefim','1','3'),
('Technology Basics Dictionary','1','4'),
('Welcome to the Monkey House','1','5'),
('Shtivelband King','1','6'),
('Come on Come on','1','5'),
('Eurobeat Extravaganza','1','6'),
('The Watchmaker','1','4'),
('The Shining','1','2'),
('Pet Sematary','1','5'),
('Secrets of the galaxy','1','5'),
('Pride and Prejudice','1','4'),
('The Luhzin Defense','1','5'),
('The waxiest candle','1','4'),
('Endgames','4','3'),
('Encylopedia of Dogs','4','5'),
('The story of Yefim','4','3'),
('Technology Basics Dictionary','4','4'),
('Lolita','4','10'),
('Welcome to the Monkey House','4','5'),
('Shtivelband King','4','1'),
('Come on Come on','4','5'),
('Eurobeat Extravaganza','4','6'),
('The Watchmaker','4','4'),
('The Shining','4','2'),
('Pet Sematary','4','5'),
('Secrets of the galaxy','4','5'),
('Pride and Prejudice','4','4'),
('The Luhzin Defense','4','5'),
('The waxiest candle','4','4')
;
SELECT * FROM tbl_Book_Copies

SELECT * FROM tbl_Books
SELECT * FROM tbl_Borrower
INSERT INTO tbl_Borrower
(CardNo, [Name],[Address], Phone)
VALUES 
('1', 'Jim Slugmutton','8888 W 44th St','402-301-4023'),
('2','Elizabeth Thoreau','4255 Fossil Ct','423-123-5124'),
('3','Quackery Duckadahl','4245 Greeman St','401-231-9950'),
('4','Deanna Gregory','950 N 423rd St','706-623-1245'),
('5','Rhett Langsam','5023 Snail Ct','719-359-6077'),
('6','Ilya Mxyzptlk','5025 Snail Ct','303-506-1234'),
('7','Tiansteve Wang','405 N Carolina Ave','603-245-1246'),
('8','Snow Man','669 Winter Ave','303-123-4569'), /*(n = 9)*/
('9','Illirhett Langsam','3838 Meow Lane','301-123-4569')
;

 /*REMEMBER TO USE THE TILES OF THE BOOKS WITH BOOKID!!!!!!!!!!!!!!!!*/
/*Params:
	BOOKID- Any of the 20 titles in this majestic Library
	BRANCHID- Integer 1-4 
	CardNo- Integers 1-9
	DATEIN- say like 5/23/2018 or whatever
	DATEOUT- same as DATEIN but must be later
	*/
	SELECT * FROM tbl_Book_Loans
	/*I think that my problem here is that I need to change the BRANCHID to a non unique key, because it does not allow me to put more than 1 book in each branch which is a huge problem*/
INSERT INTO tbl_Book_Loans
(BookID, BranchID, CardNo, DateOut, DateDue)			
VALUES

('The Lost Tribe', '2', '1', '7-28-2018', '12-8-2018'),
('The Lost Tribe', '2', '1', '7-28-2018', '12-8-2018'),
('The Lost Tribe', '2', '1', '7-28-2018', '12-8-2018'),
('The Lost Tribe', '2', '1', '7-28-2018', '12-8-2018'),
('Endgames', '2', '2','7-31-2018','12-10-2018'),
('Endgames', '2', '1', '4-5-2018','6-10-2018'),
('Endgames', '4', '4', '5-12-2018','6-11-2018'),
('Endgames', '2', '8','5-14-2018','6-13-2018'),
('Encylopedia of dogs', '1', '2','12-12-2018','1-10-2019'),
('Encylopedia of dogs', '1', '3','11-7-2018','2-10-2019'),
('Encylopedia of dogs', '1', '4','10-10-2018','12-10-2018'),
('Encylopedia of dogs', '3', '5','9-5-2018','11-3-2018'),
('Encylopedia of dogs', '3', '6','8-8-2018','10-16-2018'),
('Encylopedia of dogs', '2', '7','11-7-2018','1-10-2019'),
('Saccarhine nights', '2', '8','3-7-2018','6-2-2018'),
('Saccarhine nights', '2', '5','2-7-2018','6-1-2018'),
('Saccarhine nights', '3', '1','1-3-2018','6-3-2018'),
('Saccarhine nights', '2', '3','7-4-2018','6-20-2018'),
('Saccarhine nights', '3', '5','6-6-2018','6-20-2018'),
('Saccarhine nights', '4', '7','5-2-2018','7-10-2018'),
('Saccarhine nights', '4', '8','4-4-2018','5-10-2018'),
('The story of Yefim', '4', '2','10-3-2018','1-1-2019'),
('The story of Yefim', '4', '4','9-3-2018','1-10-2019'),
('The story of Yefim', '3', '6','9-2-2018','2-10-2019'),
('The nastiest coat rack of them all', '2', '7','8-2-2018','10-10-2018'),
('The nastiest coat rack of them all', '2', '8','7-3-2018','9-10-2018'),
('The nastiest coat rack of them all', '2', '4','6-3-2018','12-10-2018'),
('The nastiest coat rack of them all', '1', '3','5-23-2018','7-10-2018'),
('The nastiest coat rack of them all', '1', '2','4-23-2018','10-10-2018'),
('The nastiest coat rack of them all', '1', '1','12-26-2018','1-10-2019'),
('The nastiest coat rack of them all', '1', '4','1-4-2018','3-10-2018'),
('The nastiest coat rack of them all', '2', '5','1-3-2018','4-10-2018'),
('Technology Basics Dictionary', '4', '5','1-2-2018','2-10-2018'),
('Technology Basics Dictionary', '2', '6','9-22-2018','10-10-2018'),
('Technology Basics Dictionary', '1', '7','2-23-2018','4-10-2018'),
('Lolita', '1', '2','3-21-2018','6-10-2018'),
('Lolita', '2', '3','3-26-2018','6-10-2018'),
('Lolita', '3', '4','7-28-2018','9-10-2018'),
('Lolita', '3', '5','8-28-2018','10-10-2018'),
('Lolita', '2', '6','6-23-2018','8-10-2018'),
('Lolita', '4', '7','2-3-2018','4-10-2018'),
('Lolita', '2', '8','4-2-2018','6-10-2018'),
('Welcome to the Monkey House', '1', '1','7-3-2018','9-10-2018'),
('Welcome to the Monkey House', '2', '3','12-17-2018','2-10-2019'),
('Welcome to the Monkey House', '2', '2','4-3-2018','7-10-2018'),
('Welcome to the Monkey House', '1', '4','6-3-2018','9-10-2018'),
('Welcome to the Monkey House', '2', '5','6-2-2018','9-10-2018'),
('Shtivelband King', '3', '6','2-2-2018','11-10-2018'),
('Shtivelband King', '3', '1','10-23-2018','12-10-2018'),
('Shtivelband King', '4', '5','4-23-2018','6-10-2018'),
('Shtivelband King', '2', '4','1-23-2018','3-10-2018'),
('Eurobeat Extravaganza', '4', '1','1-2-2018','6-10-2018'),
('The Watchmaker', '3', '8','5-3-2018','6-10-2018'),
('The Shining', '2', '3','5-22-2018','6-10-2018'),
('Pet Sematary', '1', '5','5-20-2018','6-10-2018'),
('The Shining', '2', '3','4-20-2018','6-10-2018'),
('The Shining', '1', '2','2-23-2018','6-10-2018'),
('Secrets of the galaxy', '2', '1','9-23-2018','12-10-2018'),
('Pride and Prejudice', '1', '1','7-23-2018','12-10-2018'),
('The Luhzin Defense', '2', '1','6-23-2018','9-10-2018'),
('The Luhzin Defense', '1', '2','3-23-2018','5-10-2018'),
('The Luhzin Defense', '2', '3','2-23-2018','4-10-2018'),
('The waxiest candle', '2', '4','1-23-2018','4-10-2018'),
('Pet Sematary', '1', '8','2-23-2018','5-10-2018'),
('The waxiest candle', '2', '8','4-23-2018','7-10-2018'),
('The waxiest candle', '3', '1','3-23-2018','6-10-2018'),
('The waxiest candle', '4', '2','2-23-2018','5-10-2018'),
('The waxiest candle', '4', '5','4-23-2018','7-10-2018'),
('The waxiest candle', '4', '2','6-23-2018','9-10-2018'),
('Learn to speak Ukrainian in 10 EASY STEPS', '4', '1','5-22-2018','7-23-2018'),
('Learn to speak Ukrainian in 10 EASY STEPS', '2', '3','5-29-2018','7-30-2018'),
('Learn to speak Ukrainian in 10 EASY STEPS', '1', '2','5-28-2018','7-29-2018'),
('Learn to speak Ukrainian in 10 EASY STEPS', '2', '4','5-27-2018','7-28-2018'),
('Learn to speak Ukrainian in 10 EASY STEPS', '4', '6','5-26-2018','7-27-2018'),
('Learn to speak Ukrainian in 10 EASY STEPS', '3', '5','5-24-2018','7-25-2018')
;

-- END DATA INSERTION --

-- Begin creation of stored procedures --

/*Procedure 1, name "uspSharpstownTribe"*/
GO
CREATE PROCEDURE dbo.uspSharpstownTribe

AS

SELECT a1.BookID, a1.Number_Of_Copies, a2.BranchName, a2.BranchID FROM tbl_Book_Copies a1
INNER JOIN tbl_Library_Branch a2 ON a2.BranchID = a1.BranchID 
WHERE a1.BranchID = '1' AND BookID = 'The Lost Tribe'
GO

uspSharpstownTribe

/*Procedure passed manual inspection. End Procedure 1*/


/*Procedure 2 start, name 'uspTheLostTribe'*/


GO
CREATE PROCEDURE dbo.uspTheLostTribe
AS

SELECT a1.BookID, a1.Number_Of_Copies, a2.BranchName, a2.BranchID FROM tbl_Book_Copies a1
INNER JOIN tbl_Library_Branch a2 ON a2.BranchID = a1.BranchID
WHERE BookID = 'The Lost Tribe' 
GO

uspTheLostTribe


/*Passed Manual Inspection, end procedure 2*/

/*Start Procedure 3*/

GO
CREATE PROCEDURE dbo.uspWhoCantRead
AS

SELECT a2.CardNo, a1.CardNo, a2.Name
FROM tbl_Book_Loans a1
RIGHT JOIN tbl_Borrower a2 ON a2.CardNo = a1.CardNo
WHERE a1.CardNo IS NULL
GO

uspWhoCantRead
/*END procedure 3, passed manual inspection*/


/*BEGIN procedure 4*/
GO
CREATE PROCEDURE dbo.uspBooksDue
AS

SELECT a2.Address, a1.DateDue, a2.Name, a3.Title, a1.BranchID AS 'Sharpstown'
FROM tbl_Book_Loans a1
INNER JOIN tbl_Borrower a2 ON a2.CardNo = a1.CardNo
INNER JOIN tbl_Books a3 ON a3.BookID = a1.BranchID
WHERE a1.DateDue = GETDATE();

GO

uspBooksDue

/*END OF PROCEDURE 4, PASSED MANUAL INSPECTION*/


/*START of Procedure 5*/
GO
CREATE PROCEDURE uspBookLoanTotal
AS
SELECT COUNT(BookID) AS Sharpstown
FROM tbl_Book_Loans
WHERE BranchID = '1';


SELECT COUNT(BookID) AS Central
FROM tbl_Book_Loans
WHERE BranchID = '2';

SELECT COUNT(BookID) AS 'Council Tree'
FROM tbl_Book_Loans
WHERE BranchID = '3';

SELECT COUNT(BookID) AS 'Public Library'
FROM tbl_Book_Loans
WHERE BranchID = '4';

GO
uspBookLoanTotal
/*END PROCEDURE 5, I checked it and it seems there are many ways to do this but I will elect to use this one.*/


/*Start Procedure 6*/
GO
CREATE PROCEDURE uspGetReaders
AS
SELECT a1.Name, a1.Address, a1.CardNo, COUNT(*)
FROM tbl_Borrower a1, tbl_Book_Loans a2
WHERE a1.CardNo = a2.CardNo
GROUP BY a1.CardNo, a1.Name, a1.Address
HAVING COUNT(*) > 5
GO
/*END procedure 6*/

/*Start Procedure 7 */

GO

CREATE PROCEDURE uspFindStephenKing
AS


SELECT  a3.AuthorName, a2.BookID, a2.Number_Of_Copies, a1.Title, a4.BranchName
FROM tbl_Books a1 
INNER JOIN tbl_Book_Copies a2 ON a2.BookID = a1.Title
INNER JOIN tbl_Book_Authors a3 ON a3.BookID = a1.BookID
INNER JOIN tbl_Library_Branch a4 ON a4.BranchID = a2.BranchID
WHERE AuthorName = 'Stephen King' AND a2.BranchID = '2'
/*END Procedure 7*/
GO