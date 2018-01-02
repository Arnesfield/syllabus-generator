-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2018 at 05:17 AM
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
(2, 'Author\'s Name. (2001). Some book about JavaScript.', 1);

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
(9, 2, 3, 1);

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
(3, 'WEB APPLICATION DEVELOPMENT 2', 'ITWSPEC6', 'Some description about web application development using PHP frameworks.', 2, 1, 3, 1);

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
(14, 3, 9, 1);

-- --------------------------------------------------------

--
-- Table structure for table `curriculum`
--

CREATE TABLE `curriculum` (
  `id` int(11) NOT NULL,
  `label` varchar(4) NOT NULL,
  `content` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `curriculum`
--

INSERT INTO `curriculum` (`id`, `label`, `content`, `status`) VALUES
(1, 'a', 'Apply knowledge of computing, science and mathematics appropriate to the discipline.', 1),
(2, 'b', 'Understand best practices and standards and their applications.', 1),
(3, 'c', 'Analyze complex problems and identify and define the computing requirements appropriate to its solution.', 1),
(4, 'd', 'Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.', 1),
(5, 'e', 'Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.', 1),
(6, 'f', 'Integrate IT-based solutions into the user environment effectively.', 1),
(7, 'g', 'Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.', 1),
(8, 'h', 'Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.', 1),
(9, 'i', 'Assist in the creation of an effective IT project plan.', 1),
(10, 'j', 'Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.', 1),
(11, 'k', 'Analyze the local and global impact of computing information technology on individuals, organizations and society.', 1),
(12, 'l', 'Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.', 1),
(13, 'm', 'Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.', 1);

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
(37, 'Basic Input and Output', '', 1);

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
(1, 2, 1, 1, '{\"editor\":{\"id\":\"1\",\"fname\":\"John\",\"mname\":\"Smith\",\"lname\":\"Doe\",\"username\":\"test\"},\"programOutcomes\":[{\"id\":1,\"label\":\"a\",\"content\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"id\":2,\"label\":\"b\",\"content\":\"Understand best practices and standards and their applications.\"},{\"id\":3,\"label\":\"c\",\"content\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"id\":4,\"label\":\"d\",\"content\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"id\":5,\"label\":\"e\",\"content\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"id\":6,\"label\":\"f\",\"content\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"id\":7,\"label\":\"g\",\"content\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"id\":8,\"label\":\"h\",\"content\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"id\":9,\"label\":\"i\",\"content\":\"Assist in the creation of an effective IT project plan.\"},{\"id\":10,\"label\":\"j\",\"content\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"id\":11,\"label\":\"k\",\"content\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"id\":12,\"label\":\"l\",\"content\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"id\":13,\"label\":\"m\",\"content\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"courseLearningOutcomes\":[{\"label\":\"1\",\"content\":\"Develop and execute the project requirements based from the proposal document.\",\"programOutcomes\":[\"e\"]},{\"label\":\"2\",\"content\":\"Test and evaluate the software product to validate for the process and output.\",\"programOutcomes\":[\"f\"]},{\"label\":\"3\",\"content\":\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\",\"programOutcomes\":[\"k\"]}],\"intendedLearningOutcomes\": [],\"weeklyActivities\":{\"totalWeeks\":14,\"weeks\":[]},\"version\":\"1.0.1\"}', 1512231212, 1512233602, 1),
(2, 2, 1, 1, '{\"editor\":{\"id\":\"1\",\"fname\":\"John\",\"mname\":\"Smith\",\"lname\":\"Doe\",\"username\":\"test\"},\"programOutcomes\":[{\"id\":1,\"label\":\"a\",\"content\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"id\":2,\"label\":\"b\",\"content\":\"Understand best practices and standards and their applications.\"},{\"id\":3,\"label\":\"c\",\"content\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"id\":4,\"label\":\"d\",\"content\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"id\":5,\"label\":\"e\",\"content\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"id\":6,\"label\":\"f\",\"content\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"id\":7,\"label\":\"g\",\"content\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"id\":8,\"label\":\"h\",\"content\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"id\":9,\"label\":\"i\",\"content\":\"Assist in the creation of an effective IT project plan.\"},{\"id\":10,\"label\":\"j\",\"content\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"id\":11,\"label\":\"k\",\"content\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"id\":12,\"label\":\"l\",\"content\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"id\":13,\"label\":\"m\",\"content\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"courseLearningOutcomes\":[{\"label\":\"1\",\"content\":\"Develop and execute the project requirements based from the proposal document.\",\"programOutcomes\":[\"e\"]},{\"label\":\"2\",\"content\":\"Test and evaluate the software product to validate for the process and output.\",\"programOutcomes\":[\"f\",\"c\"]},{\"label\":\"3\",\"content\":\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\",\"programOutcomes\":[\"k\"]}],\"intendedLearningOutcomes\": [],\"weeklyActivities\":{\"totalWeeks\":14,\"weeks\":[]},\"version\":\"1.0.1\"}', 1512231212, 1512233606, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `book_field_relation`
--
ALTER TABLE `book_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course_field_relation`
--
ALTER TABLE `course_field_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `curriculum`
--
ALTER TABLE `curriculum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `syllabi`
--
ALTER TABLE `syllabi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
