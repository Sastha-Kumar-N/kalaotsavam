-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 15, 2025 at 12:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ASBT_Kalotsavam`
--
CREATE DATABASE IF NOT EXISTS `ASBT_Kalotsavam` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ASBT_Kalotsavam`;

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `password`) VALUES
(7, 'admin', '$2y$10$Yzu2uRSj63es24xi4GGJbev9DRn.yJU8U7iUmI5DfHLqX09TuFzxC');

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `text`, `created_at`) VALUES
(2, 'The titles of Kalathilakam and Kalaprathibha will be awarded based on the total number of prizes secured in both onstage and offstage events. However, onstage event prizes will carry more weightage in the final decision.', '2025-05-10 09:45:48'),
(8, 'Registrations are closed. Thank you for your interest!!', '2025-05-11 06:31:57');

-- --------------------------------------------------------

--
-- Table structure for table `Disabled_events`
--

CREATE TABLE `Disabled_events` (
  `Events` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `event_type` enum('individual','group') NOT NULL,
  `stage` enum('on','off') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `event_name`, `event_type`, `stage`) VALUES
(39, 'Western Music', 'individual', 'on'),
(40, 'Indian Classical Music', 'individual', 'on'),
(41, 'Tharjima', 'individual', 'off'),
(42, 'Pencil drawing', 'individual', 'off'),
(43, 'Face to Face', 'individual', 'off'),
(44, 'Cartoon Drawing', 'individual', 'off'),
(45, 'Oil Painting', 'individual', 'off'),
(46, 'Light Music', 'individual', 'on'),
(47, 'Mime', 'group', 'on'),
(48, 'Soap Carving', 'individual', 'off'),
(49, 'Story Writing- English', 'individual', 'off'),
(50, 'Story Writing- Hindi', 'individual', 'off'),
(51, 'Clay modelling', 'individual', 'off'),
(52, 'Filmy-Song', 'individual', 'on'),
(53, 'Water Coloring', 'individual', 'off'),
(54, 'Mandala Art', 'individual', 'off'),
(55, 'Mehendi Designing', 'individual', 'off'),
(56, 'Doodling', 'individual', 'off'),
(57, 'Collage', 'individual', 'off'),
(58, 'Patriotic Song', 'group', 'on'),
(59, 'Karaoke Duet', 'group', 'on'),
(60, 'Carnatic solo', 'individual', 'on'),
(61, 'Jugalbandhi', 'group', 'on'),
(62, 'Group song', 'group', 'on'),
(63, 'Folk song', 'group', 'on'),
(64, 'Vanjipattu', 'group', 'on'),
(65, 'Instruments', 'individual', 'on'),
(66, 'Monoact', 'individual', 'on'),
(67, 'Mimicry', 'individual', 'on'),
(68, 'Anchoring', 'individual', 'on'),
(69, 'One act play', 'individual', 'on'),
(72, 'Extempore', 'individual', 'on'),
(73, 'Filmy dance', 'group', 'on'),
(74, 'Folk dance', 'individual', 'on'),
(75, 'Nostalgia dance', 'group', 'on'),
(76, 'Fancy dress', 'individual', 'on'),
(77, 'Synchronized Duet Dance', 'group', 'on'),
(78, 'Oppana', 'group', 'on'),
(79, 'Thiruvathira', 'group', 'on'),
(80, 'Margamkali', 'group', 'on'),
(81, 'Semi-Classical Group Dance', 'group', 'on'),
(82, 'Story Writing- Malayalam', 'individual', 'off'),
(83, 'Essay Writing- Hindi', 'individual', 'off'),
(84, 'Essay Writing- English', 'individual', 'off'),
(85, 'Essay Writing- Malayalam', 'individual', 'off'),
(86, 'Poetry writing- English', 'individual', 'off'),
(87, 'Poetry writing- Hindi', 'individual', 'off'),
(88, 'Poetry writing- Malayalam', 'individual', 'off'),
(89, 'Solo Dance- Filmy', 'individual', 'on'),
(90, 'Solo Dance- Semi-Classical', 'individual', 'on'),
(92, 'Poem Recitation Hindi', 'individual', 'on'),
(93, 'Poem Recitation English', 'individual', 'on'),
(94, 'Poem Recitation Malayalam', 'individual', 'on'),
(95, 'Elocution Hindi', 'individual', 'on'),
(96, 'Elocution English', 'individual', 'on'),
(97, 'Elocution Sanskrit', 'individual', 'on'),
(98, 'Elocution Malayalam', 'individual', 'on'),
(99, 'Bharatanatyam', 'individual', 'on'),
(100, 'Mohiniyattom', 'individual', 'on'),
(101, 'Kucchipudi', 'individual', 'on'),
(102, 'Poem Recitation-Sanskrit', 'individual', 'on');

-- --------------------------------------------------------

--
-- Table structure for table `Event_Registration`
--

