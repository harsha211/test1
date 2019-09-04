-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2017 at 11:41 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ticket_booking`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `dispt` ()  BEGIN
SELECT * FROM theatre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dispu` ()  BEGIN
SELECT * from register;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminid` varchar(20) NOT NULL,
  `apassword` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminid`, `apassword`) VALUES
('harshith', 'harshith');

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `moviename` varchar(30) NOT NULL,
  `movieid` varchar(300) NOT NULL,
  `movielang` varchar(20) DEFAULT NULL,
  `moviecast` varchar(20) DEFAULT NULL,
  `moviedirector` varchar(20) DEFAULT NULL,
  `movierating` int(11) DEFAULT NULL,
  `movieimage` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `movie`
--


-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `fname` varchar(20) NOT NULL,
  `lname` varchar(20) NOT NULL,
  `uid` varchar(30) NOT NULL,
  `passwd` varchar(20) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`fname`, `lname`, `uid`, `passwd`, `age`) VALUES
('harshith', 'kumar', 'harshith kumar', '12345', 19),
('harshith', 'm', 'harshithm7', '12345', 17);

-- --------------------------------------------------------

--
-- Table structure for table `theatre`
--

CREATE TABLE `theatre` (
  `theatreid` varchar(10) NOT NULL,
  `theatrename` varchar(30) DEFAULT NULL,
  `location` varchar(15) DEFAULT NULL,
  `movie_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `theatre`
--


-- --------------------------------------------------------

--
-- Table structure for table `ticketprice`
--

CREATE TABLE `ticketprice` (
  `ticketno` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `seats` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ticketprice`
--

INSERT INTO `ticketprice` (`ticketno`, `price`, `seats`) VALUES
(146, 450, '1a 1b 1c'),
(147, 600, '1a 1b 1c 1d'),
(148, 450, '1e 1f 1g');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticketno` int(11) NOT NULL,
  `seats` varchar(50) NOT NULL,
  `date1` varchar(10) NOT NULL,
  `time1` varchar(10) NOT NULL,
  `tid` varchar(10) NOT NULL,
  `mid` varchar(10) NOT NULL,
  `uid` varchar(30) NOT NULL,
  `noticket` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tickets`
--


--
-- Triggers `tickets`
--
DELIMITER $$
CREATE TRIGGER `t1` AFTER INSERT ON `tickets` FOR EACH ROW insert into ticketprice values (new.ticketno,new.noticket*150,new.seats)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminid`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movieid`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `theatre`
--
ALTER TABLE `theatre`
  ADD PRIMARY KEY (`theatreid`),
  ADD KEY `mvid` (`movie_id`);

--
-- Indexes for table `ticketprice`
--
ALTER TABLE `ticketprice`
  ADD KEY `ticketno` (`ticketno`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticketno`),
  ADD UNIQUE KEY `seats` (`seats`),
  ADD KEY `thid` (`tid`),
  ADD KEY `mmid` (`mid`),
  ADD KEY `uuid` (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticketno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `theatre`
--
ALTER TABLE `theatre`
  ADD CONSTRAINT `mvid` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movieid`) ON DELETE CASCADE;

--
-- Constraints for table `ticketprice`
--
ALTER TABLE `ticketprice`
  ADD CONSTRAINT `ticketno` FOREIGN KEY (`ticketno`) REFERENCES `tickets` (`ticketno`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `mmid` FOREIGN KEY (`mid`) REFERENCES `movie` (`movieid`) ON DELETE CASCADE,
  ADD CONSTRAINT `thid` FOREIGN KEY (`tid`) REFERENCES `theatre` (`theatreid`) ON DELETE CASCADE,
  ADD CONSTRAINT `uuid` FOREIGN KEY (`uid`) REFERENCES `register` (`uid`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
