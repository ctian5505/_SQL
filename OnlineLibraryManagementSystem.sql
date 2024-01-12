-- This Project is my final Project capstone at MS SQL Server Masterclass by DataSense Analytics

-- Phase 1: Database Design (DDL)
        -- Task 1: Define the Database Schema
        -- Description: Create the database schema for the library management system, defining tables and relationships.

-- Creating Library Database
CREATE DATABASE Library

  -- Creating the Books Table
CREATE TABLE Books(
BookID INT NOT NULL,
Title NVARCHAR(150) NOT NULL,
Author NVARCHAR(100),
Language NVARCHAR(50),
DatePublished DATE,
GenreID INT)
  
-- Creating the Genre Table
CREATE TABLE Genre(
GenreID INT NOT NULL,
Genre NVARCHAR(150))
  
-- Creating the Borrowers Table
CREATE TABLE Borrowers (
StudentID INT NOT NULL,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
BookID INT NOT NULL)
  
-- Creating the Students Info Table
CREATE TABLE StudentsInfo (
StudentID INT NOT NULL,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Gender NVARCHAR(6) NOT NULL,
DateOfBirth NVARCHAR(12) NOT NULL,
ContactInformation NVARCHAR(20) NOT NULL)


        -- Task 2: Specify Keys and Constraints
        -- Description: Define primary keys, foreign keys, constraints, and relationships between tables.

-- Defining Primary Key for books table
ALTER TABLE 
        Books
ADD CONSTRAINT 
        PK_Books PRIMARY KEY(BookID)
        
-- Defining Primary Key for Genre table
ALTER TABLE 
        Genre
ADD CONSTRAINT 
        PK_GenreID PRIMARY KEY (GenreID)
        
-- Defining Primary Key for Students Info table
ALTER TABLE 
        StudentsInfo
ADD CONSTRAINT 
        PK_StudentID PRIMARY KEY (StudentID)

        
-- Phase 2: Data Population (DML)
	-- Task 3: Populate the Database with Sample Data
	-- Description: Insert sample data into the database, including books, user information, and transactions.
	
--INSERTING sample book records
INSERT INTO Books(BookID, Title, Author, Language, DatePublished, GenreID)
VALUES
	(1, 'A Tale of Two Cities','Charles Dickens','English','1859',28),
	(2, 'The Little Prince (Le Petit Prince)','Antoine de Saint-Exupéry','French','1943',41),
	(3, 'Harry Potter and the Philosopher''s Stone','J. K. Rowling','English','1997',23),
	(4, 'And Then There Were None','Agatha Christie','English','1939',36),
	(5, 'Dream of the Red Chamber (紅樓夢)','Cao Xueqin','Chinese','1791',22),
	(6, 'The Hobbit','J. R. R. Tolkien','English','1937',23),
	(7, 'The Lion, the Witch and the Wardrobe','C. S. Lewis','English','1950',23),
	(8, 'She: A History of Adventure','H. Rider Haggard','English','1887',1),
	(9, 'Vardi Wala Gunda (वर्दी वाला ग ुंडा)','Ved Prakash Sharma','Hindi','1992',17),
	(10, 'The Da Vinci Code','Dan Brown','English','2003',37),
	(11, 'Harry Potter and the Chamber of Secrets','J. K. Rowling','English','1998',23),
	(12, 'Harry Potter and the Prisoner of Azkaban','J. K. Rowling','English','1999',23),
	(13, 'Harry Potter and the Goblet of Fire','J. K. Rowling','English','2000',23),
	(14, 'Harry Potter and the Order of the Phoenix','J. K. Rowling','English','2003',23),
	(15, 'Harry Potter and the Half-Blood Prince','J. K. Rowling','English','2005',23),
	(16, 'Harry Potter and the Deathly Hallows','J. K. Rowling','English','2007',23),
	(17, 'The Alchemist (O Alquimista)','Paulo Coelho','Portuguese','1988',23),
	(18, 'The Catcher in the Rye','J. D. Salinger','English','1951',13),
	(19, 'The Bridges of Madison County','Robert James Waller','English','1992',46),
	(20, 'Ben-Hur: A Tale of the Christ','Lew Wallace','English','1880',28),
	(21, 'You Can Heal Your Life','Louise Hay','English','1984',53),
	(22, 'One Hundred Years of Solitude (Cien años de soledad)','Gabriel García Márquez','Spanish','1967',33),
	(23, 'Lolita','Vladimir Nabokov','English','1955',40),
	(24, 'Heidi','Johanna Spyri','German','1880',7),
	(25, 'The Common Sense Book of Baby and Child Care','Benjamin Spock','English','1946',34),
	(26, 'Anne of Green Gables','Lucy Maud Montgomery','English','1908',9),
	(27, 'Black Beauty','Anna Sewell','English','1877',8),
	(28, 'The Name of the Rose (Il Nome della Rosa)','Umberto Eco','Italian','1980',30),
	(29, 'The Eagle Has Landed','Jack Higgins','English','1975',63),
	(30, 'Watership Down','Richard Adams','English','1972',23),
	(31, 'The Hite Report','Shere Hite','English','1976',55),
	(32, 'Charlotte''s Web','E. B. White; illustrated by Garth Williams','English','1952',7),
	(33, 'The Ginger Man','J. P. Donleavy','English','1955',40),
	(34, 'The Tale of Peter Rabbit','Beatrix Potter','English','1902',8),
	(35, 'Jonathan Livingston Seagull','Richard Bach','English','1970',41),
	(36, 'The Very Hungry Caterpillar','Eric Carle','English','1969',8),
	(37, 'A Message to Garcia','Elbert Hubbard','English','1899',21),
	(38, 'To Kill a Mockingbird','Harper Lee','English','1960',58),
	(39, 'Flowers in the Attic','V. C. Andrews','English','1979',26),
	(40, 'Cosmos','Carl Sagan','English','1980',44),
	(41, 'Sophie''s World (Sofies verden)','Jostein Gaarder','Norwegian','1991',42),
	(42, 'Angels & Demons','Dan Brown','English','2000',37),
	(43, 'Kane and Abel','Jeffrey Archer','English','1979',40),
	(44, 'How the Steel Was Tempered (Как закалялась сталь)','Nikolai Ostrovsky','Russian','1932',57),
	(45, 'War and Peace (Война и мир)','Leo Tolstoy','Russian','1869',30),
	(46, 'The Adventures of Pinocchio (Le avventure di Pinocchio)','Carlo Collodi','Italian','1881',23),
	(47, 'The Diary of Anne Frank (Het Achterhuis)','Anne Frank','Dutch','1947',29),
	(48, 'Your Erroneous Zones','Wayne Dyer','English','1976',53),
	(49, 'The Thorn Birds','Colleen McCullough','English','1977',48),
	(50, 'The Purpose Driven Life','Rick Warren','English','2002',11),
	(51, 'The Kite Runner','Khaled Hosseini','English','2003',4),
	(52, 'Valley of the Dolls','Jacqueline Susann','English','1966',40),
	(53, 'Alcoholics Anonymous Big Book','Bill Wilson','English','1939',53),
	(54, 'How to Win Friends and Influence People','Dale Carnegie','English','1936',53),
	(55, 'The Great Gatsby','F. Scott Fitzgerald','English','1925',40),
	(56, 'Gone with the Wind','Margaret Mitchell','English','1936',28),
	(57, 'Rebecca','Daphne du Maurier','English','1938',27),
	(58, 'Nineteen Eighty-Four','George Orwell','English','1949',19),
	(59, 'The Revolt of Mamie Stover','William Bradford Huie','English','1951',25),
	(60, 'The Girl with the Dragon Tattoo (Män som hatar kvinnor)','Stieg Larsson','Swedish','2005',25),
	(61, 'The Lost Symbol','Dan Brown','English','2009',25),
	(62, 'The Hunger Games','Suzanne Collins','English','2008',64),
	(63, 'James and the Giant Peach','Roald Dahl','English','1961',9),
	(64, 'The Young Guard (Молодая гвардия)','Alexander Alexandrovich Fadeyev','Russian','1945',65),
	(65, 'Who Moved My Cheese?','Spencer Johnson','English','1998',53),
	(66, 'A Brief History of Time','Stephen Hawking','English','1988',44),
	(67, 'Paul et Virginie','Jacques-Henri Bernardin de Saint-Pierre','French','1788',40),
	(68, 'Lust for Life','Irving Stone','English','1934',5),
	(69, 'The Wind in the Willows','Kenneth Grahame','English','1908',8),
	(70, 'The 7 Habits of Highly Effective People','Stephen R. Covey','English','1989',53),
	(71, 'Virgin Soil Upturned (Поднятая целина)','Mikhail Sholokhov','Russian','1935',40),
	(72, 'The Celestine Prophecy','James Redfield','English','1993',39),
	(73, 'The Fault in Our Stars','John Green','English','2012',67),
	(74, 'The Girl on the Train','Paula Hawkins','English','2015',59),
	(75, 'The Shack','William P. Young','English','2007',40),
	(76, 'Uncle Styopa (Дядя Стёпа)','Sergey Mikhalkov','Russian','1936',8),
	(77, 'The Godfather','Mario Puzo','English','1969',15),
	(78, 'Love Story','Erich Segal','English','1970',47),
	(79, 'Catching Fire','Suzanne Collins','English','2009',66),
	(80, 'Mockingjay','Suzanne Collins','English','2010',66),
	(81, 'Kitchen (キッチン)','Banana Yoshimoto','Japanese','1988',32),
	(82, 'Andromeda Nebula (Туманность Андромеды)','Ivan Yefremov','Russian','1957',52),
	(83, 'Autobiography of a Yogi (योगी कथामृत)','Paramahansa Yogananda','Hindi','1946',3),
	(84, 'Gone Girl','Gillian Flynn','English','2012',16),
	(85, 'All Quiet on the Western Front (Im Westen nichts Neues)','Erich Maria Remarque','German','1929',62),
	(86, 'Things Fall Apart ','Chinua Achebe','English','1958',40),
	(87, 'Animal Farm ','George Orwell','English','1945',50),
	(88, 'Wolf Totem (狼图腾)','Jiang Rong','Chinese','2004',54),
	(89, 'The Happy Hooker: My Own Story','Xaviera Hollander','English','1971',35),
	(90, 'Jaws','Peter Benchley','English','1974',59),
	(91, 'Love You Forever','Robert Munsch','English','1986',8),
	(92, 'The Women''s Room','Marilyn French','English','1977',24),
	(93, 'What to Expect When You''re Expecting','Arlene Eisenberg and Heidi Murkoff','English','1984',45),
	(94, 'Adventures of Huckleberry Finn','Mark Twain','English','1885',43),
	(95, 'The Secret Diary of Adrian Mole, Aged 13¾','Sue Townsend','English','1982',66),
	(96, 'Pride and Prejudice','Jane Austen','English','1813',12),
	(97, 'Kon-Tiki: Across the Pacific in a Raft (Kon-Tiki ekspedisjonen)','Thor Heyerdahl','Norwegian','1950',60),
	(98, 'The Good Soldier Švejk (Osudy dobrého vojáka Švejka za světové války)','Jaroslav Hašek','Czech','1923',61),
	(99, 'Where the Wild Things Are','Maurice Sendak','English','1963',10),
	(100, 'The Power of Positive Thinking','Norman Vincent Peale','English','1952',53),
	(101, 'The Secret','Rhonda Byrne','English','2006',53),
	(102, 'Fear of Flying','Erica Jong','English','1973',49),
	(103, 'Dune','Frank Herbert','English','1965',52),
	(104, 'Charlie and the Chocolate Factory','Roald Dahl','English','1964',6),
	(105, 'The Naked Ape','Desmond Morris','English','1968',56),
	(106, 'Where the Crawdads Sing','Delia Owens','English','2018',14),
	(107, 'Totto-chan, the Little Girl at the Window (窓ぎわのトットちゃん)','Tetsuko Kuroyanagi','Japanese','1981',2),
	(108, 'Matilda','Roald Dahl','English','1988',8),
	(109, 'The Book Thief','Markus Zusak','English','2005',64),
	(110, 'Goodnight Moon','Margaret Wise Brown','English','1947',8),
	(111, 'The Neverending Story (Die unendliche Geschichte)','Michael Ende','German','1979',8),
	(112, 'All the Light We Cannot See','Anthony Doerr','English','2014',28),
	(113, 'Fifty Shades of Grey','E. L. James','English','2011',20),
	(114, 'The Pillars of the Earth','Ken Follett','English','1989',28),
	(115, 'The Hitchhiker''s Guide to the Galaxy','Douglas Adams','English','1979',51),
	(116, 'The Giver','Lois Lowry','English','1993',18),
	(117, 'The Exorcist','William Peter Blatty','English','1971',31),
	(118, 'Fifty Shades Darker','E. L. James','English','2012',20)
	
