-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2018 at 05:41 AM
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
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `citation` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `citation`, `status`) VALUES
(1, 'Author Name. (1999). Some title of book or article about Android Development.', 1),
(2, 'Author\'s Name. (2001). Some book about JavaScript.', 1),
(3, 'Zak, Diane (2011) An Introduction to Programming with C++. 6th ed.  Australia: Course Technology', 1),
(4, 'McGrath, Mike (2012) C++ Programming in Easy Steps.  4th ed.  Warwickshire, United Kingdom: Easy Steps Limited', 1),
(5, 'Gaddis, Tony (2007) Starting out with C++. Pearson Publishing.	', 1),
(6, 'Gregoire, Marc, et. al. (2011) Professional C++. 2nd ed.  Indianapolis, Indiana: Wiley', 1),
(7, 'Deitel, Paul J. (2009) C++ for programmers. Prentice Hall.', 1),
(8, 'D. S. Malik (2008) C++ programming. Thomson Course Technology.', 1),
(9, 'Deitel, Paul J. (2008) C++ how to program. Pearson Publishing.', 1),
(10, 'Josuttis, Nicolai M. (2012) The C++ Standard Library: a tutorial and reference. 2nd ed.  Upper Saddle River, NJ. :  Addison-Wesley', 1),
(11, 'Mullins, C. (2013). Database Administration 2nd Edition, Addison-Wesley.', 1),
(12, 'Gillenson, M. (2012). Fundamentals of Database Management Systems 2nd Edition, John Wiley & Sons.', 1),
(13, 'Elmasri, R. (2011). Fundamentals of Database Systems 6th Edition, Addison-Wesley.', 1),
(14, 'Gill, P. (2011). Database Management Systems 2nd Edition, I.K. International Pub.', 1),
(15, 'Connoly, T. (2010). Database Systems: A practical Approach to Design, Implementation and Management 5th Edition, McGraw Hill International.', 1),
(16, 'Harrington, J. (2010). SQL Clearly Explained, Morgan Kaufmann.', 1),
(17, 'Kroenke, D. (2010). Database Concepts 4th Edition, Pearson.', 1),
(18, 'Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ', 1),
(19, 'Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press', 1),
(20, 'Puntambekar, A. (2014). Object oriented analysis & design: a conceptual approach. Technical Publication: New Delhi', 1),
(21, 'Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology', 1);

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
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `code` varchar(16) NOT NULL,
  `description` text NOT NULL,
  `unitsLec` tinyint(4) NOT NULL,
  `unitsLab` tinyint(4) NOT NULL,
  `unitsType` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `title`, `code`, `description`, `unitsLec`, `unitsLab`, `unitsType`, `status`) VALUES
(1, 'CAPSTONE PROJECT 1', 'ITWPROJ1', 'This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.', 3, 0, 1, 1),
(2, 'MOBILE APPLICATION DEVELOPMENT 2', 'ITWSPEC4', 'Some description about mobile application development in iOS.', 2, 1, 3, 1),
(3, 'WEB APPLICATION DEVELOPMENT 2', 'ITWSPEC6', 'Some description about web application development using PHP frameworks.', 2, 1, 3, 1),
(4, 'DATABASE MANAGEMENT SYSTEMS 1', 'ITEDBASE1', 'This course introduces the concept of databases and database management system. In this course, the students will  learn how to examine the database management in business for routine processing and management reporting, design databases using ERD, and use SQL statements to store, retrieve and manipulate data in the database. In addition, students will be introduced to basic data and database administration and installation of DBMS.', 2, 1, 3, 1),
(5, 'Introduction to Programming', 'ITPROG1', 'This course is an introduction to programming which will provide the students the skills in programming through the use of conventional techniques of flowcharting and pseudo-coding.', 2, 1, 3, 1);

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
-- Table structure for table `curriculum`
--

