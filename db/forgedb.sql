-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2018 at 12:25 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `forgedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `assigns`
--

CREATE TABLE `assigns` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `assigns`
--

INSERT INTO `assigns` (`id`, `content`, `created_by`, `created_at`, `updated_at`, `status`) VALUES
(1, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":8,\"status\":\"2\"}]]}', 3, 1522508115, 1522597627, 3);

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `citation` text NOT NULL,
  `tags` text NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `citation`, `tags`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Author Name. (1999). Some title of book or article about Android Development.', '', 0, 0, 1),
(2, 'Author\'s Name. (2001). Some book about JavaScript.', '[\"JavaScript\",\"Programming\",\"Web Development\",\"VueJS\"]', 0, 1522315528, 1),
(3, 'Zak, Diane (2011) An Introduction to Programming with C++. 6th ed.  Australia: Course Technology', '', 0, 0, 1),
(4, 'McGrath, Mike (2012) C++ Programming in Easy Steps.  4th ed.  Warwickshire, United Kingdom: Easy Steps Limited', '', 0, 0, 1),
(5, 'Gaddis, Tony (2007) Starting out with C++. Pearson Publishing.	', '', 0, 1521736538, 1),
(6, 'Gregoire, Marc, et. al. (2011) Professional C++. 2nd ed.  Indianapolis, Indiana: Wiley', '', 0, 0, 1),
(7, 'Deitel, Paul J. (2009) C++ for programmers. Prentice Hall.', '', 0, 0, 1),
(8, 'D. S. Malik (2008) C++ programming. Thomson Course Technology.', '', 0, 0, 1),
(9, 'Deitel, Paul J. (2008) C++ how to program. Pearson Publishing.', '', 0, 0, 1),
(10, 'Josuttis, Nicolai M. (2012) The C++ Standard Library: a tutorial and reference. 2nd ed.  Upper Saddle River, NJ. :  Addison-Wesley', '', 0, 0, 1),
(11, 'Mullins, C. (2013). Database Administration 2nd Edition, Addison-Wesley.', '', 0, 0, 1),
(12, 'Gillenson, M. (2012). Fundamentals of Database Management Systems 2nd Edition, John Wiley & Sons.', '', 0, 0, 1),
(13, 'Elmasri, R. (2011). Fundamentals of Database Systems 6th Edition, Addison-Wesley.', '', 0, 0, 1),
(14, 'Gill, P. (2011). Database Management Systems 2nd Edition, I.K. International Pub.', '', 0, 0, 1),
(15, 'Connoly, T. (2010). Database Systems: A practical Approach to Design, Implementation and Management 5th Edition, McGraw Hill International.', '', 0, 0, 1),
(16, 'Harrington, J. (2010). SQL Clearly Explained, Morgan Kaufmann.', '', 0, 0, 1),
(17, 'Kroenke, D. (2010). Database Concepts 4th Edition, Pearson.', '', 0, 0, 1),
(18, 'Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ', '', 0, 0, 1),
(19, 'Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press', '', 0, 0, 1),
(20, 'Puntambekar, A. (2014). Object oriented analysis & design: a conceptual approach. Technical Publication: New Delhi', '', 0, 0, 1),
(21, 'Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology', '', 0, 0, 1),
(22, 'Test1', '', 0, 0, 1),
(23, 'Test2', '', 0, 0, 0),
(24, 'Test3', '', 0, 0, 1),
(25, 'Test4', '', 0, 0, 1),
(26, 'Test5', '', 0, 0, 0),
(27, 'test', '[\"VBScript\",\"Programming\"]', 1522315610, 1522315748, 1);

-- --------------------------------------------------------

--
-- Table structure for table `book_field_relation`
--

CREATE TABLE `book_field_relation` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book_field_relation`
--