-- INSERTING sample Genre records
INSERT INTO Genre(GenreID, Genre)
VALUES
	(1, 'Adventure'),
	(2, 'Autobiographical novel'),
	(3, 'Autobiography'),
	(4, 'Bildungsroman'),
	(5, 'Biographical novel'),
	(6, 'Children''s fantasy novel'),
	(7, 'Children''s fiction'),
	(8, 'Children''s literature'),
	(9, 'Children''s novel'),
	(10, 'Children''s picture book'),
	(11, 'Christian literature'),
	(12, 'Classic regency novel'),
	(13, 'Coming-of-age'),
	(14, 'Coming-of-age Murder mystery'),
	(15, 'Crime novel'),
	(16, 'Crime thriller novel'),
	(17, 'Detective'),
	(18, 'Dystopian fiction'),
	(19, 'Dystopian'),
	(20, 'Erotica'),
	(21, 'Essay/Literature'),
	(22, 'Family saga'),
	(23, 'Fantasy'),
	(24, 'Feminist novel'),
	(25, 'Fiction'),
	(26, 'Gothic horror'),
	(27, 'Gothic novel'),
	(28, 'Historical fiction'),
	(29, 'Historical non-fiction'),
	(30, 'Historical novel'),
	(31, 'Horror'),
	(32, 'Japanese novel'),
	(33, 'Magic realism'),
	(34, 'Manual'),
	(35, 'Memoir'),
	(36, 'Mystery'),
	(37, 'Mystery thriller'),
	(38, 'Mystery thriller'),
	(39, 'New-age spiritual novel'),
	(40, 'Novel'),
	(41, 'Novella'),
	(42, 'Philosophical novel'),
	(43, 'Picaresque novel'),
	(44, 'Popular science'),
	(45, 'Pregnancy guide'),
	(46, 'Romance'),
	(47, 'Romance novel'),
	(48, 'Romantic family saga'),
	(49, 'Romantic novel'),
	(50, 'Satirical allegorical novella'),
	(51, 'Science fiction'),
	(52, 'Science fiction novel'),
	(53, 'Self-help'),
	(54, 'Semi-autobiographical novel'),
	(55, 'Sexology'),
	(56, 'Social Science'),
	(57, 'Socialist realist novel'),
	(58, 'Southern Gothic'),
	(59, 'Thriller'),
	(60, 'Travel literature'),
	(61, 'Unfinished satirical dark comedy novel'),
	(62, 'War novel'),
	(63, 'War'),
	(64, 'Young adult fiction'),
	(65, 'Young adult historical novel'),
	(66, 'Young adult novel'),
	(67, 'Young adult romantic novel')
	
