-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 07, 2018 at 10:59 PM
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
(2, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":\"1\"}],[{\"id\":5,\"status\":2}]]}', 3, 1527828566, 1531226945, 2),
(3, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":2}],[{\"id\":4,\"status\":2}]]}', 3, 1531233046, 1531238441, 2),
(4, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":\"1\"}],[{\"id\":4,\"status\":\"1\"}]]}', 3, 1531762352, 1531762483, 1),
(5, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":\"1\"}],[{\"id\":4,\"status\":\"1\"}]]}', 3, 1531816880, 1532696619, 1),
(6, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":4,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":\"1\"}],[{\"id\":4,\"status\":\"1\"},{\"id\":8,\"status\":\"1\"}],[{\"id\":8,\"status\":\"1\"},{\"id\":5,\"status\":\"1\"}]]}', 3, 1533052595, 1533054466, 1),
(7, '{\"assigned\":{\"id\":3,\"status\":2},\"course\":1,\"remarks\":null,\"levels\":[[{\"id\":4,\"status\":2}],[{\"id\":4,\"status\":2}]]}', 3, 1533551073, 1533551073, 3);

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `related_user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `assign_id` int(11) NOT NULL,
  `curriculum_id` int(11) NOT NULL,
  `outcome_id` int(11) NOT NULL,
  `syllabus_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `category` tinyint(4) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `user_id`, `related_user_id`, `course_id`, `assign_id`, `curriculum_id`, `outcome_id`, `syllabus_id`, `book_id`, `content`, `category`, `type`, `created_at`, `status`) VALUES
(1, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531641802, 1),
(2, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531645955, 1),
(3, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531645957, 1),
(4, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531645959, 1),
(5, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531645962, 1),
(6, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531646044, 1),
(7, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531646047, 1),
(8, 3, 0, 0, 3, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1531646053, 1),
(9, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531646060, 1),
(10, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531646072, 1),
(11, 1, 0, 4, 0, 0, 0, 0, 0, 'Updated Course 4', 4, 2, 1531652288, 1),
(12, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531658523, 1),
(13, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531658525, 1),
(14, 3, 0, 0, 3, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1531658534, 1),
(15, 3, 0, 0, 3, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1531658914, 1),
(16, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531658917, 1),
(17, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531658919, 1),
(18, 1, 0, 0, 0, 0, 0, 0, 8, 'Updated Book 8', 7, 2, 1531659890, 1),
(19, 1, 0, 0, 0, 0, 0, 0, 0, '', 10, 1, 1531660335, 1),
(20, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531733642, 1),
(21, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531756825, 1),
(22, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531762315, 1),
(23, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531762319, 1),
(24, 3, 0, 0, 0, 0, 0, 0, 0, '', 11, 1, 1531762352, 1),
(25, 3, 0, 0, 0, 0, 0, 4, 0, 'Saved Syllabus 4', 12, 1, 1531762451, 1),
(26, 3, 0, 0, 0, 0, 0, 4, 0, 'Saved Syllabus 4', 12, 1, 1531762461, 1),
(27, 3, 0, 0, 0, 0, 0, 4, 0, 'Saved Syllabus 4', 12, 1, 1531762463, 1),
(28, 3, 0, 0, 0, 0, 0, 4, 0, 'Submitted Syllabus 4', 12, 2, 1531762463, 1),
(29, 3, 0, 0, 4, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1531762465, 1),
(30, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531762470, 1),
(31, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531762473, 1),
(32, 4, 0, 0, 4, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1531762479, 1),
(33, 4, 0, 0, 4, 0, 0, 0, 0, '<strong>level 1</strong> &mdash; approved this syllabus.', 2, 2, 1531762481, 1),
(34, 4, 0, 0, 4, 0, 0, 0, 0, '<strong>level 2</strong> &mdash; approved this syllabus.', 2, 2, 1531762483, 1),
(35, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531762486, 1),
(36, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531762489, 1),
(37, 1, 0, 0, 0, 0, 0, 1, 0, 'Viewed Syllabus 1', 14, 1, 1531762630, 1),
(38, 1, 0, 0, 0, 0, 0, 1, 0, 'Viewed Syllabus 1', 14, 1, 1531762693, 1),
(39, 1, 0, 0, 0, 0, 0, 4, 0, 'Viewed Syllabus 4', 14, 1, 1531762697, 1),
(40, 1, 0, 0, 0, 0, 0, 4, 0, 'Viewed Syllabus 4', 14, 1, 1531762958, 1),
(41, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531816586, 1),
(42, 3, 0, 3, 0, 0, 0, 0, 0, 'Viewed Course 3', 13, 1, 1531816627, 1),
(43, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1531816631, 1),
(44, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1531816636, 1),
(45, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1531816637, 1),
(46, 3, 0, 0, 0, 0, 0, 1, 0, 'Viewed Syllabus 1', 14, 1, 1531816780, 1),
(47, 3, 0, 2, 0, 0, 0, 0, 0, 'Viewed Course 2', 13, 1, 1531816821, 1),
(48, 3, 0, 0, 0, 0, 0, 0, 0, '', 11, 1, 1531816880, 1),
(49, 3, 0, 2, 0, 0, 0, 0, 0, 'Viewed Course 2', 13, 1, 1531817076, 1),
(50, 3, 0, 11, 0, 0, 0, 0, 0, 'Viewed Course 11', 13, 1, 1531817985, 1),
(51, 3, 0, 12, 0, 0, 0, 0, 0, 'Viewed Course 12', 13, 1, 1531818034, 1),
(52, 3, 0, 5, 0, 0, 0, 0, 0, 'Viewed Course 5', 13, 1, 1531818038, 1),
(53, 3, 0, 4, 0, 0, 0, 0, 0, 'Viewed Course 4', 13, 1, 1531818043, 1),
(54, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1531818357, 1),
(55, 3, 0, 4, 0, 0, 0, 0, 0, 'Viewed Course 4', 13, 1, 1531818398, 1),
(56, 3, 0, 2, 0, 0, 0, 0, 0, 'Viewed Course 2', 13, 1, 1531818448, 1),
(57, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1531818450, 1),
(58, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1531818472, 1),
(59, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1531840356, 1),
(60, 3, 0, 8, 0, 0, 0, 0, 0, 'Viewed Course 8', 13, 1, 1531840358, 1),
(61, 3, 0, 8, 0, 0, 0, 0, 0, 'Viewed Course 8 Tree', 13, 2, 1531840360, 1),
(62, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532000517, 1),
(63, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532000608, 1),
(64, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532022865, 1),
(65, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532023520, 1),
(66, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532025417, 1),
(67, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532028837, 1),
(68, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532030216, 1),
(69, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532265263, 1),
(70, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532349220, 1),
(71, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532352366, 1),
(72, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532364931, 1),
(73, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532440909, 1),
(74, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532440926, 1),
(75, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532524499, 1),
(76, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532528558, 1),
(77, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532538846, 1),
(78, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532551557, 1),
(79, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532551560, 1),
(80, 3, 0, 0, 0, 0, 0, 4, 0, 'Viewed Syllabus 4', 14, 1, 1532552353, 1),
(81, 3, 0, 4, 0, 0, 0, 0, 0, 'Viewed Course 4', 13, 1, 1532552358, 1),
(82, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532552360, 1),
(83, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532552366, 1),
(84, 3, 0, 0, 0, 0, 0, 1, 0, 'Viewed Syllabus 1', 14, 1, 1532552368, 1),
(85, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532552633, 1),
(86, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532557980, 1),
(87, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532603008, 1),
(88, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532603188, 1),
(89, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1532603190, 1),
(90, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532603202, 1),
(91, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1532603278, 1),
(92, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1532603318, 1),
(93, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1532603337, 1),
(94, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1532604179, 1),
(95, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1532604361, 1),
(96, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532615106, 1),
(97, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532619344, 1),
(98, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532619380, 1),
(99, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532619458, 1),
(100, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532619516, 1),
(101, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532619653, 1),
(102, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532619724, 1),
(103, 2, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532619748, 1),
(104, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532621011, 1),
(105, 2, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532621034, 1),
(106, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532621903, 1),
(107, 2, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532621916, 1),
(108, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532622336, 1),
(109, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532622466, 1),
(110, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532631997, 1),
(111, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1532632025, 1),
(112, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532632030, 1),
(113, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532633995, 1),
(114, 3, 0, 0, 0, 0, 0, 4, 0, 'Viewed Syllabus 4', 14, 1, 1532633998, 1),
(115, 3, 0, 4, 0, 0, 0, 0, 0, 'Viewed Course 4', 13, 1, 1532636919, 1),
(116, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532636920, 1),
(117, 3, 0, 0, 0, 0, 0, 1, 0, 'Viewed Syllabus 1', 14, 1, 1532636923, 1),
(118, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532661416, 1),
(119, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532678208, 1),
(120, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532678211, 1),
(121, 3, 0, 0, 0, 0, 0, 4, 0, 'Viewed Syllabus 4', 14, 1, 1532678213, 1),
(122, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532693075, 1),
(123, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532693087, 1),
(124, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532696388, 1),
(125, 3, 0, 0, 0, 0, 0, 5, 0, 'Saved Syllabus 5', 12, 1, 1532696564, 1),
(126, 3, 0, 0, 0, 0, 0, 5, 0, 'Submitted Syllabus 5', 12, 2, 1532696564, 1),
(127, 3, 0, 0, 5, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1532696568, 1),
(128, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1532696571, 1),
(129, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532696574, 1),
(130, 4, 0, 0, 5, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1532696617, 1),
(131, 4, 0, 0, 5, 0, 0, 0, 0, '<strong>level 1</strong> &mdash; approved this syllabus.', 2, 2, 1532696618, 1),
(132, 4, 0, 0, 5, 0, 0, 0, 0, '<strong>level 2</strong> &mdash; approved this syllabus.', 2, 2, 1532696619, 1),
(133, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532697635, 1),
(134, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1532701027, 1),
(135, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532701029, 1),
(136, 3, 0, 4, 0, 0, 0, 0, 0, 'Viewed Course 4', 13, 1, 1532701120, 1),
(137, 3, 0, 13, 0, 0, 0, 0, 0, 'Viewed Course 13', 13, 1, 1532701128, 1),
(138, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532701138, 1),
(139, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1532701141, 1),
(140, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532760237, 1),
(141, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532760242, 1),
(142, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1532760244, 1),
(143, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532770171, 1),
(144, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532770176, 1),
(145, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1532770180, 1),
(146, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532895584, 1),
(147, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532907005, 1),
(148, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532907011, 1),
(149, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1532907013, 1),
(150, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532951318, 1),
(151, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1532951321, 1),
(152, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1532951322, 1),
(153, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1532960534, 1),
(154, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533042960, 1),
(155, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533042962, 1),
(156, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1533042963, 1),
(157, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533052472, 1),
(158, 3, 0, 0, 0, 0, 0, 0, 0, '', 11, 1, 1533052595, 1),
(159, 3, 0, 0, 0, 0, 0, 6, 0, 'Saved Syllabus 6', 12, 1, 1533053068, 1),
(160, 3, 0, 0, 0, 0, 0, 6, 0, 'Saved Syllabus 6', 12, 1, 1533053324, 1),
(161, 3, 0, 0, 0, 0, 0, 6, 0, 'Saved Syllabus 6', 12, 1, 1533053433, 1),
(162, 3, 0, 0, 0, 0, 0, 6, 0, 'Saved Syllabus 6', 12, 1, 1533053446, 1),
(163, 3, 0, 0, 0, 0, 0, 6, 0, 'Submitted Syllabus 6', 12, 2, 1533053446, 1),
(164, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533053448, 1),
(165, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533053460, 1),
(166, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533053463, 1),
(167, 4, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533053469, 1),
(168, 4, 0, 0, 6, 0, 0, 0, 0, '<strong>level 1</strong> &mdash; approved this syllabus.', 2, 2, 1533053470, 1),
(169, 4, 0, 0, 6, 0, 0, 0, 0, '<strong>level 2</strong> &mdash; approved this syllabus.', 2, 2, 1533053471, 1),
(170, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533053474, 1),
(171, 8, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533053485, 1),
(172, 8, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533054448, 1),
(173, 8, 0, 0, 6, 0, 0, 0, 0, '<strong>level 2</strong> &mdash; approved this syllabus.', 2, 2, 1533054450, 1),
(174, 8, 0, 0, 6, 0, 0, 0, 0, '<strong>level 3</strong> &mdash; approved this syllabus.', 2, 2, 1533054452, 1),
(175, 8, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533054456, 1),
(176, 5, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533054461, 1),
(177, 5, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533054464, 1),
(178, 5, 0, 0, 6, 0, 0, 0, 0, '<strong>level 3</strong> &mdash; approved this syllabus.', 2, 2, 1533054466, 1),
(179, 5, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533054470, 1),
(180, 4, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533061727, 1),
(181, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533061800, 1),
(182, 8, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533148683, 1),
(183, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533148692, 1),
(184, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533208234, 1),
(185, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533208825, 1),
(186, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533208833, 1),
(187, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533221742, 1),
(188, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1533222220, 1),
(189, 1, 1, 0, 0, 0, 0, 0, 0, 'Updated User 1', 3, 2, 1533223057, 1),
(190, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533223250, 1),
(191, 1, 1, 0, 0, 0, 0, 0, 0, 'Updated User 1', 3, 2, 1533224471, 1),
(192, 1, 1, 0, 0, 0, 0, 0, 0, 'Updated User 1', 3, 2, 1533224505, 1),
(193, 1, 1, 0, 0, 0, 0, 0, 0, 'Updated User 1', 3, 2, 1533224511, 1),
(194, 1, 1, 0, 0, 0, 0, 0, 0, 'Updated User 1', 15, 1, 1533225463, 1),
(195, 1, 1, 0, 0, 0, 0, 0, 0, 'Updated User 1', 15, 1, 1533225696, 1),
(196, 1, 1, 0, 0, 0, 0, 0, 0, 'Updated User 1', 15, 1, 1533225715, 1),
(197, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1533226650, 1),
(198, 1, 3, 0, 0, 0, 0, 0, 0, 'Updated User 3', 3, 2, 1533226656, 1),
(199, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533231737, 1),
(200, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533247210, 1),
(201, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533247646, 1),
(202, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533389866, 1),
(203, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533391520, 1),
(204, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393133, 1),
(205, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393206, 1),
(206, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393227, 1),
(207, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393293, 1),
(208, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393427, 1),
(209, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393463, 1),
(210, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393528, 1),
(211, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393567, 1),
(212, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393585, 1),
(213, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393683, 1),
(214, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393691, 1),
(215, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393723, 1),
(216, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393733, 1),
(217, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393821, 1),
(218, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533393835, 1),
(219, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533394108, 1),
(220, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533394154, 1),
(221, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533394427, 1),
(222, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533394482, 1),
(223, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533394796, 1),
(224, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533394810, 1),
(225, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533394856, 1),
(226, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533396523, 1),
(227, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533396586, 1),
(228, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533396674, 1),
(229, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533397354, 1),
(230, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533397518, 1),
(231, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533397631, 1),
(232, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533399268, 1),
(233, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533399303, 1),
(234, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533400344, 1),
(235, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533400673, 1),
(236, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533401321, 1),
(237, 3, 0, 0, 0, 0, 0, 1, 0, 'Viewed Syllabus 1', 14, 1, 1533401322, 1),
(238, 3, 0, 4, 0, 0, 0, 0, 0, 'Viewed Course 4', 13, 1, 1533401994, 1),
(239, 3, 0, 4, 0, 0, 0, 0, 0, 'Viewed Course 4', 13, 1, 1533401995, 1),
(240, 3, 0, 0, 0, 0, 0, 6, 0, 'Viewed Syllabus 6', 14, 1, 1533401996, 1),
(241, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533404382, 1),
(242, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533404864, 1),
(243, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533404881, 1),
(244, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1533404884, 1),
(245, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1533404951, 1),
(246, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533405074, 1),
(247, 3, 0, 0, 0, 0, 0, 4, 0, 'Viewed Syllabus 4', 14, 1, 1533405078, 1),
(248, 3, 0, 0, 0, 0, 0, 4, 0, 'Viewed Syllabus 4', 14, 1, 1533405233, 1),
(249, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533405247, 1),
(250, 3, 0, 0, 5, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533405258, 1),
(251, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533405272, 1),
(252, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1533405273, 1),
(253, 3, 0, 0, 5, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533405295, 1),
(254, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533405518, 1),
(255, 3, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1533405519, 1),
(256, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533405523, 1),
(257, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533546243, 1),
(258, 1, 0, 0, 0, 0, 0, 0, 0, '', 8, 1, 1533549632, 1),
(259, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533550986, 1),
(260, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533550989, 1),
(261, 3, 0, 0, 0, 0, 0, 0, 0, '', 11, 1, 1533551073, 1),
(262, 3, 0, 0, 5, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533555215, 1),
(263, 3, 0, 0, 0, 0, 0, 7, 0, 'Saved Syllabus 7', 12, 1, 1533555521, 1),
(264, 3, 0, 0, 0, 0, 0, 7, 0, 'Saved Syllabus 7', 12, 1, 1533555809, 1),
(265, 3, 0, 0, 0, 0, 0, 7, 0, 'Saved Syllabus 7', 12, 1, 1533555840, 1),
(266, 3, 0, 0, 0, 0, 0, 7, 0, 'Saved Syllabus 7', 12, 1, 1533555843, 1),
(267, 3, 0, 0, 0, 0, 0, 7, 0, 'Saved Syllabus 7', 12, 1, 1533558462, 1),
(268, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533560521, 1),
(269, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533561545, 1),
(270, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533561559, 1),
(271, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533564598, 1),
(272, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533564601, 1),
(273, 3, 0, 0, 6, 0, 0, 0, 0, 'viewed this syllabus.', 2, 1, 1533566233, 1),
(274, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533639583, 1),
(275, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639857, 1),
(276, 3, 0, 3, 0, 0, 0, 0, 0, 'Viewed Course 3', 13, 1, 1533639860, 1),
(277, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639862, 1),
(278, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639911, 1),
(279, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639913, 1),
(280, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639917, 1),
(281, 3, 0, 3, 0, 0, 0, 0, 0, 'Viewed Course 3', 13, 1, 1533639922, 1),
(282, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639923, 1),
(283, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639927, 1),
(284, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639928, 1),
(285, 3, 0, 3, 0, 0, 0, 0, 0, 'Viewed Course 3', 13, 1, 1533639931, 1),
(286, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533639934, 1),
(287, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533639953, 1),
(288, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533639955, 1),
(289, 1, 0, 0, 0, 0, 0, 5, 0, 'Viewed Syllabus 5', 14, 1, 1533640023, 1),
(290, 1, 0, 0, 0, 0, 0, 1, 0, 'Viewed Syllabus 1', 14, 1, 1533640040, 1),
(291, 1, 0, 0, 0, 0, 0, 6, 0, 'Viewed Syllabus 6', 14, 1, 1533640098, 1),
(292, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533668295, 1),
(293, 3, 0, 0, 0, 0, 0, 7, 0, 'Saved Syllabus 7', 12, 1, 1533672096, 1),
(294, 3, 0, 6, 0, 0, 0, 0, 0, 'Viewed Course 6', 13, 1, 1533673803, 1),
(295, 3, 0, 0, 0, 0, 0, 6, 0, 'Viewed Syllabus 6', 14, 1, 1533673830, 1),
(296, 3, 0, 1, 0, 0, 0, 0, 0, 'Viewed Course 1', 13, 1, 1533673849, 1),
(297, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533673858, 1),
(298, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533673860, 1),
(299, 1, 0, 0, 0, 0, 0, 0, 0, '', 8, 1, 1533673919, 1),
(300, 1, 0, 0, 0, 0, 0, 0, 0, '', 9, 1, 1533674951, 1),
(301, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533675019, 1),
(302, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533675022, 1),
(303, 3, 0, 0, 0, 0, 0, 7, 0, 'Saved Syllabus 7', 12, 1, 1533675110, 1),
(304, 3, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 1533675392, 1),
(305, 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 1, 1533675395, 1),
(306, 1, 0, 0, 0, 0, 0, 0, 0, '', 9, 1, 1533675437, 1);

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
(8, 'D. S. Malik (2008) C++ programming. Thomson Course Technology.', '[]', 0, 1531659890, 1),
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
(1, 'CAPSTONE PROJECT 1', 'ITWPROJ1', 'This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.', '', 3, 0, '[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\",\"WMA\"]', '[\"6\"]', '[]', 0, 1531235490, 1),
(2, 'MOBILE APPLICATION DEVELOPMENT 2', 'ITWSPEC4', 'Some description about mobile application development in iOS.', '', 2, 1, '', '', '', 0, 0, 1),
(3, 'WEB APPLICATION DEVELOPMENT 2', 'ITWSPEC6', 'Some description about web application development using PHP frameworks.', '', 2, 1, '', '', '', 0, 0, 1),
(4, 'DATABASE MANAGEMENT SYSTEMS 1', 'ITEDBASE1', 'This course introduces the concept of databases and database management system. In this course, the students will  learn how to examine the database management in business for routine processing and management reporting, design databases using ERD, and use SQL statements to store, retrieve and manipulate data in the database. In addition, students will be introduced to basic data and database administration and installation of DBMS.', 'Upon successful completion of this course, the student will be able to:\r\n- To develop understanding of the context of Database Management including: (a) the Database environment and (b) the Database development process.\r\n- To build expertise in Database Analysis that includes: (a) Modeling data in the organization and (b) the Enhanced E-R Model and business rules.\r\n- To develop skills in Database Design including: (a) Logical Database design and (b) the Relational Model.\r\n- To develop and implement Databases and enhance skills in advanced database topics including: (a) SQL/ Advanced SQL, and (b) Data and Database Administration.', 2, 1, '[\"SMBA\"]', '[]', '[]', 0, 1531652288, 1),
(5, 'COMPUTER PROGRAMMING 1', 'ITPROG1', 'This course is an introduction to programming which will provide the students the skills in programming through the use of conventional techniques of flowcharting and pseudo-coding.', '<p>Upon successful completion of this course, the student will be able to:</p> <ul>   <li>Know the similarities and differences between C and C++</li>   <li>Translate logic formulation into algorithms and flowchart;</li>   <li>Create working C++ programs;</li>   <li>Test and debug C++ programs; and</li>   <li>Create simple programs for input and output operations</li>   <li>Use the visual studio IDE in running C++ programs.</li>   <li>Understand and apply different control structures of C++</li>   <li>Understand and apply the principles of data storage and array manipulation</li>   <li>Perform tests in programs by using the \"if\" and \"switch\" control flow branching statements and repeat code segments by including \"for, while,\" and \"do…while\" control flow loops</li>   <li>Use critical thinking skills to create and debug C programs.</li> </ul>', 2, 1, '[]', '[]', '[\"14\"]', 0, 1522907882, 1),
(6, 'PROJECT MANAGEMENT FOR IT-WMA', 'ITWPROMAN', 'This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.', '', 3, 0, '[]', '[]', '[\"3\"]', 0, 1523780512, 1),
(7, 'SOME COURSE TITLE 1', 'NEWCOURSE1', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 2, 1, '', '', '', 0, 0, 0),
(8, 'SOME COURSE TITLE 2', 'NEWCOURSE2', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 1),
(9, 'SOME COURSE TITLE 3', 'NEWCOURSE3', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 0),
(10, 'SOME COURSE TITLE 4', 'NEWCOURSE4', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 2, 1, '', '', '', 0, 0, 1),
(11, 'SOME COURSE TITLE 5', 'NEWCOURSE5', 'Some description with <h1>Header</h1> and \' \" this \\ ?', 'Some objectives with <h1>Header</h1> and \' \" this \\ ?', 3, 0, '', '', '', 0, 0, 1),
(12, '', '', '', '', 0, 0, '', '', '', 0, 0, 1),
(13, 'Some new course 1', 'SOMENEW1', 'Some nice course description\r\n1. with numbers :o\r\n2. waw\r\n3. another', 'Some nice course objectives with bullets\r\n- nice\r\n- waw\r\n    - sub-bullets too\r\n    - sub-bullets too', 3, 0, '[\"AGD\",\"Programming\",\"Animation\"]', '[\"3\"]', '[\"2\",\"1\"]', 1522424825, 1523780496, 1),
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
(2, '2017', '[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}]', 1, 0, 1531236378, 1),
(3, '2018', '[{\"label\":\"a\",\"text\":\"Sample\"}]', 0, 1522493286, 1531236390, 1);

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
(1, 'syllabusContent', '{\"institutionVision\":\"<p>FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.</p>\",\"institutionMission\":\"<p>FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.</p>\",\"departmentVision\":\"<p>The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.</p>\",\"departmentMission\":\"<p>The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.</p>\",\"programEducationalObjectives\":\"<p>The graduates of the Bachelor of Science in Information Technology program are:</p><ol><li>engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.</li><li>entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.</li><li>responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.</li></ol>\",\"imgSrc\":\"F_1533549632.png\"}', 1533673919),
(2, 'gradingSystem', '[{\"label\":\"Midterm Grade\",\"text\":\"<p><strong>Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)</strong></p><p><br></p><p><strong><u>Lecture: 70%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Average of at least two long quizzes\\t40%</li><li>Teacher’s Evaluation\\t5%</li><li>Class participation (Seatwork, Assignments, Recitations)\\t25%</li><li>Short Quizzes, Class Exercises\\t30%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME) 40%</strong></p><p><br></p><p><strong><u>Lab: 30%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Laboratory Exercises/Machine Problems 40%</li><li>Teacher’s Evaluation 5%</li><li>Project/s 30%</li><li>Practical Exam  25%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME)</strong>\\t<strong>40%</strong></p><p><br></p><p><strong>PASSING RAW SCORE: 70</strong></p><p><em>Note: Grades in Lecture and Lab should be the same.</em></p>\"},{\"label\":\"Final Grade\",\"text\":\"<p><strong>Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)</strong></p><p><br></p><p><strong><u>Lecture: 70%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Average of at least two long quizzes\\t40%</li><li>Teacher’s Evaluation\\t5%</li><li>Class participation (Seatwork, Assignments, Recitations)\\t25%</li><li>Short Quizzes, Class Exercises\\t30%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME) 40%</strong></p><p><br></p><p><strong><u>Lab: 30%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Laboratory Exercises/Machine Problems 40%</li><li>Teacher’s Evaluation 5%</li><li>Project/s 30%</li><li>Practical Exam  25%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME)</strong>\\t<strong>15%</strong></p><p>\\t<strong>Final Exam (FE)</strong>\\t\\t\\t<strong>25%</strong></p><p><br></p><p><strong>PASSING RAW SCORE: 70</strong></p><p><em>Note: Grades in Lecture and Lab should be the same.</em></p>\"}]', 1533675437),
(3, 'cloOptions', '[{\"symbol\":\"I\",\"text\":\"Introductory\"},{\"symbol\":\"E\",\"text\":\"Engaging\"},{\"symbol\":\"D\",\"text\":\"Demonstrative\"}]', 1531660335);

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
(1, 1, 3, 1, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"\",\"weight\":\"0\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}],[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":5,\"status\":1,\"user\":{\"id\":\"5\",\"fname\":\"Rossana\",\"mname\":\"T.\",\"lname\":\"Adao\",\"username\":\"joanne\",\"title\":\"Senior Director, CCS\",\"weight\":\"10\",\"password\":\"$2y$10$Q61GloOCeRIHKx1Gz7atr.Y9ujWhJqfA8Tmix98awgRjFDW9PKZRa\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522867906\",\"auth\":\"[\\\"5\\\"]\"}}]],\"bookReferences\":[\"Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology\",\"Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press\",\"Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ\"],\"programOutcomes\":{\"id\":\"2\",\"label\":\"2017\",\"content\":[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"latest\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522772992\",\"status\":\"1\"},\"courseLearningOutcomes\":[\"Develop and execute the project requirements based from the proposal document.\",\"Test and evaluate the software product to validate for the process and output.\",\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\"],\"intendedLearningOutcomes\":[],\"cloPoMap\":[{\"d\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"e\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"i\":{\"symbol\":\"I\",\"text\":\"Introductory\"}}],\"weeklyActivities\":[{\"noOfWeeks\":1,\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 1. Project Development\",\"Lesson 2. Software Evaluation\"],\"ilo\":[\"Develop, execute and create the project deliverables.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[0],\"tlaFaculty\":[\"Discussion of the Guidelines\"],\"tlaStudent\":[\"Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.\",\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\"],\"instructionalMaterials\":[\"Whiteboard\"],\"assessmentTasks\":[\"Group Presentation\",\"Group Dynamics\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":\"2\",\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 2. Software Evaluation\",\"Lesson 3. Project Control and Project Closure\"],\"ilo\":[\"Complete the work defined in the plan to satisfy the project specifications.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[1,2],\"tlaFaculty\":[\"Require instrument for software testing.\",\"Class/Library Activity; Research current trends in IT.\"],\"tlaStudent\":[\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\",\"The students can be able to produce Results and Discussion of the Proposal Paper.\"],\"instructionalMaterials\":[\"DLP\",\"Net book\"],\"assessmentTasks\":[\"Documentation\",\"Class Activity\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"2\",\"topics\":[],\"ilo\":[],\"cloMap\":[0,1],\"tlaFaculty\":[],\"tlaStudent\":[],\"instructionalMaterials\":[],\"assessmentTasks\":[\"Testing\"],\"text\":\"Final Exam\",\"asObject\":false}],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"versionType\":0,\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"[]\",\"corequisites\":\"[\\\"3\\\"]\",\"created_at\":\"0\",\"updated_at\":\"1523780512\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1522415141\",\"status\":\"1\"}}', '1.0', 1527422833, 1527424326, 2),
(2, 1, 3, 2, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"\",\"weight\":\"0\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":1,\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":5,\"status\":2,\"user\":{\"id\":\"5\",\"fname\":\"Rossana\",\"mname\":\"T.\",\"lname\":\"Adao\",\"username\":\"joanne\",\"title\":\"Senior Director, CCS\",\"weight\":\"10\",\"password\":\"$2y$10$Q61GloOCeRIHKx1Gz7atr.Y9ujWhJqfA8Tmix98awgRjFDW9PKZRa\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522867906\",\"auth\":\"[\\\"5\\\"]\"}}]],\"bookReferences\":[\"Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology\",\"Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press\",\"Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ\"],\"programOutcomes\":{\"id\":\"2\",\"label\":\"2017\",\"content\":[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"latest\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522772992\",\"status\":\"1\"},\"courseLearningOutcomes\":[\"Develop and execute the project requirements based from the proposal document.\",\"Test and evaluate the software product to validate for the process and output.\",\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\"],\"intendedLearningOutcomes\":[],\"cloPoMap\":[{\"d\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"e\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"i\":{\"symbol\":\"I\",\"text\":\"Introductory\"}}],\"weeklyActivities\":[{\"noOfWeeks\":1,\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 1. Project Development\",\"Lesson 2. Software Evaluation\"],\"ilo\":[\"Develop, execute and create the project deliverables.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[0],\"tlaFaculty\":[\"Discussion of the Guidelines\"],\"tlaStudent\":[\"Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.\",\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\"],\"instructionalMaterials\":[\"Whiteboard\"],\"assessmentTasks\":[\"Group Presentation\",\"Group Dynamics\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":\"2\",\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 2. Software Evaluation\",\"Lesson 3. Project Control and Project Closure\"],\"ilo\":[\"Complete the work defined in the plan to satisfy the project specifications.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[1,2],\"tlaFaculty\":[\"Require instrument for software testing.\",\"Class/Library Activity; Research current trends in IT.\"],\"tlaStudent\":[\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\",\"The students can be able to produce Results and Discussion of the Proposal Paper.\"],\"instructionalMaterials\":[\"DLP\",\"Net book\"],\"assessmentTasks\":[\"Documentation\",\"Class Activity\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"2\",\"topics\":[],\"ilo\":[],\"cloMap\":[0,1],\"tlaFaculty\":[],\"tlaStudent\":[],\"instructionalMaterials\":[],\"assessmentTasks\":[\"Testing\"],\"text\":\"Final Exam\",\"asObject\":false}],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"versionType\":1,\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"[]\",\"corequisites\":\"[\\\"3\\\"]\",\"created_at\":\"0\",\"updated_at\":\"1523780512\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1522415141\",\"status\":\"1\"}}', '', 1531226918, 1531226921, 2),
(3, 1, 3, 3, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"\",\"weight\":\"0\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":2,\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":4,\"status\":2,\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"bookReferences\":[],\"programOutcomes\":{\"id\":\"2\",\"label\":\"2017\",\"content\":[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"latest\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1531236378\",\"status\":\"1\"},\"courseLearningOutcomes\":[],\"cloPoMap\":{},\"weeklyActivities\":[],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"versionType\":1,\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"[]\",\"corequisites\":\"[\\\"3\\\"]\",\"created_at\":\"0\",\"updated_at\":\"1523780512\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1531235490\",\"status\":\"1\"}}', '', 1531238253, 1531238441, 2),
(4, 1, 3, 4, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"\",\"weight\":\"0\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":4,\"status\":1,\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"bookReferences\":[\"Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology\",\"Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press\",\"Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ\"],\"programOutcomes\":{\"id\":\"2\",\"label\":\"2017\",\"content\":[{\"label\":\"a\",\"text\":\"Apply knowledge of computing, science and mathematics appropriate to the discipline.\"},{\"label\":\"b\",\"text\":\"Understand best practices and standards and their applications.\"},{\"label\":\"c\",\"text\":\"Analyze complex problems and identify and define the computing requirements appropriate to its solution.\"},{\"label\":\"d\",\"text\":\"Identify and analyze user needs and take them into account in the selection, creation, evaluation and administration of computer-based systems.\"},{\"label\":\"e\",\"text\":\"Design, implement and evaluate computer-based systems, processes,components or programs to meet desired needs and requirements under various constraints.\"},{\"label\":\"f\",\"text\":\"Integrate IT-based solutions into the user environment effectively.\"},{\"label\":\"g\",\"text\":\"Apply knowledge through the use of current techniques, skills, tools and practices necessary for the IT profession.\"},{\"label\":\"h\",\"text\":\"Function effectively as a member or leaderof a development team recognizing the different roles within a team to accomplish a common goal.\"},{\"label\":\"i\",\"text\":\"Assist in the creation of an effective IT project plan.\"},{\"label\":\"j\",\"text\":\"Communicate effectively with the computing community and with society at large about complex computing activities through logical writing, presentations and clear instructions.\"},{\"label\":\"k\",\"text\":\"Analyze the local and global impact of computing information technology on individuals, organizations and society.\"},{\"label\":\"l\",\"text\":\"Understand professional, ethical, legal, security and social issues and responsibilities in the utilization of information technology.\"},{\"label\":\"m\",\"text\":\"Recognize the need for and engage in planning self-learning and improving performance as a foundation for continuing professional development.\"}],\"latest\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1531236378\",\"status\":\"1\"},\"courseLearningOutcomes\":[\"Develop and execute the project requirements based from the proposal document.\",\"Test and evaluate the software product to validate for the process and output.\",\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\"],\"intendedLearningOutcomes\":[],\"cloPoMap\":[{\"d\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"e\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"i\":{\"symbol\":\"I\",\"text\":\"Introductory\"}}],\"weeklyActivities\":[{\"noOfWeeks\":1,\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 1. Project Development\",\"Lesson 2. Software Evaluation\"],\"ilo\":[\"Develop, execute and create the project deliverables.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[0],\"tlaFaculty\":[\"Discussion of the Guidelines\"],\"tlaStudent\":[\"Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.\",\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\"],\"instructionalMaterials\":[\"Whiteboard\"],\"assessmentTasks\":[\"Group Presentation\",\"Group Dynamics\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":\"2\",\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 2. Software Evaluation\",\"Lesson 3. Project Control and Project Closure\"],\"ilo\":[\"Complete the work defined in the plan to satisfy the project specifications.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[1,2],\"tlaFaculty\":[\"Require instrument for software testing.\",\"Class/Library Activity; Research current trends in IT.\"],\"tlaStudent\":[\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\",\"The students can be able to produce Results and Discussion of the Proposal Paper.\"],\"instructionalMaterials\":[\"DLP\",\"Net book\"],\"assessmentTasks\":[\"Documentation\",\"Class Activity\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"2\",\"topics\":[],\"ilo\":[],\"cloMap\":[0,1],\"tlaFaculty\":[],\"tlaStudent\":[],\"instructionalMaterials\":[],\"assessmentTasks\":[\"Testing\"],\"text\":\"Final Exam\",\"asObject\":false}],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"versionType\":0,\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"[]\",\"corequisites\":\"[\\\"3\\\"]\",\"created_at\":\"0\",\"updated_at\":\"1523780512\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1531235490\",\"status\":\"1\"}}', '2.0', 1531762451, 1531762463, 2);
INSERT INTO `syllabi` (`id`, `course_id`, `editor_id`, `assign_id`, `content`, `version`, `created_at`, `updated_at`, `status`) VALUES
(5, 1, 3, 5, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"\",\"weight\":\"0\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":4,\"status\":1,\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"bookReferences\":[\"Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology\",\"Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press\",\"Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ\",\"Author\'s Name. (2001). Some book about JavaScript.\",\"Author Name. (1999). Some title of book or article about Android Development.\"],\"programOutcomes\":{\"id\":\"1\",\"label\":\"2015\",\"content\":[{\"label\":\"a\",\"text\":\"Able to apply knowledge of computing fundamentals, technical concepts and practices, best practices and standards in the application of core information technologies, mathematics, science, and domain knowledge appropriate for the information technology practice to the abstraction and conceptualization of solution models from defined problems and requirements\"},{\"label\":\"b\",\"text\":\"Identify, formulate, research literature, and analyze user needs and taking them into account to solve complex information technology problems, reaching substantiated conclusions using fundamental principles of mathematics, computing fundamentals, technical concepts and practices in the core information technologies, and relevant domain disciplines.\"},{\"label\":\"c\",\"text\":\"Design and evaluate possible solutions for complex computing problems, and design and evaluate systems, components, or processes that meet specified user needs with appropriate consideration for public health and safety, cultural, societal, and environmental considerations\"},{\"label\":\"d\",\"text\":\"An ability to assist in the creation of an effective project plan to implement solution that includes selection, creation, evaluation, and administration of IT Systems\"},{\"label\":\"e\",\"text\":\"An ability to effectively integrate IT-based solutions into the user environment\"},{\"label\":\"f\",\"text\":\"An ability to administer delivered information system assuring its appropriateness to the user’s environment\"},{\"label\":\"g\",\"text\":\"Create, select, adapt and apply appropriate techniques, resources, and modern computing tools to complex computing activities, with an understanding of the limitations\"},{\"label\":\"h\",\"text\":\"Function effectively as an individual and as a member or leader in diverse teams and in multidisciplinary settings\"},{\"label\":\"i\",\"text\":\"Communicate effectively with the computing community and with society at large (in local and international scenes) about complex computing activities by being able to comprehend and write effective reports, design documentation, make effective presentations, and give and understand clear instructions\"},{\"label\":\"j\",\"text\":\"Understand and assess societal, health, safety, legal, and cultural issues within local and global contexts, and the consequential responsibilities relevant to professional computing practice\"},{\"label\":\"k\",\"text\":\"Understand and commit to professional ethics, responsibilities, and norms of professional computing practice\"},{\"label\":\"l\",\"text\":\"Recognize the need, and have the ability, to engage in independent learning for continual development as a computing professional\"}],\"latest\":\"0\",\"created_at\":\"0\",\"updated_at\":\"1522493111\",\"status\":\"1\"},\"courseLearningOutcomes\":[\"Develop and execute the project requirements based from the proposal document.\",\"Test and evaluate the software product to validate for the process and output.\",\"Complete the system defined in the plan to satisfy the project specifications and present final documentation.\",\"Design logical and relational database that meets specified user requirements following relational database design principles and constructs.\",\"Understand the fundamental concepts and principles of database management and database administration.\"],\"intendedLearningOutcomes\":[],\"cloPoMap\":[{\"d\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"e\":{\"symbol\":\"E\",\"text\":\"Engaging\"}},{\"i\":{\"symbol\":\"I\",\"text\":\"Introductory\"},\"d\":{\"symbol\":\"E\",\"text\":\"Engaging\"}},{\"g\":{\"symbol\":\"D\",\"text\":\"Demonstrative\"},\"k\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"c\":{\"symbol\":\"I\",\"text\":\"Introductory\"},\"g\":{\"symbol\":\"E\",\"text\":\"Engaging\"},\"j\":{\"symbol\":\"D\",\"text\":\"Demonstrative\"}}],\"weeklyActivities\":[{\"noOfWeeks\":1,\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 1. Project Development\",\"Lesson 2. Software Evaluation\"],\"ilo\":[\"Develop, execute and create the project deliverables.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[0],\"tlaFaculty\":[\"Discussion of the Guidelines\"],\"tlaStudent\":[\"Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.\",\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\"],\"instructionalMaterials\":[\"Whiteboard\"],\"assessmentTasks\":[\"Group Presentation\",\"Group Dynamics\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":\"2\",\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 2. Software Evaluation\",\"Lesson 3. Project Control and Project Closure\"],\"ilo\":[\"Complete the work defined in the plan to satisfy the project specifications.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[1,2],\"tlaFaculty\":[\"Require instrument for software testing.\",\"Class/Library Activity; Research current trends in IT.\"],\"tlaStudent\":[\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\",\"The students can be able to produce Results and Discussion of the Proposal Paper.\"],\"instructionalMaterials\":[\"DLP\",\"Net book\"],\"assessmentTasks\":[\"Documentation\",\"Class Activity\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"2\",\"topics\":[],\"ilo\":[],\"cloMap\":[0,1],\"tlaFaculty\":[],\"tlaStudent\":[],\"instructionalMaterials\":[],\"assessmentTasks\":[\"Testing\"],\"text\":\"Final Exam\",\"asObject\":false}],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n.\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n.\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n.\\n\\n**Midterm Exam (ME) 40%**\\n\\n.\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n.\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n.\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"versionType\":1,\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\",\"WMA\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"[]\",\"corequisites\":\"[\\\"3\\\"]\",\"created_at\":\"0\",\"updated_at\":\"1523780512\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1531235490\",\"status\":\"1\"}}', '2.1', 1532696564, 1532696564, 2),
(6, 4, 3, 6, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"Faculty\",\"weight\":\"1\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"F_1532603278.png\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1532604361\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}],[{\"id\":4,\"status\":\"1\",\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}},{\"id\":8,\"status\":\"1\",\"user\":{\"id\":\"8\",\"fname\":\"Ace\",\"mname\":\"C.\",\"lname\":\"Lagman\",\"username\":\"lagman\",\"title\":\"Program Director, IT\",\"weight\":\"1\",\"password\":\"$2y$10$XVY3K2/Mh/Ry7.Uqm/Va/up9eFgKwVyqOYkD67.3ueju2yfRbRUdu\",\"img_src\":\"\",\"tags\":\"[\\\"Software Testing\\\",\\\"Programming\\\",\\\"Android Application Development\\\",\\\"JavaScript\\\",\\\"Ruby\\\",\\\"NodeJS\\\",\\\"AngularJS\\\"]\",\"status\":\"1\",\"created_at\":\"1522263636\",\"updated_at\":\"1531226159\",\"auth\":\"[\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":8,\"status\":\"1\",\"user\":{\"id\":\"8\",\"fname\":\"Ace\",\"mname\":\"C.\",\"lname\":\"Lagman\",\"username\":\"lagman\",\"title\":\"Program Director, IT\",\"weight\":\"1\",\"password\":\"$2y$10$XVY3K2/Mh/Ry7.Uqm/Va/up9eFgKwVyqOYkD67.3ueju2yfRbRUdu\",\"img_src\":\"\",\"tags\":\"[\\\"Software Testing\\\",\\\"Programming\\\",\\\"Android Application Development\\\",\\\"JavaScript\\\",\\\"Ruby\\\",\\\"NodeJS\\\",\\\"AngularJS\\\"]\",\"status\":\"1\",\"created_at\":\"1522263636\",\"updated_at\":\"1531226159\",\"auth\":\"[\\\"5\\\"]\"}},{\"id\":5,\"status\":1,\"user\":{\"id\":\"5\",\"fname\":\"Rossana\",\"mname\":\"T.\",\"lname\":\"Adao\",\"username\":\"joanne\",\"title\":\"Senior Director, CCS\",\"weight\":\"10\",\"password\":\"$2y$10$Q61GloOCeRIHKx1Gz7atr.Y9ujWhJqfA8Tmix98awgRjFDW9PKZRa\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522867906\",\"auth\":\"[\\\"5\\\"]\"}}]],\"bookReferences\":[\"Connoly, T. (2010). Database Systems: A practical Approach to Design, Implementation and Management 5th Edition, McGraw Hill International.\",\"Elmasri, R. (2011). Fundamentals of Database Systems 6th Edition, Addison-Wesley.\",\"Gill, P. (2011). Database Management Systems 2nd Edition, I.K. International Pub.\",\"Gillenson, M. (2012). Fundamentals of Database Management Systems 2nd Edition, John Wiley & Sons.\",\"Kroenke, D. (2010). Database Concepts 4th Edition, Pearson.\",\"Mullins, C. (2013). Database Administration 2nd Edition, Addison-Wesley.\"],\"programOutcomes\":{\"id\":\"1\",\"label\":\"2015\",\"content\":[{\"label\":\"a\",\"text\":\"Able to apply knowledge of computing fundamentals, technical concepts and practices, best practices and standards in the application of core information technologies, mathematics, science, and domain knowledge appropriate for the information technology practice to the abstraction and conceptualization of solution models from defined problems and requirements\"},{\"label\":\"b\",\"text\":\"Identify, formulate, research literature, and analyze user needs and taking them into account to solve complex information technology problems, reaching substantiated conclusions using fundamental principles of mathematics, computing fundamentals, technical concepts and practices in the core information technologies, and relevant domain disciplines.\"},{\"label\":\"c\",\"text\":\"Design and evaluate possible solutions for complex computing problems, and design and evaluate systems, components, or processes that meet specified user needs with appropriate consideration for public health and safety, cultural, societal, and environmental considerations\"},{\"label\":\"d\",\"text\":\"An ability to assist in the creation of an effective project plan to implement solution that includes selection, creation, evaluation, and administration of IT Systems\"},{\"label\":\"e\",\"text\":\"An ability to effectively integrate IT-based solutions into the user environment\"},{\"label\":\"f\",\"text\":\"An ability to administer delivered information system assuring its appropriateness to the user’s environment\"},{\"label\":\"g\",\"text\":\"Create, select, adapt and apply appropriate techniques, resources, and modern computing tools to complex computing activities, with an understanding of the limitations\"},{\"label\":\"h\",\"text\":\"Function effectively as an individual and as a member or leader in diverse teams and in multidisciplinary settings\"},{\"label\":\"i\",\"text\":\"Communicate effectively with the computing community and with society at large (in local and international scenes) about complex computing activities by being able to comprehend and write effective reports, design documentation, make effective presentations, and give and understand clear instructions\"},{\"label\":\"j\",\"text\":\"Understand and assess societal, health, safety, legal, and cultural issues within local and global contexts, and the consequential responsibilities relevant to professional computing practice\"},{\"label\":\"k\",\"text\":\"Understand and commit to professional ethics, responsibilities, and norms of professional computing practice\"},{\"label\":\"l\",\"text\":\"Recognize the need, and have the ability, to engage in independent learning for continual development as a computing professional\"}],\"latest\":\"0\",\"created_at\":\"0\",\"updated_at\":\"1522493111\",\"status\":\"1\"},\"courseLearningOutcomes\":[\"Understand the fundamental concepts and principles of database management and database administration.\",\"Analyze business rules and translate them into user requirements.\",\"Design logical and relational database that meets specified user requirements following relational database design principles and constructs.\",\"Create SQL statements that retrieve information requirements of the organization needed for reports generation.\"],\"cloPoMap\":[{\"a\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"b\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"c\":{\"symbol\":\"E\",\"text\":\"Engaging\"}},{\"g\":{\"symbol\":\"E\",\"text\":\"Engaging\"}}],\"weeklyActivities\":[{\"noOfWeeks\":\"2\",\"noOfHours\":\"5.36\",\"topics\":[\"Module 1. The Database Environment and Development Process\",\"Module 2. Modeling Data in the Organization\"],\"ilo\":[\"Understand Project Review and closure.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[0],\"tlaFaculty\":[\"Classroom Discussion\",\"Discussion of the Guidelines\"],\"tlaStudent\":[\"Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.\",\"Conducts user acceptance testing\"],\"instructionalMaterials\":[\"Whiteboard\"],\"assessmentTasks\":[\"Recitation\",\"Assignment\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"5.36\",\"topics\":[\"Module 5. Introduction to SQL\",\"Module 6. Data Definition Language (DDL)\"],\"ilo\":[\"Develop, execute and create the project deliverables.\",\"Execution of user acceptance testing.\",\"Mock defense\",\"Project Final Defense/Presentation\"],\"cloMap\":[2,3],\"tlaFaculty\":[\"Classroom Discussion\",\"Class/Library Activity; Research current trends in IT.\"],\"tlaStudent\":[\"Conducts user acceptance testing\",\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\",\"Follow formulated testing instrument and comply with the checking and testing of the software.\"],\"instructionalMaterials\":[\"Net book\",\"DLP\",\"Whiteboard\"],\"assessmentTasks\":[\"Assignment\",\"Recitation\",\"Lab Exercise 1\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"2\",\"topics\":[],\"ilo\":[],\"cloMap\":[],\"tlaFaculty\":[],\"tlaStudent\":[],\"instructionalMaterials\":[],\"assessmentTasks\":[],\"text\":\"Final Examination\",\"asObject\":false}],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n**Midterm Exam (ME) 40%**\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n**Midterm Exam (ME)\\t40%**\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"},{\"label\":\"Final Grade\",\"text\":\"**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\\n\\n**Lecture: 70%**\\n\\n- **Class Standing  (CS) 60%**\\n\\n    1. Average of at least two long quizzes 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Class participation 25%\\n        - (Seatwork, Assignments, Recitations)\\n    4. Short Quizzes, Class Exercises 30%\\n\\n**Midterm Exam (ME) 40%**\\n\\n**Lab: 30%**\\n\\n- **Class Standing  (CS) 60%**\\n    1. Laboratory Exercises/Machine Problems 40%\\n    2. Teacher’s Evaluation 5%\\n    3. Project/s 30%\\n    4. Practical Exam  25%\\n\\n**Midterm Exam (ME)\\t15%**\\n\\n**Final Exam (FE)\\t25%**\\n\\n**PASSING RAW SCORE: 70**\\n\\n_Note:  Grades in Lecture and Lab should be the same._\"}],\"versionType\":0,\"course\":{\"id\":\"4\",\"title\":\"DATABASE MANAGEMENT SYSTEMS 1\",\"code\":\"ITEDBASE1\",\"description\":\"This course introduces the concept of databases and database management system. In this course, the students will  learn how to examine the database management in business for routine processing and management reporting, design databases using ERD, and use SQL statements to store, retrieve and manipulate data in the database. In addition, students will be introduced to basic data and database administration and installation of DBMS.\",\"objectives\":\"Upon successful completion of this course, the student will be able to:\\r\\n- To develop understanding of the context of Database Management including: (a) the Database environment and (b) the Database development process.\\r\\n- To build expertise in Database Analysis that includes: (a) Modeling data in the organization and (b) the Enhanced E-R Model and business rules.\\r\\n- To develop skills in Database Design including: (a) Logical Database design and (b) the Relational Model.\\r\\n- To develop and implement Databases and enhance skills in advanced database topics including: (a) SQL/ Advanced SQL, and (b) Data and Database Administration.\",\"unitsLec\":\"2\",\"unitsLab\":\"1\",\"tags\":[\"SMBA\"],\"prerequisites\":[],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1531652288\",\"status\":\"1\"}}', '1.0', 1533053068, 1533053446, 2),
(7, 1, 3, 7, '{\"institutionVision\":\"FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.\",\"institutionMission\":\"FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.\",\"departmentVision\":\"The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.\",\"departmentMission\":\"The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.\",\"programEducationalObjectives\":\"The graduates of the Bachelor of Science in Information Technology program are:\\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.\",\"facultyInCharge\":{\"id\":\"3\",\"fname\":\"Smith\",\"mname\":\"\",\"lname\":\"Paul\",\"username\":\"ralph\",\"title\":\"\",\"weight\":\"0\",\"password\":\"$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6\",\"img_src\":\"\",\"tags\":[],\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"0\",\"auth\":[3,4]},\"evaluatedBy\":[[{\"id\":4,\"status\":2,\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"approvedBy\":[[{\"id\":4,\"status\":2,\"user\":{\"id\":\"4\",\"fname\":\"Roman\",\"mname\":\"\",\"lname\":\"De Angel\",\"username\":\"roman\",\"title\":\"Coordinator, ITWMA\",\"weight\":\"1\",\"password\":\"$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO\",\"img_src\":\"\",\"tags\":\"[]\",\"status\":\"1\",\"created_at\":\"0\",\"updated_at\":\"1522835142\",\"auth\":\"[\\\"3\\\",\\\"5\\\"]\"}}]],\"bookReferences\":[\"Schwalbe, Kathy (2011). Information Technology Project Management. Rev. 6th ed. Australia: Course Technology\",\"Wiegers K. (2013). Software requirements (3rd). Redmond, Washington: Microsoft Press\",\"Kendall (2014). System analysis and design (9th). Pearson: Upper Saddle River, NJ\",\"Author\'s Name. (2001). Some book about JavaScript.\",\"Author Name. (1999). Some title of book or article about Android Development.\"],\"programOutcomes\":{\"id\":\"1\",\"label\":\"2015\",\"content\":[{\"label\":\"a\",\"text\":\"Able to apply knowledge of computing fundamentals, technical concepts and practices, best practices and standards in the application of core information technologies, mathematics, science, and domain knowledge appropriate for the information technology practice to the abstraction and conceptualization of solution models from defined problems and requirements\"},{\"label\":\"b\",\"text\":\"Identify, formulate, research literature, and analyze user needs and taking them into account to solve complex information technology problems, reaching substantiated conclusions using fundamental principles of mathematics, computing fundamentals, technical concepts and practices in the core information technologies, and relevant domain disciplines.\"},{\"label\":\"c\",\"text\":\"Design and evaluate possible solutions for complex computing problems, and design and evaluate systems, components, or processes that meet specified user needs with appropriate consideration for public health and safety, cultural, societal, and environmental considerations\"},{\"label\":\"d\",\"text\":\"An ability to assist in the creation of an effective project plan to implement solution that includes selection, creation, evaluation, and administration of IT Systems\"},{\"label\":\"e\",\"text\":\"An ability to effectively integrate IT-based solutions into the user environment\"},{\"label\":\"f\",\"text\":\"An ability to administer delivered information system assuring its appropriateness to the user’s environment\"},{\"label\":\"g\",\"text\":\"Create, select, adapt and apply appropriate techniques, resources, and modern computing tools to complex computing activities, with an understanding of the limitations\"},{\"label\":\"h\",\"text\":\"Function effectively as an individual and as a member or leader in diverse teams and in multidisciplinary settings\"},{\"label\":\"i\",\"text\":\"Communicate effectively with the computing community and with society at large (in local and international scenes) about complex computing activities by being able to comprehend and write effective reports, design documentation, make effective presentations, and give and understand clear instructions\"},{\"label\":\"j\",\"text\":\"Understand and assess societal, health, safety, legal, and cultural issues within local and global contexts, and the consequential responsibilities relevant to professional computing practice\"},{\"label\":\"k\",\"text\":\"Understand and commit to professional ethics, responsibilities, and norms of professional computing practice\"},{\"label\":\"l\",\"text\":\"Recognize the need, and have the ability, to engage in independent learning for continual development as a computing professional\"}],\"latest\":\"0\",\"created_at\":\"0\",\"updated_at\":\"1522493111\",\"status\":\"1\"},\"courseLearningOutcomes\":[\"<p>Develop and execute the project requirements based from the proposal document.</p>\",\"<p>Test and evaluate the software product to validate for the process and output.</p>\",\"<p>Complete the system defined in the plan to satisfy the project specifications and present final documentation.</p>\",\"<p>Design logical and relational database that meets specified user requirements following relational database design principles and constructs.</p>\",\"<p>Understand the fundamental concepts and principles of database management and database administration.</p>\"],\"intendedLearningOutcomes\":[],\"cloPoMap\":[{\"d\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"e\":{\"symbol\":\"E\",\"text\":\"Engaging\"}},{\"i\":{\"symbol\":\"I\",\"text\":\"Introductory\"},\"d\":{\"symbol\":\"E\",\"text\":\"Engaging\"}},{\"g\":{\"symbol\":\"D\",\"text\":\"Demonstrative\"},\"k\":{\"symbol\":\"I\",\"text\":\"Introductory\"}},{\"c\":{\"symbol\":\"I\",\"text\":\"Introductory\"},\"g\":{\"symbol\":\"E\",\"text\":\"Engaging\"},\"j\":{\"symbol\":\"D\",\"text\":\"Demonstrative\"}}],\"weeklyActivities\":[{\"noOfWeeks\":1,\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 1. Project Development\",\"Lesson 2. Software Evaluation\"],\"ilo\":[\"Develop, execute and create the project deliverables.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[0],\"tlaFaculty\":[\"Discussion of the Guidelines\"],\"tlaStudent\":[\"Student can clarify/ask questions on matters concerning course syllabus, OBE, and PBL.\",\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\"],\"instructionalMaterials\":[\"Whiteboard\"],\"assessmentTasks\":[\"Group Presentation\",\"Group Dynamics\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":\"2\",\"noOfHours\":\"5.34\",\"topics\":[\"Lesson 2. Software Evaluation\",\"Lesson 3. Project Control and Project Closure\"],\"ilo\":[\"Complete the work defined in the plan to satisfy the project specifications.\",\"Test the software product to validate its process and output.\"],\"cloMap\":[1,2],\"tlaFaculty\":[\"Require instrument for software testing.\",\"Class/Library Activity; Research current trends in IT.\"],\"tlaStudent\":[\"Class/Library Activity; search the current trends in IT so that they will have the idea in making their title.\",\"The students can be able to produce Results and Discussion of the Proposal Paper.\"],\"instructionalMaterials\":[\"DLP\",\"Net book\"],\"assessmentTasks\":[\"Documentation\",\"Class Activity\"],\"text\":null,\"asObject\":true},{\"noOfWeeks\":1,\"noOfHours\":\"2\",\"topics\":[],\"ilo\":[],\"cloMap\":[0,1],\"tlaFaculty\":[],\"tlaStudent\":[],\"instructionalMaterials\":[],\"assessmentTasks\":[\"Testing\"],\"text\":\"<p>Final Exam</p>\",\"asObject\":false}],\"gradingSystem\":[{\"label\":\"Midterm Grade\",\"text\":\"<p><strong>Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)</strong></p><p><br></p><p><strong><u>Lecture: 70%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Average of at least two long quizzes\\t40%</li><li>Teacher’s Evaluation\\t5%</li><li>Class participation\\t25%</li><li class=\\\"ql-indent-1\\\">(Seatwork, Assignments, Recitations)</li><li>Short Quizzes, Class Exercises\\t30%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME) 40%</strong></p><p><br></p><p><strong><u>Lab: 30%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Laboratory Exercises/Machine Problems 40%</li><li>Teacher’s Evaluation 5%</li><li>Project/s 30%</li><li>Practical Exam  25%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME)</strong>\\t<strong>40%</strong></p><p><br></p><p><strong>PASSING RAW SCORE: 70</strong></p><p><em>Note: Grades in Lecture and Lab should be the same.</em></p>\"},{\"label\":\"Final Grade\",\"text\":\"<p><strong>Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)</strong></p><p><br></p><p><strong><u>Lecture: 70%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Average of at least two long quizzes\\t40%</li><li>Teacher’s Evaluation\\t5%</li><li>Class participation\\t25%</li><li class=\\\"ql-indent-1\\\">(Seatwork, Assignments, Recitations)</li><li>Short Quizzes, Class Exercises\\t30%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME) 40%</strong></p><p><br></p><p><strong><u>Lab: 30%</u></strong></p><p><br></p><p>\\t<strong>Class Standing  (CS) 60%</strong></p><ol><li>Laboratory Exercises/Machine Problems 40%</li><li>Teacher’s Evaluation 5%</li><li>Project/s 30%</li><li>Practical Exam  25%</li></ol><p><br></p><p>\\t<strong>Midterm Exam (ME)</strong>\\t<strong>15%</strong></p><p>\\t<strong>Final Exam (FE)</strong>\\t\\t\\t<strong>25%</strong></p><p><br></p><p><strong>PASSING RAW SCORE: 70</strong></p><p><em>Note: Grades in Lecture and Lab should be the same.</em></p>\"}],\"versionType\":null,\"course\":{\"id\":\"1\",\"title\":\"CAPSTONE PROJECT 1\",\"code\":\"ITWPROJ1\",\"description\":\"This course focuses on creation of reliable, efficient and maintainable software application based from the approved requirements in ITWPROJMAN. This covers implementing and testing the software, project documentation and presenting the project in front of the panel committee for final defense.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[\"Capstone Project\",\"Software Testing\",\"Software Evaluation\",\"Software Requirements\",\"WMA\"],\"prerequisites\":[{\"id\":\"6\",\"title\":\"PROJECT MANAGEMENT FOR IT-WMA\",\"code\":\"ITWPROMAN\",\"description\":\"This course focuses on the Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sollicitudin, metus sit amet egestas volutpat, ligula ex tincidunt arcu, vel venenatis tortor urna non enim. Quisque ut nisi tempor, lacinia felis ac, dictum est. Sed tristique risus nec eros dapibus, sit amet facilisis eros suscipit.\",\"objectives\":\"\",\"unitsLec\":\"3\",\"unitsLab\":\"0\",\"tags\":[],\"prerequisites\":\"[]\",\"corequisites\":\"[\\\"3\\\"]\",\"created_at\":\"0\",\"updated_at\":\"1523780512\",\"status\":\"1\"}],\"corequisites\":[],\"created_at\":\"0\",\"updated_at\":\"1531235490\",\"status\":\"1\"}}', '', 1533555521, 1533675110, 2);

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
(1, 'John', 'Smith', 'Doe', 'test', 'Admin', 0, '$2y$10$kPkVuP8HDWnXnuEd22gShelVwOPkibOEi/UGEol9DHhkfgQ/85Ohq', '', '[]', 1, 0, 1533225715, '[\"1\"]'),
(2, 'Jane', '', 'Doe', 'charlyn', '', 0, '$2y$10$3jQ.7tz1XYlAyMzsU1Mgfu9XciWKkMa26yPfiV2bPLGP0nVsniDuq', '', '', 1, 0, 1521732242, '[\"3\"]'),
(3, 'Smith', '', 'Paul', 'ralph', 'Faculty', 1, '$2y$10$QdPPMV36C0HmJG/EdEHlzum/sWKyzclgCGqWVUKeC1gJBjS3pVZb6', 'F_1532603278.png', '[]', 1, 0, 1533226656, '[\"3\",\"4\"]'),
(4, 'Roman', '', 'De Angel', 'roman', 'Coordinator, ITWMA', 1, '$2y$10$sy/BOOEgtIwkLbExWNlHHuqRCm/oa2zT98w5MW1wASS1iE25WL.WO', '', '[]', 1, 0, 1522835142, '[\"3\",\"5\"]'),
(5, 'Rossana', 'T.', 'Adao', 'joanne', 'Senior Director, CCS', 10, '$2y$10$Q61GloOCeRIHKx1Gz7atr.Y9ujWhJqfA8Tmix98awgRjFDW9PKZRa', '', '[]', 1, 0, 1522867906, '[\"5\"]'),
(8, 'Ace', 'C.', 'Lagman', 'lagman', 'Program Director, IT', 1, '$2y$10$XVY3K2/Mh/Ry7.Uqm/Va/up9eFgKwVyqOYkD67.3ueju2yfRbRUdu', '', '[\"Software Testing\",\"Programming\",\"Android Application Development\",\"JavaScript\",\"Ruby\",\"NodeJS\",\"AngularJS\"]', 1, 1522263636, 1531226159, '[\"5\"]'),
(10, 'Jeff', '', 'Rylee', 'rylee', 'Some title', 1, '$2y$10$3YLXeb11FcG8I9gGkhONAeb9oz0zRHtwsGdXGt8quL0YgyHdrw/Pm', '', '[\"Programming\"]', -1, 1531234054, 1531234454, '[\"3\"]');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assigns`
--
ALTER TABLE `assigns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assigns`
--
ALTER TABLE `assigns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=307;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
