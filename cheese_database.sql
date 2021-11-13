-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2021 at 11:27 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cheese database`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `brand_ID` int(11) NOT NULL,
  `brand_name` varchar(30) NOT NULL,
  `country_of_origin` char(2) NOT NULL,
  `website` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`brand_ID`, `brand_name`, `country_of_origin`, `website`) VALUES
(1, 'Stinky\'s Cheeses', 'US', NULL),
(2, 'Grapes of Wrath', 'FR', 'www.grapesofwrathwine.com'),
(3, 'Cheese Kings', 'CA', 'www.cheesekings.com');

-- --------------------------------------------------------

--
-- Table structure for table `pairings`
--

CREATE TABLE `pairings` (
  `pairing_ID` int(11) NOT NULL,
  `pairing_name` varchar(30) NOT NULL,
  `brand_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pairings`
--

INSERT INTO `pairings` (`pairing_ID`, `pairing_name`, `brand_ID`) VALUES
(1, 'Red Wine', 2),
(2, 'Crackers', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_ID` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `brand_ID` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_ID`, `product_name`, `brand_ID`, `type`, `description`) VALUES
(1, 'Smelly Muenster', 1, 'Muenster', 'very stinky muenster!'),
(2, 'Mild Havarti', 3, 'Havarti', 'a sliced mild havarti cheese');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_ID` int(11) NOT NULL,
  `user_ID` int(11) NOT NULL,
  `product_ID` int(11) NOT NULL,
  `rating` int(2) NOT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_ID`, `user_ID`, `product_ID`, `rating`, `comment`) VALUES
(1, 2, 1, 9, 'I love this stinky Muenster from Stinky\'s Cheeses!'),
(2, 1, 2, 2, 'This mild havarti from cheese kings STINK! And I mean that in a BAD way!');

-- --------------------------------------------------------

--
-- Table structure for table `suggestions`
--

CREATE TABLE `suggestions` (
  `product_ID` int(11) NOT NULL,
  `pairing_ID` int(11) NOT NULL,
  `user_ID` int(11) NOT NULL,
  `suggestion_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `suggestions`
--

INSERT INTO `suggestions` (`product_ID`, `pairing_ID`, `user_ID`, `suggestion_date`, `comment`) VALUES
(1, 2, 1, '2021-11-10 22:41:24', 'Crackers mix well with this cheese!'),
(2, 1, 2, '2021-11-10 22:41:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_ID` int(11) NOT NULL,
  `fname` varchar(30) NOT NULL,
  `lname` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_ID`, `fname`, `lname`, `email`, `password`) VALUES
(1, 'Jacob', 'Russell', 'russelj2@oregonstate.edu', 'oregon123'),
(2, 'Matt', 'Scardino', 'scardinm@oregonstate.edu', 'OSU0000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_ID`),
  ADD UNIQUE KEY `brand_name_unique` (`brand_name`);

--
-- Indexes for table `pairings`
--
ALTER TABLE `pairings`
  ADD PRIMARY KEY (`pairing_ID`),
  ADD UNIQUE KEY `pairing_name` (`pairing_name`),
  ADD UNIQUE KEY `pairing_name_unique` (`pairing_name`),
  ADD KEY `fk_pairing_brand` (`brand_ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_ID`),
  ADD KEY `product_brand` (`brand_ID`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_ID`),
  ADD KEY `review_user` (`user_ID`),
  ADD KEY `review_product` (`product_ID`);

--
-- Indexes for table `suggestions`
--
ALTER TABLE `suggestions`
  ADD PRIMARY KEY (`product_ID`,`pairing_ID`,`user_ID`),
  ADD KEY `suggestion_pairing` (`pairing_ID`),
  ADD KEY `suggestion_user` (`user_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_ID`),
  ADD UNIQUE KEY `email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pairings`
--
ALTER TABLE `pairings`
  MODIFY `pairing_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pairings`
--
ALTER TABLE `pairings`
  ADD CONSTRAINT `fk_pairing_brand` FOREIGN KEY (`brand_ID`) REFERENCES `brands` (`brand_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `product_brand` FOREIGN KEY (`brand_ID`) REFERENCES `brands` (`brand_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `review_product` FOREIGN KEY (`product_ID`) REFERENCES `products` (`product_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `review_user` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `suggestions`
--
ALTER TABLE `suggestions`
  ADD CONSTRAINT `suggestion_pairing` FOREIGN KEY (`pairing_ID`) REFERENCES `pairings` (`pairing_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `suggestion_product` FOREIGN KEY (`product_ID`) REFERENCES `products` (`product_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `suggestion_user` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
