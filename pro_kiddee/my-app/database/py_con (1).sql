-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2019 at 01:25 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `py_con`
--

-- --------------------------------------------------------

--
-- Table structure for table `buys`
--

CREATE TABLE `buys` (
  `buys_id` int(11) NOT NULL,
  `bill_id` int(11) NOT NULL,
  `sell_id` int(11) NOT NULL,
  `date_buy` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'ผู้ซื้อ',
  `number_buy` int(11) NOT NULL,
  `buys_status` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'R' COMMENT 'R=จอง B=ซื้อ',
  `buys_address` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `buys`
--

INSERT INTO `buys` (`buys_id`, `bill_id`, `sell_id`, `date_buy`, `username`, `number_buy`, `buys_status`, `buys_address`) VALUES
(2, 1, 15, '2019-05-24 17:07:49', 'rain', 1, 'B', '36 ซอย แสนสบาย6 ถ.บ้านบึงแกลง\nตำบล บ้านบึง อำเภอ บ้านบึง จ.ชลบุรี'),
(3, 1, 15, '2019-05-24 17:07:49', 'rain', 1, 'B', '36 ซอย แสนสบาย6 ถ.บ้านบึงแกลง\nตำบล บ้านบึง อำเภอ บ้านบึง จ.ชลบุรี'),
(4, 5, 13, '2019-05-27 13:57:25', 'admin', 1, 'B', 'บ้านบึง'),
(5, 2, 14, '2019-05-27 03:05:52', 'test', 4, 'B', 'หาดตะปุ่น'),
(6, 2, 15, '2019-05-27 03:05:52', 'test', 4, 'B', 'หาดตะปุ่น'),
(7, 3, 15, '2019-05-27 08:32:36', 'rain', 3, 'B', '36 ซอย แสนสบาย6 ถ.บ้านบึงแกลง\nตำบล บ้านบึง อำเภอ บ้านบึง จ.ชลบุรี'),
(8, 3, 15, '2019-05-27 08:32:36', 'rain', 4, 'B', '36 ซอย แสนสบาย6 ถ.บ้านบึงแกลง\nตำบล บ้านบึง อำเภอ บ้านบึง จ.ชลบุรี'),
(9, 3, 21, '2019-05-27 08:32:36', 'rain', 2, 'B', '36 ซอย แสนสบาย6 ถ.บ้านบึงแกลง\nตำบล บ้านบึง อำเภอ บ้านบึง จ.ชลบุรี'),
(10, 4, 16, '2019-05-27 10:13:35', 'rain', 5, 'B', 'บ้านป้าสากร'),
(11, 5, 16, '2019-05-27 13:57:25', 'admin', 3, 'B', 'บ้านบึง'),
(12, 6, 20, '2019-05-27 13:58:30', 'admin', 4, 'B', 'บ้านบึง'),
(13, 7, 14, '2019-05-28 02:31:56', 'admin', 1, 'B', 'บ้านบึง'),
(15, 8, 13, '2019-05-28 07:47:34', 'admin', 1, 'B', 'บ้านบึง'),
(19, 8, 13, '2019-05-28 07:47:34', 'admin', 1, 'B', 'บ้านบึง'),
(20, 9, 14, '2019-05-28 09:42:41', 'admin', 1, 'B', 'บ้านบึง'),
(36, 10, 15, '2019-05-28 11:14:29', 'admin', 2, 'B', 'บ้านบึง'),
(37, 10, 16, '2019-05-28 11:14:29', 'admin', 1, 'B', 'บ้านบึง'),
(38, 11, 16, '2019-05-28 11:15:13', 'admin', 2, 'B', 'บ้านบึง'),
(39, 11, 13, '2019-05-28 11:15:13', 'admin', 2, 'B', 'บ้านบึง'),
(40, 12, 15, '2019-05-28 11:15:33', 'admin', 1, 'B', 'บ้านบึง');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `cat_id` int(11) NOT NULL,
  `cat_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cat_icon` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`cat_id`, `cat_name`, `cat_icon`) VALUES