-- Inserting Students Info
INSERT INTO StudentsInfo(StudentID, FirstName, LastName, Gender, DateOfBirth, ContactInformation)
VALUES
	(1,'Emilio','Sutton','Male','2010-03-24','4279136052'),
	(2,'Marie','Terrell','Female','2011-04-12','9292275268'),
	(3,'Marci','Crawford','Female','2011-08-23','2706509721'),
	(4,'Sean','Hooper','Male','2011-01-29','7236067595'),
	(5,'Annmarie','House','Female','2010-01-17','3054312373'),
	(6,'Adrian','Petersen','Male','2011-01-24','8497793876'),
	(7,'Jermaine','Sherman','Female','2011-05-31','9245478519'),
	(8,'Isabelle','Ingram','Female','2011-08-28','262346399'),
	(9,'Lionel','Hughes','Male','2011-07-28','5061167473'),
	(10,'Rayford','Villa','Male','2010-04-22','6524638243'),
	(11,'Jesus','Osborn','Male','2010-09-23','8764583622'),
	(12,'Clair','Bender','Female','2011-07-22','5013277127'),
	(13,'Nadine','Mcguire','Female','2010-06-06','4646150553'),
	(14,'Adriana','Coffey','Female','2011-12-28','7910311108'),
	(15,'Angie','Lloyd','Female','2010-11-21','6861024275'),
	(16,'Alexander','Stanton','Male','2011-06-18','2416086703'),
	(17,'Roy','Simpson','Male','2010-02-23','8802004982'),
	(18,'Connie','Dunlap','Female','2011-12-30','7653620966'),
	(19,'Edith','Keith','Female','2011-08-12','1468126034'),
	(20,'Donovan','Edwards','Female','2011-07-15','3112403183'),
	(21,'Ignacio','Reeves','Male','2011-06-12','1714817033'),
	(22,'Charley','Daugherty','Female','2011-05-02','8069617923'),
	(23,'Sheri','Hardin','Female','2010-08-21','6048254722'),
	(24,'Ezequiel','Hall','Male','2011-06-09','4125152639'),
	(25,'Bethany','Conrad','Female','2011-04-05','2770487472'),
	(26,'Tameka','Bright','Female','2011-03-27','7131715261'),
	(27,'Manuela','Morrow','Female','2011-07-03','7202363432'),
	(28,'Alma','Burke','Female','2011-02-03','1126403926'),
	(29,'Tammie','Proctor','Female','2010-04-15','5332177347'),
	(30,'Williams','Berg','Male','2010-05-05','7854576562'),
	(31,'Raphael','Parrish','Male','2011-06-23','9033673719'),
	(32,'Miquel','Logan','Male','2010-08-23','8863121056'),
	(33,'Emmanuel','Marks','Male','2011-11-28','990115655'),
	(34,'Marina','Oconnell','Female','2011-12-21','7577877854'),
	(35,'Leona','Spears','Female','2010-04-19','4109095586'),
	(36,'Dorsey','Duke','Female','2010-04-21','8997239230'),
	(37,'Terrell','Mays','Female','2011-03-13','2123173956'),
	(38,'Carlene','Benitez','Female','2011-05-17','4448414612'),
	(39,'Patricia','Garrison','Female','2010-03-15','7736490323'),
	(40,'Loretta','Peterson','Female','2011-07-25','4895170928'),
	(41,'Jose','Goodman','Male','2011-12-14','4279381118'),
	(42,'Theodore','Clay','Female','2010-09-01','1972535854'),
	(43,'Aisha','Sampson','Female','2011-06-29','6257588673'),
	(44,'Kirby','Massey','Male','2011-01-30','1306184169'),
	(45,'Moses','Bailey','Male','2010-03-07','525523150'),
	(46,'Louise','Robbins','Male','2010-09-26','3554888675'),
	(47,'Otis','Ortega','Male','2010-01-09','4089516225'),
	(48,'Beatriz','Harper','Female','2011-03-25','338460094'),
	(49,'Edward','Ballard','Male','2010-06-09','6570319136'),
	(50,'Chandra','Hodge','Female','2010-02-11','2349588876')
	
