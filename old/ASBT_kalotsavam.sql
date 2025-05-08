-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 08, 2025 at 08:15 AM
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
(4, 'admin', '$2y$10$0AL3GQ3AP90/s2229oRp7.5/TtIsXMpyD4baG6aNrca03vDB7Z3KW');

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
(70, 'Poem Recitation', 'individual', 'on'),
(71, 'Elocution', 'individual', 'on'),
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
(90, 'Solo Dance- Semi-Classical', 'individual', 'on');

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
-- Table structure for table `rank_scores`
--

CREATE TABLE `rank_scores` (
  `id` int(11) NOT NULL,
  `event_type` enum('individual','group') NOT NULL,
  `rank` varchar(10) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indexes for table `rank_scores`
--
ALTER TABLE `rank_scores`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `rank_scores`
--
ALTER TABLE `rank_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