(1, 'มือถือ แท็บแล็ต', 'ec204cf5-8110-4dcb-9d5d-a4ccd9d7cd74.jpg'),
(2, 'คอมพิวเตอร์', '2.png'),
(3, 'เครื่องดนตรี', '3.png'),
(4, 'กีฬา', '4.png'),
(5, 'จักรยาน', '5.png'),
(6, 'แม่และเด็ก', '6.png'),
(7, 'กระเป๋า', '7.png'),
(8, 'นาฬิกา', '8.jpg'),
(9, 'รองเท้า', '9.png'),
(10, 'เสื้อผ้า เครื่องแต่งกาย', '10.png'),
(11, 'สุขภาพและความงาม', '11.png'),
(12, 'บ้านและสวน', '12.png'),
(13, 'พระเครื่อง', '13.jpg'),
(14, 'ของสะสม', '14.gif'),
(15, 'อสังหาิมทรัพย์', '15.png'),
(16, 'รถมือสอง', '16.png'),
(17, 'รถบรรทุก และเครื่องจักรกล', '17.png'),
(18, 'ยานพาหนะอื่นๆ', '18.png'),
(19, 'อะไหล่รถ ประดับยนต์', '19.png'),
(20, 'มอเตอร์ไซค์', '20.png'),
(21, 'กล้อง', '21.png'),
(22, 'เครื่องใช้ไฟฟ้า', '22.png'),
(23, 'เกม', '23.png'),
(24, 'สัตว์เลี้ยง', '24.png'),
(25, 'งานอดิเรก', '25_5.gif'),
(26, 'ธุรกิจ', '26.jpg'),
(27, 'บริการ', '27.png'),
(28, 'ฟาร์ม', '28.png'),
(29, 'ท่องเที่ยว', '29.jpg'),
(30, 'การศึกษา', '30.png'),
(31, 'บริจาค', '31.png');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `groups_id` int(11) NOT NULL,
  `groups_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`groups_id`, `groups_name`, `cat_id`) VALUES
(1, 'แท็บแล็ต', 1),
(2, 'โทรศัพท์', 1),
(3, 'อุปกรณ์สื่อสาร', 1),
(4, 'กีต้าร์', 3),
(5, 'อคูลเลเล่', 3),
(6, 'คอมพิวเตอร์ตั้งโต๊ะ', 2),
(7, 'โน๊ตบุ๊ค', 2),
(8, 'Printer Scanner', 2),
(9, 'อุปกรณ์คอมพิวเตอร์อื่นๆ', 2),
(10, 'กีต้าร์ไฟฟ้า', 3),
(11, 'อุตสาหกรรม', 26),
(12, 'แฟรนไชส์', 26),
(13, 'อุปกรณ์ร้านอาหาร', 26),
(14, 'ขายเซ้งกิจการ', 26),
(15, 'ธุรกิจอื่นๆ', 27),
(16, 'อุปกรณ์สำนักงาน', 27),
(17, 'งาน', 27),
(18, 'จักรยานเสือหมอบ', 5),
(19, 'จักรยานเสือภูเขา', 5),
(20, 'เปียโน', 3),
(21, 'คีย์บอร์ด', 3),
(22, 'กลอง', 3),
(23, 'เครื่องดนตรีไทย', 3),
(24, 'เครื่องดนตรีอื่นๆ', 3),
(25, 'อุปกรณ์เครื่องดนตรี', 3),
(26, 'เครื่องออกกำลังกาย', 4),
(27, 'อุปกรณ์กีฬา', 4),
(28, 'ชุดกีฬา', 4),
(29, 'รองเท้ากีฬา', 4),
(30, 'จักรยานไฮบริด', 5),
(31, 'จักรยานฟิกเกียร์', 5),
(32, 'จักรยานฺBMX', 5),
(33, 'จักรยานทัวร์ริ่ง', 5),
(34, 'จักรยานพับ', 5),
(35, 'จักรยานแม่บ้าน', 5),
(36, 'จักรยานโบราณ', 5),
(37, 'จักรยานไฟฟ้า', 5),
(38, 'จักรยานอื่นๆ', 5),
(39, 'อุปกรณ์นักปั่น', 5),
(40, 'อะไหล่ และอุปกรณ์ตกแต่ง', 5),
(41, 'เสื้อผ้าเด็ก', 6),
(42, 'รองเท้าเด็ก', 6),
(43, 'เสื้อผ้าคนท้อง', 6),
(44, 'ของใช้แม่และเด็ก', 6),
(45, 'ของเล่นเด็ก', 6),
(46, 'กระเป๋าสะพาย', 7),
(47, 'กระเป๋าถือ', 7),
(48, 'กระเป๋าสตางค์', 7),
(49, 'กระเป๋าเป้ เดินทาง', 7),
(50, 'กระเป๋าอื่นๆ', 7),
(51, 'อุปกรณ์และอะไหล่กระเป๋า', 7),
(52, 'นาฬิกาผู้หญิง', 8),
(53, 'นาฬิกาผู้ชาย', 8),
(54, 'นาฬิกาอื่นๆ', 8),
(55, 'อุปกรณ์และอะไหล่นาฬิกา', 8),
(56, 'รองเท้าผู้ชาย', 9),
(57, 'รองเท้าผู้หญิง', 9),
(58, 'อุปกรณ์และอะไหล่รองเท้า', 9),
(59, 'เสื้อผ้า', 10),
(60, 'เครื่องแต่งกาย', 10),
(61, 'แว่นตา', 10),
(62, 'เครื่องประดับ', 10),
(63, 'อุปกรณ์เกี่ยวกับสุขภาพ', 10),
(64, 'น้ำหอม', 10),
(65, 'อุปกรณ์เสริมสวย', 10),
(66, 'เฟอร์นิเจอร์', 12),
(67, 'ของใช้ในบ้าน', 12),
(68, 'ของแต่งบ้าน', 12),
(69, 'วัสดุก่อสร้าง', 12),
(70, 'ตกแต่งสวน', 12),
(71, 'อุปกรณ์และเครื่องมือช่าง', 12),
(72, 'พระเหรียญ', 13),
(73, 'พระเบญจภาคี', 13),
(74, 'พระกริ่ง', 13),
(75, 'พระกรุ', 13),
(76, 'พระบูชา', 13),
(77, 'พระเกจิ', 13),
(78, 'พระปิตตา', 13),
(79, 'จคุคามรามเทพ', 13),
(80, 'พระปิดตา', 13),
(81, 'พระเครื่องอื่น', 13),
(82, 'เครื่องราง ของมงคล', 13),
(83, 'สังฆภัณฑ์ งานพิธี', 13),
(84, 'สแตมป์', 14),
(85, 'เหรียญ ธนบัตร', 14),
(86, 'ของเก่า ของโบราณ', 14),
(87, 'งานศิลปะ โมเดล', 14),
(88, 'ของสะสมอื่นๆ', 14),
(89, 'บ้าน', 15),
(90, 'ทาวเฮ้าส์', 15),
(91, 'คอนโดมิเนียม', 15),
(92, 'หอพัก อพาร์ทเม้นต์', 15),
(93, 'ตึกแถว', 15),
(94, 'ที่ดิน', 15),
(95, 'อสังหา อื่นๆ', 15),
(96, 'บริจาคเสื้อผ้า', 31),
(97, 'บริจาคเครื่องใช้ไฟฟ้า', 31),
(98, 'บริจาคเฟอร์นิเจอร์', 31),
(99, 'บริจาคอื่นๆ', 31),
(100, 'กวดวิชา', 30),
(101, 'สอนภาษา', 30),
(102, 'อบรม', 30),
(103, 'เรียนต่อต่างประเทศ', 30),
(104, 'อุปกรณืการเรียนการสอน', 30),
(105, 'หนังสือ', 30),
(106, 'ทัวร์ในประเทศ', 29),
(107, 'ทัวร์ต่างประเทศ', 29),
(108, 'ที่พัก', 29),
(109, 'ตั๋วเดินทาง', 29),
(110, 'อุปกรณ์การท่องเที่ยว', 29),
(111, 'บริการ เดินทาง', 29),
(112, 'ร้านอาหาร', 29),
(113, 'ตลาดสด', 28),
(114, 'ตลาดเกษตร', 28),
(115, 'บริการด้านเกษตร', 28);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `img_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sell`
--

CREATE TABLE `sell` (
  `sell_id` int(11) NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'ผู้ขาย',
  `groups_id` int(11) NOT NULL,
  `sell_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `sell_image` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `sell_address` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `sell_price` int(11) NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `date_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sell_number` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sell`
--

INSERT INTO `sell` (`sell_id`, `username`, `groups_id`, `sell_name`, `sell_image`, `sell_address`, `sell_price`, `description`, `date_start`, `sell_number`) VALUES
(13, 'admin', 2, 'iphone6s', '0341e9eb-c133-4c80-9e75-f242ce83da5b.jpg', 'สุพรรบุรี', 6500, 'ไม่ค่อยได่เล่นเลยอยากขาย', '2019-05-28 11:15:03', 97),
(14, 'admin', 1, 'Ipad', '4b6edcd4-6f87-4d1d-8950-70298f56db62.jpg', 'ปราจีนบุรี', 14500, 'ไม่ค่อยได้เล่นอยากให้คนอื่นที่จำเป็นได้ใช้', '2019-05-28 11:13:42', 95),
(15, 'admin', 3, 'หูฟัง Bluetooth', 'e9f4a675-d919-42d4-a5b8-f9f7a2b2a252.jpg', 'กรุงเทพมหานคร', 3500, 'เป็นตัวแทนจำหน่ายจากต่างประเทศ สินค้ามีจำกัด', '2019-05-28 11:15:22', 12),
(16, 'admin', 3, 'วอสื่อสาร', 'f616161c-b179-4ad3-892a-d2dd634d6ab0.jpg', 'สุโททัย', 500, 'ขายเพราะ ปิดงานเลี้ยงแล้วไม่ได้ใช้', '2019-05-28 11:15:07', 13),
(17, 'admin', 4, 'กีต้าร์ YAMAHA', '5ff0f2fd-2559-4bb4-9316-ddbada3716e3.jpg', 'ชลบุรี', 2500, 'ขายเพราะไม่มีเวลาเล่น ', '2019-05-24 16:34:23', 10),
(18, 'admin', 5, 'อคูลเลเล่ สภาพนางฟ้า', 'bdbe7adc-7ce4-49ca-abb8-809dad8e5c16.jpg', 'นครราชสีมา', 15, 'สภาพนางฟ้า ไม่ค่อยได้เล่น', '2019-05-24 16:36:14', 10),
(19, 'admin', 10, 'กีต้าร์ไฟฟ้า เล่นโครตมัน', 'bec40e65-039c-4dc6-a963-1ceac03b79ee.jpg', 'ระยอง', 18000, 'ขายเพราะ จำเป็นต้องใช้เงิน ด่วน !!!!', '2019-05-24 16:38:07', 5),
(20, 'rain', 13, 'น้ำดื่มคริสตัล', 'ae62c5b2-9a7c-4955-8ecd-11f9745d3025.jpg', 'ร้านอาหาร กลางแม่น้ำ เจ้าพระยา', 65, 'ขายเป็นแพค แพคใหญ่', '2019-05-27 13:58:18', 96),
(21, 'admin', 18, 'จักรยานเสือหมอบโครตแรง', '4a45be17-4461-4d82-aa44-d1c69d4563cd.jpg', 'กรุงเทพมหานคร แถว ลาดพร้าว', 15000, 'เนื่องจากไม่ได้ขี่แล้ว', '2019-05-27 08:32:24', 10),
(22, 'admin', 19, 'จักรยานเสือภูเขาเร็วแรง', '32d38e1a-95c1-40b9-8762-3bb302808c0b.jpg', 'กรุงเทพมหานคร แถวอโศก', 7500, 'อยากได้เสือหมอบ', '2019-05-27 02:34:27', 5),
(23, 'admin', 6, 'คอมตั้งโต๊ะ', '8d391035-e492-4da1-a4be-ee9c9a3167f3.jpg', 'ปราจีนบุรี', 16000, 'ขาย เพราะ อยากได้ max book', '2019-05-28 10:35:34', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `lname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `user_image` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `user_address` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `fname`, `lname`, `status`, `phone`, `user_image`, `user_address`) VALUES
(8650, 'admin', 'admin', 'admin', 'admin', 'A', '0831101923', 'd772fc44-864c-432e-a601-43ae81df9980.jpg', 'บ้านบึง'),
(8651, '5555', '123456', 'K', 'K', 'U', '123456789', '12.jpg', '11'),
(8666, '23q1', '23', '23', '23', 'U', '123456786', '12.jpg', 'asd'),
(8667, 'rain', 'rain', 'Patomporn', 'Rungruangrutai', 'U', '0927486210', 'cae7247f-5e04-4cbf-a865-8b38fcbce428.jpg', '36 ซอย แสนสบาย6 ถ.บ้านบึงแกลง\nตำบล บ้านบึง อำเภอ บ้านบึง จ.ชลบุรี'),
(8668, 'test', 'test', 'test', 'test', 'U', '123456789', 'default.png', 'test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buys`
--
ALTER TABLE `buys`
  ADD PRIMARY KEY (`buys_id`),
  ADD KEY `sell_id` (`sell_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`groups_id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`img_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sell`
--
ALTER TABLE `sell`
  ADD PRIMARY KEY (`sell_id`),
  ADD KEY `username` (`username`),
  ADD KEY `groups_id` (`groups_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buys`
--
ALTER TABLE `buys`
  MODIFY `buys_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `groups_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sell`
--
ALTER TABLE `sell`
  MODIFY `sell_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8669;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buys`
--
ALTER TABLE `buys`
  ADD CONSTRAINT `buys_ibfk_1` FOREIGN KEY (`sell_id`) REFERENCES `sell` (`sell_id`),
  ADD CONSTRAINT `buys_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`);

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `category` (`cat_id`);

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `sell`
--
ALTER TABLE `sell`
  ADD CONSTRAINT `sell_ibfk_1` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`groups_id`),
  ADD CONSTRAINT `sell_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