-- Inserting into borrowers
INSERT INTO Borrowers (StudentID,FirstName,LastName,BookID)
VALUES
(1,'Emilio','Sutton',56),
(26,'Tameka','Bright',18),
(20,'Donovan','Edwards',95),
(6,'Adrian','Petersen',63),
(24,'Ezequiel','Hall',32),
(26,'Tameka','Bright',90),
(14,'Adriana','Coffey',75),
(40,'Loretta','Peterson',44),
(39,'Patricia','Garrison',21),
(39,'Patricia','Garrison',24),
(50,'Chandra','Hodge',105),
(33,'Emmanuel','Marks',105),
(1,'Emilio','Sutton',15),
(22,'Charley','Daugherty',88),
(7,'Jermaine','Sherman',4),
(27,'Manuela','Morrow',73),
(30,'Williams','Berg',60),
(43,'Aisha','Sampson',33),
(3,'Marci','Crawford',33),
(24,'Ezequiel','Hall',42),
(27,'Manuela','Morrow',59),
(9,'Lionel','Hughes',16),
(29,'Tammie','Proctor',55),
(7,'Jermaine','Sherman',16),
(18,'Connie','Dunlap',109),
(39,'Patricia','Garrison',61),
(16,'Alexander','Stanton',113),
(31,'Raphael','Parrish',104),
(37,'Terrell','Mays',54),
(1,'Emilio','Sutton',14),
(22,'Charley','Daugherty',34),
(18,'Connie','Dunlap',71),
(38,'Carlene','Benitez',1),
(1,'Emilio','Sutton',10),
(29,'Tammie','Proctor',89),
(48,'Beatriz','Harper',51),
(27,'Manuela','Morrow',13),
(35,'Leona','Spears',33),
(31,'Raphael','Parrish',56),
(38,'Carlene','Benitez',112),
(26,'Tameka','Bright',38),
(25,'Bethany','Conrad',10),
(34,'Marina','Oconnell',58),
(49,'Edward','Ballard',79),
(47,'Otis','Ortega',98),
(21,'Ignacio','Reeves',73),
(13,'Nadine','Mcguire',46),
(19,'Edith','Keith',62),
(48,'Beatriz','Harper',46),
(26,'Tameka','Bright',74),
(36,'Dorsey','Duke',16),
(29,'Tammie','Proctor',68),
(12,'Clair','Bender',1),
(18,'Connie','Dunlap',41),
(5,'Annmarie','House',36),
(38,'Carlene','Benitez',28),
(45,'Moses','Bailey',17),
(43,'Aisha','Sampson',22),
(40,'Loretta','Peterson',76),
(45,'Moses','Bailey',78),
(22,'Charley','Daugherty',93),
(3,'Marci','Crawford',100),
(5,'Annmarie','House',112),
(13,'Nadine','Mcguire',40),
(45,'Moses','Bailey',94),
(5,'Annmarie','House',11),
(1,'Emilio','Sutton',11),
(43,'Aisha','Sampson',4),
(36,'Dorsey','Duke',16),
(50,'Chandra','Hodge',76),
(11,'Jesus','Osborn',44),
(25,'Bethany','Conrad',79),
(8,'Isabelle','Ingram',12),
(27,'Manuela','Morrow',68),
(22,'Charley','Daugherty',31),
(43,'Aisha','Sampson',17),
(22,'Charley','Daugherty',98),
(8,'Isabelle','Ingram',110),
(18,'Connie','Dunlap',29),
(32,'Miquel','Logan',25),
(36,'Dorsey','Duke',97),
(32,'Miquel','Logan',97),
(22,'Charley','Daugherty',48),
(13,'Nadine','Mcguire',29),
(26,'Tameka','Bright',9),
(24,'Ezequiel','Hall',7),
(9,'Lionel','Hughes',101),
(41,'Jose','Goodman',34),
(43,'Aisha','Sampson',25),
(50,'Chandra','Hodge',97),
(15,'Angie','Lloyd',77),
(44,'Kirby','Massey',78),
(29,'Tammie','Proctor',110),
(45,'Moses','Bailey',93),
(40,'Loretta','Peterson',26),
(29,'Tammie','Proctor',100),
(8,'Isabelle','Ingram',14),
(23,'Sheri','Hardin',85),
(2,'Marie','Terrell',90),
(10,'Rayford','Villa',84),
(50,'Chandra','Hodge',4),
(47,'Otis','Ortega',13),
(35,'Leona','Spears',40),
(49,'Edward','Ballard',88),
(36,'Dorsey','Duke',12),
(36,'Dorsey','Duke',21),
(42,'Theodore','Clay',70),
(48,'Beatriz','Harper',75),
(19,'Edith','Keith',78),
(4,'Sean','Hooper',114),
(18,'Connie','Dunlap',93),
(26,'Tameka','Bright',74),
(34,'Marina','Oconnell',77),
(29,'Tammie','Proctor',80),
(46,'Louise','Robbins',109),
(38,'Carlene','Benitez',82),
(10,'Rayford','Villa',110),
(31,'Raphael','Parrish',38),
(31,'Raphael','Parrish',62),
(13,'Nadine','Mcguire',80),
(32,'Miquel','Logan',93),
(9,'Lionel','Hughes',1),
(10,'Rayford','Villa',38),
(38,'Carlene','Benitez',17),
(29,'Tammie','Proctor',70),
(5,'Annmarie','House',87),
(35,'Leona','Spears',55),
(1,'Emilio','Sutton',78),
(20,'Donovan','Edwards',12),
(19,'Edith','Keith',56),
(46,'Louise','Robbins',13),
(42,'Theodore','Clay',27),
(34,'Marina','Oconnell',52),
(50,'Chandra','Hodge',59),
(46,'Louise','Robbins',50),
(7,'Jermaine','Sherman',92),
(24,'Ezequiel','Hall',21),
(11,'Jesus','Osborn',87),
(32,'Miquel','Logan',43),
(19,'Edith','Keith',2),
(42,'Theodore','Clay',108),
(10,'Rayford','Villa',61),
(8,'Isabelle','Ingram',1),
(30,'Williams','Berg',21),
(28,'Alma','Burke',79),
(49,'Edward','Ballard',101),
(2,'Marie','Terrell',56),
(27,'Manuela','Morrow',56),
(13,'Nadine','Mcguire',12),
(19,'Edith','Keith',104),
(20,'Donovan','Edwards',84),
(24,'Ezequiel','Hall',81),
(6,'Adrian','Petersen',84),
(46,'Louise','Robbins',3),
(18,'Connie','Dunlap',27),
(25,'Bethany','Conrad',42),
(20,'Donovan','Edwards',110),
(40,'Loretta','Peterson',102),
(19,'Edith','Keith',79),
(41,'Jose','Goodman',17),
(31,'Raphael','Parrish',79),
(1,'Emilio','Sutton',48),
(22,'Charley','Daugherty',40),
(25,'Bethany','Conrad',49),
(34,'Marina','Oconnell',97),
(25,'Bethany','Conrad',89),
(10,'Rayford','Villa',44),
(41,'Jose','Goodman',81),
(25,'Bethany','Conrad',94),
(28,'Alma','Burke',6),
(21,'Ignacio','Reeves',91),
(10,'Rayford','Villa',26),
(8,'Isabelle','Ingram',46),
(34,'Marina','Oconnell',1),
(13,'Nadine','Mcguire',83),
(24,'Ezequiel','Hall',69),
(43,'Aisha','Sampson',108),
(11,'Jesus','Osborn',81),
(38,'Carlene','Benitez',113),
(9,'Lionel','Hughes',26),
(2,'Marie','Terrell',27),
(25,'Bethany','Conrad',6),
(21,'Ignacio','Reeves',105),
(6,'Adrian','Petersen',42),
(1,'Emilio','Sutton',71),
(3,'Marci','Crawford',57),
(35,'Leona','Spears',7),
(20,'Donovan','Edwards',100),
(33,'Emmanuel','Marks',34),
(37,'Terrell','Mays',75),
(42,'Theodore','Clay',87),
(35,'Leona','Spears',73),
(44,'Kirby','Massey',10),
(47,'Otis','Ortega',59),
(15,'Angie','Lloyd',18),
(37,'Terrell','Mays',100),
(39,'Patricia','Garrison',39),
(39,'Patricia','Garrison',3),
(12,'Clair','Bender',48),
(30,'Williams','Berg',4),
(19,'Edith','Keith',21),
(49,'Edward','Ballard',95),
(18,'Connie','Dunlap',14),
(8,'Isabelle','Ingram',19),
(22,'Charley','Daugherty',38),
(43,'Aisha','Sampson',13),
(1,'Emilio','Sutton',28),
(29,'Tammie','Proctor',101),
(32,'Miquel','Logan',17),
(33,'Emmanuel','Marks',66),
(22,'Charley','Daugherty',80),
(49,'Edward','Ballard',64),
(8,'Isabelle','Ingram',36),
(5,'Annmarie','House',104),
(19,'Edith','Keith',107),
(46,'Louise','Robbins',109),
(50,'Chandra','Hodge',53),
(16,'Alexander','Stanton',94),
(45,'Moses','Bailey',23),
(47,'Otis','Ortega',89),
(29,'Tammie','Proctor',6),
(3,'Marci','Crawford',35),
(27,'Manuela','Morrow',21),
(37,'Terrell','Mays',53),
(12,'Clair','Bender',55),
(47,'Otis','Ortega',109),
(11,'Jesus','Osborn',18),
(6,'Adrian','Petersen',109),
(33,'Emmanuel','Marks',31),
(9,'Lionel','Hughes',67),
(21,'Ignacio','Reeves',61),
(16,'Alexander','Stanton',16),
(24,'Ezequiel','Hall',68),
(40,'Loretta','Peterson',38),
(5,'Annmarie','House',26),
(13,'Nadine','Mcguire',89),
(48,'Beatriz','Harper',50),
(28,'Alma','Burke',87),
(50,'Chandra','Hodge',25),
(14,'Adriana','Coffey',71),
(29,'Tammie','Proctor',41),
(49,'Edward','Ballard',15),
(8,'Isabelle','Ingram',19),
(6,'Adrian','Petersen',38),
(39,'Patricia','Garrison',32),
(14,'Adriana','Coffey',1),
(5,'Annmarie','House',97),
(46,'Louise','Robbins',30),
(50,'Chandra','Hodge',16),
(34,'Marina','Oconnell',89),
(20,'Donovan','Edwards',103),
(26,'Tameka','Bright',3),
(31,'Raphael','Parrish',16),
(41,'Jose','Goodman',54),
(49,'Edward','Ballard',66),
(29,'Tammie','Proctor',40),
(39,'Patricia','Garrison',66),
(3,'Marci','Crawford',3),
(2,'Marie','Terrell',87),
(46,'Louise','Robbins',50),
(27,'Manuela','Morrow',65),
(12,'Clair','Bender',1),
(26,'Tameka','Bright',50),
(40,'Loretta','Peterson',14),
(40,'Loretta','Peterson',3),
(28,'Alma','Burke',113),
(41,'Jose','Goodman',30),
(5,'Annmarie','House',89),
(42,'Theodore','Clay',79),
(4,'Sean','Hooper',41),
(39,'Patricia','Garrison',72),
(7,'Jermaine','Sherman',2),
(16,'Alexander','Stanton',12),
(37,'Terrell','Mays',72),
(45,'Moses','Bailey',70),
(46,'Louise','Robbins',71),
(49,'Edward','Ballard',4),
(10,'Rayford','Villa',24),
(34,'Marina','Oconnell',27),
(9,'Lionel','Hughes',28),
(37,'Terrell','Mays',31),
(32,'Miquel','Logan',21),
(41,'Jose','Goodman',96),
(46,'Louise','Robbins',74),
(41,'Jose','Goodman',112),
(6,'Adrian','Petersen',75),
(32,'Miquel','Logan',113),
(8,'Isabelle','Ingram',61),
(34,'Marina','Oconnell',109),
(45,'Moses','Bailey',105),
(48,'Beatriz','Harper',55),
(44,'Kirby','Massey',112),
(16,'Alexander','Stanton',51),
(27,'Manuela','Morrow',8),
(17,'Roy','Simpson',25),
(4,'Sean','Hooper',51),
(7,'Jermaine','Sherman',9),
(45,'Moses','Bailey',113), 
(17,'Roy','Simpson',45),
(49,'Edward','Ballard',106),
(7,'Jermaine','Sherman',67),
(25,'Bethany','Conrad',45),
(11,'Jesus','Osborn',52),
(44,'Kirby','Massey',99),
(22,'Charley','Daugherty',66),
(40,'Loretta','Peterson',91),
(22,'Charley','Daugherty',103),
(16,'Alexander','Stanton',17),
(31,'Raphael','Parrish',50),
(44,'Kirby','Massey',115),
(3,'Marci','Crawford',103),
(37,'Terrell','Mays',20),
(24,'Ezequiel','Hall',75),
(33,'Emmanuel','Marks',20),
(50,'Chandra','Hodge',92),
(33,'Emmanuel','Marks',32),
(25,'Bethany','Conrad',112),
(30,'Williams','Berg',95),
(27,'Manuela','Morrow',21),
(9,'Lionel','Hughes',4),
(31,'Raphael','Parrish',72),
(43,'Aisha','Sampson',68),
(48,'Beatriz','Harper',56),
(31,'Raphael','Parrish',3),
(2,'Marie','Terrell',61),
(8,'Isabelle','Ingram',25),
(32,'Miquel','Logan',95),
(33,'Emmanuel','Marks',77),
(22,'Charley','Daugherty',8),
(26,'Tameka','Bright',94),
(2,'Marie','Terrell',30),
(1,'Emilio','Sutton',32),
(28,'Alma','Burke',23),
(23,'Sheri','Hardin',14),
(19,'Edith','Keith',83),
(35,'Leona','Spears',69),
(6,'Adrian','Petersen',53),
(25,'Bethany','Conrad',70),
(43,'Aisha','Sampson',10),
(33,'Emmanuel','Marks',27),
(7,'Jermaine','Sherman',46),
(6,'Adrian','Petersen',112),
(28,'Alma','Burke',61),
(19,'Edith','Keith',18),
(5,'Annmarie','House',89),
(25,'Bethany','Conrad',56),
(48,'Beatriz','Harper',63),
(40,'Loretta','Peterson',110),
(16,'Alexander','Stanton',33),
(17,'Roy','Simpson',110),
(11,'Jesus','Osborn',102),
(10,'Rayford','Villa',15),
(4,'Sean','Hooper',13),
(38,'Carlene','Benitez',13),
(30,'Williams','Berg',82),
(13,'Nadine','Mcguire',91),
(12,'Clair','Bender',79),
(6,'Adrian','Petersen',114),
(14,'Adriana','Coffey',87),
(21,'Ignacio','Reeves',75),
(15,'Angie','Lloyd',75),
(17,'Roy','Simpson',13),
(30,'Williams','Berg',88),
(42,'Theodore','Clay',26),
(30,'Williams','Berg',62),
(36,'Dorsey','Duke',41),
(27,'Manuela','Morrow',74),
(44,'Kirby','Massey',22),
(30,'Williams','Berg',34),
(19,'Edith','Keith',43),
(27,'Manuela','Morrow',51),
(36,'Dorsey','Duke',91),
(34,'Marina','Oconnell',3),
(22,'Charley','Daugherty',34),
(32,'Miquel','Logan',25),
(7,'Jermaine','Sherman',49),
(34,'Marina','Oconnell',38),
(14,'Adriana','Coffey',24),
(10,'Rayford','Villa',15),
(24,'Ezequiel','Hall',72),
(39,'Patricia','Garrison',112),
(23,'Sheri','Hardin',78),
(48,'Beatriz','Harper',45),
(4,'Sean','Hooper',30),
(2,'Marie','Terrell',76),
(20,'Donovan','Edwards',62),
(35,'Leona','Spears',101),
(38,'Carlene','Benitez',69),
(8,'Isabelle','Ingram',56),
(3,'Marci','Crawford',59),
(32,'Miquel','Logan',70),
(16,'Alexander','Stanton',98),
(19,'Edith','Keith',107),
(46,'Louise','Robbins',55),
(22,'Charley','Daugherty',112),
(16,'Alexander','Stanton',43),
(50,'Chandra','Hodge',71),
(27,'Manuela','Morrow',9),
(15,'Angie','Lloyd',107),
(33,'Emmanuel','Marks',32),
(4,'Sean','Hooper',26),
(16,'Alexander','Stanton',42),
(45,'Moses','Bailey',17),
(10,'Rayford','Villa',106),
(25,'Bethany','Conrad',100),
(44,'Kirby','Massey',59),
(18,'Connie','Dunlap',70),
(48,'Beatriz','Harper',47),
(10,'Rayford','Villa',7),
(30,'Williams','Berg',24),
(28,'Alma','Burke',1),
(48,'Beatriz','Harper',47),
(25,'Bethany','Conrad',12),
(39,'Patricia','Garrison',61),
(22,'Charley','Daugherty',58),
(17,'Roy','Simpson',84),
(47,'Otis','Ortega',99),
(4,'Sean','Hooper',63),
(43,'Aisha','Sampson',72),
(24,'Ezequiel','Hall',74),
(6,'Adrian','Petersen',112),
(5,'Annmarie','House',63),
(8,'Isabelle','Ingram',10),
(38,'Carlene','Benitez',31),
(42,'Theodore','Clay',100),
(27,'Manuela','Morrow',21),
(44,'Kirby','Massey',53),
(8,'Isabelle','Ingram',90),
(10,'Rayford','Villa',11),
(36,'Dorsey','Duke',29),
(7,'Jermaine','Sherman',17),
(10,'Rayford','Villa',66),
(24,'Ezequiel','Hall',107),
(10,'Rayford','Villa',35),
(29,'Tammie','Proctor',107),
(30,'Williams','Berg',51),
(35,'Leona','Spears',26),
(7,'Jermaine','Sherman',14),
(23,'Sheri','Hardin',58),
(41,'Jose','Goodman',46),
(47,'Otis','Ortega',9),
(36,'Dorsey','Duke',72),
(25,'Bethany','Conrad',20),
(6,'Adrian','Petersen',20),
(13,'Nadine','Mcguire',2),
(12,'Clair','Bender',107),
(24,'Ezequiel','Hall',105),
(23,'Sheri','Hardin',34),
(21,'Ignacio','Reeves',16),
(48,'Beatriz','Harper',79),
(6,'Adrian','Petersen',37),
(29,'Tammie','Proctor',81),
(27,'Manuela','Morrow',62),
(1,'Emilio','Sutton',37),
(25,'Bethany','Conrad',25),
(13,'Nadine','Mcguire',105),
(13,'Nadine','Mcguire',82),
(27,'Manuela','Morrow',38),
(15,'Angie','Lloyd',96),
(15,'Angie','Lloyd',10),
(20,'Donovan','Edwards',23),
(31,'Raphael','Parrish',92),
(35,'Leona','Spears',29),
(25,'Bethany','Conrad',95),
(25,'Bethany','Conrad',20),
(9,'Lionel','Hughes',114),
(32,'Miquel','Logan',10),
(28,'Alma','Burke',46),
(38,'Carlene','Benitez',59),
(12,'Clair','Bender',18),
(33,'Emmanuel','Marks',68),
(47,'Otis','Ortega',106),
(5,'Annmarie','House',88),
(25,'Bethany','Conrad',84),
(37,'Terrell','Mays',46),
(32,'Miquel','Logan',90),
(5,'Annmarie','House',95),
(42,'Theodore','Clay',84),
(9,'Lionel','Hughes',51),
(15,'Angie','Lloyd',43),
(36,'Dorsey','Duke',73),
(44,'Kirby','Massey',75),
(32,'Miquel','Logan',100),
(20,'Donovan','Edwards',53),
(40,'Loretta','Peterson',50),
(16,'Alexander','Stanton',5),
(29,'Tammie','Proctor',16),
(1,'Emilio','Sutton',69),
(25,'Bethany','Conrad',2),
(29,'Tammie','Proctor',42),
(38,'Carlene','Benitez',99),
(32,'Miquel','Logan',12),
(34,'Marina','Oconnell',63),
(36,'Dorsey','Duke',99),
(19,'Edith','Keith',23),
(37,'Terrell','Mays',44),
(45,'Moses','Bailey',93),
(20,'Donovan','Edwards',23),
(49,'Edward','Ballard',104),
(30,'Williams','Berg',50),
(17,'Roy','Simpson',9),
(27,'Manuela','Morrow',3),
(48,'Beatriz','Harper',9),
(26,'Tameka','Bright',38),
(14,'Adriana','Coffey',23),
(50,'Chandra','Hodge',78),
(46,'Louise','Robbins',75),
(14,'Adriana','Coffey',29),
(9,'Lionel','Hughes',6),
(17,'Roy','Simpson',108),
(25,'Bethany','Conrad',60),
(17,'Roy','Simpson',52),
(14,'Adriana','Coffey',87),
(20,'Donovan','Edwards',103),
(7,'Jermaine','Sherman',23),
(33,'Emmanuel','Marks',27),
(34,'Marina','Oconnell',54),
(47,'Otis','Ortega',9),
(37,'Terrell','Mays',38),
(10,'Rayford','Villa',9),
(8,'Isabelle','Ingram',13),
(10,'Rayford','Villa',82),
(49,'Edward','Ballard',42),
(16,'Alexander','Stanton',77),
(16,'Alexander','Stanton',40),
(36,'Dorsey','Duke',112),
(45,'Moses','Bailey',27),
(15,'Angie','Lloyd',31),
(15,'Angie','Lloyd',68),
(17,'Roy','Simpson',81),
(22,'Charley','Daugherty',71),
(47,'Otis','Ortega',12),
(36,'Dorsey','Duke',32),
(8,'Isabelle','Ingram',11),
(30,'Williams','Berg',100),
(9,'Lionel','Hughes',3),
(5,'Annmarie','House',12),
(24,'Ezequiel','Hall',109),
(28,'Alma','Burke',71),
(24,'Ezequiel','Hall',82),
(32,'Miquel','Logan',3),
(3,'Marci','Crawford',26),
(21,'Ignacio','Reeves',17),
(16,'Alexander','Stanton',7),
(16,'Alexander','Stanton',50),
(11,'Jesus','Osborn',81),
(23,'Sheri','Hardin',54),
(46,'Louise','Robbins',14),
(1,'Emilio','Sutton',21),
(6,'Adrian','Petersen',37),
(1,'Emilio','Sutton',25),
(46,'Louise','Robbins',114),
(50,'Chandra','Hodge',89),
(40,'Loretta','Peterson',50),
(24,'Ezequiel','Hall',96),
(50,'Chandra','Hodge',92),
(14,'Adriana','Coffey',115),
(44,'Kirby','Massey',7),
(25,'Bethany','Conrad',1),
(26,'Tameka','Bright',51),
(9,'Lionel','Hughes',52),
(7,'Jermaine','Sherman',92),
(36,'Dorsey','Duke',9),
(2,'Marie','Terrell',27),
(16,'Alexander','Stanton',103),
(38,'Carlene','Benitez',60),
(20,'Donovan','Edwards',39),
(5,'Annmarie','House',66),
(16,'Alexander','Stanton',110),
(21,'Ignacio','Reeves',25),
(11,'Jesus','Osborn',110),
(34,'Marina','Oconnell',95),
(27,'Manuela','Morrow',98),
(41,'Jose','Goodman',85),
(8,'Isabelle','Ingram',45),
(20,'Donovan','Edwards',107),
(2,'Marie','Terrell',60),
(36,'Dorsey','Duke',71),
(20,'Donovan','Edwards',41),
(19,'Edith','Keith',52),
(37,'Terrell','Mays',30),
(29,'Tammie','Proctor',46),
(31,'Raphael','Parrish',25),
(32,'Miquel','Logan',63),
(21,'Ignacio','Reeves',50),
(40,'Loretta','Peterson',14),
(37,'Terrell','Mays',15),
(16,'Alexander','Stanton',107),
(11,'Jesus','Osborn',6),
(21,'Ignacio','Reeves',13),
(17,'Roy','Simpson',25),
(19,'Edith','Keith',96),
(43,'Aisha','Sampson',78),
(49,'Edward','Ballard',96),
(8,'Isabelle','Ingram',52),
(32,'Miquel','Logan',22),
(47,'Otis','Ortega',72),
(23,'Sheri','Hardin',64), 
	(15,'Angie','Lloyd',73),
	(12,'Clair','Bender',79),
	(47,'Otis','Ortega',54),
	(19,'Edith','Keith',83),
	(23,'Sheri','Hardin',98),
	(41,'Jose','Goodman',9),
	(21,'Ignacio','Reeves',26),
	(34,'Marina','Oconnell',33),
	(38,'Carlene','Benitez',38),
	(3,'Marci','Crawford',37),
	(32,'Miquel','Logan',112),
	(39,'Patricia','Garrison',93),
	(10,'Rayford','Villa',13),
	(21,'Ignacio','Reeves',59),
	(6,'Adrian','Petersen',110),
	(16,'Alexander','Stanton',13),
	(30,'Williams','Berg',15),
	(43,'Aisha','Sampson',98),
	(28,'Alma','Burke',61),
	(31,'Raphael','Parrish',29),
	(19,'Edith','Keith',93),
	(31,'Raphael','Parrish',106),
	(3,'Marci','Crawford',93),
	(16,'Alexander','Stanton',66),
	(29,'Tammie','Proctor',53),
	(27,'Manuela','Morrow',4),
	(22,'Charley','Daugherty',57),
	(32,'Miquel','Logan',106),
	(24,'Ezequiel','Hall',9),
	(18,'Connie','Dunlap',32),
	(37,'Terrell','Mays',8),
	(12,'Clair','Bender',10),
	(30,'Williams','Berg',37),
	(17,'Roy','Simpson',40),
	(14,'Adriana','Coffey',44),
	(23,'Sheri','Hardin',49),
	(28,'Alma','Burke',90),
	(39,'Patricia','Garrison',107),
	(28,'Alma','Burke',11),
	(29,'Tammie','Proctor',112),
	(5,'Annmarie','House',23),
	(40,'Loretta','Peterson',75),
	(21,'Ignacio','Reeves',110),
	(30,'Williams','Berg',32),
	(35,'Leona','Spears',21),
	(41,'Jose','Goodman',60),
	(8,'Isabelle','Ingram',81),
	(31,'Raphael','Parrish',50),
	(32,'Miquel','Logan',110),
	(50,'Chandra','Hodge',19),
	(20,'Donovan','Edwards',38),
	(26,'Tameka','Bright',53),
	(23,'Sheri','Hardin',50),
	(32,'Miquel','Logan',92),
	(19,'Edith','Keith',104),
	(21,'Ignacio','Reeves',84),
	(21,'Ignacio','Reeves',45),
	(16,'Alexander','Stanton',102),
	(47,'Otis','Ortega',18),
	(18,'Connie','Dunlap',60),
	(7,'Jermaine','Sherman',55),
	(42,'Theodore','Clay',98),
	(23,'Sheri','Hardin',3),
	(16,'Alexander','Stanton',87),
	(42,'Theodore','Clay',51),
	(48,'Beatriz','Harper',25),
	(35,'Leona','Spears',33),
	(1,'Emilio','Sutton',59),
	(27,'Manuela','Morrow',83),
	(1,'Emilio','Sutton',45),
	(44,'Kirby','Massey',62),
	(41,'Jose','Goodman',113),
	(41,'Jose','Goodman',64),
	(13,'Nadine','Mcguire',115),
	(2,'Marie','Terrell',62),
	(38,'Carlene','Benitez',106),
	(33,'Emmanuel','Marks',107),
	(24,'Ezequiel','Hall',100),
	(26,'Tameka','Bright',49),
	(25,'Bethany','Conrad',94),
	(29,'Tammie','Proctor',15),
	(4,'Sean','Hooper',47),
	(30,'Williams','Berg',102),
	(27,'Manuela','Morrow',50),
	(45,'Moses','Bailey',20),
	(19,'Edith','Keith',75),
	(23,'Sheri','Hardin',107),
	(43,'Aisha','Sampson',108),
	(48,'Beatriz','Harper',70),
	(13,'Nadine','Mcguire',12),
	(4,'Sean','Hooper',15),
	(19,'Edith','Keith',97),
	(50,'Chandra','Hodge',44),
	(46,'Louise','Robbins',6),
	(28,'Alma','Burke',70),
	(42,'Theodore','Clay',62),
	(14,'Adriana','Coffey',19),
	(44,'Kirby','Massey',89),
	(47,'Otis','Ortega',19),
	(10,'Rayford','Villa',101),
	(1,'Emilio','Sutton',17),
	(29,'Tammie','Proctor',84),
	(4,'Sean','Hooper',23),
	(14,'Adriana','Coffey',30),
	(30,'Williams','Berg',30),
	(39,'Patricia','Garrison',89),
	(40,'Loretta','Peterson',7),
	(34,'Marina','Oconnell',44),
	(26,'Tameka','Bright',69),
	(12,'Clair','Bender',94),
	(39,'Patricia','Garrison',61),
	(12,'Clair','Bender',96),
	(48,'Beatriz','Harper',74),
	(12,'Clair','Bender',104),
	(16,'Alexander','Stanton',101),
	(10,'Rayford','Villa',108),
	(22,'Charley','Daugherty',91),
	(23,'Sheri','Hardin',68),
	(13,'Nadine','Mcguire',79),
	(44,'Kirby','Massey',97),
	(22,'Charley','Daugherty',43),
	(13,'Nadine','Mcguire',33),
	(26,'Tameka','Bright',15),
	(23,'Sheri','Hardin',44),
	(32,'Miquel','Logan',79),
	(34,'Marina','Oconnell',28),
	(24,'Ezequiel','Hall',80),
	(19,'Edith','Keith',109),
	(42,'Theodore','Clay',1),
	(10,'Rayford','Villa',53),
	(17,'Roy','Simpson',90),
	(19,'Edith','Keith',62),
	(3,'Marci','Crawford',47),
	(22,'Charley','Daugherty',94),
	(2,'Marie','Terrell',98),
	(50,'Chandra','Hodge',102),
	(18,'Connie','Dunlap',84),
	(11,'Jesus','Osborn',17),
	(3,'Marci','Crawford',79),
	(19,'Edith','Keith',101),
	(39,'Patricia','Garrison',22),
	(13,'Nadine','Mcguire',96),
	(25,'Bethany','Conrad',37),
	(37,'Terrell','Mays',13),
	(31,'Raphael','Parrish',67),
	(42,'Theodore','Clay',33),
	(36,'Dorsey','Duke',9),
	(5,'Annmarie','House',51),
	(6,'Adrian','Petersen',26),
	(46,'Louise','Robbins',78),
	(19,'Edith','Keith',26),
	(20,'Donovan','Edwards',18),
	(36,'Dorsey','Duke',10),
	(41,'Jose','Goodman',50),
	(47,'Otis','Ortega',1),
	(32,'Miquel','Logan',70),
	(34,'Marina','Oconnell',12),
	(50,'Chandra','Hodge',95),
	(32,'Miquel','Logan',73),
	(10,'Rayford','Villa',71),
	(10,'Rayford','Villa',61),
	(5,'Annmarie','House',60),
	(2,'Marie','Terrell',114),
	(14,'Adriana','Coffey',8),
	(8,'Isabelle','Ingram',96),
	(9,'Lionel','Hughes',88),
	(8,'Isabelle','Ingram',66),
	(32,'Miquel','Logan',55),
	(33,'Emmanuel','Marks',8),
	(41,'Jose','Goodman',57),
	(29,'Tammie','Proctor',60),
	(37,'Terrell','Mays',9),
	(17,'Roy','Simpson',57),
	(12,'Clair','Bender',2),
	(10,'Rayford','Villa',30),
	(31,'Raphael','Parrish',43),
	(24,'Ezequiel','Hall',69),
	(31,'Raphael','Parrish',23),
	(35,'Leona','Spears',100),
	(49,'Edward','Ballard',10),
	(43,'Aisha','Sampson',83),
	(3,'Marci','Crawford',25),
	(12,'Clair','Bender',30),
	(42,'Theodore','Clay',22),
	(30,'Williams','Berg',50),
	(40,'Loretta','Peterson',71),
	(28,'Alma','Burke',15),
	(22,'Charley','Daugherty',97),
	(8,'Isabelle','Ingram',50),
	(3,'Marci','Crawford',81),
	(37,'Terrell','Mays',5),
	(22,'Charley','Daugherty',56),
	(16,'Alexander','Stanton',25),
	(22,'Charley','Daugherty',79),
	(1,'Emilio','Sutton',90),
	(31,'Raphael','Parrish',100)

	