CREATE TABLE `curriculum` (
  `id` int(11) NOT NULL,
  `label` varchar(8) NOT NULL,
  `content` text NOT NULL,
  `year` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `curriculum`
--

INSERT INTO `curriculum` (`id`, `label`, `content`, `year`, `status`) VALUES
(1, 'a', 'Apply knowledge of computing, science and mathematics appropriate to the discipline.', 2017, 1),
(2, 'b', 'Understand best practices and standards and their applications.', 2017, 1),
(3, 'c', 'Analyze complex problems and identify and define the computing requirements appropriate to its solution.', 2017, 1),
(4, 'd', 'Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.', 2017, 1),
(5, 'e', 'Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.', 2017, 1),
(6, 'f', 'Integrate IT-based solutions into the user environment effectively.', 2017, 1),
(7, 'g', 'Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.', 2017, 1),
(8, 'h', 'Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.', 2017, 1),
(9, 'i', 'Assist in the creation of an effective IT project plan.', 2017, 1),
(10, 'j', 'Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.', 2017, 1),
(11, 'k', 'Analyze the local and global impact of computing information technology on individuals, organizations and society.', 2017, 1),
(12, 'l', 'Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.', 2017, 1),
(13, 'm', 'Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.', 2017, 1),
(14, 'a', 'Able to apply knowledge of computing fundamentals, technical concepts and practices, best practices and standards in the application of core information technologies, mathematics, science, and domain knowledge appropriate for the information technology practice to the abstraction and conceptualization of solution models from defined problems and requirements', 2015, 1),
(15, 'b', 'Identify, formulate, research literature, and analyze user needs and taking them into account to solve complex information technology problems, reaching substantiated conclusions using fundamental principles of mathematics, computing fundamentals, technical concepts and practices in the core information technologies, and relevant domain disciplines.', 2015, 1),
(16, 'c', 'Design and evaluate possible solutions for complex computing problems, and design and evaluate systems, components, or processes that meet specified user needs with appropriate consideration for public health and safety, cultural, societal, and environmental considerations', 2015, 1),
(17, 'd', 'An ability to assist in the creation of an effective project plan to implement solution that includes selection, creation, evaluation, and administration of IT Systems', 2015, 1),
(18, 'e', 'An ability to effectively integrate IT-based solutions into the user environment', 2015, 1),
(19, 'f', 'An ability to administer delivered information system assuring its appropriateness to the user’s environment', 2015, 1),
(20, 'g', 'Create, select, adapt and apply appropriate techniques, resources, and modern computing tools to complex computing activities, with an understanding of the limitations', 2015, 1),
(21, 'h', 'Function effectively as an individual and as a member or leader in diverse teams and in multidisciplinary settings', 2015, 1),
(22, 'i', 'Communicate effectively with the computing community and with society at large (in local and international scenes) about complex computing activities by being able to comprehend and write effective reports, design documentation, make effective presentations, and give and understand clear instructions', 2015, 1),
(23, 'j', 'Understand and assess societal, health, safety, legal, and cultural issues within local and global contexts, and the consequential responsibilities relevant to professional computing practice', 2015, 1),
(24, 'k', 'Understand and commit to professional ethics, responsibilities, and norms of professional computing practice', 2015, 1),
(25, 'l', 'Recognize the need, and have the ability, to engage in independent learning for continual development as a computing professional', 2015, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fields`
--

CREATE TABLE `fields` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fields`
--

INSERT INTO `fields` (`id`, `title`, `description`, `status`) VALUES
(1, 'Java', '', 1),
(2, 'Programming', '', 1),
(3, 'Object Oriented Programming', '', 1),
(4, 'Web Development', '', 1),
(5, 'Mobile Programming', '', 1),
(6, 'PHP', '', 1),
(7, 'Frameworks', '', 1),
(8, 'CodeIgniter', '', 1),
(9, 'Laravel', '', 1),
(10, 'iOS', '', 1),
(11, 'Swift', '', 1),
(12, 'Android Application Development', '', 1),
(13, 'Capstone Project', '', 1),
(14, 'Project Presentation', '', 1),
(15, 'Software Development', '', 1),
(16, 'JavaScript', '', 1),
(17, 'Database', '', 1),
(18, 'Arrays', '', 1),
(19, 'SQL', '', 1),
(20, 'C++', '', 1),
(21, 'Database Management', '', 1),
(22, 'Data Definition Language (DDL)', '', 1),
(23, 'Data Manipulation Language (DML)', '', 1),
(24, 'Data Control Language (DCL)', '', 1),
(25, 'Database Administration', '', 1),
(26, 'Database Design', '', 1),
(27, 'Control Structures', '', 1),
(28, 'Operators', '', 1),
(29, 'Project Management', '', 1),
(30, 'Assignment and Formatting', '', 1),
(31, 'Software Evaluation', '', 1),
(32, 'Software Testing', '', 1),
(33, 'Data Modeling', '', 1),
(34, 'Transaction Control', '', 1),
(35, 'Computer Programming', '', 1),
(36, 'History', '', 1),
(37, 'Basic Input and Output', '', 1),
(38, 'System Analysis', '', 1),
(39, 'System Design', '', 1),
(40, 'Software Requirements', '', 1);

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
(19, 'Submission of Final Requirements', 2, 1);

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
(135, 19, 40, 1);

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
-- Table structure for table `syllabi`
--

CREATE TABLE `syllabi` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `format_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `syllabi`
--

INSERT INTO `syllabi` (`id`, `course_id`, `editor_id`, `format_id`, `content`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, 1, 1, '{\"editor\":{\"id\":\"1\",\"fname\":\"John\",\"mname\":\"Smith\",\"lname\":\"Doe\",\"username\":\"test\"},\"programOutcomes\":[{\"id\":1,\"label\":\"a\",\"content\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"id\":2,\"label\":\"b\",\"content\":\"Understand best practices and standards and their applications.\"},{\"id\":3,\"label\":\"c\",\"content\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"id\":4,\"label\":\"d\",\"content\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"id\":5,\"label\":\"e\",\"content\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"id\":6,\"label\":\"f\",\"content\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"id\":7,\"label\":\"g\",\"content\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"id\":8,\"label\":\"h\",\"content\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"id\":9,\"label\":\"i\",\"content\":\"Assist in the creation of an effective IT project plan.\"},{\"id\":10,\"label\":\"j\",\"content\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"id\":11,\"label\":\"k\",\"content\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"id\":12,\"label\":\"l\",\"content\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"id\":13,\"label\":\"m\",\"content\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"courseLearningOutcomes\":[{\"label\":\"1\",\"content\":\"Develop and execute the project requirements based from the proposal document.\",\"programOutcomes\":[\"e\"]},{\"label\":\"2\",\"content\":\"Test and evaluate the software product to validate for the process and output.\",\"programOutcomes\":[\"f\"]},{\"label\":\"3\",\"content\":\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\",\"programOutcomes\":[\"k\"]}],\"intendedLearningOutcomes\": [],\"weeklyActivities\":{\"totalWeeks\":14,\"weeks\":[]},\"version\":\"1.0.1\"}', 1512231212, 1512233602, 1),
(2, 1, 1, 1, '{\"editor\":{\"id\":\"1\",\"fname\":\"John\",\"mname\":\"Smith\",\"lname\":\"Doe\",\"username\":\"test\"},\"programOutcomes\":[{\"id\":1,\"label\":\"a\",\"content\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"id\":2,\"label\":\"b\",\"content\":\"Understand best practices and standards and their applications.\"},{\"id\":3,\"label\":\"c\",\"content\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"id\":4,\"label\":\"d\",\"content\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"id\":5,\"label\":\"e\",\"content\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"id\":6,\"label\":\"f\",\"content\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"id\":7,\"label\":\"g\",\"content\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"id\":8,\"label\":\"h\",\"content\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"id\":9,\"label\":\"i\",\"content\":\"Assist in the creation of an effective IT project plan.\"},{\"id\":10,\"label\":\"j\",\"content\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"id\":11,\"label\":\"k\",\"content\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"id\":12,\"label\":\"l\",\"content\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"id\":13,\"label\":\"m\",\"content\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"courseLearningOutcomes\":[{\"label\":\"1\",\"content\":\"Develop and execute the project requirements based from the proposal document.\",\"programOutcomes\":[\"e\"]},{\"label\":\"2\",\"content\":\"Test and evaluate the software product to validate for the process and output.\",\"programOutcomes\":[\"f\",\"c\"]},{\"label\":\"3\",\"content\":\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\",\"programOutcomes\":[\"k\"]}],\"intendedLearningOutcomes\": [],\"weeklyActivities\":{\"totalWeeks\":14,\"weeks\":[]},\"version\":\"1.0.1\"}', 1512231212, 1512233606, 1),
(3, 4, 1, 1, '{\"editor\":{\"id\":\"1\",\"fname\":\"John\",\"mname\":\"Smith\",\"lname\":\"Doe\",\"username\":\"test\"},\"programOutcomes\":[{\"id\":1,\"label\":\"a\",\"content\":\"Able to apply knowledge of computing fundamentals, technical concepts and practices, best practices and standards in the application of core information technologies, mathematics, science, and domain knowledge appropriate for the information technology practice to the abstraction and conceptualization of solution models from defined problems and requirements\"},{\"id\":2,\"label\":\"b\",\"content\":\"Identify, formulate, research literature, and analyze user needs and taking them into account to solve complex information technology problems, reaching substantiated conclusions using fundamental principles of mathematics, computing fundamentals, technical concepts and practices in the core information technologies, and relevant domain disciplines.\"},{\"id\":3,\"label\":\"c\",\"content\":\"Design and evaluate possible solutions for complex computing problems, and design and evaluate systems, components, or processes that meet specified user needs with appropriate consideration for public health and safety, cultural, societal, and environmental considerations\"},{\"id\":4,\"label\":\"d\",\"content\":\"An ability to assist in the creation of an effective project plan to implement solution that includes selection, creation, evaluation, and administration of IT Systems\"},{\"id\":5,\"label\":\"e\",\"content\":\"An ability to effectively integrate IT-based solutions into the user environment\"},{\"id\":6,\"label\":\"f\",\"content\":\"An ability to administer delivered information system assuring its appropriateness to the user’s environment\"},{\"id\":7,\"label\":\"g\",\"content\":\"Create, select, adapt and apply appropriate techniques, resources, and modern computing tools to complex computing activities, with an understanding of the limitations\"},{\"id\":8,\"label\":\"h\",\"content\":\"Function effectively as an individual and as a member or leader in diverse teams and in multidisciplinary settings\"},{\"id\":9,\"label\":\"i\",\"content\":\"Communicate effectively with the computing community and with society at large (in local and international scenes) about  complex computing activities by being able to comprehend and write effective reports, design documentation, make effective presentations, and give and understand clear instructions\"},{\"id\":10,\"label\":\"j\",\"content\":\"Understand and assess societal, health, safety, legal, and cultural issues within local and global contexts, and the consequential responsibilities relevant to professional computing practice\"},{\"id\":11,\"label\":\"k\",\"content\":\"Understand and commit to professional ethics, responsibilities, and norms of professional computing practice\"},{\"id\":12,\"label\":\"l\",\"content\":\"Recognize the need, and have the ability, to engage in independent learning for continual development as a computing professional\"}],\"courseLearningOutcomes\":[{\"label\":\"1\",\"content\":\"Understand the fundamental concepts and principles of database management and database administration.\",\"programOutcomes\":[\"a\"]},{\"label\":\"2\",\"content\":\"Analyze business rules and translate them into user requirements.\",\"programOutcomes\":[\"b\"]},{\"label\":\"3\",\"content\":\"Design logical and relational database that meets specified user requirements following relational database design principles and constructs.\",\"programOutcomes\":[\"c\"]},{\"label\":\"4\",\"content\":\"Create SQL statements that retrieve information requirements of the organization needed for reports generation.\",\"programOutcomes\":[\"g\"]}],\"intendedLearningOutcomes\":[],\"weeklyActivities\":{\"totalWeeks\":14,\"weeks\":[]},\"version\":\"2.0\"}', 1514871140, 1514871163, 1);

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` int(11) NOT NULL,
  `label` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `reference` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `label`, `name`, `description`, `reference`, `status`) VALUES
(1, 'Lesson 1', 'Project Development', '', '', 1),
(2, 'Lesson 2', 'Software Evaluation', '', '', 1),
(3, 'Lesson 3', 'Project Control and Project Closure', '', '', 1),
(4, 'Lesson 4', 'Project Management Process Issues', '', '', 1),
(5, 'Lesson 5', 'Writing Proposals', 'Results', '', 1),
(6, 'Lesson 6', 'Writing Proposals', 'Discussion', '', 1),
(7, '', 'Users\' Acceptance Testing', '', '', 1),
(8, 'Module 1', 'The Database Environment and Development Process', 'Basic Concepts and Definitions | Traditional File Processing System | The Database Approach | Components of the Database Environment | Range of Database Applications | The Database Development Process\r\n', '', 1),
(9, 'Module 2', 'Modeling Data in the Organization', 'E-R Model Notation | Modeling the Rules of the Organization | Modeling Entities and Attributes | Modeling Relationships | SQL Data Modeler\r\n', '', 1),
(10, 'Module 3', 'Enhanced E-R Model', 'Representing Supertypes and Subtypes | Specifying Constraints in Supertype/Subtype Relationships | Entity Clustering', '', 1),
(11, 'Module 4', 'Logical Database Design and the Relational Model', 'Relational Data Model | Integrity Constraints | Transforming EER Diagrams into Relations | Introduction to  Normalization', '', 1),
(12, 'Module 5', 'Introduction to SQL', 'Origins of the SQL Standard | The SQL Environment | SQL Statements | SQL Developer and SQL *Plus', '', 1),
(13, 'Module 6', 'Data Definition Language (DDL)', 'Create | Alter | Drop | Rename | Truncate | Comment\r\n', '', 1),
(14, 'Module 7', 'Data Manipulation Language (DML) and Transaction Control', 'Insert | Update | Delete  | Merge | Select | Commit, Rollback and Savepoint\r\n', '', 1),
(15, 'Module 8', 'Advanced SQL', 'Join  | Subqueries | Tips for Developing Queries', '', 1),
(16, 'Module 9', 'Data Control Language (DCL)', 'Grant | Revoke', '', 1),
(17, 'Module 10', 'Data and Database Administration', 'Role of Data and Database Administrators | Open Source Movement and Database Movement | Managing Data Securit | Database Software Data Security Features | Database Backup and Recovery | Recovery and Restart Procedures  | Types of Database Failure | Disaster Recovery | Controlling Concurrent Access | Database Performance Tuning | Data Availability', '', 1),
(18, 'Module 1', 'Introduction to Programming', '', '', 1),
(19, 'Module 2.1', 'Introduction to C++', '', '', 1),
(20, 'Module 2.2', 'Basic Input and Output', '', '', 1),
(21, 'Module 2.3', 'Operators', '', '', 1),
(22, 'Module 3', 'Assignment and Formatting', '', '', 1),
(23, 'Module 4', 'Program Control Structures', '', '', 1),
(24, 'Module 5', 'Repetition Control Structure', '', '', 1),
(25, 'Module 6', 'Introduction to Arrays', '', '', 1);

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
(83, 0, 0, 0),
(84, 0, 0, 0),
(85, 0, 0, 0),
(86, 0, 0, 0),
(87, 0, 0, 0),
(88, 0, 0, 0);

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
  `password` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `type` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `mname`, `lname`, `username`, `password`, `status`, `type`) VALUES
(1, 'John', 'Smith', 'Doe', 'test', '$2a$10$F6ZeGLY.LxQjUyHO7RYxFus3/zMVjPSgkMSq1GVUmlAcoIOwTdMCq', 1, 1);

--
-- Indexes for dumped tables
--

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
-- Indexes for table `outcomes`
--
ALTER TABLE `outcomes`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `syllabi`
--
ALTER TABLE `syllabi`
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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `book_field_relation`
--
ALTER TABLE `book_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `course_field_relation`
--
ALTER TABLE `course_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `curriculum`
--
ALTER TABLE `curriculum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `outcomes`
--
ALTER TABLE `outcomes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `outcome_field_relation`
--
ALTER TABLE `outcome_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `outcome_relation`
--
ALTER TABLE `outcome_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `syllabi`
--
ALTER TABLE `syllabi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `topic_field_relation`
--
ALTER TABLE `topic_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
