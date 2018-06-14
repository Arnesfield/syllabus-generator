-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2018 at 11:44 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

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
(1, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":\"1\"}],[{\"id\":4,\"status\":\"1\"}],[{\"id\":5,\"status\":\"1\"}]]}', 3, 1527422461, 1528682434, 1),
(2, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":2}],[{\"id\":5,\"status\":2}]]}', 3, 1527828566, 1527828566, 3);

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
(1, 'Author Name. (1999). Some title of book or article about Android Development.', '[\"Android Application Development\"]', 0, 1522834404, 1),
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
(18, 'Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ', '[\"Capstone Project\",\"Project Management\",\"System Analysis\",\"System Design\"]', 0, 1526302967, 1),
(19, 'Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press', '[\"Software Requirements\",\"Capstone Project\",\"Project Management\"]', 0, 1526302661, 1),
(20, 'Puntambekar, A. (2014). Object oriented analysis & design: a conceptual approach. Technical Publication: New Delhi', '', 0, 0, 1),
(21, 'Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology', '[\"Capstone Project\",\"Project Management\"]', 0, 1526302620, 1),
(22, 'Test1', '', 0, 0, 1),
(23, 'Test2', '', 0, 0, 0),
(24, 'Test3', '', 0, 0, 1),
(25, 'Test4', '', 0, 0, 1),
(26, 'Test5', '', 0, 0, 0),
(27, 'test', '[\"VBScript\",\"Programming\"]', 1522315610, 1522315748, 1);

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
(1, 5, 1, 'test', 2, 1528682509, 1);

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
(5, 'COMPUTER PROGRAMMING 1', 'ITPROG1', 'This course is an introduction to programming which will provide the students the skills in programming through the use of conventional techniques of flowcharting and pseudo-coding.', '<p>Upon successful completion of this course, the student will be able to:</p> <ul>   <li>Know the similarities and differences between C and C++</li>   <li>Translate logic formulation into algorithms and flowchart;</li>   <li>Create working C++ programs;</li>   <li>Test and debug C++ programs; and</li>   <li>Create simple programs for input and output operations</li>   <li>Use the visual studio IDE in running C++ programs.</li>   <li>Understand and apply different control structures of C++</li>   <li>Understand and apply the principles of data storage and array manipulation</li>   <li>Perform tests in programs by using the \"if\" and \"switch\" control flow branching statements and repeat code segments by including \"for, while,\" and \"do…while\" control flow loops</li>   <li>Use critical thinking skills to create and debug C programs.</li> </ul>', 2, 1, '[]', '[]', '[\"14\"]', 0, 1522907882, 1),
(6, 'PROJECT MANAGEMENT FOR IT-WMA', 'ITWPROMAN', 'This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.', '', 3, 0, '[]', '[]', '[\"3\"]', 0, 1523780512, 1),
(7, 'SOME COURSE TITLE 1', 'NEWCOURSE1', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 2, 1, '', '', '', 0, 0, 0),
(8, 'SOME COURSE TITLE 2', 'NEWCOURSE2', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 1),
(9, 'SOME COURSE TITLE 3', 'NEWCOURSE3', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 0),
(10, 'SOME COURSE TITLE 4', 'NEWCOURSE4', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 2, 1, '', '', '', 0, 0, 1),
(11, 'SOME COURSE TITLE 5', 'NEWCOURSE5', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 1),
(12, '', '', '', '', 0, 0, '', '', '', 0, 0, 1),
(13, 'Some new course 1', 'SOMENEW1', 'Some nice course description\r\n1. with numbers :o\r\n2. waw\r\n3. another', 'Some nice course objectives with bullets\r\n- nice\r\n- waw\r\n    - sub-bullets too\r\n    - sub-bullets too', 3, 0, '[\"Programming\",\"Animation\"]', '[\"3\"]', '[\"2\",\"1\"]', 1522424825, 1523780496, 1),
(14, 'COMPUTER PROGRAMMING 1 FOR IT (LAB)', 'ITPROG1L', 'Test', 'test', 0, 1, '[]', '[]', '[]', 1522907865, 1522907865, 1);

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
(2, '2017', '[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}]', 1, 0, 1522772992, 1),
(3, '2018', '[{\"label\":\"a\",\"text\":\"Sample\"}]', 0, 1522493286, 1527831387, 1);

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
  `tags` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `name`, `description`, `tags`, `status`) VALUES
(1, 'Whiteboard', '', '[\"Capstone Project\"]', 1),
(2, 'Net book', '', '[\"Capstone Project\"]', 1),
(3, 'DLP', '', '[\"Capstone Project\"]', 1);

-- --------------------------------------------------------

--
-- Table structure for table `outcomes`
--

CREATE TABLE `outcomes` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `type` tinyint(4) NOT NULL,
  `tags` text NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `outcomes`
--

INSERT INTO `outcomes` (`id`, `content`, `type`, `tags`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Develop and execute the project requirements based from the proposal document.', 1, '[\"Capstone Project\"]', 0, 1528031100, 1),
(2, 'Test and evaluate the software product to validate for the process and output.', 1, '[\"Capstone Project\"]', 0, 0, 1),
(3, 'Complete the system defined in the plan to satisfy the project specifications and present final documentation.', 1, '[\"Capstone Project\"]', 0, 0, 1),
(4, 'Understand the fundamental concepts and principles of database management and database administration.', 1, '[\"Database\"]', 0, 0, 1),
(5, 'Analyze business rules and translate them into user requirements.', 1, '[\"Database\"]', 0, 0, 1),
(6, 'Design logical and relational database that meets specified user requirements following relational database design principles and constructs.', 1, '[\"Database\"]', 0, 0, 1),
(7, 'Create SQL statements that retrieve information requirements of the organization needed for reports generation.', 1, '[\"Database\"]', 0, 0, 1),
(8, 'Develop, execute and create the project deliverables.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(9, 'Test the software product to validate its process and output.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(10, 'Complete the work defined in the plan to satisfy the project specifications.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(11, 'Complete the 50% software development stated in the proposal.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(12, 'Understand Project Review and closure.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(13, 'Complete the 75% software development stated in the proposal.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(14, 'Create and present the final documentation.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(15, 'Execution of user acceptance testing.', 2, '[\"Capstone Project\"]', 0, 0, 1),
(16, 'Mock defense', 2, '[\"Capstone Project\"]', 0, 0, 1),
(17, 'Project Final Defense/Presentation', 2, '[\"Capstone Project\"]', 0, 0, 1),
(18, 'Revision of Software and Documents', 2, '[\"Capstone Project\"]', 0, 0, 1),
(19, 'Submission of Final Requirements', 2, '[\"Capstone Project\"]', 0, 0, 1),
(20, 'Discussion of the Guidelines', 3, '[\"Capstone Project\"]', 0, 0, 1),
(21, 'Classroom Discussion', 3, '[\"Capstone Project\"]', 0, 0, 1),
(22, 'Class/Library Activity; Research current trends in IT.', 3, '[\"Capstone Project\"]', 0, 0, 1),
(23, 'Require instrument for software testing.', 3, '[\"Capstone Project\"]', 0, 0, 1),
(24, 'Actual user acceptance', 3, '[\"Capstone Project\"]', 0, 0, 1),
(25, 'Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.', 4, '[\"Capstone Project\"]', 0, 0, 1),
(26, 'Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.', 4, '[\"Capstone Project\"]', 0, 0, 1),
(27, 'Follow formulated testing instrument and comply with the checking and testing of the software.', 4, '[\"Capstone Project\"]', 0, 0, 1),
(28, 'The students can identify and describe Project Management Groups needed for a project. Determine their role in project development.', 4, '[\"Capstone Project\"]', 0, 0, 1),
(29, 'The students can be able to produce Results and Discussion of the Proposal Paper.', 4, '[\"Capstone Project\"]', 0, 0, 1),
(30, 'Conducts user acceptance testing', 4, '[\"Capstone Project\"]', 0, 0, 1),
(31, 'Test', 1, '', 0, 0, 0);

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
(1, 'syllabusContent', '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\"}', 1523275579),
(2, 'gradingSystem', '[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises\\/Machine Problems 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Project\\/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises\\/Machine Problems 40%\\n    2. Teacher\\u2019s Evaluation 5%\\n    3. Project\\/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}]', 1523275585),
(3, 'cloOptions', '[{\"symbol\":\"I\",\"text\":\"Introductory\"},{\"symbol\":\"E\",\"text\":\"Engaging\"},{\"symbol\":\"D\",\"text\":\"Demonstrative\"}]', 1523275586);

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
(1, 1, 3, 1, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"\",\"weight\":\"0\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}],[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":5,\"status\":1,\"user\":{\"id\":\"5\",\"fname\":\"Rossana\",\"mname\":\"T.\",\"lname\":\"Adao\",\"username\":\"joanne\",\"title\":\"Senior Director, CCS\",\"weight\":\"10\",\"password\":\"$2y$10$Q61GloOCeRIHKx1Gz7atr.Y9ujWhJqfA8Tmix98awgRjFDW9PKZRa\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522867906\",\"auth\":\"[\\\"5\\\"]\"}}]],\"bookReferences\":[\"Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology\",\"Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press\",\"Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ\"],\"programOutcomes\":{\"id\":\"2\",\"label\":\"2017\",\"content\":[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"latest\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522772992\",\"status\":\"1\"},\"courseLearningOutcomes\":[\"Develop and execute the project requirements based from the proposal document.\",\"Test and evaluate the software product to validate for the process and output.\",\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\"],\"intendedLearningOutcomes\":[],\"cloPoMap\":[{\"d\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"e\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"i\":{\"symbol\":\"I\",\"text\":\"Introductory\"}}],\"weeklyActivities\":[{\"noOfWeeks\":1,\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 1. Project Development\",\"Lesson 2. Software Evaluation\"],\"ilo\":[\"Develop, execute and create the project deliverables.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[0],\"tlaFaculty\":[\"Discussion of the Guidelines\"],\"tlaStudent\":[\"Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.\",\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\"],\"instructionalMaterials\":[\"Whiteboard\"],\"assessmentTasks\":[\"Group Presentation\",\"Group Dynamics\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":\"2\",\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 2. Software Evaluation\",\"Lesson 3. Project Control and Project Closure\"],\"ilo\":[\"Complete the work defined in the plan to satisfy the project specifications.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[1,2],\"tlaFaculty\":[\"Require instrument for software testing.\",\"Class/Library Activity; Research current trends in IT.\"],\"tlaStudent\":[\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\",\"The students can be able to produce Results and Discussion of the Proposal Paper.\"],\"instructionalMaterials\":[\"DLP\",\"Net book\"],\"assessmentTasks\":[\"Documentation\",\"Class Activity\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"2\",\"topics\":[],\"ilo\":[],\"cloMap\":[0,1],\"tlaFaculty\":[],\"tlaStudent\":[],\"instructionalMaterials\":[],\"assessmentTasks\":[\"Testing\"],\"text\":\"Final Exam\",\"asObject\":false}],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"versionType\":0,\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"[]\",\"corequisites\":\"[\\\"3\\\"]\",\"created_at\":\"0\",\"updated_at\":\"1523780512\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1522415141\",\"status\":\"1\"}}', '1.0', 1527422833, 1527424326, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `tags` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `name`, `description`, `tags`, `status`) VALUES
(1, 'Assignment', '', '[\"Programming\",\"Database\"]', 1),
(2, 'Recitation', '', '[\"Programming\",\"Database\"]', 1),
(3, 'Short Quiz', '', '[\"Programming\",\"Database\"]', 1),
(4, 'Case Study 1', '', '[\"Programming\"]', 1),
(5, 'Seatwork/Boardwork', '', '[\"Programming\",\"Database\"]', 1),
(6, 'Lab Exercise 1', '', '[\"Programming\"]', 1),
(7, 'Case Study 3', '', '[\"Programming\"]', 1),
(8, 'Lab Exercise 2', '', '[\"Programming\"]', 1),
(9, 'Case Study 4', '', '[\"Programming\"]', 1),
(10, 'Lab Exercise 3', '', '[\"Programming\"]', 1),
(11, 'Case Study 5', '', '[\"Programming\"]', 1),
(12, 'Lab Exercise 4', '', '[\"Programming\"]', 1),
(13, 'Case Study 6', '', '[\"Programming\"]', 1),
(14, 'Lab Exercise 5', '', '[\"Database\"]', 1),
(15, 'Lab Exercise 6', '', '[\"Database\"]', 1),
(16, 'Case Study 7', '', '[\"Database\"]', 1),
(17, 'Lab Exercise 7', '', '[\"Database\"]', 1),
(18, 'Lab Exercise 8', '', '[\"Database\"]', 1),
(19, 'Seatwork', '', '[\"Programming\",\"Database\"]', 1),
(20, 'Group Dynamics', '', '[\"Capstone Project\"]', 1),
(21, 'Group Presentation', '', '[\"Capstone Project\"]', 1),
(22, 'Class Activity', '', '[\"Capstone Project\"]', 1),
(23, 'Documentation', '', '[\"Capstone Project\"]', 1),
(24, 'Testing', '', '[\"Capstone Project\"]', 1);

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tags` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `name`, `tags`, `status`) VALUES
(1, 'Lesson 1. Project Development', '[\"Capstone Project\"]', 1),
(2, 'Lesson 2. Software Evaluation', '[\"Capstone Project\"]', 1),
(3, 'Lesson 3. Project Control and Project Closure', '[\"Capstone Project\"]', 1),
(4, 'Lesson 4. Project Management Process Issues', '[\"Capstone Project\"]', 1),
(5, 'Lesson 5. Writing Proposals', '[\"Capstone Project\"]', 1),
(6, 'Lesson 6. Writing Proposals', '[\"Capstone Project\"]', 1),
(7, 'Users\' Acceptance Testing', '[\"Capstone Project\"]', 1),
(8, 'Module 1. The Database Environment and Development Process', '[\"Database\"]', 1),
(9, 'Module 2. Modeling Data in the Organization', '[\"Database\"]', 1),
(10, 'Module 3. Enhanced E-R Model', '[\"Database\"]', 1),
(11, 'Module 4. Logical Database Design and the Relational Model', '[\"Database\"]', 1),
(12, 'Module 5. Introduction to SQL', '[\"Database\"]', 1),
(13, 'Module 6. Data Definition Language (DDL)', '[\"Database\"]', 1),
(14, 'Module 7. Data Manipulation Language (DML) and Transaction Control', '[\"Database\"]', 1),
(15, 'Module 8. Advanced SQL', '[\"Database\"]', 1),
(16, 'Module 9. Data Control Language (DCL)', '[\"Database\"]', 1),
(17, 'Module 10. Data and Database Administration', '[\"Database\"]', 1),
(18, 'Module 1. Introduction to Programming', '[\"Programming\"]', 1),
(19, 'Module 2.1. Introduction to C++', '[\"Programming\"]', 1),
(20, 'Module 2.2. Basic Input and Output', '[\"Programming\"]', 1),
(21, 'Module 2.3. Operators', '[\"Programming\"]', 1),
(22, 'Module 3. Assignment and Formatting', '[\"Programming\"]', 1),
(23, 'Module 4. Program Control Structures', '[\"Programming\"]', 1),
(24, 'Module 5. Repetition Control Structure', '[\"Programming\"]', 1),
(25, 'Module 6. Introduction to Arrays', '[\"Programming\"]', 1),
(26, 'PBL Orientation', '[\"Capstone Project\"]', 1),
(27, 'Sample topic 1', '', 1),
(28, 'Sample topic 2', '', 1),
(29, 'Sample topic 3', '', 1);

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
(1, 'John', 'Smith', 'Doe', 'test', 'Admin', 0, '$2y$10$tEU6V/HbHOZ59TQQpUrIb.eE3enrCo5i.fYkvSKY9EPFwJJqnMh1C', 'F_1522260047.png', '[]', 1, 0, 1522834696, '[\"1\"]'),
(2, 'Jane', '', 'Doe', 'charlyn', '', 0, '$2y$10$3jQ.7tz1XYlAyMzsU1Mgfu9XciWKkMa26yPfiV2bPLGP0nVsniDuq', '', '', 1, 0, 1521732242, '[\"3\"]'),
(3, 'Smith', '', 'Paul', 'ralph', '', 0, '$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6', '', '', 1, 0, 0, '[\"3\",\"4\"]'),
(4, 'Roman', '', 'De Angel', 'roman', 'Coordinator, ITWMA', 1, '$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO', '', '[]', 1, 0, 1522835142, '[\"3\",\"5\"]'),
(5, 'Rossana', 'T.', 'Adao', 'joanne', 'Senior Director, CCS', 10, '$2y$10$Q61GloOCeRIHKx1Gz7atr.Y9ujWhJqfA8Tmix98awgRjFDW9PKZRa', '', '[]', 1, 0, 1522867906, '[\"5\"]'),
(8, 'Ace', 'C.', 'Lagman', 'lagman', 'Program Director, IT', 1, '$2y$10$XVY3K2/Mh/Ry7.Uqm/Va/up9eFgKwVyqOYkD67.3ueju2yfRbRUdu', 'F_1522263636.png', '[\"Software Testing\",\"Programming\",\"Android Application Development\",\"JavaScript\",\"Ruby\",\"NodeJS\",\"AngularJS\"]', 1, 1522263636, 1522835033, '[\"5\"]');

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
(1, 3, 1, 'viewed this syllabus.', 'view', 1527827835, 1),
(2, 3, 1, 'viewed this syllabus.', 'view', 1527828400, 1),
(3, 4, 1, 'viewed this syllabus.', 'view', 1528682422, 1),
(4, 4, 1, '<strong>level 1</strong> &mdash; approved this syllabus.', 'approval', 1528682423, 1),
(5, 4, 1, '<strong>level 2</strong> &mdash; approved this syllabus.', 'approval', 1528682425, 1),
(6, 5, 1, 'viewed this syllabus.', 'view', 1528682433, 1),
(7, 5, 1, '<strong>level 3</strong> &mdash; approved this syllabus.', 'approval', 1528682434, 1),
(8, 5, 1, 'viewed this syllabus.', 'view', 1528682440, 1),
(9, 5, 1, 'viewed this syllabus.', 'view', 1528682446, 1),
(10, 5, 1, 'viewed this syllabus.', 'view', 1528682449, 1),
(11, 5, 1, 'viewed this syllabus.', 'view', 1528682506, 1),
(12, 3, 1, 'viewed this syllabus.', 'view', 1528788853, 1),
(13, 3, 1, 'viewed this syllabus.', 'view', 1528789387, 1),
(14, 3, 1, 'viewed this syllabus.', 'view', 1528861615, 1),
(15, 3, 1, 'viewed this syllabus.', 'view', 1528965269, 1);

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
ALTER TABLE `books` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`tags`);
ALTER TABLE `books` ADD FULLTEXT KEY `FULLTEXT_INDEX_CITATION_TAGS` (`citation`,`tags`);

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
ALTER TABLE `courses` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`code`,`title`,`tags`);

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
ALTER TABLE `materials` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`tags`);
ALTER TABLE `materials` ADD FULLTEXT KEY `FULLTEXT_INDEX_NAME_TAGS` (`name`,`tags`);

--
-- Indexes for table `outcomes`
--
ALTER TABLE `outcomes`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `outcomes` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`content`);
ALTER TABLE `outcomes` ADD FULLTEXT KEY `FULLTEXT_INDEX_TAGS` (`tags`);
ALTER TABLE `outcomes` ADD FULLTEXT KEY `FULLTEXT_INDEX_CONTENT_TAGS` (`content`,`tags`);

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
ALTER TABLE `tasks` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`tags`);
ALTER TABLE `tasks` ADD FULLTEXT KEY `FULLTEXT_INDEX_NAME_TAGS` (`name`,`tags`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `topics` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`tags`);
ALTER TABLE `topics` ADD FULLTEXT KEY `FULLTEXT_INDEX_NAME_TAGS` (`name`,`tags`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);
ALTER TABLE `users` ADD FULLTEXT KEY `FULLTEXT_INDEX` (`fname`,`mname`,`lname`,`username`,`title`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
-- AUTO_INCREMENT for table `outcomes`
--
ALTER TABLE `outcomes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `workflow_logs`
--
ALTER TABLE `workflow_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