-- Task 4: Implement Data Modification
	-- Description: Create SQL scripts for updating, deleting, and modifying data as needed.
	-- Updating the books by removing excess data
UPDATE
	Books
SET 
	Title = 'Dream of the Red Chamber'
WHERE 
	BookID = 5
	
UPDATE 
	Books
SET 
	Title = 'Vardi Wala Gunda'
WHERE 
	BookID = 9
	
UPDATE 
	Books
SET 
	Title = 'How the Steel Was Tempered'
WHERE 
	BookID = 44
	
UPDATE 
	Books
SET 
	Title = 'War and Peace'
WHERE 
	BookID = 45
	
UPDATE 
	Books
SET 
	Title = 'The Young Guard'
WHERE 
	BookID = 64
	
UPDATE
	Books
SET
	Title = 'Virgin Soil Upturned'
WHERE
	BookID = 71
	
UPDATE
	Books
SET 
	Title = 'Uncle Styopa'
WHERE 
	BookID = 76
	
UPDATE 
	Books
SET 
	Title = 'Kitchen'
WHERE 
	BookID = 81
	
UPDATE 
	Books
SET 
	Title = 'Andromeda Nebula'
WHERE 
	BookID = 82
	
UPDATE
	Books
SET
	Title = 'Autobiography of a Yogi'