CREATE TABLE `Event_Registration` (
  `Name` varchar(50) NOT NULL,
  `Roll_Number` varchar(20) NOT NULL,
  `Gender` text NOT NULL,
  `Degree` varchar(5) NOT NULL,
  `Course` varchar(15) NOT NULL,
  `Year` varchar(10) NOT NULL,
  `Event1` varchar(50) NOT NULL,
  `Event2` varchar(50) NOT NULL,
  `Event3` varchar(50) NOT NULL,
  `Event4` varchar(50) NOT NULL,
  `Event5` varchar(50) NOT NULL,
  `Event6` varchar(50) NOT NULL,
  `Event7` varchar(50) NOT NULL,
  `Event8` varchar(50) NOT NULL,
  `Event9` varchar(50) NOT NULL,
  `Event10` varchar(50) NOT NULL,
  `Group_event` varchar(50) NOT NULL,
  `EB1` varchar(50) NOT NULL,
  `EB2` varchar(50) NOT NULL,
  `EB3` varchar(50) NOT NULL,
  `EB4` varchar(50) NOT NULL,
  `EB5` varchar(50) NOT NULL,
  `EB6` varchar(50) NOT NULL,
  `EB7` varchar(50) NOT NULL,
  `EB8` varchar(50) NOT NULL,
  `EB9` varchar(50) NOT NULL,
  `EB10` varchar(50) NOT NULL,
  `GB` varchar(50) NOT NULL,
  `group_event_Participants` varchar(255) NOT NULL,
  `Chest_Number` int(4) NOT NULL,
  `Phone_Number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Event_Registration`
--

INSERT INTO `Event_Registration` (`Name`, `Roll_Number`, `Gender`, `Degree`, `Course`, `Year`, `Event1`, `Event2`, `Event3`, `Event4`, `Event5`, `Event6`, `Event7`, `Event8`, `Event9`, `Event10`, `Group_event`, `EB1`, `EB2`, `EB3`, `EB4`, `EB5`, `EB6`, `EB7`, `EB8`, `EB9`, `EB10`, `GB`, `group_event_Participants`, `Chest_Number`, `Phone_Number`) VALUES
('Abhimanyu R', 'AM.LS.P2BIF24001', 'Male', 'MSc', 'Bioinformatics', '1st', '', '', '', '', '', 'Tharjima', '', '', '', '', '', '', '', '', '', '', 'Tharjima', '', '', '', '', '', '', 489, '7012932014'),
('Navaneeth S Raju', 'AM.LS.P2BIF24018', 'Male', 'MSc', 'Bioinformatics', '1st', '', '', '', '', '', 'Cartoon Drawing', 'Doodling', '', '', '', '', '', '', '', '', '', 'Cartoon Drawing', 'Doodling', '', '', '', '', '', 493, '8547171177'),
('Shoumya Bharti', 'AM.LS.P2BIF24027', 'Female', 'MSc', 'Bioinformatics', '1st', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', 'Poetry writing- Hindi', '', '', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', 'Poetry writing- Hindi', '', '', '', 490, '7667491680'),
('Staicy Fredy', 'AM.LS.P2BIF24030', 'Female', 'MSc', 'Bioinformatics', '1st', '', '', '', '', '', 'Tharjima', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', '', '', '', 'Tharjima', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', 409, '8330821259'),
('Akshaya M H ', 'AM.LS.P2BIT24004', 'Female', 'MSc', 'Biotechnology', '1st', 'Carnatic solo', '', '', '', '', 'Essay Writing- English', '', '', '', '', '', 'Carnatic solo', '', '', '', '', 'Essay Writing- English', '', '', '', '', '', '', 474, '8903143554'),
('Aswathy P V', 'AM.LS.P2BIT24012', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Story Writing- Malayalam', 'Poetry writing- English', 'Poetry writing- Malayalam', '', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Story Writing- Malayalam', 'Poetry writing- English', 'Poetry writing- Malayalam', '', '', 415, '8590349618'),
('Avanthika K', 'AM.LS.P2BIT24013', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Pencil drawing', 'Cartoon Drawing', 'Mandala Art', 'Story Writing- Malayalam', 'Poetry writing- Malayalam', '', '', '', '', '', '', 'Pencil drawing', 'Cartoon Drawing', 'Mandala Art', 'Story Writing- Malayalam', 'Poetry writing- Malayalam', '', '', 420, '9746068641'),
('Devika K', 'AM.LS.P2BIT24017', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', 482, '7909296994'),
('Devika M', 'AM.LS.P2BIT24018', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Poetry writing- English', 'Story Writing- English', 'Essay Writing- English', 'Face to Face', '', '', '', '', '', '', '', 'Poetry writing- English', 'Story Writing- English', 'Essay Writing- English', 'Face to Face', '', '', '', 495, '7907610269'),
('Geethika A K ', 'AM.LS.P2BIT24021', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Poetry writing- English', 'Mandala Art', '', '', '', '', '', '', '', '', '', 'Poetry writing- English', 'Mandala Art', '', '', '', '', '', 416, '6238975870'),
('Malavika padmakumar ', 'AM.LS.P2BIT24027', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Mandala Art', 'Story Writing- Malayalam', 'Collage', 'Doodling', '', '', '', '', '', '', '', 'Mandala Art', 'Story Writing- Malayalam', 'Collage', 'Doodling', '', '', '', 496, '9447825036'),
('Monisha.H.V', 'AM.LS.P2BIT24028', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Clay modelling', 'Story Writing- English', '', '', '', '', '', '', '', '', '', 'Clay modelling', 'Story Writing- English', '', '', '', '', '', 401, '8946032294'),
('NANDANA SURESH BABU', 'AM.LS.P2BIT24029', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', 471, '9778479440'),
('Athira', 'AM.LS.P2BIT24038', 'Female', 'MSc', 'Biotechnology', '1st', 'Light Music', 'Filmy-Song', '', '', '', '', '', '', '', '', '', 'Light Music', 'Filmy-Song', '', '', '', '', '', '', '', '', '', '', 419, '8078074603'),
('Sridharshini Sampathkumar', 'AM.LS.P2BIT24044', 'Female', 'MSc', 'Biotechnology', '1st', 'Solo Dance- Filmy', '', '', '', '', 'Mehendi Designing', '', '', '', '', '', 'Solo Dance- Filmy', '', '', '', '', 'Mehendi Designing', '', '', '', '', '', '', 451, '8925505756'),
('Aswathipriya KR', 'AM.LS.P2BIT24048', 'Female', 'MSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- Malayalam', 'Poetry writing- Malayalam', '', '', '', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Poetry writing- Malayalam', '', '', '', '', '', 463, '9074296248'),
('Revathy S Prathapan ', 'AM.LS.P2MIB23012', 'Female', 'MSc', 'Microbiology', '2nd', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', 'Essay Writing- English', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', 'Essay Writing- English', '', '', '', '', 460, '9495957249'),
('Abhinav S', 'AM.LS.P2MIB24001', 'Male', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Tharjima', '', '', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Tharjima', '', '', '', '', 469, '9539052878'),
('Amritha Nair', 'AM.LS.P2MIB24003', 'Female', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Story Writing- Malayalam', 'Story Writing- English', 'Essay Writing- Malayalam', 'Essay Writing- English', 'Tharjima', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Story Writing- English', 'Essay Writing- Malayalam', 'Essay Writing- English', 'Tharjima', '', '', 462, '7561854172'),
('Anagha Narippatta', 'AM.LS.P2MIB24004', 'Female', 'MSc', 'Microbiology', '1st', 'Poem Recitation English', '', '', '', '', 'Poetry writing- English', '', '', '', '', '', 'Poem Recitation English', '', '', '', '', 'Poetry writing- English', '', '', '', '', '', '', 467, '6382826440'),
('Chitrangi Dashora', 'AM.LS.P2MIB24013', 'Female', 'MSc', 'Microbiology', '1st', 'Folk dance', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', 'Folk dance', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', 438, '7300455004'),
('Manaswita Prem ', 'AM.LS.P2MIB24021', 'Female', 'MSc', 'Microbiology', '1st', 'Bharatanatyam', 'Kucchipudi', '', '', '', '', '', '', '', '', '', 'Bharatanatyam', 'Kucchipudi', '', '', '', '', '', '', '', '', '', '', 425, '9778729323'),
('Meera Ramesh ', 'AM.LS.P2MIB24022', 'Female', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Essay Writing- Malayalam', 'Essay Writing- English', 'Story Writing- Malayalam', '', '', '', '', '', '', '', '', 'Essay Writing- Malayalam', 'Essay Writing- English', 'Story Writing- Malayalam', '', '', '', '', 486, '8301878180'),
('Mohammed Aslam', 'AM.LS.P2MIB24024', 'Male', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Essay Writing- English', 'Tharjima', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Essay Writing- English', 'Tharjima', '', '', 423, '7592826480'),
('Nikita A', 'AM.LS.P2MIB24026', 'Female', 'MSc', 'Microbiology', '1st', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', 'Group song', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', 'Group song', 'AM.LS.P2MIB24026,AM.LS.P2MIB24017,AM.LS.P2MIB24011,AM.LS.P2MIB24019,AM.LS.P2MIB24016,AM.LS.P2MIB24035,AM.LS.P2MIB24021,AM.LS.P2MIB24024,AM.LS.P2BIT24008,AM.LS.P2BIT24026,AM.LS.P2MIB24013', 435, '9072420150'),
('Shri Varsha M', 'AM.LS.P2MIB24028', 'Female', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', 479, '9500547082'),
('Subin John', 'AM.LS.P2MIB24031', 'Male', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Story Writing- English', 'Essay Writing- English', '', '', '', 500, '8606703166'),
('Jahnavi Mani ', 'AM.LS.P2MIB24035', 'Female', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Soap Carving', 'Clay modelling', '', '', '', '', '', '', '', '', '', 'Soap Carving', 'Clay modelling', '', '', '', '', '', 412, '8714719597'),
('BHAGYA LAKSHMY T.R', 'AM.LS.P2MIB24036', 'Female', 'MSc', 'Microbiology', '1st', '', '', '', '', '', 'Soap Carving', 'Mandala Art', 'Mehendi Designing', '', '', '', '', '', '', '', '', 'Soap Carving', 'Mandala Art', 'Mehendi Designing', '', '', '', '', 414, '7907732578'),
('Abhinandhana vinu ', 'AM.LS.U3BIT22001', 'Female', 'BSc', 'Biotechnology', '3rd', 'Filmy-Song', '', '', '', '', '', '', '', '', '', '', 'Filmy-Song', '', '', '', '', '', '', '', '', '', '', '', 330, '6238196388'),
('Abhishek S', 'AM.LS.U3BIT22002', 'Male', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Soap Carving', 'Clay modelling', '', '', '', '', '', '', '', '', '', 'Soap Carving', 'Clay modelling', '', '', '', '', '', 323, '6282779625'),
('Anakha Anil', 'AM.LS.U3BIT22006', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Doodling', 'Pencil drawing', 'Cartoon Drawing', 'Collage', 'Poetry writing- English', '', '', '', '', '', '', 'Doodling', 'Pencil drawing', 'Cartoon Drawing', 'Collage', 'Poetry writing- English', '', '', 339, '8590268989'),
('Anjaly G Nair', 'AM.LS.U3BIT22013', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', '', '', '', '', '', 'Thiruvathira', '', '', '', '', '', '', '', '', '', '', 'Thiruvathira', 'AM.LS.U3BIT22013,AM.LS.U3BIT22036', 354, '9188720014'),
('Biza Ann Mathew', 'AM.LS.U3BIT22016', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', 'Poetry writing- Malayalam', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', 'Poetry writing- Malayalam', '', '', '', '', 312, '7356579931'),
('Devayani S', 'AM.LS.U3BIT22021', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Clay modelling', '', '', '', '', '', '', '', '', '', '', 'Clay modelling', '', '', '', '', '', '', 378, '9745731842'),
('Gayathri K V', 'AM.LS.U3BIT22023', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Tharjima', 'Essay Writing- Malayalam', 'Mehendi Designing', 'Poetry writing- Malayalam', '', '', '', '', '', '', '', 'Tharjima', 'Essay Writing- Malayalam', 'Mehendi Designing', 'Poetry writing- Malayalam', '', '', '', 306, '9778074256'),
('Gowri Nandana R', 'AM.LS.U3BIT22025', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', '', 352, '6282097159'),
('K. S SADHYA', 'AM.LS.U3BIT22029', 'Female', 'BSc', 'Biotechnology', '3rd', 'Carnatic solo', 'Filmy-Song', '', '', '', '', '', '', '', '', 'Karaoke Duet', 'Carnatic solo', 'Filmy-Song', '', '', '', '', '', '', '', '', 'Karaoke Duet', 'AM.LS.U3BIT22029,AM.LS.U3BIT22001', 302, '9063116048'),
('Neha Murali', 'AM.LS.U3BIT22034', 'Female', 'BSc', 'Biotechnology', '3rd', 'Elocution Malayalam', 'Elocution English', 'Poem Recitation Hindi', '', '', 'Tharjima', '', '', '', '', '', 'Elocution Malayalam', 'Elocution English', 'Poem Recitation Hindi', '', '', 'Tharjima', '', '', '', '', '', '', 307, '8089989230'),
('Niranjana D R', 'AM.LS.U3BIT22036', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', '', '', 'Clay modelling', '', '', '', '', '', '', '', '', '', '', 'Clay modelling', '', '', '', '', 335, '8714502923'),
('S Lakshmi Parvathy ', 'AM.LS.U3BIT22040', 'Female', 'BSc', 'Biotechnology', '3rd', 'Bharatanatyam', 'Folk dance', 'Solo Dance- Semi-Classical', 'Kucchipudi', '', 'Soap Carving', 'Clay modelling', '', '', '', '', 'Bharatanatyam', 'Folk dance', 'Solo Dance- Semi-Classical', 'Kucchipudi', '', 'Soap Carving', 'Clay modelling', '', '', '', '', '', 382, '8714773707'),
('Vaibhav chauhan', 'AM.LS.U3BIT22045', 'Male', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Essay Writing- Hindi', '', '', '', '', '', '', '', '', '', '', 'Essay Writing- Hindi', '', '', '', '', '', '', 389, '9871009629'),
('Amal Bhaskar', 'AM.LS.U3BIT22049', 'Male', 'BSc', 'Biotechnology', '3rd', 'Monoact', 'Anchoring', 'Fancy dress', 'Extempore', 'Solo Dance- Filmy', 'Collage', 'Clay modelling', 'Mehendi Designing', 'Face to Face', '', 'Group song', 'Monoact', 'Anchoring', 'Fancy dress', 'Extempore', 'Solo Dance- Filmy', 'Collage', 'Clay modelling', 'Mehendi Designing', 'Face to Face', '', 'Group song', 'AM.LS.U3BIT22049,AM.LS.U3BIT22060', 325, '9495967196'),
('Athul Ashok', 'AM.LS.U3BIT22050', 'Male', 'BSc', 'Biotechnology', '3rd', 'Light Music', 'Filmy-Song', 'Instruments', '', '', 'Soap Carving', '', 'Clay modelling', '', '', 'Karaoke Duet', 'Light Music', 'Filmy-Song', 'Instruments', '', '', 'Soap Carving', '', 'Clay modelling', '', '', 'Karaoke Duet', 'AM.LS.U3BIT22050,AM.LS.U3MIB22028', 338, '7510387158'),
('Neeshma S', 'AM.LS.U3BIT22052', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Story Writing- Malayalam', 'Poetry writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Poetry writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', 372, '8089330641'),
('Navya', 'AM.LS.U3BIT22054', 'Female', 'BSc', 'Biotechnology', '3rd', 'Elocution English', '', '', '', '', 'Story Writing- English', '', '', '', '', '', 'Elocution English', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', 328, '8595634253'),
('AKSHAY CHANDRAN A', 'AM.LS.U3BIT22060', 'Male', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', '', '', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', '', '', '', 348, '9995595827'),
('Sreeganesh A', 'AM.LS.U3BIT22062', 'Male', 'BSc', 'Biotechnology', '3rd', 'Extempore', 'Elocution English', 'Poem Recitation English', 'Elocution Malayalam', 'Poem Recitation Malayalam', 'Story Writing- English', 'Essay Writing- English', 'Essay Writing- Malayalam', 'Poetry writing- English', '', '', 'Extempore', 'Elocution English', 'Poem Recitation English', 'Elocution Malayalam', 'Poem Recitation Malayalam', 'Story Writing- English', 'Essay Writing- English', 'Essay Writing- Malayalam', 'Poetry writing- English', '', '', '', 320, '8078389479'),
('Adithiyakrishnan rajeev', 'AM.LS.U3BIT22108', 'Male', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Pencil drawing', 'Cartoon Drawing', 'Doodling', '', '', '', '', '', '', '', '', 'Pencil drawing', 'Cartoon Drawing', 'Doodling', '', '', '', '', 400, '9778146237'),
('Akshaya MV', 'AM.LS.U3BIT22109', 'Female', 'BSc', 'Biotechnology', '3rd', 'Fancy dress', 'Folk dance', 'Poem Recitation Malayalam', 'Kucchipudi', 'Solo Dance- Semi-Classical', 'Pencil drawing', 'Water Coloring', 'Face to Face', 'Clay modelling', 'Soap Carving', 'Nostalgia dance', 'Poem Recitation-Sanskrit', 'Folk dance', 'Poem Recitation Malayalam', 'Kucchipudi', 'Solo Dance- Semi-Classical', 'Pencil drawing', 'Water Coloring', 'Face to Face', 'Clay modelling', 'Soap Carving', 'Nostalgia dance', 'AM.LS.U3BIT22109,AM.LS.U3BIT22132,AM.LS.U3BIT22118,AM.LS.U3BIT22041,AM.LS.U3BIT22114,AM.LS.U3BIT22016', 367, '9747264189'),
('Bindhya Nair', 'AM.LS.U3BIT22113', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', '', '', '', '', '', 'Folk song', '', '', '', '', '', '', '', '', '', '', 'Folk song', 'AM.LS.U3BIT22113,AM.LS.U3BIT22149', 363, '8943605567'),
('Chaithanya Unnikrishnan ', 'AM.LS.U3BIT22114', 'Female', 'BSc', 'Biotechnology', '3rd', 'Filmy-Song', 'Light Music', 'Carnatic solo', '', '', 'Mandala Art', 'Mehendi Designing', '', '', '', 'Karaoke Duet', 'Filmy-Song', 'Light Music', 'Carnatic solo', '', '', 'Mandala Art', 'Mehendi Designing', '', '', '', 'Karaoke Duet', 'AM.LS.U3BIT22114,AM.LS.U3BIT22042', 334, '9895820702'),
('Devika Sandeep ', 'AM.LS.U3BIT22116', 'Female', 'BSc', 'Biotechnology', '3rd', 'Extempore', '', '', '', '', 'Poetry writing- English', 'Mehendi Designing', 'Story Writing- English', '', '', '', 'Extempore', '', '', '', '', 'Poetry writing- English', 'Mehendi Designing', 'Story Writing- English', '', '', '', '', 358, '9747655878'),
('Namratha Manoj ', 'AM.LS.U3BIT22127', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', '', '', '', '', '', 373, '8590065252'),
('Oudlin Mary Lenin', 'AM.LS.U3BIT22129', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', '', '', '', '', '', 'Karaoke Duet', '', '', '', '', '', '', '', '', '', '', 'Karaoke Duet', 'AM.LS.U3BIT22129,AM.LS.U3BIT22145', 333, '7736485100'),
('P.N. SIVAPRIYA ', 'AM.LS.U3BIT22131', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', 376, '8078378991'),
('Satheesh Krishna C ', 'AM.LS.U3BIT22138', 'Male', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Pencil drawing', 'Story Writing- English', '', '', '', '', '', '', '', '', '', 'Pencil drawing', 'Story Writing- English', '', '', '', '', '', 399, '9820209544'),
('Sreelakshmi S Kumar', 'AM.LS.U3BIT22144', 'Female', 'BSc', 'Biotechnology', '3rd', 'Monoact', '', '', '', '', '', '', '', '', '', 'Filmy dance', 'Monoact', '', '', '', '', '', '', '', '', '', 'Filmy dance', 'AM.LS.U3BIT22144,AM.LS.U3BIT22029,AM.LS.U3BIT22020,AM.LS.U3BIT22158,AM.LS.U3BIT22159,AM.LS.U3BIT22054', 394, '9718139339'),
('Sreekarthika R S', 'AM.LS.U3BIT22157', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Collage', '', '', '', '', '', '', '', '', '', '', 'Collage', '', '', '', '', '', '', 308, '9847028261'),
('Nasrin S Baiju', 'AM.LS.U3BIT22158', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Mehendi Designing', 'Story Writing- English', '', '', '', '', '', '', '', '', '', 'Mehendi Designing', 'Story Writing- English', '', '', '', '', '', 336, '8089808577'),
('Aaliya sujab', 'AM.LS.U3BIT22159', 'Female', 'BSc', 'Biotechnology', '3rd', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', '', '', '', '', '', 315, '7736063228'),
('Abirami A', 'AM.LS.U3BIT23002', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Pencil drawing', 'Face to Face', 'Story Writing- English', '', '', 'Nostalgia dance', '', '', '', '', '', 'Pencil drawing', 'Face to Face', 'Story Writing- English', '', '', 'Nostalgia dance', 'AM.LS.U3BIT23002,AM.LS.U3MIB23039,AM.LS.U3MIB23020,AM.LS.U3BIT23113,AM.LS.U3BIT23104,AM.LS.U3BIT23156,AM.LS.U3BIT23034,AM.LS.U3BIT23033,AM.LS.U3BIT23040,AM.LS.U3BIT23010,AM.LS.U3BIT23039', 227, '6383495300'),
('Abitha S', 'AM.LS.U3BIT23003', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Soap Carving', 'Mandala Art', '', '', '', 'Vanjipattu', '', '', '', '', '', 'Soap Carving', 'Mandala Art', '', '', '', 'Vanjipattu', 'AM.LS.U3BIT23003,AM.LS.U3MIB23028,AM.LS.U3BIT23029,AM.LS.U3BIT23117,AM.LS.U3BIT23156,AM.LS.U3BIT23118,AM.LS.U3BIT23039', 296, '8189909040'),
('Adendla Sai Sri Siri ', 'AM.LS.U3BIT23006', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', '', '', '', '', '', 'Patriotic Song', '', '', '', '', '', '', '', '', '', '', 'Patriotic Song', 'AM.LS.U3BIT23006,AM.LS.U3BIT23139,AM.LS.U3BIT23050,AM.LS.U3BIT23117,AM.LS.U3BUT23119,AM.LS.U3BIT23039,AM.LS.U3MIB23003', 255, '7702205237'),
('Akhila Chandran', 'AM.LS.U3BIT23010', 'Female', 'BSc', 'Biotechnology', '2nd', 'Solo Dance- Filmy', 'Solo Dance- Semi-Classical', 'Bharatanatyam', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Tharjima', '', '', '', 'Solo Dance- Filmy', 'Solo Dance- Semi-Classical', 'Bharatanatyam', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Tharjima', '', '', '', '', 229, '9746873404'),
('Anushka Pandey', 'AM.LS.U3BIT23012', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Essay Writing- English', 'Essay Writing- Hindi', 'Story Writing- Hindi', '', '', '', '', '', '', '', '', 'Essay Writing- English', 'Essay Writing- Hindi', 'Story Writing- Hindi', '', '', '', '', 215, '8955905335'),
('Arya Saaj Mohanan', 'AM.LS.U3BIT23016', 'Female', 'BSc', 'Biotechnology', '2nd', 'Essay Writing- Hindi', 'Mehendi Designing', 'Pencil drawing', '', '', '', '', '', '', '', '', 'Essay Writing- Hindi', 'Mehendi Designing', 'Pencil drawing', '', '', '', '', '', '', '', '', '', 284, '9778461114'),
('B Nameetha', 'AM.LS.U3BIT23018', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Mandala Art', 'Cartoon Drawing', 'Pencil drawing', 'Story Writing- English', 'Doodling', '', '', '', '', '', '', 'Mandala Art', 'Cartoon Drawing', 'Pencil drawing', 'Story Writing- English', 'Doodling', '', '', 276, '6379397344'),
('Elishia Alex', 'AM.LS.U3BIT23022', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', '', '', '', '', '', 'Patriotic Song', '', '', '', '', '', '', '', '', '', '', 'Patriotic Song', 'AM.LS.U3BIT23022,AM.LS.U3BIT23102,AM.LS.U3BIT23121,AM.LS.U3BIT23129,AM.LS.U3BIT23144,AM.LS.U3BIT23118', 245, '9846869240'),
('Lekshmi Greeshma Ratheesh', 'AM.LS.U3BIT23030', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Story Writing- English', 'Doodling', 'Essay Writing- English', '', '', 'Filmy dance', '', '', '', '', '', 'Story Writing- English', 'Doodling', 'Essay Writing- English', '', '', 'Filmy dance', 'AM.LS.U3BIT23030,AM.LS.U3BIT23044,AM.LS.U3BIT23027,AM.LS.U3BIT23039,AM.LS.U3BIT23032,AM.LS.U3BIT23136,AM.LS.U3BIT23122,AM.LS.U3BIT23040,AM.LS.U3BIT23033', 279, '6235628244'),
('Meghna Sanjeev', 'AM.LS.U3BIT23031', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', '', '', '', '', '', 'Karaoke Duet', '', '', '', '', '', '', '', '', '', '', 'Karaoke Duet', 'AM.LS.U3BIT23031,AM.LS.U3BIT23032', 298, '6238747137'),
('Mithra Manoj ', 'AM.LS.U3BIT23032', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Story Writing- English', '', '', '', '', 'Synchronized Duet Dance', '', '', '', '', '', 'Story Writing- English', '', '', '', '', 'Synchronized Duet Dance', 'AM.LS.U3BIT23032,AM.LS.U3MIB23039', 293, '9020301144'),
('Nandaja A', 'AM.LS.U3BIT23037', 'Female', 'BSc', 'Biotechnology', '2nd', 'Poem Recitation Malayalam', 'Poem Recitation Hindi', '', '', '', 'Essay Writing- English', 'Story Writing- Malayalam', '', '', '', '', 'Poem Recitation Malayalam', 'Poem Recitation Hindi', '', '', '', 'Essay Writing- English', 'Story Writing- Malayalam', '', '', '', '', '', 218, '9778242376'),
('Nikhil sarath C S', 'AM.LS.U3BIT23038', 'Male', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Essay Writing- English', '', '', '', '', '', '', '', '', '', '', 'Essay Writing- English', '', '', '', '', '', '', 291, '7012250867'),
('Pavithra Balachandran ', 'AM.LS.U3BIT23039', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Tharjima', 'Pencil drawing', 'Story Writing- English', 'Story Writing- Hindi', 'Mandala Art', '', '', '', '', '', '', 'Tharjima', 'Pencil drawing', 'Story Writing- English', 'Story Writing- Hindi', 'Mandala Art', '', '', 250, '8590671075'),
('Reshma Suresh ', 'AM.LS.U3BIT23040', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Pencil drawing', 'Story Writing- English', 'Mandala Art', 'Essay Writing- English', '', '', '', '', '', '', '', 'Pencil drawing', 'Story Writing- English', 'Mandala Art', 'Essay Writing- English', '', '', '', 233, '8891041238'),
('Saparya Panakkat ', 'AM.LS.U3BIT23042', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', 236, '7736477740'),
('Shivani C V', 'AM.LS.U3BIT23044', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Essay Writing- Malayalam', 'Story Writing- Malayalam', '', '', '', '', '', '', '', '', '', 'Essay Writing- Malayalam', 'Story Writing- Malayalam', '', '', '', '', '', 275, '8714958031'),
('Sona Agnes K L ', 'AM.LS.U3BIT23046', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Story Writing- English', 'Story Writing- Malayalam', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Story Writing- Malayalam', '', '', '', '', '', 217, '8075354772'),
('Vaddireddy jhansi', 'AM.LS.U3BIT23047', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Poetry writing- English', '', '', '', '', '', '', '', '', '', '', 'Poetry writing- English', '', '', '', '', '', '', 259, '6303977842'),
('Niranjana Muraleedharan', 'AM.LS.U3BIT23050', 'Female', 'BSc', 'Biotechnology', '2nd', 'Anchoring', 'Extempore', 'Elocution English', 'Light Music', 'Filmy-Song', 'Poetry writing- Hindi', 'Poetry writing- English', 'Essay Writing- English', 'Essay Writing- Hindi', 'Poetry writing- Malayalam', '', 'Anchoring', 'Extempore', 'Elocution English', 'Light Music', 'Filmy-Song', 'Poetry writing- Hindi', 'Poetry writing- English', 'Essay Writing- English', 'Essay Writing- Hindi', 'Poetry writing- Malayalam', '', '', 248, '9497572799'),
('Nidhi Jayaprakash', 'AM.LS.U3BIT23052', 'Female', 'BSc', 'Biotechnology', '2nd', 'Kucchipudi', '', '', '', '', '', '', '', '', '', '', 'Kucchipudi', '', '', '', '', '', '', '', '', '', '', '', 238, '9074969062'),
('Abhijith Gopakumar ', 'AM.LS.U3BIT23101', 'Male', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', 299, '8089945211'),
('Adrita Chatterjee ', 'AM.LS.U3BIT23102', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Essay Writing- Hindi', 'Story Writing- Hindi', '', '', '', '', '', '', '', '', '', 'Essay Writing- Hindi', 'Story Writing- Hindi', '', '', '', '', '', 222, '9928945570'),
('Devika S Warrier ', 'AM.LS.U3BIT23110', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', 252, '9307438285'),
('Daya Anil', 'AM.LS.U3BIT23111', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Essay Writing- Hindi', 'Doodling', '', '', '', '', '', '', '', '', '', 'Essay Writing- Hindi', 'Doodling', '', '', '', '', '', 262, '6235135947'),
('Divya Raju', 'AM.LS.U3BIT23114', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Pencil drawing', 'Cartoon Drawing', 'Story Writing- English', 'Doodling', '', '', '', '', '', '', '', 'Pencil drawing', 'Cartoon Drawing', 'Story Writing- English', 'Doodling', '', '', '', 224, '8281894531'),
('Srilaasya M I Ganapathiraju', 'AM.LS.U3BIT23117', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Soap Carving', 'Story Writing- English', 'Clay modelling', '', '', '', '', '', '', '', '', 'Soap Carving', 'Story Writing- English', 'Clay modelling', '', '', '', '', 223, '9493244254'),
('Gireendraja VS', 'AM.LS.U3BIT23118', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Essay Writing- Hindi', 'Mandala Art', 'Doodling', '', '', '', '', '', '', '', '', 'Essay Writing- Hindi', 'Mandala Art', 'Doodling', '', '', '', '', 207, '8921025722'),
('GOPIKA CS', 'AM.LS.U3BIT23119', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Tharjima', 'Essay Writing- Malayalam', 'Story Writing- Malayalam', '', '', '', '', '', '', '', '', 'Tharjima', 'Essay Writing- Malayalam', 'Story Writing- Malayalam', '', '', '', '', 240, '8606692946'),
('INDRAJA SHEESU ', 'AM.LS.U3BIT23121', 'Female', 'BSc', 'Biotechnology', '2nd', 'Fancy dress', '', '', '', '', '', '', '', '', '', 'Mime', 'Fancy dress', '', '', '', '', '', '', '', '', '', 'Mime', 'AM.LS.U3BIT23121', 251, '8139841532'),
('NIVYAA J P', 'AM.LS.U3BIT23122', 'Female', 'BSc', 'Biotechnology', '2nd', 'Solo Dance- Filmy', '', '', '', '', 'Story Writing- English', '', '', '', '', '', 'Solo Dance- Filmy', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', 221, '8807373374'),
('M J DAYITA', 'AM.LS.U3BIT23129', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', '', '', '', '', '', 'Vanjipattu', '', '', '', '', '', '', '', '', '', '', 'Vanjipattu', 'AM.LS.U3BIT23129,AM.LS.U3BIT23119,AM.LS.U3BIT23033,AM.LS.U3BIT23139,AM.LS.U3BIT23042,AM.LS.U3BIT23131,AM.LS.U3BIT23121', 237, '8281896301'),
('Mithra Krishna ', 'AM.LS.U3BIT23131', 'Female', 'BSc', 'Biotechnology', '2nd', 'Fancy dress', '', '', '', 'Elocution English', 'Essay Writing- English', 'Story Writing- English', 'Poetry writing- English', '', '', 'Nostalgia dance', 'Fancy dress', '', '', '', 'Elocution English', 'Essay Writing- English', 'Story Writing- English', 'Poetry writing- English', '', '', 'Nostalgia dance', 'AM.LS.U3BIT23131,AM.LS.U3BIT23134,AM.LS.U3BIT23133,AM.LS.U3BIT23132,AM.LS.U3BIT23121,AM.LS.U3BIT23151,AM.LS.U3BIT23157,AM.LS.U3BIT23147,AM.LS.U3BIT23038,AM.LS.U3BIT23043,AM.LS.U3BIT23031,AM.LS.U3BIT23112', 239, '9995468229'),
('Nandana Santhosh ', 'AM.LS.U3BIT23134', 'Female', 'BSc', 'Biotechnology', '2nd', 'Solo Dance- Semi-Classical', 'Bharatanatyam', 'Mohiniyattom', 'Fancy dress', '', '', '', '', '', '', 'Synchronized Duet Dance', 'Solo Dance- Semi-Classical', 'Bharatanatyam', 'Mohiniyattom', 'Fancy dress', '', '', '', '', '', '', 'Synchronized Duet Dance', 'AM.LS.U3BIT23134,AM.LS.U3BIT23131', 234, '6238294930'),
('Neha Nair Sajeev', 'AM.LS.U3BIT23136', 'Female', 'BSc', 'Biotechnology', '2nd', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', '', 242, '8089569278'),
('NIKHILA S BABU', 'AM.LS.U3BIT23137', 'Female', 'BSc', 'Biotechnology', '2nd', 'Kucchipudi', '', '', '', '', '', '', '', '', '', '', 'Kucchipudi', '', '', '', '', '', '', '', '', '', '', '', 294, '8891768296'),
('Noura Nizar', 'AM.LS.U3BIT23138', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Tharjima', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', '', '', 'Tharjima', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Essay Writing- English', 'Poetry writing- English', '', '', 271, '9995931747'),
('Oviya S', 'AM.LS.U3BIT23139', 'Female', 'BSc', 'Biotechnology', '2nd', 'Filmy-Song', 'Light Music', '', '', '', 'Story Writing- English', 'Water Coloring', 'Soap Carving', '', '', 'Karaoke Duet', 'Filmy-Song', 'Light Music', '', '', '', 'Story Writing- English', 'Water Coloring', 'Soap Carving', '', '', 'Karaoke Duet', 'AM.LS.U3BIT23139,AM.LS.U3BIT23154', 205, '6379942557'),
('Pavithra Praveen', 'AM.LS.U3BIT23140', 'Female', 'BSc', 'Biotechnology', '2nd', 'Elocution English', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', 'Elocution English', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', 282, '9054588127'),
('Sreelakshmi Rajan', 'AM.LS.U3BIT23144', 'Female', 'BSc', 'Biotechnology', '2nd', 'Poem Recitation Malayalam', 'Light Music', '', '', '', '', '', '', '', '', 'Semi-Classical Group Dance', 'Poem Recitation Malayalam', 'Light Music', '', '', '', '', '', '', '', '', 'Semi-Classical Group Dance', 'AM.LS.U3BIT23144,AM.LS.U3BIT23134,AM.LS.U3BIT23010,AM.LS.U3BIT23032,AM.LS.U3MIB23039,AM.LS.U3MIB23041,AM.LS.U3BIT23006,AM.LS.U3BIT23002', 246, '7012680250'),
('Sreelakshmi Ranjith', 'AM.LS.U3BIT23145', 'Female', 'BSc', 'Biotechnology', '2nd', 'Western Music', 'Indian Classical Music', 'Filmy-Song', 'Monoact', 'Solo Dance- Semi-Classical', 'Mandala Art', '', '', '', '', 'Karaoke Duet', 'Western Music', 'Indian Classical Music', 'Filmy-Song', 'Monoact', 'Solo Dance- Semi-Classical', 'Mandala Art', '', '', '', '', 'Karaoke Duet', 'AM.LS.U3BIT23145,AM.LS.U3BIT23118', 253, '9746795478'),
('Vaishnovi Sethi', 'AM.LS.U3BIT23149', 'Female', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', '', '', '', '', '', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', '', 292, '9633351657'),
('nandana hari', 'AM.LS.U3BIT23151', 'Female', 'BSc', 'Biotechnology', '2nd', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', '', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', '', '', 232, '9745610164'),
('Hari Govind P', 'AM.LS.U3BIT23153', 'Male', 'BSc', 'Biotechnology', '2nd', '', '', '', '', '', 'Story Writing- English', 'Pencil drawing', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Pencil drawing', '', '', '', '', '', 231, '9908302880'),
('DEEPAK T T ', 'AM.LS.U3BIT23154', 'Male', 'BSc', 'Biotechnology', '2nd', 'Filmy-Song', 'Light Music', 'Carnatic solo', 'Western Music', '', 'Tharjima', '', '', '', '', '', 'Filmy-Song', 'Light Music', 'Carnatic solo', 'Western Music', '', 'Tharjima', '', '', '', '', '', '', 286, '7306951692'),
('Sahithi varma ', 'AM.LS.U3BIT23155', 'Female', 'BSc', 'Biotechnology', '2nd', 'Fancy dress', '', '', '', '', '', '', '', '', '', '', 'Fancy dress', '', '', '', '', '', '', '', '', '', '', '', 204, '9492035189'),
('Sanjay Krishna ', 'AM.LS.U3BIT23157', 'Male', 'BSc', 'Biotechnology', '2nd', 'Monoact', '', '', '', '', '', '', '', '', '', '', 'Monoact', '', '', '', '', '', '', '', '', '', '', '', 266, '8610783675'),
('Devika Rajesh ', 'AM.LS.U3BIT24007', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', '', '', '', '', '', 'Nostalgia dance', '', '', '', '', '', '', '', '', '', '', 'Nostalgia dance', 'AM.LS.U3BIT24007,AM.LS.U3BIT24011', 137, '8848664320'),
('Gouri Krishna K R', 'AM.LS.U3BIT24010', 'Female', 'BSc', 'Biotechnology', '1st', 'Fancy dress', '', '', '', '', '', '', '', '', '', '', 'Fancy dress', '', '', '', '', '', '', '', '', '', '', '', 123, '8590512112'),
('Gowri S Thampi ', 'AM.LS.U3BIT24011', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- Malayalam', '', '', '', '', '', '', '', '', '', '', 'Story Writing- Malayalam', '', '', '', '', '', '', 148, '8089643729'),
('Harsha A', 'AM.LS.U3BIT24012', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- English', 'Pencil drawing', 'Story Writing- Malayalam', 'Essay Writing- English', 'Essay Writing- Malayalam', 'Nostalgia dance', '', '', '', '', '', 'Story Writing- English', 'Pencil drawing', 'Story Writing- Malayalam', 'Essay Writing- English', 'Essay Writing- Malayalam', 'Nostalgia dance', 'AM.LS.U3BIT24012,AM.LS.U4BIT24131,AM.LS.U4BIT24121,AM.LS.U4BIT24005,AM.LS.U4BIT24015,AM.LS.U4BIT24059,AM.LS.U4BIT24021,AM.LS.U4BIT24127', 182, '6238283098'),
('Kashinath K Manoj', 'AM.LS.U3BIT24014', 'Male', 'BSc', 'Biotechnology', '1st', 'Anchoring', 'Extempore', 'Poem Recitation English', '', '', 'Poetry writing- English', 'Essay Writing- English', '', '', '', '', 'Anchoring', 'Extempore', 'Poem Recitation English', '', '', 'Poetry writing- English', 'Essay Writing- English', '', '', '', '', '', 164, '9847202769'),
('Namita Anup', 'AM.LS.U3BIT24016', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- English', 'Cartoon Drawing', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Cartoon Drawing', '', '', '', '', '', 166, '9072313974'),
('Sree Lakshmi Raj', 'AM.LS.U3BIT24022', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', 'AM.LS.U3BIT24022', 193, '8921992319'),
('Aiswarya Sajikumar ', 'AM.LS.U3MIB22009', 'Female', 'BSc', 'Microbiology', '3rd', 'Elocution English', 'Extempore', '', '', '', 'Pencil drawing', 'Soap Carving', 'Mandala Art', 'Clay modelling', 'Essay Writing- English', '', 'Elocution English', 'Extempore', '', '', '', 'Pencil drawing', 'Soap Carving', 'Mandala Art', 'Clay modelling', 'Essay Writing- English', '', '', 393, '7902709843'),
('AMRITHA SANTHOSH', 'AM.LS.U3MIB22011', 'Female', 'BSc', 'Microbiology', '3rd', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', 'Essay Writing- English', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', 'Essay Writing- English', '', '', '', '', 397, '8848975686'),
('Devika C S', 'AM.LS.U3MIB22016', 'Female', 'BSc', 'Microbiology', '3rd', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', '', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', '', '', 327, '9188252092'),
('Gayathri P', 'AM.LS.U3MIB22019', 'Female', 'BSc', 'Microbiology', '3rd', 'Poem Recitation Hindi', '', '', '', '', 'Tharjima', 'Poetry writing- English', 'Story Writing- English', '', '', '', 'Poem Recitation Hindi', '', '', '', '', 'Tharjima', 'Poetry writing- English', 'Story Writing- English', '', '', '', '', 341, '9037980573'),
('Krishna Roy', 'AM.LS.U3MIB22026', 'Female', 'BSc', 'Microbiology', '3rd', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', '', 349, '9846028072'),
('Lubna Shajahan', 'AM.LS.U3MIB22027', 'Female', 'BSc', 'Microbiology', '3rd', '', '', '', '', '', 'Soap Carving', 'Water Coloring', 'Mehendi Designing', 'Clay modelling', 'Collage', '', '', '', '', '', '', 'Soap Carving', 'Water Coloring', 'Mehendi Designing', 'Clay modelling', 'Collage', '', '', 360, '8714400576'),
('M Manaswini', 'AM.LS.U3MIB22028', 'Female', 'BSc', 'Microbiology', '3rd', 'Carnatic solo', '', '', '', '', 'Doodling', 'Mandala Art', '', '', '', '', 'Carnatic solo', '', '', '', '', 'Doodling', 'Mandala Art', '', '', '', '', '', 366, '7012740868'),
('Preethika Krishnan', 'AM.LS.U3MIB22037', 'Female', 'BSc', 'Microbiology', '3rd', 'Solo Dance- Filmy', 'Anchoring', '', '', '', '', '', '', '', '', '', 'Solo Dance- Filmy', 'Anchoring', '', '', '', '', '', '', '', '', '', '', 332, '9656045985'),
('Amritha Lekshmi R', 'AM.LS.U3MIB22050', 'Female', 'BSc', 'Microbiology', '3rd', '', '', '', '', '', 'Mandala Art', 'Mehendi Designing', '', '', '', '', '', '', '', '', '', 'Mandala Art', 'Mehendi Designing', '', '', '', '', '', 374, '9048810131'),
('Dhakshathaa.u', 'AM.LS.U3MIB22053', 'Female', 'BSc', 'Microbiology', '3rd', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', '', 303, '8220317208'),
('Amrita M Nair', 'AM.LS.U3MIB22060', 'Female', 'BSc', 'Microbiology', '3rd', 'Poem Recitation Malayalam', 'Carnatic solo', '', '', '', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Mandala Art', 'Doodling', 'Story Writing- Malayalam', '', 'Poem Recitation Malayalam', 'Carnatic solo', '', '', '', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Mandala Art', 'Doodling', 'Story Writing- Malayalam', '', '', 353, '6235741609'),
('ALISHA MARIA SAILESH', 'AM.LS.U3MIB23003', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', '', '', '', '', '', 'Vanjipattu', '', '', '', '', '', '', '', '', '', '', 'Vanjipattu', 'AM.LS.U3MIB23003,AM.LS.U3BIT23144,AM.LS.U3BIT23145,AM.LS.U3BIT23034,AM.LS.U3MIB23025,AM.LS.U3MIB23038', 220, '9188063584'),
('Anooja', 'AM.LS.U3MIB23006', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Tharjima', 'Story Writing- English', 'Story Writing- Malayalam', 'Poetry writing- English', 'Poetry writing- Malayalam', '', '', '', '', '', '', 'Tharjima', 'Story Writing- English', 'Story Writing- Malayalam', 'Poetry writing- English', 'Poetry writing- Malayalam', '', '', 280, '9946969600'),
('Anakha ', 'AM.LS.U3MIB23010', 'Female', 'BSc', 'Microbiology', '2nd', 'Anchoring', 'Extempore', 'Elocution English', 'Elocution Malayalam', 'Poem Recitation Malayalam', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Story Writing- English', 'Poetry writing- English', 'Patriotic Song', 'Anchoring', 'Extempore', 'Elocution English', 'Elocution Malayalam', 'Poem Recitation Malayalam', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Story Writing- English', 'Poetry writing- English', 'Patriotic Song', 'AM.LS.U3MIB23010,AM.LS.U3MIB23033,AM.LS.U3MIB23047,AM.LS.U3MIB23028,AM.LS.U3MIB23024,AM.LS.U3MIB23037,AM.LS.U3MIB23026', 202, '7907812835'),
('JUDIT SARAH VARGHESE', 'AM.LS.U3MIB23020', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', 285, '8606920527'),
('Mugdha Payyanadan', 'AM.LS.U3MIB23024', 'Female', 'BSc', 'Microbiology', '2nd', 'Carnatic solo', '', '', '', '', '', '', '', '', '', '', 'Indian Classical Music', '', '', '', '', '', '', '', '', '', '', '', 274, '7306633790'),
('Nancy K R ', 'AM.LS.U3MIB23025', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Tharjima', 'Essay Writing- English', 'Clay modelling', '', '', '', '', '', '', '', '', 'Tharjima', 'Essay Writing- English', 'Clay modelling', '', '', '', '', 212, '9562581533'),
('Parvathy Ajit', 'AM.LS.U3MIB23028', 'Female', 'BSc', 'Microbiology', '2nd', 'Carnatic solo', 'Filmy-Song', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', 'Carnatic solo', 'Filmy-Song', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', 241, '9656005975'),
('Prerana Rajesh', 'AM.LS.U3MIB23030', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Pencil drawing', 'Water Coloring', 'Cartoon Drawing', 'Mandala Art', '', '', '', '', '', '', '', 'Pencil drawing', 'Water Coloring', 'Cartoon Drawing', 'Mandala Art', '', '', '', 210, '9747619857'),
('Ram Raj', 'AM.LS.U3MIB23032', 'Male', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Pencil drawing', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', '', '', '', 'Pencil drawing', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', 267, '6238004269'),
('Smrithi ', 'AM.LS.U3MIB23033', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', '', '', '', '', '', 'Folk song', '', '', '', '', '', '', '', '', '', '', 'Folk song', 'AM.LS.U3MIB23033,AM.LS.U3MIB23010,AM.LS.U3MIB23047,AM.LS.U3MIB23024,AM.LS.U3MIB23037,AM.LS.U3MIB23028,AM.LS.U3MIB23026', 213, '9961310203'),
('Sneha S', 'AM.LS.U3MIB23037', 'Female', 'BSc', 'Microbiology', '2nd', 'Filmy-Song', 'Carnatic solo', '', '', '', '', '', '', '', '', '', 'Filmy-Song', 'Carnatic solo', '', '', '', '', '', '', '', '', '', '', 268, '9846699940'),
('Gopika jayakumar', 'AM.LS.U3MIB23039', 'Female', 'BSc', 'Microbiology', '2nd', 'Solo Dance- Filmy', '', '', '', '', 'Essay Writing- English', 'Poetry writing- English', '', '', '', 'Filmy dance', 'Solo Dance- Filmy', '', '', '', '', 'Essay Writing- English', 'Poetry writing- English', '', '', '', 'Filmy dance', 'AM.LS.U3MIB23039,AM.LS.U3MIB23020,AM.LS.U3MIB23030,AM.LS.U3BIT23134,AM.LS.U3BIT23133,AM.LS.U3BIT23231', 290, '7356459172'),
('Malavika Pazhore', 'AM.LS.U3MIB23041', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Mandala Art', 'Doodling', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Essay Writing- English', '', '', '', '', '', '', 'Mandala Art', 'Doodling', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Essay Writing- English', '', '', 265, '8089811956'),
('Abitha k Sajeev ', 'AM.LS.U3MIB23047', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', '', 244, '9037636958'),
('Namita Logeshwaran ', 'AM.LS.U3MIB23049', 'Female', 'BSc', 'Microbiology', '2nd', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', '', '', '', '', '', 260, '8438833647'),
('Athulya P S', 'AM.LS.U3MIB24002', 'Female', 'BSc', 'Microbiology', '1st', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', 150, '8075915390'),
('Jovanna Jephy', 'AM.LS.U3MIB24005', 'Female', 'BSc', 'Microbiology', '1st', 'Poem Recitation Malayalam', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Mehendi Designing', '', 'Semi-Classical Group Dance', 'Poem Recitation Malayalam', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', 'Poetry writing- Malayalam', 'Mehendi Designing', '', 'Semi-Classical Group Dance', 'AM.LS.U3MIB24005,AM.LS.U4MIB24016', 138, '8304071309'),
('A Kavyasree', 'AM.LS.U4BIT24001', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', 'AM.LS.U4BIT24001,AM.LS.U4BIT24025,AM.LS.U4BIT24043,AM.LS.U4BIT24010,AM.LS.U4BIT24061,AM.LS.U4BIT24142,AM.LS.U4BIT24012,AM.LS.U4BIT24006,AM.LS.U4BIT24052,AM.LS.U4BIT24018', 147, '9566445703'),
('Aarya S', 'AM.LS.U4BIT24003', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Mandala Art', '', '', '', '', '', '', '', '', '', '', 'Mandala Art', '', '', '', '', '', '', 199, '8088594308'),
('Adhya Umesh ', 'AM.LS.U4BIT24005', 'Female', 'BSc', 'Biotechnology', '1st', 'Anchoring', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', 'Poetry writing- Malayalam', '', 'Anchoring', '', '', '', '', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', 'Poetry writing- Malayalam', '', '', 149, '9188641945'),
('Anagha Alice George', 'AM.LS.U4BIT24011', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Mandala Art', '', '', '', '', '', '', '', '', '', '', 'Mandala Art', '', '', '', '', '', '', 163, '8304096062'),
('Aparna V', 'AM.LS.U4BIT24015', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- English', 'Story Writing- Malayalam', 'Essay Writing- English', 'Essay Writing- Malayalam', '', '', '', '', '', '', '', 'Story Writing- English', 'Story Writing- Malayalam', 'Essay Writing- English', 'Essay Writing- Malayalam', '', '', '', 140, '8075084622'),
('Arya PP', 'AM.LS.U4BIT24019', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', 179, '9446164678'),
('Devapriya Sivaprasad ', 'AM.LS.U4BIT24020', 'Female', 'BSc', 'Biotechnology', '1st', 'Poem Recitation Hindi', 'Monoact', 'Light Music', 'Carnatic solo', 'Filmy-Song', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', 'Poem Recitation Hindi', 'Monoact', 'Light Music', 'Carnatic solo', 'Filmy-Song', 'Story Writing- English', 'Essay Writing- English', 'Poetry writing- English', '', '', '', '', 192, '7306104985'),
('K S BHADRAA', 'AM.LS.U4BIT24034', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Essay Writing- Malayalam', 'Story Writing- Malayalam', '', '', '', 'Filmy dance', '', '', '', '', '', 'Essay Writing- Malayalam', 'Story Writing- Malayalam', '', '', '', 'Filmy dance', 'AM.LS.U4BIT24034,AM.LS.U4BIT24041,AM.LS.U4BIT24042,AM.LS.U4BIT24050,AM.LS.U4BIT24044,AM.LS.U4BIT24033,AM.LS.U4BIT24057', 191, '7012212793'),
('Nakshatra Mohanan ', 'AM.LS.U4BIT24039', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Pencil drawing', 'Essay Writing- English', '', '', '', 'Filmy dance', '', '', '', '', '', 'Pencil drawing', 'Essay Writing- English', '', '', '', 'Filmy dance', 'AM.LS.U4BIT24039', 173, '9961243110'),
('PRARTHANA S NAIR ', 'AM.LS.U4BIT24042', 'Female', 'BSc', 'Biotechnology', '1st', 'Poem Recitation Malayalam', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', 'Poem Recitation Malayalam', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', '', 145, '8289864791'),
('Sneha R Nair', 'AM.LS.U4BIT24052', 'Female', 'BSc', 'Biotechnology', '1st', 'Solo Dance- Semi-Classical', '', '', '', '', 'Mehendi Designing', '', '', '', '', 'Semi-Classical Group Dance', 'Solo Dance- Semi-Classical', '', '', '', '', 'Mehendi Designing', '', '', '', '', 'Semi-Classical Group Dance', 'AM.LS.U4BIT24052,AM.LS.U4BIT24012,AM.LS.U4BIT24001,AM.LS.U4BIT24006,AM.LS.U4BIT24055,AM.LS.U4BIT24033,AM.LS.U4BIT24112', 186, '7907747736'),
('Vaishnavi R Nair', 'AM.LS.U4BIT24056', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- English', 'Pencil drawing', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Pencil drawing', '', '', '', '', '', 121, '7829966005'),
('Nikitha', 'AM.LS.U4BIT24101', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Story Writing- English', 'Mandala Art', 'Mehendi Designing', 'Doodling', '', '', '', '', '', '', '', 'Story Writing- English', 'Mandala Art', 'Mehendi Designing', 'Doodling', '', '', '', 126, '9842781022'),
('Anamika Sunil', 'AM.LS.U4BIT24105', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Essay Writing- English', 'Essay Writing- Malayalam', '', '', '', '', '', '', '', '', '', 'Essay Writing- English', 'Essay Writing- Malayalam', '', '', '', '', '', 113, '7034141282'),
('Archana k', 'AM.LS.U4BIT24108', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Doodling', '', '', '', '', '', '', '', '', '', '', 'Doodling', '', '', '', '', '', '', 139, '9072902958'),
('Gayathri Suresh ', 'AM.LS.U4BIT24115', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Essay Writing- English', 'Essay Writing- Malayalam', '', '', '', '', '', '', '', '', '', 'Essay Writing- English', 'Essay Writing- Malayalam', '', '', '', '', '', 112, '9562364751');
INSERT INTO `Event_Registration` (`Name`, `Roll_Number`, `Gender`, `Degree`, `Course`, `Year`, `Event1`, `Event2`, `Event3`, `Event4`, `Event5`, `Event6`, `Event7`, `Event8`, `Event9`, `Event10`, `Group_event`, `EB1`, `EB2`, `EB3`, `EB4`, `EB5`, `EB6`, `EB7`, `EB8`, `EB9`, `EB10`, `GB`, `group_event_Participants`, `Chest_Number`, `Phone_Number`) VALUES
('Karthika.S', 'AM.LS.U4BIT24119', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', '', '', '', '', '', 'Thiruvathira', '', '', '', '', '', '', '', '', '', '', 'Thiruvathira', 'AM.LS.U4BIT24119,AM.LS.U4BIT24118,AM.LS.U4BIT24124,AM.LS.U3BIT24015,AM.LS.U4BIT24042,AM.LS.U4BIT24031,AM.LS.U4BIT24044,AM.LS.U4BIT24131,AM.LS.U4BIT24127,AM.LS.U3BIT24022', 181, '9995621850'),
('Keerthana KS', 'AM.LS.U4BIT24121', 'Female', 'BSc', 'Biotechnology', '1st', 'Fancy dress', '', '', '', '', '', '', '', '', '', '', 'Fancy dress', '', '', '', '', '', '', '', '', '', '', '', 167, '7012918069'),
('Medha Madhu ', 'AM.LS.U4BIT24123', 'Female', 'BSc', 'Biotechnology', '1st', 'Poem Recitation English', 'Fancy dress', '', '', '', 'Face to Face', 'Essay Writing- English', 'Poetry writing- English', 'Story Writing- English', 'Poetry writing- Hindi', '', 'Poem Recitation English', 'Fancy dress', '', '', '', 'Face to Face', 'Essay Writing- English', 'Poetry writing- English', 'Story Writing- English', 'Poetry writing- Hindi', '', '', 161, '8606796969'),
('Nandana Krishnakumar ', 'AM.LS.U4BIT24124', 'Female', 'BSc', 'Biotechnology', '1st', 'Carnatic solo', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', 'Carnatic solo', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', '', 131, '9446973812'),
('Samyuktha S', 'AM.LS.U4BIT24131', 'Female', 'BSc', 'Biotechnology', '1st', 'Fancy dress', '', '', '', '', '', '', '', '', '', 'Synchronized Duet Dance', 'Fancy dress', '', '', '', '', '', '', '', '', '', 'Synchronized Duet Dance', 'AM.LS.U4BIT24131,AM.LS.U4BIT24052', 158, '8590365703'),
('Shivangi Aravindan', 'AM.LS.U4BIT24133', 'Female', 'BSc', 'Biotechnology', '1st', 'Fancy dress', 'Poem Recitation-Sanskrit', '', '', '', 'Story Writing- English', 'Doodling', 'Face to Face', 'Clay modelling', '', '', 'Fancy dress', 'Poem Recitation-Sanskrit', '', '', '', 'Story Writing- English', 'Doodling', 'Face to Face', 'Clay modelling', '', '', '', 184, '7034543284'),
('Vandana VS', 'AM.LS.U4BIT24138', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Cartoon Drawing', 'Mehendi Designing', 'Mandala Art', 'Water Coloring', '', '', '', '', '', '', '', 'Cartoon Drawing', 'Mehendi Designing', 'Mandala Art', 'Water Coloring', '', '', '', 159, '9048457331'),
('Deekshitha Giriraj', 'AM.LS.U4BIT24143', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', '', '', '', '', '', '', '', '', '', '', 'Filmy dance', 'AM.LS.U4BIT24143,AM.LS.U4BIT24139,AM.LS.U4BIT24119,AM.LS.U3BIT24015,AM.LS.U3BIT24020,AM.LS.U4BIT24133,AM.LS.U4BIT24114', 153, '8248916801'),
('NandanaBR', 'AM.LS.U4MIB24001', 'Female', 'BSc', 'Microbiology', '1st', '', '', '', '', '', '', '', '', '', 'Story Writing- English', '', '', '', '', '', '', '', '', '', '', 'Story Writing- English', '', '', 183, '8943868106'),
('Krishna varshini PR ', 'AM.LS.U4MIB24002', 'Female', 'BSc', 'Microbiology', '1st', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', '', '', '', '', 'Pencil drawing', '', '', '', '', '', '', 127, '7012434672'),
('MITHRA B RAJI', 'AM.LS.U4MIB24003', 'Female', 'BSc', 'Microbiology', '1st', 'Monoact', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', 'Monoact', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', '', 174, '7736171842'),
('Aaron Sanju', 'AM.LS.U4MIB24004', 'Male', 'BSc', 'Microbiology', '1st', 'Extempore', 'Elocution English', '', '', '', '', '', '', '', '', '', 'Extempore', 'Elocution English', '', '', '', '', '', '', '', '', '', '', 157, '7306706559'),
('Prarthana binu', 'AM.LS.U4MIB24005', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Doodling', '', '', '', '', '', '', '', '', '', '', 'Doodling', '', '', '', '', '', '', 180, '8848297308'),
('Krishna Priya.c', 'AM.LS.U4MIB24009', 'Female', 'BSc', 'Microbiology', '1st', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', 'Solo Dance- Filmy', '', '', '', '', '', '', '', '', '', '', '', 154, '8921764948'),
('GAUTHAMI S NAIR', 'AM.LS.U4MIB24014', 'Female', 'BSc', 'Microbiology', '1st', 'Poem Recitation Malayalam', '', '', '', '', 'Essay Writing- Malayalam', '', '', '', '', '', 'Poem Recitation Malayalam', '', '', '', '', 'Essay Writing- Malayalam', '', '', '', '', '', '', 129, '8590784765'),
('Arshida nk ', 'AM.LS.U4MIB24015', 'Female', 'BSc', 'Microbiology', '1st', 'Poem Recitation English', 'Anchoring', 'Elocution English', '', '', 'Mandala Art', 'Mehendi Designing', '', '', '', '', 'Poem Recitation English', 'Anchoring', 'Elocution English', '', '', 'Mandala Art', 'Mehendi Designing', '', '', '', '', '', 152, '8281665552'),
('krithi vb', 'AM.LS.U4MIB24016', 'Female', 'BSc', 'Microbiology', '1st', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', '', '', '', '', '', '', '', '', '', 'Story Writing- English', 'Poetry writing- English', '', '', '', '', '', 176, '8714008922'),
('Vismaya. H P', 'AM.LS.U4MIB24020', 'Female', 'BSc', 'Microbiology', '1st', 'Indian Classical Music', 'Light Music', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', 'Indian Classical Music', 'Light Music', 'Poem Recitation Malayalam', '', '', '', '', '', '', '', '', '', 189, '9496540803'),
('Krishna B ', 'AM.LS.U4MIB24025', 'Female', 'BSc', 'Microbiology', '1st', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', '', '', '', '', '', 'Story Writing- Malayalam', 'Essay Writing- Malayalam', '', '', '', '', '', 102, '8848604266'),
('Nandana Prasad ', 'AM.LS.U4MIB24026', 'Female', 'BSc', 'Microbiology', '1st', 'Elocution Sanskrit', '', '', '', '', '', '', '', '', '', '', 'Elocution Sanskrit', '', '', '', '', '', '', '', '', '', '', '', 156, '9400253809'),
('Layana nv', 'AM.LS.U4MIB24028', 'Female', 'BSc', 'Biotechnology', '1st', '', '', '', '', '', 'Doodling', '', '', '', '', '', '', '', '', '', '', 'Doodling', '', '', '', '', '', '', 105, '7736755536'),
('Nirupama Krishna', 'AM.LS.U4MIB24030', 'Female', 'BSc', 'Microbiology', '1st', 'Light Music', '', '', '', '', '', '', '', '', '', '', 'Light Music', '', '', '', '', '', '', '', '', '', '', '', 101, '7736669074');

-- --------------------------------------------------------

--
-- Table structure for table `Event_Results`
--

CREATE TABLE `Event_Results` (
  `Name` varchar(50) DEFAULT NULL,
  `Roll_Number` varchar(20) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Degree` varchar(4) DEFAULT NULL,
  `Year` varchar(10) DEFAULT NULL,
  `Chest_Number` int(4) DEFAULT NULL,
  `Event` varchar(50) NOT NULL,
  `Rank` varchar(10) DEFAULT NULL,
  `Score` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaderboard_status`
--

CREATE TABLE `leaderboard_status` (
  `id` int(11) NOT NULL,
  `is_on` tinyint(1) NOT NULL,
  `end_time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leaderboard_status`
--

INSERT INTO `leaderboard_status` (`id`, `is_on`, `end_time`) VALUES
(1, 0, 1747411556282);

-- --------------------------------------------------------

--
-- Table structure for table `rank_scores`
--

CREATE TABLE `rank_scores` (
  `id` int(11) NOT NULL,
  `event_type` enum('individual','group') NOT NULL,
  `rank` varchar(10) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registration_status`
--

CREATE TABLE `registration_status` (
  `id` int(11) NOT NULL,
  `is_open` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registration_status`
--

INSERT INTO `registration_status` (`id`, `is_open`) VALUES
(1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `date` varchar(10) DEFAULT NULL,
  `month` varchar(10) DEFAULT NULL,
  `day` varchar(10) DEFAULT NULL,
  `venue` varchar(100) DEFAULT NULL,
  `events` text DEFAULT NULL,
  `times` text DEFAULT NULL,
  `coordinator` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `date`, `month`, `day`, `venue`, `events`, `times`, `coordinator`, `phone`) VALUES
(7, '12', 'May', 'Moday', '', 'Story Writing Malayalam', '3:00 - 4:00 PM', '', ''),
(8, '12', 'May', 'Moday', '', 'Essay Writing - Hindi', '3:00 - 4:00 PM', '', ''),
(9, '12', 'May', 'Moday', '', 'Poetry Writing English', '4:00 - 5:00 PM', '', ''),
(10, '12', 'May', 'Moday', '', 'Tharjima', '4:00 - 5:00 PM', '', ''),
(11, '13', 'May', 'Tuesday', '', 'Mandala Art', '3:00 - 4:00 PM', '', ''),
(12, '13', 'May', '', '', 'Cartoon Drawing', '3:00 - 4:00 PM', '', ''),
(13, '13', 'May', '', '', 'Essay Writing English', '3:00 - 4:00 PM', '', ''),
(14, '13', 'May', '', '', 'Doodling', '3:00 - 4:00 PM', '', ''),
(15, '14', 'May', 'Wednesday', '', 'Carnatic Solo', '3:00 - 4:00 PM', '', ''),
(16, '14', 'May', 'Wednesday', '', 'Poem Recitation English', '3:00 - 4:00 PM', '', ''),
(17, '14', 'May', 'Wednesday', '', 'Anchoring', '4:00 - 5:00 PM', '', ''),
(18, '14', 'May', 'Wednesday', '', 'Clay Modeling', '3:00 - 4:00 PM', '', ''),
(19, '14', 'May', 'Wednesday', '', 'Collage', '3:00 - 4:00 PM', '', ''),
(20, '14', 'May', 'Wednesday', '', 'Pencil Drawing', '3:00 - 4:00 PM', '', ''),
(21, '14', 'May', 'Wednesday', '', 'Soap Carving', '4:00 - 5:00 PM', '', ''),
(22, '14', 'May', 'Wednesday', '', 'Water Coloring', '4:00 - 5:00 PM', '', ''),
(23, '14', 'May', 'Wednesday', '', 'Poetry Writing Malayalam', '4:00 - 5:00 PM', '', ''),
(24, '15', 'May', 'Thursday', '', 'Elocution English', '3:00 - 4:00 PM', '', ''),
(25, '15', 'May', 'Thursday', '', 'Light Music', '3:00 - 4:00 PM', '', ''),
(26, '15', 'May', 'Thursday', '', 'Mono Act ', '3:00 - 4:00 PM', '', ''),
(27, '15', 'May', 'Thursday', '', 'Essay Writting Malayalam', '3:00 - 4:00 PM', '', ''),
(28, '15', 'May', 'Thursday', '', 'Face to Face', '3:00 - 4:00 PM', '', ''),
(29, '15', 'May', 'Thursday', '', 'Story Writing English', '4:00 - 5:00 PM', '', ''),
(30, '15', 'May', 'Thursday', '', 'Mehandi Designing', '4:00 - 5:00 PM', '', ''),
(31, '15', 'May', 'Thursday', '', 'Extempore', '4:00 - 5:00 PM', '', ''),
(32, '15', 'May', 'Thursday', '', 'Poem Recitation Malayalam', '4:00 - 5:00 PM', '', ''),
(33, '15', 'May', 'Thursday', '', 'Poem Writing Malayalam', '4:00 - 5:00 PM', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Disabled_events`
--
ALTER TABLE `Disabled_events`
  ADD PRIMARY KEY (`Events`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Event_Registration`
--
ALTER TABLE `Event_Registration`
  ADD PRIMARY KEY (`Roll_Number`,`Chest_Number`);

--
-- Indexes for table `Event_Results`
--
ALTER TABLE `Event_Results`
  ADD PRIMARY KEY (`Roll_Number`,`Event`),
  ADD UNIQUE KEY `unique_event` (`Roll_Number`,`Event`),
  ADD UNIQUE KEY `Roll_Number` (`Roll_Number`,`Event`);

--
-- Indexes for table `leaderboard_status`
--
ALTER TABLE `leaderboard_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rank_scores`
--
ALTER TABLE `rank_scores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `registration_status`
--
ALTER TABLE `registration_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `rank_scores`
--
ALTER TABLE `rank_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