INSERT INTO `book_field_relation` (`id`, `book_id`, `field_id`, `status`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 1, 5, 1),
(5, 1, 12, 1),
(6, 2, 16, 1),
(7, 2, 2, 1),
(8, 2, 4, 1),
(9, 2, 3, 1),
(10, 3, 2, 1),
(11, 3, 20, 1),
(12, 3, 35, 1),
(13, 4, 2, 1),
(14, 4, 20, 1),
(15, 4, 35, 1),
(16, 5, 2, 1),
(17, 5, 20, 1),
(18, 5, 35, 1),
(19, 6, 2, 1),
(20, 6, 20, 1),
(21, 6, 35, 1),
(22, 7, 2, 1),
(23, 7, 20, 1),
(24, 7, 35, 1),
(25, 8, 2, 1),
(26, 8, 20, 1),
(27, 8, 35, 1),
(28, 9, 2, 1),
(29, 9, 20, 1),
(30, 9, 35, 1),
(31, 10, 2, 1),
(32, 10, 20, 1),
(33, 10, 35, 1),
(34, 11, 17, 1),
(35, 11, 25, 1),
(36, 11, 21, 1),
(37, 12, 17, 1),
(38, 12, 21, 1),
(39, 12, 19, 1),
(40, 11, 19, 1),
(41, 12, 33, 1),
(42, 12, 26, 1),
(43, 11, 33, 1),
(44, 11, 26, 1),
(45, 13, 17, 1),
(46, 13, 19, 1),
(47, 13, 21, 1),
(48, 13, 26, 1),
(49, 13, 33, 1),
(50, 14, 17, 1),
(51, 14, 19, 1),
(52, 14, 21, 1),
(53, 14, 26, 1),
(54, 14, 33, 1),
(55, 14, 25, 1),
(56, 13, 22, 1),
(57, 13, 23, 1),
(58, 13, 24, 1),
(59, 12, 22, 1),
(60, 12, 23, 1),
(61, 12, 24, 1),
(62, 14, 22, 1),
(63, 14, 23, 1),
(64, 14, 24, 1),
(65, 15, 17, 1),
(66, 15, 19, 1),
(67, 15, 21, 1),
(68, 15, 22, 1),
(69, 15, 23, 1),
(70, 15, 24, 1),
(71, 15, 25, 1),
(72, 15, 26, 1),
(73, 15, 33, 1),
(74, 16, 17, 1),
(75, 16, 19, 1),
(76, 16, 21, 1),
(77, 16, 22, 1),
(78, 16, 23, 1),
(79, 16, 24, 1),
(80, 16, 25, 1),
(81, 16, 26, 1),
(82, 16, 33, 1),
(83, 17, 17, 1),
(84, 17, 19, 1),
(85, 17, 21, 1),
(86, 17, 22, 1),
(87, 17, 23, 1),
(88, 17, 24, 1),
(89, 17, 25, 1),
(90, 17, 26, 1),
(91, 17, 33, 1),
(92, 11, 34, 1),
(93, 12, 34, 1),
(94, 13, 34, 1),
(95, 14, 34, 1),
(96, 15, 34, 1),
(97, 16, 34, 1),
(98, 17, 34, 1),
(99, 18, 13, 1),
(100, 18, 38, 1),
(101, 18, 39, 1),
(102, 19, 13, 1),
(103, 19, 15, 1),
(104, 19, 40, 1),
(105, 20, 13, 1),
(106, 20, 38, 1),
(107, 20, 39, 1),
(108, 21, 13, 1),
(109, 21, 29, 1),
(110, 21, 38, 1),
(111, 18, 29, 1),
(112, 19, 38, 1),
(113, 19, 39, 1),
(114, 19, 29, 1),
(115, 20, 29, 1),
(116, 21, 39, 1),
(117, 0, 0, 1),
(118, 0, 0, 1),
(119, 0, 0, 1),
(120, 0, 0, 1),
(121, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `assign_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `level` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `assign_id`, `comment`, `level`, `created_at`, `status`) VALUES
(1, 3, 1, 'test', 0, 1522595586, 1);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `code` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `objectives` text NOT NULL,
  `unitsLec` tinyint(4) NOT NULL,
  `unitsLab` tinyint(4) NOT NULL,
  `tags` text NOT NULL,
  `prerequisites` text NOT NULL,
  `corequisites` text NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `title`, `code`, `description`, `objectives`, `unitsLec`, `unitsLab`, `tags`, `prerequisites`, `corequisites`, `created_at`, `updated_at`, `status`) VALUES
(1, 'CAPSTONE PROJECT 1', 'ITWPROJ1', 'This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.', '', 3, 0, '[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\"]', '[\"6\"]', '[]', 0, 1522415141, 1),
(2, 'MOBILE APPLICATION DEVELOPMENT 2', 'ITWSPEC4', 'Some description about mobile application development in iOS.', '', 2, 1, '', '', '', 0, 0, 1),
(3, 'WEB APPLICATION DEVELOPMENT 2', 'ITWSPEC6', 'Some description about web application development using PHP frameworks.', '', 2, 1, '', '', '', 0, 0, 1),
(4, 'DATABASE MANAGEMENT SYSTEMS 1', 'ITEDBASE1', 'This course introduces the concept of databases and database management system. In this course, the students will  learn how to examine the database management in business for routine processing and management reporting, design databases using ERD, and use SQL statements to store, retrieve and manipulate data in the database. In addition, students will be introduced to basic data and database administration and installation of DBMS.', '<p>Upon successful completion of this course, the student will be able to:</p>\r\n<ul>\r\n  <li>To develop understanding of the context of Database Management including: (a) the Database environment and (b) the Database development process.</li>\r\n  <li>To build expertise in Database Analysis that includes: (a) Modeling data in the organization and (b) the Enhanced E-R Model and business rules.</li>\r\n  <li>To develop skills in Database Design including: (a) Logical Database design and (b) the Relational Model.</li>\r\n  <li>To develop and implement Databases and enhance skills in advanced database topics including: (a) SQL/ Advanced SQL, and (b) Data and Database Administration.</li>\r\n</ul>', 2, 1, '', '', '', 0, 0, 1),
(5, 'Introduction to Programming', 'ITPROG1', 'This course is an introduction to programming which will provide the students the skills in programming through the use of conventional techniques of flowcharting and pseudo-coding.', '<p>Upon successful completion of this course, the student will be able to:</p> <ul>   <li>Know the similarities and differences between C and C++</li>   <li>Translate logic formulation into algorithms and flowchart;</li>   <li>Create working C++ programs;</li>   <li>Test and debug C++ programs; and</li>   <li>Create simple programs for input and output operations</li>   <li>Use the visual studio IDE in running C++ programs.</li>   <li>Understand and apply different control structures of C++</li>   <li>Understand and apply the principles of data storage and array manipulation</li>   <li>Perform tests in programs by using the \"if\" and \"switch\" control flow branching statements and repeat code segments by including \"for, while,\" and \"do…while\" control flow loops</li>   <li>Use critical thinking skills to create and debug C programs.</li> </ul>', 2, 1, '', '', '', 0, 0, 1),
(6, 'PROJECT MANAGEMENT FOR IT-WMA', 'ITWPROMAN', 'This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.', '', 3, 0, '', '', '', 0, 0, 1),
(7, 'SOME COURSE TITLE 1', 'NEWCOURSE1', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 2, 1, '', '', '', 0, 0, 0),
(8, 'SOME COURSE TITLE 2', 'NEWCOURSE2', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 1),
(9, 'SOME COURSE TITLE 3', 'NEWCOURSE3', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 0),
(10, 'SOME COURSE TITLE 4', 'NEWCOURSE4', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 2, 1, '', '', '', 0, 0, 1),
(11, 'SOME COURSE TITLE 5', 'NEWCOURSE5', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 1),
(12, '', '', '', '', 0, 0, '', '', '', 0, 0, 1),
(13, 'Some new course 1', 'SOMENEW1', 'Some nice course description\r\n1. with numbers :o\r\n2. waw\r\n3. another', 'Some nice course objectives with bullets\r\n- nice\r\n- waw\r\n    - sub-bullets too\r\n    - sub-bullets too', 3, 0, '[\"Programming\",\"Animation\"]', '[\"3\"]', '[\"2\"]', 1522424825, 1522424825, 1);

-- --------------------------------------------------------

--
-- Table structure for table `course_field_relation`
--

CREATE TABLE `course_field_relation` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course_field_relation`
--

INSERT INTO `course_field_relation` (`id`, `course_id`, `field_id`, `status`) VALUES
(1, 1, 13, 1),
(2, 1, 14, 1),
(3, 1, 15, 1),
(4, 2, 2, 1),
(5, 2, 3, 1),
(6, 2, 5, 1),
(7, 2, 10, 1),
(8, 2, 11, 1),
(9, 3, 2, 1),
(10, 3, 4, 1),
(11, 3, 6, 1),
(12, 3, 7, 1),
(13, 3, 8, 1),
(14, 3, 9, 1),
(15, 1, 38, 1),
(16, 1, 39, 1),
(17, 1, 40, 1),
(18, 1, 31, 1),
(19, 1, 32, 1),
(20, 4, 17, 1),
(21, 4, 21, 1),
(22, 4, 19, 1),
(23, 4, 22, 1),
(24, 4, 23, 1),
(25, 4, 24, 1),
(26, 4, 25, 1),
(27, 4, 26, 1),
(28, 1, 29, 1),
(29, 4, 33, 1),
(30, 4, 34, 1),
(31, 5, 2, 1),
(32, 5, 20, 1),
(33, 5, 35, 1),
(34, 5, 36, 1),
(35, 5, 37, 1),
(36, 5, 27, 1),
(37, 5, 28, 1),
(38, 5, 18, 1),
(39, 0, 0, 1),
(40, 0, 0, 1),
(41, 0, 0, 1),
(42, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `course_relation`
--

CREATE TABLE `course_relation` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `related_course_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course_relation`
--

INSERT INTO `course_relation` (`id`, `course_id`, `related_course_id`, `type`, `status`) VALUES
(1, 1, 6, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `curriculum`
--

CREATE TABLE `curriculum` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `latest` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `curriculum`
--

INSERT INTO `curriculum` (`id`, `label`, `content`, `latest`, `created_at`, `updated_at`, `status`) VALUES
(1, '2015', '[{\"label\":\"a\",\"text\":\"Able to apply knowledge of computing fundamentals, technical concepts and practices, best practices and standards in the application of core information technologies, mathematics, science, and domain knowledge appropriate for the information technology practice to the abstraction and conceptualization of solution models from defined problems and requirements\"},{\"label\":\"b\",\"text\":\"Identify, formulate, research literature, and analyze user needs and taking them into account to solve complex information technology problems, reaching substantiated conclusions using fundamental principles of mathematics, computing fundamentals, technical concepts and practices in the core information technologies, and relevant domain disciplines.\"},{\"label\":\"c\",\"text\":\"Design and evaluate possible solutions for complex computing problems, and design and evaluate systems, components, or processes that meet specified user needs with appropriate consideration for public health and safety, cultural, societal, and environmental considerations\"},{\"label\":\"d\",\"text\":\"An ability to assist in the creation of an effective project plan to implement solution that includes selection, creation, evaluation, and administration of IT Systems\"},{\"label\":\"e\",\"text\":\"An ability to effectively integrate IT-based solutions into the user environment\"},{\"label\":\"f\",\"text\":\"An ability to administer delivered information system assuring its appropriateness to the user’s environment\"},{\"label\":\"g\",\"text\":\"Create, select, adapt and apply appropriate techniques, resources, and modern computing tools to complex computing activities, with an understanding of the limitations\"},{\"label\":\"h\",\"text\":\"Function effectively as an individual and as a member or leader in diverse teams and in multidisciplinary settings\"},{\"label\":\"i\",\"text\":\"Communicate effectively with the computing community and with society at large (in local and international scenes) about complex computing activities by being able to comprehend and write effective reports, design documentation, make effective presentations, and give and understand clear instructions\"},{\"label\":\"j\",\"text\":\"Understand and assess societal, health, safety, legal, and cultural issues within local and global contexts, and the consequential responsibilities relevant to professional computing practice\"},{\"label\":\"k\",\"text\":\"Understand and commit to professional ethics, responsibilities, and norms of professional computing practice\"},{\"label\":\"l\",\"text\":\"Recognize the need, and have the ability, to engage in independent learning for continual development as a computing professional\"}]', 0, 0, 1522493111, 1),
(2, '2017', '[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}]', 1, 0, 1522500271, 1),
(3, '2018', '[{\"label\":\"a\",\"text\":\"Sample\"}]', 0, 1522493286, 1522500262, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fields`
--

CREATE TABLE `fields` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fields`
--

INSERT INTO `fields` (`id`, `title`, `status`) VALUES
(1, 'Java', 1),
(2, 'Programming', 1),
(3, 'Object Oriented Programming', 1),
(4, 'Web Development', 1),
(5, 'Mobile Programming', 1),
(6, 'PHP', 1),
(7, 'Frameworks', 1),
(8, 'CodeIgniter', 1),
(9, 'Laravel', 1),
(10, 'iOS', 1),
(11, 'Swift', 1),
(12, 'Android Application Development', 1),
(13, 'Capstone Project', 1),
(14, 'Project Presentation', 1),
(15, 'Software Development', 1),
(16, 'JavaScript', 1),
(17, 'Database', 1),
(18, 'Arrays', 1),
(19, 'SQL', 1),
(20, 'C++', 1),
(21, 'Database Management', 1),
(22, 'Data Definition Language (DDL)', 1),
(23, 'Data Manipulation Language (DML)', 1),
(24, 'Data Control Language (DCL)', 1),
(25, 'Database Administration', 1),
(26, 'Database Design', 1),
(27, 'Control Structures', 1),
(28, 'Operators', 1),
(29, 'Project Management', 1),
(30, 'Assignment and Formatting', 1),
(31, 'Software Evaluation', 1),
(32, 'Software Testing', 1),
(33, 'Data Modeling', 1),
(34, 'Transaction Control', 1),
(35, 'Computer Programming', 1),
(36, 'History', 1),
(37, 'Basic Input and Output', 1),
(38, 'System Analysis', 1),
(39, 'System Design', 1),
(40, 'Software Requirements', 1),
(41, 'Ruby', 1),
(42, 'NodeJS', 1),
(43, 'AngularJS', 1),
(44, 'VueJS', 1),
(45, 'VBScript', 1),
(46, 'Animation', 1);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `name`, `description`, `status`) VALUES
(1, 'Whiteboard', '', 1),
(2, 'Net book', '', 1),
(3, 'DLP', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `material_field_relation`
--

CREATE TABLE `material_field_relation` (
  `id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `material_field_relation`
--

INSERT INTO `material_field_relation` (`id`, `material_id`, `field_id`, `status`) VALUES
(1, 1, 13, 1),
(2, 1, 29, 1),
(3, 2, 13, 1),
(4, 2, 29, 1),
(5, 3, 13, 1),
(6, 3, 29, 1);

-- --------------------------------------------------------

--
-- Table structure for table `outcomes`
--

CREATE TABLE `outcomes` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `type` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `outcomes`
--

INSERT INTO `outcomes` (`id`, `content`, `type`, `status`) VALUES
(1, 'Develop and execute the project requirements based from the proposal document.', 1, 1),
(2, 'Test and evaluate the software product to validate for the process and output.', 1, 1),
(3, 'Complete the system defined in the plan to satisfy the project specifications and present final documentation.', 1, 1),
(4, 'Understand the fundamental concepts and principles of database management and database administration.', 1, 1),
(5, 'Analyze business rules and translate them into user requirements.', 1, 1),
(6, 'Design logical and relational database that meets specified user requirements following relational database design principles and constructs.', 1, 1),
(7, 'Create SQL statements that retrieve information requirements of the organization needed for reports generation.', 1, 1),
(8, 'Develop, execute and create the project deliverables.', 2, 1),
(9, 'Test the software product to validate its process and output.', 2, 1),
(10, 'Complete the work defined in the plan to satisfy the project specifications.', 2, 1),
(11, 'Complete the 50% software development stated in the proposal.', 2, 1),
(12, 'Understand Project Review and closure.', 2, 1),
(13, 'Complete the 75% software development stated in the proposal.', 2, 1),
(14, 'Create and present the final documentation.', 2, 1),
(15, 'Execution of user acceptance testing.', 2, 1),
(16, 'Mock defense', 2, 1),
(17, 'Project Final Defense/Presentation', 2, 1),
(18, 'Revision of Software and Documents', 2, 1),
(19, 'Submission of Final Requirements', 2, 1),
(20, 'Discussion of the Guidelines', 3, 1),
(21, 'Classroom Discussion', 3, 1),
(22, 'Class/Library Activity; Research current trends in IT.', 3, 1),
(23, 'Require instrument for software testing.', 3, 1),
(24, 'Actual user acceptance', 3, 1),
(25, 'Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.', 4, 1),
(26, 'Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.', 4, 1),
(27, 'Follow formulated testing instrument and comply with the checking and testing of the software.', 4, 1),
(28, 'The students can identify and describe Project Management Groups needed for a project. Determine their role in project development.', 4, 1),
(29, 'The students can be able to produce Results and Discussion of the Proposal Paper.', 4, 1),
(30, 'Conducts user acceptance testing', 4, 1),
(31, '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `outcome_field_relation`
--

CREATE TABLE `outcome_field_relation` (
  `id` int(11) NOT NULL,
  `outcome_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `outcome_field_relation`
--

INSERT INTO `outcome_field_relation` (`id`, `outcome_id`, `field_id`, `status`) VALUES
(1, 1, 13, 1),
(2, 1, 14, 1),
(3, 1, 15, 1),
(4, 1, 29, 1),
(5, 1, 31, 1),
(6, 1, 32, 1),
(7, 1, 38, 1),
(8, 1, 39, 1),
(9, 1, 40, 1),
(10, 2, 13, 1),
(11, 2, 14, 1),
(12, 2, 15, 1),
(13, 2, 29, 1),
(14, 2, 31, 1),
(15, 2, 32, 1),
(16, 2, 38, 1),
(17, 2, 39, 1),
(18, 2, 40, 1),
(19, 3, 13, 1),
(20, 3, 14, 1),
(21, 3, 15, 1),
(22, 3, 29, 1),
(23, 3, 31, 1),
(24, 3, 32, 1),
(25, 3, 38, 1),
(26, 3, 39, 1),
(27, 3, 40, 1),
(28, 8, 13, 1),
(29, 8, 14, 1),
(30, 8, 15, 1),
(31, 8, 29, 1),
(32, 8, 31, 1),
(33, 8, 32, 1),
(34, 8, 38, 1),
(35, 8, 39, 1),
(36, 8, 40, 1),
(37, 9, 13, 1),
(38, 9, 14, 1),
(39, 9, 15, 1),
(40, 9, 29, 1),
(41, 9, 31, 1),
(42, 9, 32, 1),
(43, 9, 38, 1),
(44, 9, 39, 1),
(45, 9, 40, 1),
(46, 10, 13, 1),
(47, 10, 14, 1),
(48, 10, 15, 1),
(49, 10, 29, 1),
(50, 10, 31, 1),
(51, 10, 32, 1),
(52, 10, 38, 1),
(53, 10, 39, 1),
(54, 10, 40, 1),
(55, 11, 13, 1),
(56, 11, 14, 1),
(57, 11, 15, 1),
(58, 11, 29, 1),
(59, 11, 31, 1),
(60, 11, 32, 1),
(61, 11, 38, 1),
(62, 11, 39, 1),
(63, 11, 40, 1),
(64, 12, 13, 1),
(65, 12, 14, 1),
(66, 12, 15, 1),
(67, 12, 29, 1),
(68, 12, 31, 1),
(69, 12, 32, 1),
(70, 12, 38, 1),
(71, 12, 39, 1),
(72, 12, 40, 1),
(73, 13, 13, 1),
(74, 13, 14, 1),
(75, 13, 15, 1),
(76, 13, 29, 1),
(77, 13, 31, 1),
(78, 13, 32, 1),
(79, 13, 38, 1),
(80, 13, 39, 1),
(81, 13, 40, 1),
(82, 14, 13, 1),
(83, 14, 14, 1),
(84, 14, 15, 1),
(85, 14, 29, 1),
(86, 14, 31, 1),
(87, 14, 32, 1),
(88, 14, 38, 1),
(89, 14, 39, 1),
(90, 14, 40, 1),
(91, 15, 13, 1),
(92, 15, 14, 1),
(93, 15, 15, 1),
(94, 15, 29, 1),
(95, 15, 31, 1),
(96, 15, 32, 1),
(97, 15, 38, 1),
(98, 15, 39, 1),
(99, 15, 40, 1),
(100, 16, 13, 1),
(101, 16, 14, 1),
(102, 16, 15, 1),
(103, 16, 29, 1),
(104, 16, 31, 1),
(105, 16, 32, 1),
(106, 16, 38, 1),
(107, 16, 39, 1),
(108, 16, 40, 1),
(109, 17, 13, 1),
(110, 17, 14, 1),
(111, 17, 15, 1),
(112, 17, 29, 1),
(113, 17, 31, 1),
(114, 17, 32, 1),
(115, 17, 38, 1),
(116, 17, 39, 1),
(117, 17, 40, 1),
(118, 18, 13, 1),
(119, 18, 14, 1),
(120, 18, 15, 1),
(121, 18, 29, 1),
(122, 18, 31, 1),
(123, 18, 32, 1),
(124, 18, 38, 1),
(125, 18, 39, 1),
(126, 18, 40, 1),
(127, 19, 13, 1),
(128, 19, 14, 1),
(129, 19, 15, 1),
(130, 19, 29, 1),
(131, 19, 31, 1),
(132, 19, 32, 1),
(133, 19, 38, 1),
(134, 19, 39, 1),
(135, 19, 40, 1),
(136, 4, 17, 1),
(137, 4, 19, 1),
(138, 4, 21, 1),
(139, 4, 22, 1),
(140, 4, 23, 1),
(141, 4, 24, 1),
(142, 4, 25, 1),
(143, 4, 26, 1),
(144, 4, 33, 1),
(145, 4, 34, 1),
(146, 5, 17, 1),
(147, 5, 19, 1),
(148, 5, 21, 1),
(149, 5, 22, 1),
(150, 5, 23, 1),
(151, 5, 24, 1),
(152, 5, 25, 1),
(153, 5, 26, 1),
(154, 5, 33, 1),
(155, 5, 34, 1),
(156, 6, 17, 1),
(157, 6, 19, 1),
(158, 6, 21, 1),
(159, 6, 22, 1),
(160, 6, 23, 1),
(161, 6, 24, 1),
(162, 6, 25, 1),
(163, 6, 26, 1),
(164, 6, 33, 1),
(165, 6, 34, 1),
(166, 7, 17, 1),
(167, 7, 19, 1),
(168, 7, 21, 1),
(169, 7, 22, 1),
(170, 7, 23, 1),
(171, 7, 24, 1),
(172, 7, 25, 1),
(173, 7, 26, 1),
(174, 7, 33, 1),
(175, 7, 34, 1),
(176, 20, 13, 1),
(177, 20, 29, 1),
(178, 21, 13, 1),
(179, 21, 29, 1),
(180, 22, 13, 1),
(181, 22, 29, 1),
(182, 23, 13, 1),
(183, 23, 29, 1),
(184, 23, 32, 1),
(185, 23, 31, 1),
(186, 24, 13, 1),
(187, 24, 29, 1),
(188, 24, 31, 1),
(189, 24, 32, 1),
(190, 24, 14, 1),
(191, 25, 13, 1),
(192, 25, 29, 1),
(193, 26, 13, 1),
(194, 26, 29, 1),
(195, 27, 13, 1),
(196, 27, 29, 1),
(197, 27, 31, 1),
(198, 27, 32, 1),
(199, 28, 13, 1),
(200, 28, 29, 1),
(201, 28, 15, 1),
(202, 28, 38, 1),
(203, 28, 39, 1),
(204, 28, 40, 1),
(205, 29, 13, 1),
(206, 29, 29, 1),
(207, 29, 38, 1),
(208, 29, 39, 1),
(209, 29, 40, 1),
(210, 30, 13, 1),
(211, 30, 14, 1),
(212, 30, 29, 1),
(213, 30, 31, 1),
(214, 30, 32, 1),
(215, 0, 0, 0),
(216, 0, 0, 0),
(217, 0, 0, 0),
(218, 0, 0, 0),
(219, 0, 0, 0),
(220, 0, 0, 0),
(221, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `outcome_relation`
--

CREATE TABLE `outcome_relation` (
  `id` int(11) NOT NULL,
  `clo_id` int(11) NOT NULL,
  `ilo_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `outcome_relation`
--

INSERT INTO `outcome_relation` (`id`, `clo_id`, `ilo_id`, `status`) VALUES
(1, 1, 8, 1),
(2, 1, 12, 1),
(3, 1, 18, 1),
(4, 2, 11, 1),
(5, 2, 13, 1),
(6, 2, 15, 1),
(7, 2, 18, 1),
(8, 3, 11, 1),
(9, 3, 13, 1),
(10, 3, 14, 1),
(11, 3, 15, 1),
(12, 3, 16, 1),
(13, 3, 17, 1),
(14, 3, 18, 1);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `content` text NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `content`, `updated_at`) VALUES
(1, 'syllabusContent', '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\"}', 1522750993),
(2, 'cloOptions', '[{\"symbol\":\"I\",\"text\":\"Introductory\"},{\"symbol\":\"E\",\"text\":\"Engaging\"},{\"symbol\":\"D\",\"text\":\"Demonstrative\"}]', 1522745267),
(3, 'gradingSystem', '[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises\\/Machine Problems 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Project\\/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises\\/Machine Problems 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Project\\/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}]', 1522745267);

-- --------------------------------------------------------

--
-- Table structure for table `syllabi`
--

CREATE TABLE `syllabi` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `assign_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `version` varchar(32) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `syllabi`
--

INSERT INTO `syllabi` (`id`, `course_id`, `editor_id`, `assign_id`, `content`, `version`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, 3, 1, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"name\":\"Smith Paul\",\"position\":null},\"evaluatedBy\":{\"name\":null,\"position\":null},\"approvedBy\":[],\"bookReferences\":[],\"programOutcomes\":{\"id\":\"2\",\"label\":\"2017\",\"content\":[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"latest\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522500271\",\"status\":\"1\"},\"courseLearningOutcomes\":[],\"intendedLearningOutcomes\":[],\"cloPoMap\":{},\"weeklyActivities\":[],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"\",\"corequisites\":\"\",\"created_at\":\"0\",\"updated_at\":\"0\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1522415141\",\"status\":\"1\"}}', '', 1522747430, 1522747430, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `name`, `description`, `status`) VALUES
(1, 'Assignment', '', 1),
(2, 'Recitation', '', 1),
(3, 'Short Quiz', '', 1),
(4, 'Case Study 1', '', 1),
(5, 'Seatwork/Boardwork', '', 1),
(6, 'Lab Exercise 1', '', 1),
(7, 'Case Study 3', '', 1),
(8, 'Lab Exercise 2', '', 1),
(9, 'Case Study 4', '', 1),
(10, 'Lab Exercise 3', '', 1),
(11, 'Case Study 5', '', 1),
(12, 'Lab Exercise 4', '', 1),
(13, 'Case Study 6', '', 1),
(14, 'Lab Exercise 5', '', 1),
(15, 'Lab Exercise 6', '', 1),
(16, 'Case Study 7', '', 1),
(17, 'Lab Exercise 7', '', 1),
(18, 'Lab Exercise 8', '', 1),
(19, 'Seatwork', '', 1),
(20, 'Group Dynamics', '', 1),
(21, 'Group Presentation', '', 1),
(22, 'Class Activity', '', 1),
(23, 'Documentation', '', 1),
(24, 'Testing', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `task_field_relation`
--

CREATE TABLE `task_field_relation` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_field_relation`
--

INSERT INTO `task_field_relation` (`id`, `task_id`, `field_id`, `status`) VALUES
(1, 20, 13, 1),
(2, 20, 29, 1),
(3, 20, 0, 1),
(4, 21, 13, 1),
(5, 21, 29, 1),
(6, 22, 13, 1),
(7, 22, 29, 1),
(8, 22, 14, 1),
(9, 23, 13, 1),
(10, 23, 29, 1),
(11, 23, 38, 1),
(12, 23, 39, 1),
(13, 23, 40, 1),
(14, 24, 13, 1),
(15, 24, 29, 1),
(16, 24, 31, 1),
(17, 24, 32, 1),
(18, 2, 13, 1),
(19, 2, 29, 1),
(20, 0, 0, 0),
(21, 0, 0, 0),
(22, 0, 0, 0),
(23, 0, 0, 0),
(24, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `name`, `status`) VALUES
(1, 'Lesson 1. Project Development', 1),
(2, 'Lesson 2. Software Evaluation', 1),
(3, 'Lesson 3. Project Control and Project Closure', 1),
(4, 'Lesson 4. Project Management Process Issues', 1),
(5, 'Lesson 5. Writing Proposals', 1),
(6, 'Lesson 6. Writing Proposals', 1),
(7, 'Users\' Acceptance Testing', 1),
(8, 'Module 1. The Database Environment and Development Process', 1),
(9, 'Module 2. Modeling Data in the Organization', 1),
(10, 'Module 3. Enhanced E-R Model', 1),
(11, 'Module 4. Logical Database Design and the Relational Model', 1),
(12, 'Module 5. Introduction to SQL', 1),
(13, 'Module 6. Data Definition Language (DDL)', 1),
(14, 'Module 7. Data Manipulation Language (DML) and Transaction Control', 1),
(15, 'Module 8. Advanced SQL', 1),
(16, 'Module 9. Data Control Language (DCL)', 1),
(17, 'Module 10. Data and Database Administration', 1),
(18, 'Module 1. Introduction to Programming', 1),
(19, 'Module 2.1. Introduction to C++', 1),
(20, 'Module 2.2. Basic Input and Output', 1),
(21, 'Module 2.3. Operators', 1),
(22, 'Module 3. Assignment and Formatting', 1),
(23, 'Module 4. Program Control Structures', 1),
(24, 'Module 5. Repetition Control Structure', 1),
(25, 'Module 6. Introduction to Arrays', 1),
(26, 'PBL Orientation', 1),
(27, 'Sample topic 1', 1),
(28, 'Sample topic 2', 1),
(29, 'Sample topic 3', 1);

-- --------------------------------------------------------

--
-- Table structure for table `topic_field_relation`
--

CREATE TABLE `topic_field_relation` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topic_field_relation`
--

INSERT INTO `topic_field_relation` (`id`, `topic_id`, `field_id`, `status`) VALUES
(1, 1, 13, 1),
(2, 1, 15, 1),
(3, 2, 13, 1),
(4, 2, 31, 1),
(5, 3, 13, 1),
(6, 3, 29, 1),
(7, 4, 13, 1),
(8, 4, 29, 1),
(9, 5, 13, 1),
(10, 5, 29, 1),
(11, 6, 13, 1),
(12, 6, 29, 1),
(13, 2, 29, 1),
(14, 7, 13, 1),
(15, 7, 32, 1),
(16, 8, 17, 1),
(17, 8, 21, 1),
(18, 9, 26, 1),
(19, 9, 33, 1),
(20, 9, 17, 1),
(21, 9, 21, 1),
(22, 10, 17, 1),
(23, 10, 21, 1),
(24, 10, 26, 1),
(25, 10, 33, 1),
(26, 11, 17, 1),
(27, 11, 21, 1),
(28, 11, 26, 1),
(29, 11, 33, 1),
(30, 12, 17, 1),
(31, 12, 21, 1),
(32, 12, 19, 1),
(33, 13, 17, 1),
(34, 13, 19, 1),
(35, 13, 21, 1),
(36, 13, 22, 1),
(37, 14, 17, 1),
(38, 14, 19, 1),
(39, 14, 21, 1),
(40, 14, 23, 1),
(41, 14, 24, 1),
(42, 15, 17, 1),
(43, 15, 21, 1),
(44, 15, 19, 1),
(45, 16, 17, 1),
(46, 16, 19, 1),
(47, 16, 21, 1),
(48, 16, 24, 1),
(49, 17, 17, 1),
(50, 17, 21, 1),
(51, 17, 25, 1),
(52, 18, 2, 1),
(53, 18, 35, 1),
(54, 18, 36, 1),
(55, 18, 20, 1),
(56, 19, 35, 1),
(57, 19, 20, 1),
(58, 19, 2, 1),
(59, 20, 2, 1),
(60, 20, 20, 1),
(61, 20, 35, 1),
(62, 20, 37, 1),
(63, 21, 2, 1),
(64, 21, 20, 1),
(65, 21, 35, 1),
(66, 21, 28, 1),
(67, 22, 2, 1),
(68, 22, 20, 1),
(69, 22, 35, 1),
(70, 22, 30, 1),
(71, 23, 2, 1),
(72, 23, 20, 1),
(73, 23, 35, 1),
(74, 23, 27, 1),
(75, 24, 2, 1),
(76, 24, 20, 1),
(77, 24, 35, 1),
(78, 24, 27, 1),
(79, 25, 2, 1),
(80, 25, 20, 1),
(81, 25, 35, 1),
(82, 25, 18, 1),
(83, 27, 13, 1),
(84, 27, 31, 1),
(85, 27, 32, 1),
(86, 28, 13, 1),
(87, 28, 31, 1),
(88, 28, 32, 1),
(89, 29, 13, 1),
(90, 29, 31, 1),
(91, 29, 32, 1),
(92, 26, 13, 1),
(93, 26, 29, 1),
(94, 0, 0, 0),
(95, 0, 0, 0),
(96, 0, 0, 0),
(97, 0, 0, 0),
(98, 0, 0, 0),
(99, 0, 0, 0),
(100, 0, 0, 0),
(101, 0, 0, 0),
(102, 0, 0, 0),
(103, 0, 0, 0),
(104, 0, 0, 0),
(105, 0, 0, 0),
(106, 0, 0, 0),
(107, 0, 0, 0),
(108, 0, 0, 0),
(109, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `topic_material_relation`
--

CREATE TABLE `topic_material_relation` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topic_material_relation`
--

INSERT INTO `topic_material_relation` (`id`, `topic_id`, `material_id`, `status`) VALUES
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1),
(5, 5, 1, 1),
(6, 6, 1, 1),
(7, 8, 1, 1),
(8, 9, 1, 1),
(9, 10, 1, 1),
(10, 11, 1, 1),
(11, 18, 1, 1),
(12, 19, 1, 1),
(13, 26, 1, 1),
(14, 19, 2, 1),
(15, 20, 2, 1),
(16, 21, 2, 1),
(17, 22, 2, 1),
(18, 23, 2, 1),
(19, 24, 2, 1),
(20, 25, 2, 1),
(21, 1, 3, 1),
(22, 2, 3, 1),
(23, 3, 3, 1),
(24, 4, 3, 1),
(25, 5, 3, 1),
(26, 6, 3, 1),
(27, 8, 3, 1),
(28, 9, 3, 1),
(29, 10, 3, 1),
(30, 11, 3, 1),
(31, 12, 3, 1),
(32, 13, 3, 1),
(33, 14, 3, 1),
(34, 15, 3, 1),
(35, 16, 3, 1),
(36, 17, 3, 1),
(37, 18, 3, 1),
(38, 19, 3, 1),
(39, 20, 3, 1),
(40, 21, 3, 1),
(41, 22, 3, 1),
(42, 23, 3, 1),
(43, 24, 3, 1),
(44, 25, 3, 1),
(45, 26, 3, 1),
(46, 27, 3, 1),
(47, 28, 3, 1),
(48, 29, 3, 1),
(49, 0, 0, 0),
(50, 0, 0, 0),
(51, 0, 0, 0),
(52, 0, 0, 0),
(53, 0, 0, 0),
(54, 0, 0, 0),
(55, 0, 0, 0),
(56, 0, 0, 0),
(57, 0, 0, 0),
(58, 0, 0, 0),
(59, 0, 0, 0),
(60, 0, 0, 0),
(61, 0, 0, 0),
(62, 0, 0, 0),
(63, 0, 0, 0),
(64, 0, 0, 0),
(65, 0, 0, 0),
(66, 0, 0, 0),
(67, 0, 0, 0),
(68, 0, 0, 0),
(69, 0, 0, 0),
(70, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `topic_outcome_relation`
--

CREATE TABLE `topic_outcome_relation` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `outcome_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topic_outcome_relation`
--

INSERT INTO `topic_outcome_relation` (`id`, `topic_id`, `outcome_id`, `status`) VALUES
(1, 1, 8, 1),
(2, 2, 9, 1),
(3, 1, 10, 1),
(4, 2, 10, 1),
(5, 27, 11, 1),
(6, 28, 11, 1),
(7, 3, 12, 1),
(8, 4, 12, 1),
(9, 28, 13, 1),
(10, 29, 13, 1),
(11, 5, 14, 1),
(12, 6, 14, 1),
(13, 7, 15, 1),
(14, 26, 8, 1),
(15, 26, 20, 1),
(16, 1, 21, 1),
(17, 2, 21, 1),
(18, 1, 22, 1),
(19, 2, 22, 1),
(20, 27, 23, 1),
(21, 28, 23, 1),
(22, 29, 23, 1),
(23, 3, 21, 1),
(24, 4, 21, 1),
(25, 5, 21, 1),
(26, 6, 21, 1),
(27, 7, 24, 1),
(28, 7, 30, 1),
(29, 5, 29, 1),
(30, 6, 29, 1),
(31, 26, 25, 1),
(32, 1, 26, 1),
(33, 2, 26, 1),
(34, 27, 27, 1),
(35, 28, 27, 1),
(36, 29, 27, 1),
(37, 3, 28, 1),
(38, 4, 28, 1);

-- --------------------------------------------------------

--
-- Table structure for table `topic_task_relation`
--

CREATE TABLE `topic_task_relation` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topic_task_relation`
--

INSERT INTO `topic_task_relation` (`id`, `topic_id`, `task_id`, `status`) VALUES
(1, 1, 2, 1),
(2, 1, 20, 1),
(3, 2, 2, 1),
(4, 2, 20, 1),
(5, 27, 21, 1),
(6, 28, 21, 1),
(7, 29, 21, 1),
(8, 3, 22, 1),
(9, 4, 22, 1),
(10, 5, 23, 1),
(11, 6, 23, 1),
(12, 7, 24, 1),
(13, 0, 0, 0),
(14, 0, 0, 0),
(15, 0, 0, 0),
(16, 0, 0, 0),
(17, 0, 0, 0),
(18, 0, 0, 0),
(19, 0, 0, 0),
(20, 0, 0, 0),
(21, 0, 0, 0),
(22, 0, 0, 0),
(23, 0, 0, 0),
(24, 0, 0, 0),
(25, 0, 0, 0),
(26, 0, 0, 0),
(27, 0, 0, 0),
(28, 0, 0, 0),
(29, 0, 0, 0),
(30, 0, 0, 0),
(31, 0, 0, 0),
(32, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(32) NOT NULL,
  `mname` varchar(32) NOT NULL,
  `lname` varchar(32) NOT NULL,
  `username` varchar(16) NOT NULL,
  `title` varchar(255) NOT NULL,
  `weight` tinyint(4) NOT NULL,
  `password` varchar(255) NOT NULL,
  `img_src` text NOT NULL,
  `tags` text NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `auth` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `mname`, `lname`, `username`, `title`, `weight`, `password`, `img_src`, `tags`, `status`, `created_at`, `updated_at`, `auth`) VALUES
(1, 'John', 'Smith', 'Doe', 'test', 'new', 0, '$2y$10$tEU6V/HbHOZ59TQQpUrIb.eE3enrCo5i.fYkvSKY9EPFwJJqnMh1C', 'F_1522260047.png', '[]', 1, 0, 1522425466, '[\"1\"]'),
(2, 'Jane', '', 'Doe', 'charlyn', '', 0, '$2y$10$3jQ.7tz1XYlAyMzsU1Mgfu9XciWKkMa26yPfiV2bPLGP0nVsniDuq', '', '', 1, 0, 1521732242, '[\"3\"]'),
(3, 'Smith', '', 'Paul', 'ralph', '', 0, '$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6', '', '', 1, 0, 0, '[\"3\",\"4\"]'),
(4, 'Cayle', '', 'Gaspar', 'cayle', '', 0, '$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO', '', '', 1, 0, 0, '[\"3\"]'),
(5, 'Joanne', '', 'Katrin', 'joanne', '', 0, '$2y$10$Q61GloOCeRIHKx1Gz7atr.Y9ujWhJqfA8Tmix98awgRjFDW9PKZRa', '', '', 1, 0, 0, '[\"3\"]'),
(8, 'New', 'test', 'last', 'rylee', 'title', 1, '$2y$10$XVY3K2/Mh/Ry7.Uqm/Va/up9eFgKwVyqOYkD67.3ueju2yfRbRUdu', 'F_1522263636.png', '[\"Software Testing\",\"Programming\",\"Android Application Development\",\"JavaScript\",\"Ruby\",\"NodeJS\",\"AngularJS\"]', 1, 1522263636, 1522595690, '[\"5\"]');

-- --------------------------------------------------------

--
-- Table structure for table `workflow_logs`
--

CREATE TABLE `workflow_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `assign_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `type` varchar(16) NOT NULL,
  `created_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workflow_logs`
--

INSERT INTO `workflow_logs` (`id`, `user_id`, `assign_id`, `content`, `type`, `created_at`, `status`) VALUES
(1, 3, 1, 'viewed this syllabus.', 'view', 1522595502, 1),
(2, 8, 1, 'viewed this syllabus.', 'view', 1522595700, 1),
(3, 8, 1, '<strong>level 1</strong> &mdash; approved this syllabus.', 'approval', 1522595713, 1),
(4, 8, 1, '<strong>level 1</strong> &mdash; approved this syllabus.', 'approval', 1522595722, 1),
(5, 8, 1, 'viewed this syllabus.', 'view', 1522595821, 1),
(6, 3, 1, 'viewed this syllabus.', 'view', 1522595867, 1),
(7, 3, 1, 'viewed this syllabus.', 'view', 1522597689, 1),
(8, 3, 1, 'viewed this syllabus.', 'view', 1522597808, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assigns`
--
ALTER TABLE `assigns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_field_relation`
--
ALTER TABLE `book_field_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_field_relation`
--
ALTER TABLE `course_field_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_relation`
--
ALTER TABLE `course_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `curriculum`
--
ALTER TABLE `curriculum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `material_field_relation`
--
ALTER TABLE `material_field_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `outcomes`
--
ALTER TABLE `outcomes`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `outcomes` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`content`);

--
-- Indexes for table `outcome_field_relation`
--
ALTER TABLE `outcome_field_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `outcome_relation`
--
ALTER TABLE `outcome_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `syllabi`
--
ALTER TABLE `syllabi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_field_relation`
--
ALTER TABLE `task_field_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topic_field_relation`
--
ALTER TABLE `topic_field_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topic_material_relation`
--
ALTER TABLE `topic_material_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topic_outcome_relation`
--
ALTER TABLE `topic_outcome_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topic_task_relation`
--
ALTER TABLE `topic_task_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);
ALTER TABLE `users` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`fname`,`mname`,`lname`,`username`);

--
-- Indexes for table `workflow_logs`
--
ALTER TABLE `workflow_logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assigns`
--
ALTER TABLE `assigns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `book_field_relation`
--
ALTER TABLE `book_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `course_field_relation`
--
ALTER TABLE `course_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `course_relation`
--
ALTER TABLE `course_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `curriculum`
--
ALTER TABLE `curriculum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `material_field_relation`
--
ALTER TABLE `material_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `outcomes`
--
ALTER TABLE `outcomes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `outcome_field_relation`
--
ALTER TABLE `outcome_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT for table `outcome_relation`
--
ALTER TABLE `outcome_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `syllabi`
--
ALTER TABLE `syllabi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `task_field_relation`
--
ALTER TABLE `task_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `topic_field_relation`
--
ALTER TABLE `topic_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `topic_material_relation`
--
ALTER TABLE `topic_material_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `topic_outcome_relation`
--
ALTER TABLE `topic_outcome_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `topic_task_relation`
--
ALTER TABLE `topic_task_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `workflow_logs`
--
ALTER TABLE `workflow_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