WHERE
	BookID = 83
	
UPDATE
	Books
SET
	Title = 'Wolf Totem'
WHERE 
	BookID = 88
	
UPDATE 
	Books
SET 
	Title = 'Wolf Totem'
WHERE
	BookID = 89
	
UPDATE
	Books
SET 
	Title = 'Totto-chan, the Little Girl at the Window'
WHERE 
	BookID = 107
	
UPDATE 
	Books
SET 
	Title = 'Totto-chan, the Little Girl at the Window'
WHERE 
	BookID = 108

	
-- Phase 3: Data Retrieval (DQL)
	-- Task 5: Create SQL Queries for Common Tasks
	-- Description: Develop SQL queries to perform common library-related tasks, such as searching for books by title, author, or genre.
	
-- Display the title and author of the book
SELECT 
	Title,
	Author
FROM
	Books
	
-- Find the details of books that BookID = 100
SELECT
	*
FROM 
	Books
WHERE 
	BookID = 100
	
-- Find the books that are published year 2000 onwards
SELECT 
	*
FROM 
	Books
WHERE 
	DatePublished >= '2000'
	
-- Find the books that are published before year 2000
SELECT 
	*
FROM 
	Books
WHERE 
	DatePublished <= '2000'
	
-- Find the total count of books.
SELECT 
	COUNT(Title) AS [Total Books]
