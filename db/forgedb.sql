-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2017 at 04:34 PM
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
(2, 'Author Name. (2001). Some book about JavaScript.', 1);

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
(16, 'JavaScript', '', 1);

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
(1, 2, 1, 1, '{\"editor\":{\"id\":\"1\",\"fname\":\"John\",\"mname\":\"Smith\",\"lname\":\"Doe\",\"username\":\"test\"},\"programOutcomes\":[{\"id\":1,\"label\":\"a\",\"content\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"id\":2,\"label\":\"b\",\"content\":\"Understand best practices and standards and their applications.\"},{\"id\":3,\"label\":\"c\",\"content\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"id\":4,\"label\":\"d\",\"content\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"id\":5,\"label\":\"e\",\"content\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"id\":6,\"label\":\"f\",\"content\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"id\":7,\"label\":\"g\",\"content\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"id\":8,\"label\":\"h\",\"content\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"id\":9,\"label\":\"i\",\"content\":\"Assist in the creation of an effective IT project plan.\"},{\"id\":10,\"label\":\"j\",\"content\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"id\":11,\"label\":\"k\",\"content\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"id\":12,\"label\":\"l\",\"content\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"id\":13,\"label\":\"m\",\"content\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"courseLearningOutcomes\":[{\"label\":\"1\",\"content\":\"Develop and execute the project requirements based from the proposal document.\",\"programOutcomes\":[\"e\"]},{\"label\":\"2\",\"content\":\"Test and evaluate the software product to validate for the process and output.\",\"programOutcomes\":[\"f\"]},{\"label\":\"3\",\"content\":\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\",\"programOutcomes\":[\"k\"]}],\"version\":\"1.0.1\"}', 1512231212, 1512233602, 1),
(2, 2, 1, 1, '{\"editor\":{\"id\":\"1\",\"fname\":\"John\",\"mname\":\"Smith\",\"lname\":\"Doe\",\"username\":\"test\"},\"programOutcomes\":[{\"id\":1,\"label\":\"a\",\"content\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"id\":2,\"label\":\"b\",\"content\":\"Understand best practices and standards and their applications.\"},{\"id\":3,\"label\":\"c\",\"content\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"id\":4,\"label\":\"d\",\"content\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"id\":5,\"label\":\"e\",\"content\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"id\":6,\"label\":\"f\",\"content\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"id\":7,\"label\":\"g\",\"content\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"id\":8,\"label\":\"h\",\"content\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"id\":9,\"label\":\"i\",\"content\":\"Assist in the creation of an effective IT project plan.\"},{\"id\":10,\"label\":\"j\",\"content\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"id\":11,\"label\":\"k\",\"content\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"id\":12,\"label\":\"l\",\"content\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"id\":13,\"label\":\"m\",\"content\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"courseLearningOutcomes\":[{\"label\":\"1\",\"content\":\"Develop and execute the project requirements based from the proposal document.\",\"programOutcomes\":[\"e\"]},{\"label\":\"2\",\"content\":\"Test and evaluate the software product to validate for the process and output.\",\"programOutcomes\":[\"f\",\"c\"]},{\"label\":\"3\",\"content\":\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\",\"programOutcomes\":[\"k\"]}],\"version\":\"1.0.1\"}', 1512231212, 1512233606, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `syllabi`
--
ALTER TABLE `syllabi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