FROM 
	ooks
	
-- Rank the students based on their borrowed books.
SELECT 
	distinct(StudentID), 
	FirstName, LastName, 
	COUNT(*) AS [Total Borrowed Books]
FROM 
	Borrowers
GROUP BY 
	StudentID, FirstName, LastName
ORDER BY 
	[Total Borrowed Books] DESC
	
-- Find the books that the language is Chinese and Portuguese
SELECT 
	*
FROM 
	Books
WHERE 
	Language = 'Chinese' OR Language = 'Portuguese'
	
-- Find the book where the author is J. K. Rowling that published year 2000 onwards
SELECT 
	*
FROM 
	Books
WHERE 
	Author LIKE '%owling' and DatePublished >= '2000'
	
-- Task 6: Implement Advanced Queries
	-- Description: Construct more advanced SQL queries for generating reports on borrowed books, overdue books, and popular book genres.
	
-- Find The Genre Of each title
SELECT 
	B.Title,
	G.Genre
FROM 
	Books AS B
JOIN 
	Genre AS G
ON 
	B.GenreID = G.GenreID
	
-- Find the top 50 Students that borrowed books Together with the genre of the books
SELECT 
	TOP 50 BW.StudentID, 
	BW.FirstName, 
	BW.LastName, 
	B.Title, 
	G.Genre
FROM 
	Books AS B
JOIN 
	Genre AS G
ON 
	B.GenreID = G.GenreID
JOIN 
	Borrowers AS BW
ON 
	B.BookID = BW.BookID
	
-- What is the TOP 10 most borrowed books based on their genre?
SELECT 
	TOP 10 G.Genre, 
	COUNT(BW.StudentID) AS Most_Borrowed_Books_By_Genre
FROM 
	Borrowers AS BW
LEFT JOIN 
	Books AS BK
ON 
	BW.BookID = BK.BookID
LEFT JOIN 
	Genre AS G
ON 
	BK.GenreID = G.GenreID
GROUP BY 
	G.Genre
ORDER BY 
	COUNT(BW.StudentID) DESC
	
-- count the students based on their age
SELECT 
	DATEDIFF(year,DateOfBirth, 
	GETDATE()) AS Age ,
	COUNT(*) AS Students
FROM 
	StudentsInfo
GROUP BY 
	DATEDIFF(year,DateOfBirth, GETDATE())

-- What are the most popular books that borrowed by the students
SELECT 
	Title, 
	Author, 
	COUNT(BR.BookID) AS Total_Borrowed_Books
FROM 
	Borrowers AS BR
JOIN
	Books AS BK
ON 
	BR.BookID = BK.BookID
GROUP BY
	Title, Author, BR.BookID
ORDER BY 
	COUNT(BR.BookID) DESC
	
-- Phase 4: Access Control (DCL)
-- Task 7: Define User Roles and Permissions
-- Description: Define user roles (e.g., librarian, member) and set appropriate permissions.
USE Library
CREATE ROLE librarian;

CREATE ROLE Adviser;

-- Task 8: Implement Access Control Statements
-- Description: Implement DCL statements to control access to the database based on user roles and permissions.
GRANT SELECT ON Books TO librarian

GRANT UPDATE ON StudentsInfo TO Adviser
	
-- Task 9: Simulate User Interactions
-- Description: Simulate user interactions with the system, demonstrating how access control works based on user roles.
USE master
CREATE LOGIN UserLibrarian WITH PASSWORD = 'UserLibrarian'
	
USE Library
CREATE USER Librarian1 FOR LOGIN UserLibrarian
EXEC sp_addrolemember 'Librarian','Librarian1'
	
USE MASTER
CREATE LOGIN UserAdviser WITH PASSWORD = 'UserAdviser'
	
USE Library
CREATE USER Adviser1 FOR LOGIN UserAdviser
EXEC sp_addrolemember Adviser,Adviser1

	
--Phase 5: User Interface (Optional)
-- Task 10: Create a Power BI Report
-- Description: (Optional) Develop a Power BI dashboard to interact with the SQL Server database. Enhance the project's practicality.
-- Phase 6: Documentation and Presentation
-- Task 11: Prepare Documentation
-- Description: Document the entire project, including a project report, schema diagrams, SQL scripts, and explanations of DML, DDL, DQL, and DCL operations.
-- Entity Relationship Diagram
	
--DML(Data Manipulation Language) – DML commands are used to manipulate the data, example of DML command is SELECT, INSERT, UPDATE and DELETE.
--DDL(Data Definition Language) – DDL Commands are used to alter, edit and managing the attributes of the tables, example of DDL commands is CREATE, ALTER and DROP.
--DQL(Data Query Language) – DQL Commands are used to retrieve data from the database, example of DQL Commands is SELECT.
DCL(Data Control Language) – DCL Commands are used to control the access of the database, example of DCL commands is GRANT and REVOKE
-- Task 12: Present the Project
-- Description: Present the project to the class, highlighting the different SQL Server features and operations learned during the project's development.
