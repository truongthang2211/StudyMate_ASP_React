-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2022 at 08:41 AM
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
-- Database: `studymate`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `ACCOUNT_ID` smallint(6) NOT NULL,
  `USER_ID` smallint(6) DEFAULT NULL,
  `USERNAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PWD` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ACCOUNT_ROLE` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`ACCOUNT_ID`, `USER_ID`, `USERNAME`, `PWD`, `ACCOUNT_ROLE`, `CREATED_AT`) VALUES
(1111, 1111, 'admin', '$2y$10$inZ1RSlq91xw.6MpxZhiE.SHHYJSChQPrmQ93ilrPSazIYz2rHYoO', 'Admin', '2021-12-19 08:04:59'),
(1112, 1112, 'sanke2211', '$2a$11$u00EpeIiiqJmQazFa7S49uSanb/GKvqiXtGK1JdDoj5gAvyggmPAK', 'User', '2021-12-19 08:07:55'),
(1113, 1113, 'xuanthulab', '$2y$10$TpSLwncEhKWmjg9ZBeBRCuccALkAawokgOQadsrs0KkcjianAKARS', 'User', '2021-12-19 08:39:18'),
(1114, 1114, 'Thuw Huynh', '$2y$10$7HICcDKwCJrkjzy46tfeke.20v9CIutpJgLNia7.bbiiBi1GBAj.i', 'User', '2021-12-20 03:02:52'),
(1115, 1115, 'Thư', '$2y$10$MZ9z9r9VevuMfshkE0tAY.ttbK6KsZwG7SzWkudTtvXjHgoKfkOqC', 'User', '2021-12-20 04:43:37'),
(1116, 1116, 'xuanson', '$2y$10$AdrFOI4qeegzTppcfE/ZqOTSCsGb8Jk6KLleBer9PGUetLjwBd1EK', 'User', '2021-12-20 08:22:33'),
(1117, 1117, 'thangfanboy', '$2y$10$.AdpDN8GMDAFbCyJr3cAL.k5erLGrNKi2n6ZNnuN7gZz/StLfE85G', 'User', '2021-12-20 13:03:36'),
(1118, 1118, 'sondang', '$2y$10$fB0GZdGqcSaQpkM5tjV8u.JmdIVxIkoZVmMb1CoVksQdO9UC/XQ9y', 'User', '2021-12-21 00:59:26'),
(1119, 1119, 'nguyenvana', '$2y$10$N2KsCHLZkJ1zvm1hWgJdduJZPBoBzfuttIJRYC2Y20gdUUwPBeTBa', 'User', '2021-12-21 02:35:24'),
(1120, 1120, 'nguyencuong', '$2a$11$89DQcEvgSQPnw7r3U5A3bOgjMB1y7fCCT2LPIluXVBah.wObe5/vO', NULL, '2022-01-09 11:01:26'),
(1121, 1121, 'howkteam', '$2a$11$EQQdXbtDDU5Ays6ut4M.g.HwNxUfWQaCuaM7gQt7BrXSo1DwnDBVq', NULL, '2022-01-12 13:43:56'),
(1122, 1122, 'nguoitinhtrongmong', '$2a$11$XcEMtAs/OmxJjdOCC4u80.z4qlYAAHzXZ0fdYgD0wPhjdtNKpngke', NULL, '2022-01-13 10:40:16'),
(1123, 1123, 'nguyenthang2211', '$2a$11$WvsHZ.ozPXDY/j2zz71gweG6XAfvOyltRcHLLoTdpX22FSLm926wC', NULL, '2022-01-14 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `approvals`
--

CREATE TABLE `approvals` (
  `APPROVAL_ID` smallint(6) NOT NULL,
  `APPROVER_ID` smallint(6) DEFAULT NULL,
  `COURSE_ID` smallint(6) DEFAULT NULL,
  `APPROVE_TIME` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ACCEPT` tinyint(1) DEFAULT NULL,
  `REASON` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `approvals`
--

INSERT INTO `approvals` (`APPROVAL_ID`, `APPROVER_ID`, `COURSE_ID`, `APPROVE_TIME`, `ACCEPT`, `REASON`) VALUES
(1111, NULL, 1111, '2021-12-19 08:58:43', 1, NULL),
(1112, NULL, 1112, '2021-12-19 09:18:22', 1, NULL),
(1113, NULL, 1113, '2021-12-20 03:02:10', 1, NULL),
(1114, NULL, 1114, '2021-12-20 03:34:42', 1, NULL),
(1115, NULL, 1115, '2021-12-20 03:41:15', 1, NULL),
(1116, NULL, 1116, '2021-12-20 03:59:22', 1, NULL),
(1117, NULL, 1117, '2021-12-20 04:35:53', 1, NULL),
(1118, NULL, 1118, '2021-12-20 08:03:38', 1, NULL),
(1119, NULL, 1119, '2021-12-20 08:25:45', 1, NULL),
(1120, NULL, 1120, '2021-12-20 14:29:35', 0, 'Không hợp lệ'),
(1121, NULL, 1121, '2021-12-21 01:06:21', 1, NULL),
(1122, NULL, 1122, '2021-12-21 02:57:19', 1, NULL),
(1123, NULL, 1123, '2022-01-11 07:38:42', 0, 'không hợp lệ'),
(1124, NULL, 1124, '2022-01-11 07:50:05', 0, 'tiêu đề không hợp lệ'),
(1125, NULL, 1126, '2022-01-12 12:21:26', 1, NULL),
(1126, NULL, 1127, '2022-01-12 14:14:36', 1, NULL),
(1127, NULL, 1118, '2022-01-13 03:08:46', 1, NULL),
(1128, NULL, 1128, '2022-01-13 05:58:16', 0, 'không phù hợp'),
(1129, NULL, 1129, '2022-01-13 06:04:12', 1, NULL),
(1130, NULL, 1122, '2022-01-13 10:51:57', 1, NULL),
(1131, NULL, 1130, '2022-01-14 01:32:29', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `CITY_ID` smallint(6) NOT NULL,
  `CITY_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`CITY_ID`, `CITY_NAME`) VALUES
(1, 'Hồ Chí Minh'),
(2, 'Hà Nội'),
(3, 'Đà Nẵng'),
(4, 'Bình Dương'),
(5, 'Đồng Nai'),
(6, 'Khánh Hòa'),
(7, 'Hải Phòng'),
(8, 'Long An'),
(9, 'Quảng Nam'),
(10, 'Bà Rịa Vũng Tàu'),
(11, 'Đắk Lắk'),
(12, 'Cần Thơ'),
(13, 'Bình Thuận  '),
(14, 'Lâm Đồng'),
(15, 'Thừa Thiên Huế'),
(16, 'Kiên Giang'),
(17, 'Bắc Ninh'),
(18, 'Quảng Ninh'),
(19, 'Thanh Hóa'),
(20, 'Nghệ An'),
(21, 'Hải Dương'),
(22, 'Gia Lai'),
(23, 'Bình Phước'),
(24, 'Hưng Yên'),
(25, 'Bình Định'),
(26, 'Tiền Giang'),
(27, 'Thái Bình'),
(28, 'Bắc Giang'),
(29, 'Hòa Bình'),
(30, 'An Giang'),
(31, 'Vĩnh Phúc'),
(32, 'Tây Ninh'),
(33, 'Thái Nguyên'),
(34, 'Lào Cai'),
(35, 'Nam Định'),
(36, 'Quảng Ngãi'),
(37, 'Bến Tre'),
(38, 'Đắk Nông'),
(39, 'Cà Mau'),
(40, 'Vĩnh Long'),
(41, 'Ninh Bình'),
(42, 'Phú Thọ'),
(43, 'Ninh Thuận'),
(44, 'Phú Yên'),
(45, 'Hà Nam'),
(46, 'Hà Tĩnh'),
(47, 'Đồng Tháp'),
(48, 'Sóc Trăng'),
(49, 'Kon Tum'),
(50, 'Quảng Bình'),
(51, 'Quảng Trị'),
(52, 'Trà Vinh'),
(53, 'Hậu Giang'),
(54, 'Sơn La'),
(55, 'Bạc Liêu'),
(56, 'Yên Bái'),
(57, 'Tuyên Quang'),
(58, 'Điện Biên'),
(59, 'Lai Châu'),
(60, 'Lạng Sơn'),
(61, 'Hà Giang'),
(62, 'Bắc Kạn'),
(63, 'Cao Bằng');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `COMMENT_ID` smallint(6) NOT NULL,
  `USER_ID` smallint(6) DEFAULT NULL,
  `LESSON_ID` smallint(6) DEFAULT NULL,
  `CONTENT` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PARENT_COMMENT_ID` smallint(6) DEFAULT NULL,
  `COMMENT_TIME` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`COMMENT_ID`, `USER_ID`, `LESSON_ID`, `CONTENT`, `PARENT_COMMENT_ID`, `COMMENT_TIME`) VALUES
(1111, 1114, 1114, 'Rất dễ hiểu!', NULL, '2021-12-20 03:16:35'),
(1112, 1113, 1274, 'Rất hay', NULL, '2021-12-20 05:31:34'),
(1113, 1117, 1214, 'nhờ bài học này tôi đã biết công dụng của excel', NULL, '2021-12-20 13:12:40'),
(1114, 1113, 1274, 'tuyệt vời', 1112, '2021-12-20 14:53:19'),
(1115, 1113, 1349, 'Bài học rất chi tiết, cảm ơn', NULL, '2021-12-21 02:45:25'),
(1116, 1113, 1349, 'Đúng vậy', 1115, '2021-12-21 02:45:42'),
(1117, 1112, 1111, 'tét', NULL, '2022-01-12 03:42:47'),
(1118, 1113, 1353, 'Hơi khó hiểu @@\n', NULL, '2022-01-13 09:00:57'),
(1119, 1113, 1353, '@@', 1118, '2022-01-13 09:05:48'),
(1120, 1113, 1111, ':(', 1117, '2022-01-14 00:37:45'),
(1121, 1113, 1392, 'bài học rất chi tiết\n', NULL, '2022-01-14 01:23:39'),
(1122, 1113, 1392, 'đúng vậy', 1121, '2022-01-14 01:23:52');

-- --------------------------------------------------------

--
-- Table structure for table `comment_votes`
--

CREATE TABLE `comment_votes` (
  `USER_ID` smallint(6) NOT NULL,
  `COMMENT_ID` smallint(6) NOT NULL,
  `COMMENT_VOTE_STATE` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `comment_votes`
--

INSERT INTO `comment_votes` (`USER_ID`, `COMMENT_ID`, `COMMENT_VOTE_STATE`) VALUES
(1112, 1111, 1),
(1112, 1117, 0),
(1113, 1112, 1),
(1113, 1117, 0),
(1113, 1121, 1),
(1117, 1113, 1),
(1118, 1117, 0);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `COURSE_ID` smallint(6) NOT NULL,
  `COURSE_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FEE` bigint(20) DEFAULT NULL,
  `COURSE_DESC` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IMG` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COURSE_STATE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COMMISSION` double DEFAULT NULL,
  `COURSE_TYPE_ID` smallint(6) DEFAULT NULL,
  `AUTHOR_ID` smallint(6) DEFAULT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`COURSE_ID`, `COURSE_NAME`, `FEE`, `COURSE_DESC`, `IMG`, `COURSE_STATE`, `COMMISSION`, `COURSE_TYPE_ID`, `AUTHOR_ID`, `CREATED_AT`, `UPDATED_AT`) VALUES
(1111, 'Sử dụng Git, GitHub và GitLab', 20000, 'Khóa học sẽ giúp bạn biết cách sử dụng Git, GitHub và GitLab cũng như biết được các câu lệnh căn bản trong thực tế sử dụng', 'img/course/1639904111.png', 'Công khai', 20, 1162, 1113, '2021-12-19 08:58:43', '2021-12-21 03:00:01'),
(1112, 'C# Cơ bản', 50000, 'Lập trình ứng dụng đa nền tảng .NET CORE 3.0 với C#', 'img/course/1639905465.png', 'Công khai', 20, 1163, 1113, '2021-12-19 09:18:21', '2021-12-19 09:18:21'),
(1113, 'Lập trình Android - Java', 80000, 'Xây dựng ứng dụng Android với ngôn ngữ lập trình Java bằng Android Studio', 'img/course/1639969257.png', 'Công khai', 20, 1165, 1113, '2021-12-20 03:02:10', '2021-12-20 03:02:10'),
(1114, 'Excel', 0, 'Excel cơ bản đến nâng cao', 'img/course/1639971231.PNG', 'Công khai', 20, 1123, 1114, '2021-12-20 03:34:42', '2021-12-20 03:34:42'),
(1115, 'PowerPoint', 0, 'PowerPoint căn bản', 'img/course/1639971651.PNG', 'Công khai', 20, 1125, 1114, '2021-12-20 03:41:15', '2021-12-20 03:41:15'),
(1116, 'Word 2016', 0, 'Microsoft Word 2016 cho người mới bắt đầu', 'img/course/1639972731.PNG', 'Công khai', 20, 1124, 1114, '2021-12-20 03:59:22', '2021-12-20 06:29:30'),
(1117, 'Access 2016', 0, 'Access từ căn bản đến nâng cao', 'img/course/1639974942.PNG', 'Công khai', 20, 1126, 1114, '2021-12-20 04:35:53', '2021-12-20 04:35:53'),
(1118, 'Học tiếng Anh qua game', 50000, 'Khóa học sẽ giúp cải thiện kỹ năng nghe và trao dồi từ vựng tiếng Anh thông qua các trò chơi điện tử', 'img/course/1639987106.jpg', 'Công khai', 20, 1111, 1112, '2021-12-20 08:03:37', '2021-12-20 14:39:13'),
(1119, 'Docker', 50000, 'Quản lý các ứng dụng chạy trong Container', 'img/course/1639988682.png', 'Công khai', 20, 1162, 1113, '2021-12-20 08:25:45', '2021-12-20 08:29:40'),
(1120, 'Học tiếng Anh qua game', 50000, 'Khóa học sẽ giúp cải thiện kỹ năng nghe và trao dồi từ vựng tiếng Anh thông qua các trò chơi điện tử', 'img/course/1639987106.jpg', 'Từ chối', 20, 1111, 1112, '2021-12-20 14:29:35', '2021-12-20 14:29:35'),
(1121, 'Cắt HTML, CSS Web The Band', 50000, 'Khóa học sẽ giúp bạn thành thạo hơn về HTML vs CSS', 'img/course/1640048711.jpg', 'Công khai', 20, 1164, 1118, '2021-12-21 01:06:21', '2021-12-21 01:06:21'),
(1122, 'Quản trị Windows', 50000, 'Quản trị Windows', 'img/course/1640055282.jpg', 'Công khai', 20, 1162, 1113, '2021-12-21 02:57:19', '2021-12-21 02:57:19'),
(1123, 'aaa', 0, 'aaa', 'img/course/1641818094.jpg', 'Từ chối', 20, 1125, 1112, '2022-01-11 07:38:41', '2022-01-11 07:38:41'),
(1124, 'aaa', 0, 'aaa', 'img/course/1641818094.jpg', 'Từ chối', 20, 1125, 1112, '2022-01-11 07:50:05', '2022-01-11 07:50:05'),
(1126, 'aaababa', 0, 'asdasdasd', 'img/course/1641978070.png', 'Bị khóa', 20, 1137, 1112, '2022-01-12 12:21:26', '2022-01-12 12:21:26'),
(1127, 'Lập trình Selenium với C# - WPF ', 50000, '[CSharp] Lập trình Selenium với C# - WPF ', 'img/course/1641996732.jpg', 'Công khai', 20, 1162, 1121, '2022-01-12 14:14:35', '2022-01-12 14:14:35'),
(1128, 'Docker', 50000, 'Quản lý các ứng dụng chạy trong Container', 'img/course/1639988682.png', 'Từ chối', 20, 1162, 1113, '2022-01-13 05:58:16', '2022-01-13 05:58:16'),
(1129, 'Javascript nâng cao', 30000, 'Javascript nhưng nâng cao hơn', 'img/course/1642053751.jpg', 'Công khai', 20, 1163, 1118, '2022-01-13 06:04:12', '2022-01-13 06:04:12'),
(1130, 'Sử dụng SSH', 30000, 'Sử dụng SSH', 'img/course/1642123845.png', 'Công khai', 20, 1162, 1113, '2022-01-14 01:32:29', '2022-01-14 01:32:29');

-- --------------------------------------------------------

--
-- Table structure for table `course_chapters`
--

CREATE TABLE `course_chapters` (
  `COURSE_CHAPTER_ID` smallint(6) NOT NULL,
  `CHAPTER_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COURSE_ID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `course_chapters`
--

INSERT INTO `course_chapters` (`COURSE_CHAPTER_ID`, `CHAPTER_NAME`, `COURSE_ID`) VALUES
(1111, 'Chương 1: Kiến thức cơ bản', 1111),
(1112, 'Chương 2: Kiến thức thêm', 1111),
(1113, 'C# Cơ bản', 1112),
(1114, 'Networking', 1112),
(1115, 'ADO.NET', 1112),
(1116, 'EF Core', 1112),
(1117, 'ASP.NET Core', 1112),
(1118, 'ASP.NET Razor', 1112),
(1119, 'ASP.NET MVC', 1112),
(1120, 'Chương 1', 1113),
(1121, 'Excel căn bản', 1114),
(1122, 'Các kỹ năng khác', 1114),
(1123, 'Học PowerPoint cơ bản', 1115),
(1124, 'Microsoft Word 2016', 1116),
(1125, 'Microsoft Access 2016', 1117),
(1126, 'Học tiếng Anh qua gaming', 1118),
(1127, 'Docker', 1119),
(1128, 'Học tiếng Anh qua gaming', 1120),
(1129, 'Cắt HTML, CSS Web the Band', 1121),
(1130, 'Chương 1', 1122),
(1131, 'Chương 2', 1122),
(1132, 'C1', 1123),
(1133, 'C1', 1124),
(1135, 'C1', 1126),
(1136, 'Chương 1', 1127),
(1137, 'Chương 2', 1127),
(1138, 'Docker', 1128),
(1139, 'Javascript nâng cao', 1129),
(1140, 'Chương 1', 1130),
(1141, 'Chương 2', 1130);

-- --------------------------------------------------------

--
-- Table structure for table `course_gains`
--

CREATE TABLE `course_gains` (
  `COURSE_GAIN_ID` smallint(6) NOT NULL,
  `CONTENT` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COURSE_ID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `course_gains`
--

INSERT INTO `course_gains` (`COURSE_GAIN_ID`, `CONTENT`, `COURSE_ID`) VALUES
(1114, 'Biết sử dụng ngôn ngữ lập trình C#', 1112),
(1115, 'Biết về Networking trong >NET Core', 1112),
(1116, 'Biết về ADO.NET', 1112),
(1117, 'Biết cách sử dùng EF Core', 1112),
(1118, 'ASP.NET Core và ASP.NET Razor', 1112),
(1119, 'Biêt về mô hình 3 lớp ASP.MVC', 1112),
(1120, 'Biết cách tạo ra ứng dụng Anroid bằng Java', 1113),
(1121, 'Biết được những thành phần công cụ của Anroid Studio', 1113),
(1122, 'Biết cách sử dụng SQLite để lưu trữ dữ liệu', 1113),
(1126, 'Biết cách sử dụng Docker', 1119),
(1127, 'Cải thiện kỹ năng nghe của bạn', 1120),
(1128, 'Tăng vốn từ vựng', 1120),
(1131, 'Thành thào hơn về HTML và CSS', 1121),
(1132, 'Biết cách chia bố cục trang web rõ ràng', 1121),
(1138, 'asdbas', 1126),
(1141, 'Cải thiện kỹ năng nghe của bạn', 1118),
(1142, 'Tăng vốn từ vựng', 1118),
(1145, 'Thực hiện tự động hóa trình duyệt', 1127),
(1146, 'Biết cách sử dụng Docker', 1128),
(1147, 'Biết được kiến thức Javascript nâng cao', 1129),
(1148, 'Sử dụng thành thạo cmd của windows', 1122),
(1149, 'Hiểu được Git, GItHub, GitLab là gì và mục đích của chúng', 1111),
(1150, 'Biết được các câu lệnh căn bản trong Git, GItHub và GitLab', 1111),
(1151, 'Biết được những tình huống thực tế và cách giải quyết đối với Git', 1111),
(1152, 'Biết về SSH', 1130);

-- --------------------------------------------------------

--
-- Table structure for table `course_maintypes`
--

CREATE TABLE `course_maintypes` (
  `COURSE_MAINTYPE_ID` smallint(6) NOT NULL,
  `TYPE_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `course_maintypes`
--

INSERT INTO `course_maintypes` (`COURSE_MAINTYPE_ID`, `TYPE_NAME`) VALUES
(1111, 'Ngoại ngữ'),
(1112, 'Marketing'),
(1113, 'Tin học văn phòng'),
(1114, 'Thiết kế'),
(1115, 'Kinh doanh'),
(1116, 'Phát triển cá nhân'),
(1117, 'Sales, bán hàng'),
(1118, 'Công nghệ thông tin'),
(1119, 'Sức khỏe - Giới tính'),
(1120, 'Phong cách sống'),
(1121, 'Nuôi dạy con'),
(1122, 'Hôn nhân gia đình'),
(1123, 'Nhiếp ảnh, dựng phim');

-- --------------------------------------------------------

--
-- Table structure for table `course_requires`
--

CREATE TABLE `course_requires` (
  `COURSE_REQUIRE_ID` smallint(6) NOT NULL,
  `CONTENT` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COURSE_ID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `course_requires`
--

INSERT INTO `course_requires` (`COURSE_REQUIRE_ID`, `CONTENT`, `COURSE_ID`) VALUES
(1111, 'Có kiến thức cơ bản về lập trình hướng đối tượng', 1112),
(1112, 'Có kiến thức cơ bản về ngôn ngữ lập trình Java', 1113),
(1113, 'Có kiến thức về lập trình hướng đối tượng', 1113),
(1114, 'Có kiến thức cơ bản về CSDL', 1113),
(1116, 'Có kiến thức cơ bản về cmd', 1119),
(1117, 'Biết đọc chữ', 1120),
(1121, 'asdasbas', 1126),
(1124, 'Biết chơi game', 1118),
(1127, 'Có kiến thức cơ bản về C#', 1127),
(1128, 'Có kiến thức cơ bản về cmd', 1128),
(1129, 'Có kiến thức Javascript cơ bản', 1129),
(1130, 'Có kiến thức cơ bản về cmd', 1122),
(1131, 'Biết lập trình căn bản', 1130);

-- --------------------------------------------------------

--
-- Table structure for table `course_reviews`
--

CREATE TABLE `course_reviews` (
  `USER_ID` smallint(6) NOT NULL,
  `COURSE_ID` smallint(6) NOT NULL,
  `COURSE_REVIEW_STATE` tinyint(1) DEFAULT NULL,
  `CONTENT` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `course_reviews`
--

INSERT INTO `course_reviews` (`USER_ID`, `COURSE_ID`, `COURSE_REVIEW_STATE`, `CONTENT`) VALUES
(1112, 1111, 1, 'Cuối chương 1 hơi khó hiểu nhưng vẫn ok'),
(1113, 1115, 1, 'Cảm ơn add'),
(1113, 1121, 1, 'Bài học rất hay'),
(1114, 1111, 1, 'Bài giảng dễ hiểu'),
(1114, 1112, 1, 'Tuyệt zời'),
(1115, 1111, 1, 'khóa học rất hay, dễ hiểu'),
(1115, 1112, 1, NULL),
(1115, 1113, 1, 'Tuyệt zời !!!!!!!!!'),
(1117, 1115, 0, 'bài học rất bổ ích'),
(1117, 1116, 0, 'bài giảng rất hay, tôi đã học hỏi rất nhiều'),
(1117, 1118, 0, 'tôi không học được gì qua khóa này do người trong cờ líp nói quá nhanh');

-- --------------------------------------------------------

--
-- Table structure for table `course_subtypes`
--

CREATE TABLE `course_subtypes` (
  `COURSE_SUBTYPE_ID` smallint(6) NOT NULL,
  `TYPE_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PARENT_TYPE_ID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `course_subtypes`
--

INSERT INTO `course_subtypes` (`COURSE_SUBTYPE_ID`, `TYPE_NAME`, `PARENT_TYPE_ID`) VALUES
(1111, 'Tiếng Anh', 1111),
(1112, 'Tiếng Trung', 1111),
(1113, 'Tiếng Hàn', 1111),
(1114, 'Tiếng Nhật', 1111),
(1115, 'Khác', 1111),
(1116, 'Marketing Online', 1112),
(1117, 'Google Ads', 1112),
(1118, 'Seo', 1112),
(1119, 'Branding', 1112),
(1120, 'Content Marketing', 1112),
(1121, 'Video Marketing', 1112),
(1122, 'Khác', 1112),
(1123, 'Exel', 1113),
(1124, 'Word', 1113),
(1125, 'PowerPoint', 1113),
(1126, 'Khác', 1113),
(1127, 'Thiết kế quảng cáo', 1114),
(1128, 'Phần mềm thiết kế', 1114),
(1129, 'Thiêt kế website', 1114),
(1130, 'Kiến trúc, nội thất', 1114),
(1131, 'Khác', 1114),
(1132, 'Bất động sản', 1115),
(1133, 'Crypto', 1115),
(1134, 'Kinh doanh Online', 1115),
(1135, 'Startup', 1115),
(1136, 'Kinh doanh Cafe', 1115),
(1137, 'Kiếm tiền Online', 1115),
(1138, 'Quản trị doanh nghiệp', 1115),
(1139, 'Chứng khoán', 1115),
(1140, 'Dropshipping', 1115),
(1141, 'Kế toán', 1115),
(1142, 'Đầu tư forex', 1115),
(1143, 'Khác', 1115),
(1144, 'Thương hiệu cá nhân', 1116),
(1145, 'Tài chính cá nhân', 1116),
(1146, 'Đàm phán', 1116),
(1147, 'Ký năng lãnh đạo', 1116),
(1148, 'Quản trị nhân sự', 1116),
(1149, 'MC', 1116),
(1150, 'Rèn luyện trí nhớ', 1116),
(1151, 'Kỹ năng mềm', 1116),
(1152, 'Giao tiếp', 1116),
(1153, 'Kỹ năng quản lý', 1116),
(1154, 'Thuyết trình', 1116),
(1155, 'Khác', 1116),
(1156, 'Bán hàng online', 1117),
(1157, 'Telesales', 1117),
(1158, 'Bán hàng livestream', 1117),
(1159, 'Chăm sóc khách hàng', 1117),
(1160, 'Chiến lược bán hàng', 1117),
(1161, 'Khác', 1117),
(1162, 'Lập trình', 1118),
(1163, 'Ngôn ngữ lập trình', 1118),
(1164, 'Lập trình Web', 1118),
(1165, 'Lập trình Android', 1118),
(1166, 'Khác', 1118),
(1167, 'Giảm cân', 1119),
(1168, 'Thiền', 1119),
(1169, 'Phòn thủ', 1119),
(1170, 'Giảm stress', 1119),
(1171, 'Fitness - Gym', 1119),
(1172, 'Tình yêu', 1119),
(1173, 'Yoga', 1119),
(1174, 'Massage', 1119),
(1175, 'Khác', 1119),
(1176, 'Pha chế', 1120),
(1177, 'Làm bánh', 1120),
(1178, 'Làm đẹp', 1120),
(1179, 'Handmade', 1120),
(1180, 'Tử vi', 1120),
(1181, 'Ảo thuật', 1120),
(1182, 'Nhạc cụ', 1120),
(1183, 'Ẩm thực - Nấu ăn', 1120),
(1184, 'Nhảy', 1120),
(1185, 'Phong thủy', 1120),
(1186, 'Khác', 1120),
(1187, 'Mang thai', 1121),
(1188, 'Dạy con thông minh', 1121),
(1189, 'Chăm sóc bé yêu', 1121),
(1190, 'Khác', 1121),
(1191, 'Hạnh phúc gia đình', 1122),
(1192, 'Đời sống vợ chồng', 1122),
(1193, 'Khác', 1122),
(1194, 'Dựng phim', 1123),
(1195, 'Chụp ảnh', 1123),
(1196, 'Kỹ xảo', 1123),
(1197, 'Khác', 1123);

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `ENROLLMENT_ID` smallint(6) NOT NULL,
  `USER_ID` smallint(6) DEFAULT NULL,
  `COURSE_ID` smallint(6) DEFAULT NULL,
  `ENROLL_TIME` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`ENROLLMENT_ID`, `USER_ID`, `COURSE_ID`, `ENROLL_TIME`) VALUES
(1111, 1112, 1111, '2021-12-19 09:20:53'),
(1112, 1112, 1112, '2021-12-19 09:21:01'),
(1113, 1114, 1111, '2021-12-20 03:13:52'),
(1114, 1114, 1112, '2021-12-20 03:18:21'),
(1115, 1113, 1115, '2021-12-20 03:44:44'),
(1116, 1115, 1111, '2021-12-20 04:43:47'),
(1117, 1115, 1112, '2021-12-20 04:43:55'),
(1118, 1115, 1113, '2021-12-20 04:44:14'),
(1119, 1115, 1115, '2021-12-20 04:44:50'),
(1120, 1115, 1116, '2021-12-20 04:45:04'),
(1121, 1113, 1117, '2021-12-20 05:07:12'),
(1122, 1113, 1114, '2021-12-20 06:03:44'),
(1123, 1115, 1118, '2021-12-20 09:04:40'),
(1124, 1117, 1116, '2021-12-20 13:04:09'),
(1125, 1117, 1118, '2021-12-20 13:09:06'),
(1126, 1117, 1115, '2021-12-20 13:10:06'),
(1127, 1117, 1114, '2021-12-20 13:11:40'),
(1128, 1113, 1121, '2021-12-21 02:42:10'),
(1129, 1121, 1111, '2022-01-13 03:22:11'),
(1130, 1118, 1111, '2022-01-13 08:25:59'),
(1131, 1113, 1129, '2022-01-13 10:49:04'),
(1132, 1113, 1127, '2022-01-14 01:22:42');

-- --------------------------------------------------------

--
-- Table structure for table `learnings`
--

CREATE TABLE `learnings` (
  `USER_ID` smallint(6) NOT NULL,
  `LESSON_ID` smallint(6) NOT NULL,
  `LEARN_TIME` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `learnings`
--

INSERT INTO `learnings` (`USER_ID`, `LESSON_ID`, `LEARN_TIME`) VALUES
(1112, 1111, '2022-01-12 04:41:02'),
(1112, 1112, '2022-01-12 04:44:49'),
(1112, 1113, '2022-01-12 04:44:59'),
(1113, 1214, '2022-01-13 09:30:14'),
(1113, 1273, '2021-12-20 05:07:48'),
(1113, 1274, '2021-12-20 14:53:59'),
(1113, 1275, '2021-12-20 14:54:07'),
(1113, 1276, '2021-12-20 14:54:13'),
(1113, 1346, '2021-12-21 02:42:49'),
(1113, 1347, '2021-12-21 02:43:12'),
(1113, 1348, '2021-12-21 02:43:19'),
(1113, 1349, '2022-01-13 05:18:45'),
(1113, 1350, '2022-01-13 05:18:51'),
(1113, 1351, '2022-01-13 05:19:00'),
(1113, 1352, '2022-01-13 09:00:36'),
(1113, 1353, '2022-01-13 09:28:48'),
(1113, 1354, '2022-01-13 09:28:55'),
(1113, 1391, '2022-01-14 01:23:17'),
(1113, 1392, '2022-01-14 01:23:26'),
(1113, 1425, '2022-01-13 10:49:18'),
(1113, 1426, '2022-01-13 10:49:34'),
(1114, 1111, '2021-12-20 03:14:07'),
(1114, 1112, '2021-12-20 03:14:29'),
(1114, 1113, '2021-12-20 03:16:12'),
(1114, 1114, '2021-12-20 03:16:25'),
(1114, 1115, '2021-12-20 03:19:16'),
(1114, 1122, '2021-12-20 03:18:31'),
(1114, 1123, '2021-12-20 03:18:40'),
(1115, 1122, '2021-12-20 04:44:03'),
(1115, 1123, '2021-12-20 04:44:09'),
(1115, 1198, '2021-12-20 04:44:22'),
(1115, 1199, '2021-12-20 04:44:30'),
(1115, 1200, '2021-12-20 04:44:37'),
(1115, 1240, '2021-12-20 04:44:58'),
(1115, 1258, '2021-12-20 04:45:12'),
(1115, 1298, '2021-12-20 09:04:55'),
(1115, 1299, '2021-12-20 09:05:55'),
(1118, 1111, '2022-01-13 08:27:05'),
(1118, 1112, '2022-01-13 08:27:14'),
(1121, 1111, '2022-01-13 03:27:11'),
(1121, 1112, '2022-01-13 03:41:43'),
(1121, 1113, '2022-01-13 03:41:55');

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `LESSON_ID` smallint(6) NOT NULL,
  `LESSON_NAME` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LESSON_URL` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DURATION` int(11) DEFAULT NULL,
  `CHAPTER_ID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`LESSON_ID`, `LESSON_NAME`, `LESSON_URL`, `DURATION`, `CHAPTER_ID`) VALUES
(1111, 'Git 01: Cài đặt và cấu hình Git trên macOS, Windows, Ubuntu Linux', 'https://www.youtube.com/watch?v=gjQDyND-vN8', 958000, 1111),
(1112, 'Git 02: Các lệnh cơ bản khởi tạo và làm việc với kho chứa Git', 'https://www.youtube.com/watch?v=fJImlz2N8vc', 1538000, 1111),
(1113, 'Git 03: Lệnh git reset, hủy (undo) commit, xóa commit', 'https://www.youtube.com/watch?v=NR2KO0u_p6c', 605000, 1111),
(1114, 'Git 04: Nhánh trong git, tạo và quản lý nhánh, gộp nhánh với git merge', 'https://www.youtube.com/watch?v=nCFgZ5OIiAM', 1708000, 1111),
(1115, 'Git 05: Gộp nhánh bằng git merge và git rebase', 'https://www.youtube.com/watch?v=lZTaQu0lNdI', 1037000, 1111),
(1116, 'Git 06: Làm việc với remote repository trên server lưu trữ git, lệnh git push, git pull', 'https://www.youtube.com/watch?v=F2pQ3LdtKPg', 1831000, 1111),
(1117, 'Git 07: Sử dụng GitHub và GitLab cơ bản, tạo repo mới, đẩy và lấy dữ liệu từ GitHub, GitLab', 'https://www.youtube.com/watch?v=50sNNeqOWCw', 1048000, 1111),
(1118, 'Git 08: Tag trong Git, đánh dấu phiên bản và đẩy lên GitHub', 'https://www.youtube.com/watch?v=2B4Gy-yJmuY', 611000, 1111),
(1119, 'Git 09: Fork và Pull Request trên GitHub', 'https://www.youtube.com/watch?v=1qEKuuFaBYo', 551000, 1111),
(1120, 'Git 10: Lệnh gitk và git gui, công cụ trực quan làm việc với kho chứa git', 'https://www.youtube.com/watch?v=q2rtYVXb5Og', 323000, 1112),
(1121, 'Git 11: Git trong một IDE phổ biến', 'https://www.youtube.com/watch?v=qg5MiNXmqwc', 1185000, 1112),
(1122, 'CS01 - Giới thiệu .NET Core và ngôn ngữ lập trình C#, viết chương trình C# cơ bản đầu tiên', 'https://www.youtube.com/watch?v=2FvmFZo9Bvw', 1846000, 1113),
(1123, 'CS02 - Biến, hằng số, kiểu dữ liệu và nhập xuất dữ liệu terminal console, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=N6CvaGT42jU', 1906000, 1113),
(1124, 'CS03 - Các toán tử tính toán số học trong C# toán tử gán và tăng giảm, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=0TIKuS1Tq78', 725000, 1113),
(1125, 'CS04 - Các toán tử so sánh, logic trong C#, lập trình C# .NET Core cơ bản', 'https://www.youtube.com/watch?v=Zje1wIQ1bzs', 470000, 1113),
(1126, 'CS05 - Lệnh, cấu trúc rẽ nhánh với if else trong C#, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=8JFzn6NOUDU', 1035000, 1113),
(1127, 'CS06 - Rẽ nhánh với lệnh switch case C#, lệnh goto - lập trình C# cơ bản .NET Core', 'https://www.youtube.com/watch?v=KoskfC4eS58', 837000, 1113),
(1128, 'CS07 - Vòng lặp for, while, do while và lệnh break, lệnh continue lập trình C# .NET Core Cơ bản', 'https://www.youtube.com/watch?v=URdACWHvc8A', 1036000, 1113),
(1129, 'CS08 - Cấu trúc dữ liệu mảng (array) trong lập trình C# .NET Core Cơ bản', 'https://www.youtube.com/watch?v=IikfKiBkeXo', 1360000, 1113),
(1130, 'CS09 - Phương thức (methods) trong lập trình C# cơ bản, lập trình C# .NET Core Cơ bản', 'https://www.youtube.com/watch?v=3EIoIRoVn1U', 1662000, 1113),
(1131, 'CS10 - Lớp trong C# và lập trình hướng đối tượng .NET Core', 'https://www.youtube.com/watch?v=pgCe960YRFk', 2153000, 1113),
(1132, 'CS11 - Chuỗi ký tự (xâu ký tự) string và lớp StringBuilder trong C#, lập trình .NET Core', 'https://www.youtube.com/watch?v=j6yfRzcfSak', 1783000, 1113),
(1133, 'CS12 - Dữ liệu cấu trúc struct và kiểu dữ liệt kê trong C#, lập trình .NET Core', 'https://www.youtube.com/watch?v=1bTAi-3Dgsc', 1081000, 1113),
(1134, 'CS13 - Thư viện toán học Math trong C#, lập trình .NET Core', 'https://www.youtube.com/watch?v=WTSKo_S0cCQ', 733000, 1113),
(1135, 'CS14 - Kế thừa trong lập trình C#, tạo các lớp cơ sở, lớp kế thừa, lớp bị niêm phong C# .NET Core', 'https://www.youtube.com/watch?v=_X6b-6WgmPU', 906000, 1113),
(1136, 'CS15 - Namespace và partial trong tổ chức code lập trình C# .NET Core', 'https://www.youtube.com/watch?v=CSJ1Mp3eyKQ', 914000, 1113),
(1137, 'CS16 - Sử dụng generic, phương thức generic, lớp generic lập trình C# .NET Core', 'https://www.youtube.com/watch?v=09MXsrzSjC8', 849000, 1113),
(1138, 'CS17 - Kiểu vô danh (Anonymous Type) và kiểu động dynamic trong lập trình C# .NET Core', 'https://www.youtube.com/watch?v=2vXMfooYBfk', 870000, 1113),
(1139, 'CS18 - Sử dụng null và nullable trong lập trình C# .NET Core', 'https://www.youtube.com/watch?v=EStVYg0m2J4', 340000, 1113),
(1140, 'CS19 - Phương thức ảo (virtual method), lớp trừu tượng (abstract) và giao diện intterface C# .NET', 'https://www.youtube.com/watch?v=NWJpsVU-CHg', 979000, 1113),
(1141, 'CS20 - Sử dụng delegate, khai báo delegate Action, delegate Func trong lập trình C# .NET', 'https://www.youtube.com/watch?v=IYo-vJ3DNk4', 1158000, 1113),
(1142, 'CS21 - Biểu thức lambda, viết và sử dụng  biểu thức lambda với delegate trong lập trình C# .NET Core', 'https://www.youtube.com/watch?v=MvOeTjNZyaQ', 1309000, 1113),
(1143, 'CS22 - Lập trình hướng sự kiện (event), tạo sự kiện với delegate và EventHandler trong C# .NET', 'https://www.youtube.com/watch?v=1Y4sUOXRcP4', 1415000, 1113),
(1144, 'CS23 - Phương thức mở rộng (extension method), xây dựng phương thức mở rộng lập trình C# .NET Core', 'https://www.youtube.com/watch?v=5gPIMxuF6Yw', 641000, 1113),
(1145, 'CS24 - Phương thức tĩnh, dữ liệu chỉ đọc, quá tải toán tử và indexer trong lập trình C# .NET', 'https://www.youtube.com/watch?v=_uIYPW4bTUY', 1231000, 1113),
(1146, 'CS25 - Tìm hiểu và sử dụng ngoại lệ Exception câu lệnh try catch trong lập trình C# .NET Core', 'https://www.youtube.com/watch?v=WhR2ADZ-9qM', 1718000, 1113),
(1147, 'CS26 - Kiểu dữ liệu danh sách List và SortedList trong lập trình C# .NET Core', 'https://www.youtube.com/watch?v=m6emA6KUqmc', 1372000, 1113),
(1148, 'CS27 - Kiểu dữ liệu hàng đợi (Queue), ngăn xếp (Stack), danh sách liên kết (LinkedList) C# .NET Core', 'https://www.youtube.com/watch?v=UZf-_H_5IO8', 1081000, 1113),
(1149, 'CS28 - Làm việc với thư mục và file, đọc ghi file với FileStream, File trong lập trình C# .NET', 'https://www.youtube.com/watch?v=HOuBmryoUr8', 1926000, 1113),
(1150, 'CS29 - Lập trình bất đồng bộ Asynchronous,  tạo phương thức asynchronous với async/await và task C#', 'https://www.youtube.com/watch?v=OZLCVcCB5Gg', 2620000, 1113),
(1151, 'CS30 Sử dụng LINQ (Language Integrated Query) - Ngôn ngữ truy vấn tích hợp, lập trình C# .NET CORE', 'https://www.youtube.com/watch?v=Vu_jFsPOJFw', 3571000, 1113),
(1152, 'CS31 Tạo thư viện lớp C# NET Core và chia sẻ lên nuget.org, ví dụ thư viện C# đổi số thành chữ', 'https://www.youtube.com/watch?v=dpV-fHGU4O0', 1653000, 1113),
(1153, 'CS32 Sử dụng Attribute và Type trong lập trình C# .NET Core', 'https://www.youtube.com/watch?v=foZowe9XGfc', 1812000, 1113),
(1154, 'CS33 Dependency injection (DI) trong lập trình C#, sử dụng ServiceCollection với .NET Core', 'https://www.youtube.com/watch?v=0FrfMGB8Wq8', 4100000, 1113),
(1155, 'CS34 (Networking1) Sử dụng HttpClient thực hiện các truy vấn HTTP (GET, POST) - lập trình C# .NET', 'https://www.youtube.com/watch?v=iJlAMzFy4yQ', 2875000, 1114),
(1156, 'CS35 (Networking2) Sử dụng HttpMessageHandler, CookieContainer cho HttpClient lập trình C# .NET', 'https://www.youtube.com/watch?v=WhLvkY-6F6M', 1034000, 1114),
(1157, 'CS36 (Networking3) Sử dụng HttpListener tạo máy chủ HTTP đơn giản, lập trình C# .NET', 'https://www.youtube.com/watch?v=fM0LlkYQM_w', 1307000, 1114),
(1158, 'CS37 (ADO.NET 1) Giới thiệu ADO.NET và kết nối SQL Server, MySQL với SqlConnection, lập trình C#', 'https://www.youtube.com/watch?v=SvhV1DdmubU', 2029000, 1115),
(1159, 'CS38 - (ADO.NET 2)  Sử dụng SqlCommand truy vấn và cập nhật dữ liệu SQL Server, lập trình C# .NET', 'https://www.youtube.com/watch?v=RXcbCddcTiA', 1776000, 1115),
(1160, 'CS39 - (ADO.NET 3)  Sử dụng DataAdapter, DataSet, DataTable  và SQL Server, lập trình C# .NET', 'https://www.youtube.com/watch?v=Ru2qSKfI0NA', 2733000, 1115),
(1161, 'CS40 - (EF 1)  Giới thiệu Entity Framework,  EF cơ bản đọc, cập nhật, SQL Server lập trình C# .NET', 'https://www.youtube.com/watch?v=tLTvz4cD9fc', 2430000, 1116),
(1162, 'CS41 - (EF 2)  Tạo Model trong Entity Framework, thiết lập mối quan hệ một nhiều, lập trình C# .NET', 'https://www.youtube.com/watch?v=mZJn2Kv6wPo', 3006000, 1116),
(1163, 'CS42 - (EF 3)  Sử dụng Fluent API - Entity Framework, lập trình C# .NET', 'https://www.youtube.com/watch?v=-BPaRiN2lIE', 1760000, 1116),
(1164, 'CS43 - (EF 4)  Migration và Scaffold  trong Entity Framework, lập trình C# .NET', 'https://www.youtube.com/watch?v=I5xsuyrSD08', 2221000, 1116),
(1165, 'CS44 - (ASP.NET Core 01)  Giới thiệu và tạo ứng dụng web đầu tiên, lập trình C# .NET', 'https://www.youtube.com/watch?v=haz3Ta4lvw4', 2980000, 1117),
(1166, 'CS45 - (ASP.NET Core 02)  Middleware và pipeline luồng xử lý HttpContext , lập trình C# .NET', 'https://www.youtube.com/watch?v=kYg8_3sbb1o', 2081000, 1117),
(1167, 'CS46 - (ASP.NET Core 03)  Tích hợp Webpack, đọc HttpRequest, Cookie, trả về JSON, UploadFile ASP.NET', 'https://www.youtube.com/watch?v=3t7EsWvu3Mc', 2732000, 1117),
(1168, 'CS47 - (ASP.NET Core 04)  Cấu hình ứng dụng và DI trong ứng dụng ASP.NET, lập trình C#', 'https://www.youtube.com/watch?v=9NIU--AIw6Y', 1424000, 1117),
(1169, 'CS48 - (ASP.NET Core 05)  Sử dụng Session trong ASP.NET, lập trình C#', 'https://www.youtube.com/watch?v=bR_Mp8gAfhM', 883000, 1117),
(1170, 'CS49 - (ASP.NET Core 06)  Dịch vụ gửi mail trong ASP.NET, lập trình C#', 'https://www.youtube.com/watch?v=nhQmGnMPC1M', 1618000, 1117),
(1171, 'CS50 - (ASP.NET Razor  01) Giới thiệu và khởi tạo trang web với Razor Page, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=FTHtby9qvBw', 3450000, 1118),
(1172, 'CS51 - (ASP.NET Razor  02) Cú pháp cơ bản trong ASP.NET Razor, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=EUwLp91xo6k', 1090000, 1118),
(1173, 'CS52 - (ASP.NET Razor  03) Layout trong ASP.NET Razor, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=awAiunNkxX8', 1242000, 1118),
(1174, 'CS53 - (ASP.NET Razor  04) PartialView và ViewComponent trong ASP.NET, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=PghZfnDJl-0', 2635000, 1118),
(1175, 'CS54 - (ASP.NET Razor  05) TagHelper và HtmlHelper trong ASP.NET, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=J6Qr-1EcKo8', 1051000, 1118),
(1176, 'CS55 - (ASP.NET Razor  06) Ôn tập về Razor PageModel ASP.NET, lập trình C# .NET Core', 'https://www.youtube.com/watch?v=aJMc4RllYQE', 2558000, 1118),
(1177, 'CS56 - (ASP.NET Razor  07) Model Binding - liên kết dữ liệu Model trong ASP.NET,  C# .NET Core', 'https://www.youtube.com/watch?v=t-i6IHxXzcg', 2066000, 1118),
(1178, 'CS57 - (ASP.NET Razor  08) Validation, ModelBinder và Upload file trong ASP.NET,  C# .NET Core', 'https://www.youtube.com/watch?v=U8PnMeLRj9Y', 2874000, 1118),
(1179, 'CS58 - (ASP.NET Razor  09) Tích hợp Entity Framework vào ASP.NET, làm việc với SQL Server', 'https://www.youtube.com/watch?v=ZLvLZUDqSX0', 2042000, 1118),
(1180, 'CS59 - (ASP.NET Razor  10) Tạo các trang CRUD làm việc với DbContext EF, SQL Server trong ASP.NET', 'https://www.youtube.com/watch?v=NzqYGPx27wM', 2374000, 1118),
(1181, 'CS60 - (ASP.NET Razor  11) Sử dụng Identity xác thực người dùng, chức năng đăng nhập tài khoản', 'https://www.youtube.com/watch?v=RSylgebJP2A', 2568000, 1118),
(1182, 'CS61 - (ASP.NET Razor  12)  Tùy biến trang đăng ký tài khoản và xác thực email, lập trình C#', 'https://www.youtube.com/watch?v=xHydHEjBMW0', 1794000, 1118),
(1183, 'CS62 - (ASP.NET Razor  13)  Tùy biến trang đăng nhập, đăng xuất, lấy lại mật khẩu, khóa tài khoản', 'https://www.youtube.com/watch?v=A-sc5IU39J0', 1543000, 1118),
(1184, 'CS63 - (ASP.NET Razor  14)  Tích hợp xác thực, đăng nhập từ Google, Facebook cho ASP.NET', 'https://www.youtube.com/watch?v=hPp8Qxo2Rdc', 3071000, 1118),
(1185, 'CS64 - (ASP.NET Razor  15)  Tùy biến các trang quản lý tài khoản cá nhân trong Identity -  ASP.NET', 'https://www.youtube.com/watch?v=maLqYmVHIek', 2015000, 1118),
(1186, 'CS65- (ASP.NET Razor  16)  Quản lý các Role, phân quyền theo Role (Role-based)  trong ASP.NET', 'https://www.youtube.com/watch?v=ILi29Ikn6jY', 4824000, 1118),
(1187, 'CS66- (ASP.NET Razor  17)  Quản lý Claim, phân quyền theo Policy và Claim ASP.NET', 'https://www.youtube.com/watch?v=s_GPT8IyhO0', 3709000, 1118),
(1188, 'CS67- (ASP.NET Razor  18)  IAuthorizationService và xác thực quyền truy cập Resource-based ASP.NET', 'https://www.youtube.com/watch?v=gNdfWgCK6PE', 2164000, 1118),
(1189, 'CS68 (Lập trình ASP.NET MVC 01) Tạo dự án ứng dụng web mô hình MVC, tìm hiểu Controller, View, Model', 'https://www.youtube.com/watch?v=-MctlvnYAC4', 3788000, 1119),
(1190, 'CS69 (Lập trình ASP.NET MVC 02) Tạo Route, ánh xạ Url vào Controller/Action, Area trong MVC', 'https://www.youtube.com/watch?v=R9WZ5Sqls3w', 4163000, 1119),
(1191, 'CS70 (Lập trình ASP.NET MVC 03) Tích hợp Entity Framework làm việc với CSDL SQL Server', 'https://www.youtube.com/watch?v=wy0PcaDeSWo', 1473000, 1119),
(1192, 'CS71 (Lập trình ASP.NET MVC 04) Ôn tập Model Binding/Validation, tạo trang liên hệ, sử dụng Gulp CSS', 'https://www.youtube.com/watch?v=E8kfcG98rj4', 2083000, 1119),
(1193, 'CS72 (Lập trình ASP.NET MVC 05) Tích hợp Identity, phân quyền truy cập, xác thực hai yếu tố', 'https://www.youtube.com/watch?v=bG4J2l9FBfE', 1609000, 1119),
(1194, 'CS73 (Lập trình ASP.NET MVC 06) Xây dựng model chuyên mục Blog, Tin tức', 'https://www.youtube.com/watch?v=4q41NstGrIU', 2377000, 1119),
(1195, 'CS74  (Lập trình ASP.NET MVC 07) Xây dựng model các bài viết post của trang BLog, xây dựng website', 'https://www.youtube.com/watch?v=AiijcHyOTEI', 3283000, 1119),
(1196, 'CS75  (Lập trình ASP.NET MVC 08) Tích hợp HTML Editor (WYSIWYG HTML) vào Website Asp.net core', 'https://www.youtube.com/watch?v=VxV2WOC2uZQ', 947000, 1119),
(1197, 'CS76  (Lập trình ASP.NET MVC 09)  Tích hợp thư viện quản lý file elFinder  vào Website Asp.net core', 'https://www.youtube.com/watch?v=kjQd3GD_tJc', 1160000, 1119),
(1198, 'Cài đặt Android Studio, máy ảo Android, tạo dự án ứng dụng đầu tiên', 'https://www.youtube.com/watch?v=hC7o-1bHFQE', 1386000, 1120),
(1199, 'Vòng đời của các Activity ', 'https://www.youtube.com/watch?v=1E08HdXUPxs', 1914000, 1120),
(1200, 'Tổng quan chạy,  trao đổi dữ liệu giữa các Activity với Intent', 'https://www.youtube.com/watch?v=lT6dIrlUP_k', 1884000, 1120),
(1201, 'Lưu và phục hồi trạng thái của Activity ', 'https://www.youtube.com/watch?v=3-TP5MD0kE8', 1045000, 1120),
(1202, 'Cơ bản về View, ViewGroup, Layout ', 'https://www.youtube.com/watch?v=aGvvWQsy62Q', 1677000, 1120),
(1203, 'TextView trong lập trình Android hiện thị text, HTML, SpannableString', 'https://www.youtube.com/watch?v=2oaXCDsBJAk', 2150000, 1120),
(1204, 'Button ', 'https://www.youtube.com/watch?v=_pavbUeiWEM', 1305000, 1120),
(1205, 'Sử dụng CheckBox, Switch, ToggleButton ', 'https://www.youtube.com/watch?v=OmnfQzILwj8', 1352000, 1120),
(1206, 'Sử dụng EditText, TextInputEditText, AutoCompleteTextView', 'https://www.youtube.com/watch?v=zqAWZDACux8', 1752000, 1120),
(1207, 'RadioButton và RadioGroup', 'https://www.youtube.com/watch?v=4zYgppmX3wE', 1608000, 1120),
(1208, 'ImageView và ImageButton', 'https://www.youtube.com/watch?v=dkrV58B0cng', 976000, 1120),
(1209, 'Sử dụng FrameLayout', 'https://www.youtube.com/watch?v=rbVAkBwbGko', 662000, 1120),
(1210, 'Sử dụng LinearLayout', 'https://www.youtube.com/watch?v=vV9ThQUajI4', 933000, 1120),
(1211, 'Sử dụng ConstraintLayout', 'https://www.youtube.com/watch?v=AJm-wAB99xk', 1912000, 1120),
(1212, 'TableLayout và TableRow', 'https://www.youtube.com/watch?v=9LvTLJwzNM4', 1273000, 1120),
(1213, 'Sử dụng RelativeLayout', 'https://www.youtube.com/watch?v=ESR4WrSv54o', 1530000, 1120),
(1214, 'Bài 00 Excel là gì? Tại sao lại học Excel?', 'https://www.youtube.com/watch?v=LC19SdKG4_c', 486000, 1121),
(1215, 'Bài 01 Các thao tác với Excel', 'https://www.youtube.com/watch?v=t-RLqZ-FZuo', 1561000, 1121),
(1216, 'Bài 02 Hướng dẫn nhập liệu và tìm hiểu các thẻ', 'https://www.youtube.com/watch?v=YUQODIm2hrE', 1936000, 1121),
(1217, 'Bài 03 Các hàm tính tổng SUM SUMIF SUMIFs', 'https://www.youtube.com/watch?v=RXj9T-wSZWk', 1159000, 1121),
(1218, 'Bài 04 Các hàm ĐẾM (Count, CountA, CountIFs,...)', 'https://www.youtube.com/watch?v=yHLGXACgTU0', 646000, 1121),
(1219, 'Bài 05 Hàm điều kiện IF', 'https://www.youtube.com/watch?v=_41-_Q6_LsE', 1080000, 1121),
(1220, 'Bài 06 Toàn bộ 18 hàm xử lý chuỗi', 'https://www.youtube.com/watch?v=olnU9t2Dr4Y', 1548000, 1121),
(1221, 'Bài 07 Hàm VLOOKUP và HLOOKUP', 'https://www.youtube.com/watch?v=zlVq9bUpbyc', 1254000, 1121),
(1222, 'Bài 08 Hàm Index, Match, Sumproduct, thời gian', 'https://www.youtube.com/watch?v=6ZqfZ5JFuTA', 3217000, 1121),
(1223, 'Bài 09 Kỹ năng Sort, Filter và Advanced Filter', 'https://www.youtube.com/watch?v=gmGNVd8V8Mg', 1789000, 1121),
(1224, 'Bài 10 Kỹ năng Định dạng Cell (Format Cells)', 'https://www.youtube.com/watch?v=clQeM5k0XP0', 2217000, 1121),
(1225, 'Bài 11 Định dạng có điều kiện', 'https://www.youtube.com/watch?v=v-lfPgj2prU', 2113000, 1121),
(1226, 'Bài 12 Paste special (10 cách copy thông minh)', 'https://www.youtube.com/watch?v=4GDYTDq2QbU', 1584000, 1121),
(1227, 'Bài 13 Flash fill, quick analysis, freeze pane', 'https://www.youtube.com/watch?v=s54HDvaqg2I', 1335000, 1122),
(1228, 'Bài 14 Các thủ thuật Excel hay (1 of 4)', 'https://www.youtube.com/watch?v=z2IW7FrpVLs', 817000, 1122),
(1229, 'Bài 15 Các thủ thuật Excel hay (2 of 4)', 'https://www.youtube.com/watch?v=Amdxvm6OJz4', 714000, 1122),
(1230, 'Bài 16 Các thủ thuật Excel hay (3 of 4)', 'https://www.youtube.com/watch?v=w2FXwxWYYcc', 1091000, 1122),
(1231, 'Bài 17 Bảo vệ dữ liệu, khóa dữ liệu trong excel', 'https://www.youtube.com/watch?v=Mh7pkYVP3tk', 963000, 1122),
(1232, 'Bài 18 Hướng dẫn vẽ biểu đồ chi tiết', 'https://www.youtube.com/watch?v=NpFOpCK8SPk', 1872000, 1122),
(1233, 'Bài 19 Toàn bộ về in ấn (18 thủ thuật)', 'https://www.youtube.com/watch?v=Vf1Lt4gYqn0', 1660000, 1122),
(1234, 'Bài 20 Pivot Table trong Excel', 'https://www.youtube.com/watch?v=Bukqq7vupEg', 1410000, 1122),
(1235, 'Bài 21 Công thức mảng (10 ví dụ mẫu)', 'https://www.youtube.com/watch?v=Qj2CtucX6yQ', 2085000, 1122),
(1236, 'Bài 22 Hướng dẫn tạo Báo cáo động (Dashboard)', 'https://www.youtube.com/watch?v=HLBpUHYU6CI', 1231000, 1122),
(1237, 'Bài 23 Các phím tắt Excel thông dụng nhất', 'https://www.youtube.com/watch?v=Xne7UmDP9TU', 1267000, 1122),
(1238, 'Bài 24 Record macro trong excel', 'https://www.youtube.com/watch?v=vM7i37Kkw80', 1528000, 1122),
(1239, 'Bài 25 Lập trình VBA trong Excel', 'https://www.youtube.com/watch?v=0a9m17AdKpM', 8204000, 1122),
(1240, 'Bài 01: Khởi động phần mềm PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=8WGpeF5InxY', 256000, 1123),
(1241, 'Bài 02: Giới thiệu giao diện làm việc PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=3RGeQ8V-r04', 310000, 1123),
(1242, 'Bài 03: Hướng dẫn sử dụng Ribbon | Trường học PowerPoint', 'https://www.youtube.com/watch?v=EPytnnrehl8', 307000, 1123),
(1243, 'Bài 04: Sử dụng thanh công cụ truy cập nhanh | Trường học PowerPoint', 'https://www.youtube.com/watch?v=gsB0RX0i2xs', 232000, 1123),
(1244, 'Bài 05: Hướng dẫn tạo bản trình chiếu mới | Trường học PowerPoint', 'https://www.youtube.com/watch?v=K2kySkOr66o', 197000, 1123),
(1245, 'Bài 06: Lưu trữ, đóng, mở tập tin trình chiếu | Trường học PowerPoint', 'https://www.youtube.com/watch?v=tWE5TynZq5I', 152000, 1123),
(1246, 'Bài 07: Các chế độ xem slide trình chiếu | Trường học PowerPoint', 'https://www.youtube.com/watch?v=PyTYCmTe7mo', 178000, 1123),
(1247, 'Bài 08: Thay đổi các chủ đề trong PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=3-izSGfz6ek', 178000, 1123),
(1248, 'Bài 09: Tạo và quản lý các nhóm Slide | Trường học PowerPoint', 'https://www.youtube.com/watch?v=7HafApI-UFY', 172000, 1123),
(1249, 'Bài 10: Thêm, chèn, di chuyển, xóa Slide | Trường học PowerPoint', 'https://www.youtube.com/watch?v=LfSV9EAXttI', 173000, 1123),
(1250, 'Bài 11: Thay đổi hình nền slide trong PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=jzFiAZRzCmQ', 326000, 1123),
(1251, 'Hướng dẫn chèn hình ảnh vào PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=YBlC0eROwHc', 332000, 1123),
(1252, 'Bài 13: Chèn công thức toán vào PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=0ywJoHOMqrs', 352000, 1123),
(1253, 'Hướng dẫn chèn video vào PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=5v6dXUJVXTA', 418000, 1123),
(1254, 'Bài 15: Chèn chữ vào PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=PpHwZQdU0U4', 562000, 1123),
(1255, 'Bài 16: Chèn âm thanh vào PowerPoint | Trường học PowerPoint', 'https://www.youtube.com/watch?v=AosfgrnKW8Q', 532000, 1123),
(1256, 'Bài 17: Hướng dẫn sử dụng Merge Shapes | Trường học PowerPoint', 'https://www.youtube.com/watch?v=0bd2sXPiS8E', 408000, 1123),
(1257, 'Tự tin làm chủ PowerPoint trong 210 phút | Tự học PowerPoint', 'https://www.youtube.com/watch?v=808pjbB-VKo', 12659000, 1123),
(1258, 'Microsoft Word 2016 Bài 01: Làm quen với Microsoft Office Word 2016', 'https://www.youtube.com/watch?v=UGpod7WlwJ0', 348000, 1124),
(1259, 'Microsoft Word 2016 Bài 02: Tổ chức quản lý các tài liệu trong Word', 'https://www.youtube.com/watch?v=KiDdqMTLc34', 869000, 1124),
(1260, 'Microsoft Word 2016 Bài 03: Các thao tác Soạn thảo văn bản Word', 'https://www.youtube.com/watch?v=SDpN6i8BUHc', 368000, 1124),
(1261, 'Microsoft Word 2016 Bài 04: Cách đọc và chỉnh sửa tài liệu trong Word', 'https://www.youtube.com/watch?v=9UBpEDaWfTE', 1176000, 1124),
(1262, 'Microsoft Word 2016 Bài 05: Chỉnh sửa văn bản Word', 'https://www.youtube.com/watch?v=zFQEzOCXuSA', 417000, 1124),
(1263, 'Microsoft Word 2016 Bài 06: Định dạng đoạn văn cơ bản', 'https://www.youtube.com/watch?v=yLgC-XMygg8', 577000, 1124),
(1264, 'Microsoft Word 2016 Bài 07: Định dạng đoạn văn Nâng cao', 'https://www.youtube.com/watch?v=YkcJCw4SIiw', 353000, 1124),
(1265, 'Microsoft Word 2016 Bài 08: Sử dụng TAB canh chỉnh văn bản', 'https://www.youtube.com/watch?v=3hlIIF7JBOo', 355000, 1124),
(1266, 'Microsoft Word 2016 Bài 09: Định dạng trang in', 'https://www.youtube.com/watch?v=AzV-wXk6y5k', 797000, 1124),
(1267, 'Microsoft Word 2016 Bài 10: In tài liệu trong Word 2016', 'https://www.youtube.com/watch?v=CcInvPs61X8', 460000, 1124),
(1268, 'Microsoft Word 2016 Bài 11: Bảng biểu (Table) và Đồ thị (Chart)', 'https://www.youtube.com/watch?v=tM_MMvM9yB0', 865000, 1124),
(1269, 'Microsoft Word 2016 Bài 12: Đối tượng đồ họa trong Word 2016', 'https://www.youtube.com/watch?v=GNSxvA5AhZE', 855000, 1124),
(1270, 'Microsoft Word 2016 Bài 13: Trộn thư trong Word (Mail Merge)', 'https://www.youtube.com/watch?v=27QyAdMiqcI', 342000, 1124),
(1271, 'Microsoft Word 2016 Bài 14: Tùy biến Word 2016', 'https://www.youtube.com/watch?v=92DlGc6-6iU', 779000, 1124),
(1272, 'Định dạng văn bản theo điều kiện trong Word - Format Condition in Office Word', 'https://www.youtube.com/watch?v=U2W-6VplF7c', 827000, 1124),
(1273, 'Microsoft Access 2016 Bài 01: Làm quen với cơ sở dữ liệu ACCESS', 'https://www.youtube.com/watch?v=1rKzLc-LtSg', 652000, 1125),
(1274, 'Microsoft Access 2016 Bài 02: Thao tác cơ bản với TABLE', 'https://www.youtube.com/watch?v=ILwMYfmwJf4', 1766000, 1125),
(1275, 'Microsoft Access 2016 Bài 03: LIÊN KẾT các TABLE', 'https://www.youtube.com/watch?v=49Grt4uKBeg', 589000, 1125),
(1276, 'Microsoft Access 2016 Bài 04: Thao tác TABLE NÂNG CAO', 'https://www.youtube.com/watch?v=TJpiOyBtDzM', 815000, 1125),
(1277, 'Microsoft Access 2016 Bài 05: TRUY VẤN QUERY căn bản', 'https://www.youtube.com/watch?v=lNAIsmHMieY', 1771000, 1125),
(1278, 'Microsoft Access 2016 Bài 06: BIỂU THỨC và HÀM CƠ BẢN trong Access', 'https://www.youtube.com/watch?v=zkt0CerScEM', 2798000, 1125),
(1279, 'Microsoft Access 2016 Bài 07: Sử dụng Query PARAMETER', 'https://www.youtube.com/watch?v=unhZDebw5yg', 910000, 1125),
(1280, 'Microsoft Access 2016 Bài 08: Sử dụng QUERY CROSSTAB', 'https://www.youtube.com/watch?v=4fhyrYn9g9c', 1247000, 1125),
(1281, 'Microsoft Access 2016 Bài 09: Truy vấn con Sub Query', 'https://www.youtube.com/watch?v=YsoCJrRCvfw', 1159000, 1125),
(1282, 'Microsoft Access 2016 Bài 10: Truy vấn hành động Action Query', 'https://www.youtube.com/watch?v=EdZnzwBVYpA', 1210000, 1125),
(1283, 'Microsoft Access 2016 Bài 11: Top Query và Total Query', 'https://www.youtube.com/watch?v=R0mpDA0t6jc', 764000, 1125),
(1284, 'Microsoft Access 2016 Bài 12: UNION Query', 'https://www.youtube.com/watch?v=AgqbXKUVNrA', 704000, 1125),
(1285, 'Microsoft Access 2016 Bài 13: Tìm hiểu REPORT', 'https://www.youtube.com/watch?v=9HBM-AWe8bY', 915000, 1125),
(1286, 'Microsoft Access 2016 Bài 14: REPORT nâng cao', 'https://www.youtube.com/watch?v=EFEPK3_JQIk', 2982000, 1125),
(1287, 'Microsoft Access 2016 Bài 15: REPORT thông dụng', 'https://www.youtube.com/watch?v=Pyuhdzue1Wk', 3707000, 1125),
(1288, 'Microsoft Access 2016 Bài 16: TRANG TRÍ và IN ẤN cho REPORT', 'https://www.youtube.com/watch?v=BaLo6fn-L4E', 800000, 1125),
(1289, 'Microsoft Access 2016 Bài 17: Làm quen với FORM (BIỂU MẪU)', 'https://www.youtube.com/watch?v=c1sR5YLFEmo', 1145000, 1125),
(1290, 'Microsoft Access 2016 Bài 18: Thiết kế FORM', 'https://www.youtube.com/watch?v=KDIOZaW0h08', 2680000, 1125),
(1291, 'Microsoft Access 2016 Bài 19: FORM NÂNG CAO', 'https://www.youtube.com/watch?v=rdVKfi7S4Z4', 2899000, 1125),
(1292, 'Microsoft Access 2016 Bài 20: FORM THƯỜNG DÙNG', 'https://www.youtube.com/watch?v=MfuntJgHBU4', 2724000, 1125),
(1293, 'Microsoft Access 2016 Bài 21: THUỘC TÍNH FORM và MACRO cơ bản', 'https://www.youtube.com/watch?v=DrxgcAMHWqc', 3647000, 1125),
(1294, 'Microsoft Access 2016 Bài 22: NAVIGATION FORM và MENU', 'https://www.youtube.com/watch?v=MzqBuIcFXAg', 2711000, 1125),
(1295, 'Microsoft Access 2016 Bài 23: Tạo FORM HÓA ĐƠN BÁN HÀNG', 'https://www.youtube.com/watch?v=G0Y_SjP5jig', 1251000, 1125),
(1296, 'Microsoft Access 2016 Bài 24: Multi User và DocSo() Function', 'https://www.youtube.com/watch?v=ShVKlmkpCJM', 1067000, 1125),
(1297, 'Microsoft Access 2016 Bài 25: Kết hợp REPORT và FORM', 'https://www.youtube.com/watch?v=WFThMuXl9ik', 1457000, 1125),
(1298, 'Real English For Gamers - Raft: Surviving On The Ocean | First Impressions by Draegast', 'https://www.youtube.com/watch?v=JXw5BvqWabg', 440000, 1126),
(1299, 'Real English For Gamers - Playing With An English Speaker (9-year-old Teams Up With Nick Bunyun!)', 'https://www.youtube.com/watch?v=jMr_qhDYobs', 433000, 1126),
(1300, 'Real English For Gamers - Fun In-Game Conversations (Small Talk)', 'https://www.youtube.com/watch?v=PZP-LinHiFc', 579000, 1126),
(1301, 'Real English For Gamers - What Is Real English? (Gamer Talk VS Classroom Talk)', 'https://www.youtube.com/watch?v=zrc1Ns9lM4Y', 296000, 1126),
(1302, 'What Should I Say? | KTZ Team Meets Foreigner -  Real English For Gamers', 'https://www.youtube.com/watch?v=S3QF1zSK7uU', 198000, 1126),
(1303, 'Alexandria Ocasio-Cortez Plays Among Us! ft. DisguisedToast, Pokimane. Myth, DrLupo, etc. | REFG', 'https://www.youtube.com/watch?v=RWd90si3WzU', 439000, 1126),
(1304, 'Guess The Gamer By His Voice! | English Listening Challenge #1 [REFG]', 'https://www.youtube.com/watch?v=VfkdkN4n4mU', 405000, 1126),
(1305, 'Nick Eh 30 \"teaches\" verb tenses in Fortnite with Travis Scott - Grammar for Gamers | REFG', 'https://www.youtube.com/watch?v=tc9MgHFNvyY', 601000, 1126),
(1306, 'Real English For Gamers - Introducing Cowsep [LoL]', 'https://www.youtube.com/watch?v=cnI5R3-qcj4', 440000, 1126),
(1307, 'Fall Guys For English Learners | Part 1: WINNING and LOSING in Fall Guys! [REFG]', 'https://www.youtube.com/watch?v=GUc0wFxZjYw', 582000, 1126),
(1308, 'Real English For Gamers - Three Australians Vs. Apex Legends! (LazarBeam, Lachlan, Muselk) [Apex]', 'https://www.youtube.com/watch?v=j_z3xmFpeN8', 317000, 1126),
(1309, 'Vulgar Language (The \"F\" Words, etc.) | Real English For Gamers', 'https://www.youtube.com/watch?v=8aL4vr4G9Ug', 211000, 1126),
(1310, 'Among Us For English Learners | Part 2 - What You Need To Say In Among Us: How To Communicate [REFG]', 'https://www.youtube.com/watch?v=k72bZfCVulA', 848000, 1126),
(1311, 'D01 - Giới thiệu và cài đặt Docker trên macOs, Windows, Ubuntu (Linux)', 'https://www.youtube.com/watch?v=r6JiWwh-08c', 567000, 1127),
(1312, 'D02 - Tìm hiểu Docker Image, chạy một Container', 'https://www.youtube.com/watch?v=9Gf4vRYSkK8', 1315000, 1127),
(1313, 'D03 - Lệnh Docker exec,  lưu container thành image với commit, xuất image ra file', 'https://www.youtube.com/watch?v=oNOfBQPcOs0', 705000, 1127),
(1314, 'D04 - Chia sẻ dữ liệu trong Docker, tạo và quản lý ổ đĩa docker volume', 'https://www.youtube.com/watch?v=DSP2-ip38Zw', 1025000, 1127),
(1315, 'D05 - Mạng | Networking trong Docker, tạo và quản lý network trong container Docker', 'https://www.youtube.com/watch?v=k1SwXOxvMdE', 1676000, 1127),
(1316, 'D06 - Cài đặt, tạo và chạy PHP,  phiên bản có PHP-FPM bằng Docker', 'https://www.youtube.com/watch?v=qwofZjKaeMs', 471000, 1127),
(1317, 'D07 - Cài đặt, chạy Apache HTTPD bằng Docker', 'https://www.youtube.com/watch?v=mlvSPV0m5W0', 743000, 1127),
(1318, 'D08 - Cài đặt, chạy MySQL bằng Docker', 'https://www.youtube.com/watch?v=jtjPV8tA5M0', 777000, 1127),
(1319, 'D09 - Cài đặt và chạy WordPress trên Docker', 'https://www.youtube.com/watch?v=qz_XCVKyaGI', 1041000, 1127),
(1320, 'D10 - Tra cứu thông tin Image, Container và giám sát hoạt động container Docker', 'https://www.youtube.com/watch?v=35o1liHCxwY', 697000, 1127),
(1321, 'D11 - Biên tập Dockerfile và sử dụng lệnh docker build để tạo các Image', 'https://www.youtube.com/watch?v=tjyiUPvDFKY', 1122000, 1127),
(1322, 'D12 - Sử dụng lệnh docker-compose chạy và quản lý các dịch vụ Docker', 'https://www.youtube.com/watch?v=6s9VqKyG1Ig', 1754000, 1127),
(1323, 'D13 - Cài đặt MS SQL Server phiên bản Linux trên Docker', 'https://www.youtube.com/watch?v=XKUoPBsfOeQ', 696000, 1127),
(1324, 'D14 - Sử dụng Haproxy làm server cân bằng tải với Docker', 'https://www.youtube.com/watch?v=-l05otgcInM', 1123000, 1127),
(1325, 'D15 -  Sử dụng docker-machine  tạo các Docker Host', 'https://www.youtube.com/watch?v=XPQqRK-lFyo', 1013000, 1127),
(1326, 'D16 - Khởi tạo và quản lý Docker Swarm', 'https://www.youtube.com/watch?v=6a529awrb4Q', 702000, 1127),
(1327, 'D17  - Chạy dịch vụ trên Docker Swarm', 'https://www.youtube.com/watch?v=QcURXYCZSuY', 2709000, 1127),
(1328, 'D18 - Sử dụng docker stack chạy các dịch vụ trên swarm', 'https://www.youtube.com/watch?v=fedUjqpfT0A', 1046000, 1127),
(1329, 'D19 - Mạng Overlay trong Docker Swarm', 'https://www.youtube.com/watch?v=aSQjoCqOx7k', 1686000, 1127),
(1330, 'D20 - Volume các ổ đĩa trong Docker Swarm', 'https://www.youtube.com/watch?v=DFQaj3Omo1E', 2427000, 1127),
(1331, 'K01 - Giới thiệu và cài đặt Kubernetes Cluster', 'https://www.youtube.com/watch?v=yOBeQNGX278', 2445000, 1127),
(1332, 'Real English For Gamers - Raft: Surviving On The Ocean | First Impressions by Draegast', 'https://www.youtube.com/watch?v=JXw5BvqWabg', 440000, 1128),
(1333, 'Real English For Gamers - Playing With An English Speaker (9-year-old Teams Up With Nick Bunyun!)', 'https://www.youtube.com/watch?v=jMr_qhDYobs', 433000, 1128),
(1334, 'Real English For Gamers - Fun In-Game Conversations (Small Talk)', 'https://www.youtube.com/watch?v=PZP-LinHiFc', 579000, 1128),
(1335, 'Real English For Gamers - What Is Real English? (Gamer Talk VS Classroom Talk)', 'https://www.youtube.com/watch?v=zrc1Ns9lM4Y', 296000, 1128),
(1336, 'What Should I Say? | KTZ Team Meets Foreigner -  Real English For Gamers', 'https://www.youtube.com/watch?v=S3QF1zSK7uU', 198000, 1128),
(1337, 'Alexandria Ocasio-Cortez Plays Among Us! ft. DisguisedToast, Pokimane. Myth, DrLupo, etc. | REFG', 'https://www.youtube.com/watch?v=RWd90si3WzU', 439000, 1128),
(1338, 'Guess The Gamer By His Voice! | English Listening Challenge #1 [REFG]', 'https://www.youtube.com/watch?v=VfkdkN4n4mU', 405000, 1128),
(1339, 'Nick Eh 30 \"teaches\" verb tenses in Fortnite with Travis Scott - Grammar for Gamers | REFG', 'https://www.youtube.com/watch?v=tc9MgHFNvyY', 601000, 1128),
(1340, 'Real English For Gamers - Introducing Cowsep [LoL]', 'https://www.youtube.com/watch?v=cnI5R3-qcj4', 440000, 1128),
(1341, 'Fall Guys For English Learners | Part 1: WINNING and LOSING in Fall Guys! [REFG]', 'https://www.youtube.com/watch?v=GUc0wFxZjYw', 582000, 1128),
(1342, 'Real English For Gamers - Three Australians Vs. Apex Legends! (LazarBeam, Lachlan, Muselk) [Apex]', 'https://www.youtube.com/watch?v=j_z3xmFpeN8', 317000, 1128),
(1343, 'Vulgar Language (The \"F\" Words, etc.) | Real English For Gamers', 'https://www.youtube.com/watch?v=8aL4vr4G9Ug', 211000, 1128),
(1344, 'Among Us For English Learners | Part 2 - What You Need To Say In Among Us: How To Communicate [REFG]', 'https://www.youtube.com/watch?v=k72bZfCVulA', 848000, 1128),
(1345, 'TÁC DỤNG CỦA NGỒI MÀ BẠN KHÔNG BIẾT? ', 'https://www.youtube.com/watch?v=mOVghAaLCMI', 57000, 1128),
(1346, '01. Giới thiệu dự án The Band | Thực hành cắt HTML CSS cơ bản | Phân tích giao diện web', 'https://www.youtube.com/watch?v=RPHBgBsw6Xg', 173000, 1129),
(1347, '02. Phân biệt & gọi tên các thành phần', 'https://www.youtube.com/watch?v=b8Z5Cyod9oI', 975000, 1129),
(1348, '03. Phân tích dự án', 'https://www.youtube.com/watch?v=vBWCymyUySw', 452000, 1129),
(1349, '04. Tạo khung dự án The Band | Dựng project base | Khóa học HTML, CSS cơ bản cho người mới bắt đầu', 'https://www.youtube.com/watch?v=IXyLoRZCAco', 616000, 1129),
(1350, '05. Header CSS', 'https://www.youtube.com/watch?v=Dj31dakHAwk', 2030000, 1129),
(1351, '06. Navigation CSS', 'https://www.youtube.com/watch?v=7nSW0GnwcYI', 1726000, 1129),
(1352, '07. Header search CSS', 'https://www.youtube.com/watch?v=bavLlrNZsTw', 1211000, 1129),
(1353, '08. Header fixed CSS', 'https://www.youtube.com/watch?v=iTAxoV0qZ_g', 439000, 1129),
(1354, '09. Slider CSS', 'https://www.youtube.com/watch?v=BmkVXoKoqVA', 1641000, 1129),
(1355, '10. About section CSS', 'https://www.youtube.com/watch?v=lBt7LTM4ISs', 1067000, 1129),
(1356, '11. Team section CSS', 'https://www.youtube.com/watch?v=_sF4fWuE0iM', 847000, 1129),
(1357, '12. Tour tickets CSS', 'https://www.youtube.com/watch?v=ZU_rWZF8a7U', 1167000, 1129),
(1358, '13. Tour places CSS', 'https://www.youtube.com/watch?v=6ab0QDpld50', 1450000, 1129),
(1359, '13.1. Buy Tickets Modal (video bổ sung)', 'https://www.youtube.com/watch?v=7yKMQGE0x5M', 2587000, 1129),
(1360, '13.2. Buy Tickets Modal Javascript Logic (video bổ sung)', 'https://www.youtube.com/watch?v=dQpW4-NzUJc', 1669000, 1129),
(1361, '14. Row - columns layout', 'https://www.youtube.com/watch?v=1iZNZnCcN1Y', 926000, 1129),
(1362, '15. Contact form CSS', 'https://www.youtube.com/watch?v=aKIVRblmz0Y', 1454000, 1129),
(1363, '16. Map & footer CSS', 'https://www.youtube.com/watch?v=7dOdXFD7t6k', 909000, 1129),
(1364, '17. Review', 'https://www.youtube.com/watch?v=u4t8JdDrqYg', 383000, 1129),
(1365, '18. Responsive là gì?', 'https://www.youtube.com/watch?v=71uJhUFR8jM', 350000, 1129),
(1366, '19. Media queries?', 'https://www.youtube.com/watch?v=joTJwyP1ZsA', 938000, 1129),
(1367, '20. Tablet responsive', 'https://www.youtube.com/watch?v=ioOP6hknXxs', 587000, 1129),
(1368, '21. Mobile menu responsive', 'https://www.youtube.com/watch?v=6nw9AWvYrak', 2139000, 1129),
(1369, '22. Mobile menu fix bug', 'https://www.youtube.com/watch?v=2nXupDp91Z4', 757000, 1129),
(1370, '23. Mobile fix bug submenu', 'https://www.youtube.com/watch?v=tl6M4YBNvaI', 1218000, 1129),
(1371, '24. Content responsive', 'https://www.youtube.com/watch?v=wEeGBwiTR0w', 883000, 1129),
(1372, '25. Contact form responsive', 'https://www.youtube.com/watch?v=d6270etxQgY', 822000, 1129),
(1373, '26. Review', 'https://www.youtube.com/watch?v=2aG4eRKe7Io', 1286000, 1129),
(1374, '27. Run and fix bug on mobile', 'https://www.youtube.com/watch?v=Cxi3cHpV238', 1021000, 1129),
(1375, '28. Fix bugs', 'https://www.youtube.com/watch?v=2kquykrrpOs', 1022000, 1129),
(1376, 'WSL01 - Giới thiệu và cài đặt WSL trên Windows', 'https://www.youtube.com/watch?v=Y1Yr10qrOjg', 751000, 1130),
(1377, 'WSL02 - Cài LAMP (Linux Apache MySQL PHP) + Wordpress trên Windows với WSL', 'https://www.youtube.com/watch?v=DdWNG9BKJtY', 961000, 1130),
(1378, 'WSL03 - Cài đặt MySQL Workbench, quản lý MySQL Server trên WSL', 'https://www.youtube.com/watch?v=QK831ZR6eGA', 404000, 1130),
(1379, 'WSL04 - Cài đặt NodeJS trên WSL tạo ứng dụng ExpressJS', 'https://www.youtube.com/watch?v=XRPRdY6otqs', 445000, 1130),
(1380, 'WSL05 - Sử dụng VSC mở dự án trong Linux WSL', 'https://www.youtube.com/watch?v=QeNjUfv0WGc', 240000, 1130),
(1381, 'WSL06 - Cài đặt và chạy Docker trong WSL2 Windows', 'https://www.youtube.com/watch?v=zUoQmIaozc8', 616000, 1131),
(1382, 'SSH02 - Cài đặt OpenSSH trên Windows và kết nối SSH đến Windows Server', 'https://www.youtube.com/watch?v=JCCADhxpTlg', 720000, 1131),
(1383, 'SSH02 - Cài đặt OpenSSH trên Windows và kết nối SSH đến Windows Server', 'https://www.youtube.com/watch?v=JCCADhxpTlg', 720000, 1131),
(1384, 'Form validation (Cách 2)', 'https://www.youtube.com/watch?v=jhvEPY8cEu0', 3687000, 1132),
(1385, 'Form validation (fix vài chỗ)', 'https://www.youtube.com/watch?v=V88PFJNlE-I', 565000, 1132),
(1386, 'Form validation (Cách 2)', 'https://www.youtube.com/watch?v=jhvEPY8cEu0', 3687000, 1133),
(1387, 'Form validation (fix vài chỗ)', 'https://www.youtube.com/watch?v=V88PFJNlE-I', 565000, 1133),
(1388, 'Giới thiệu Windows Terminal & WSL', 'https://www.youtube.com/watch?v=7ppRSaGT1uw', 253000, 1135),
(1389, 'Cài Đặt Windows Terminal | Install Windows Terminal', 'https://www.youtube.com/watch?v=egSxAF-Sak4', 1258000, 1135),
(1390, 'Cài Đặt Ubuntu với WSL 1 | Install WSL 1', 'https://www.youtube.com/watch?v=ypvjxw5qBK0', 677000, 1135),
(1391, '[Lập trình Selenium cơ bản][Bài 1] - Giới thiệu Selenium - HowKteam.com', 'https://www.youtube.com/watch?v=ReyI9VE6Fio', 631000, 1136),
(1392, '[Lập trình Selenium cơ bản][Bài 2] - Thao tác cơ bản với Selenium - HowKteam.com', 'https://www.youtube.com/watch?v=mIDT61KumBk', 1241000, 1136),
(1393, '[Lập trình Selenium cơ bản][Bài 3] - Execute JavaScript với Selenium - HowKteam', 'https://www.youtube.com/watch?v=yESTl1JCnEE', 450000, 1136),
(1394, '[Lập trình Selenium cơ bản][Bài 4] - WebElement với Selenium -  HowKteam', 'https://www.youtube.com/watch?v=wAkoF98N0VU', 326000, 1136),
(1395, '[Lập trình Selenium cơ bản][Bài 5] - XPath với Selenium -  HowKteam', 'https://www.youtube.com/watch?v=rS1RkoRmrCY', 406000, 1136),
(1396, '[Lập trình Selenium cơ bản][Bài 6] - Profile với Selenium - HowKteam', 'https://www.youtube.com/watch?v=7pZaIVWxOAs', 573000, 1136),
(1397, '[Lập trình Selenium cơ bản][Bài 7] - Proxy và Fake IP với Selenium - HowKteam', 'https://www.youtube.com/watch?v=AlpT_iY0CR0', 656000, 1137),
(1398, '[Lập trình Selenium cơ bản][Bài 8] - Turn off WebRTTC với Selenium - HowKteam.com', 'https://www.youtube.com/watch?v=mtd3H7CqGvI', 385000, 1137),
(1399, '[Lập trình Selenium cơ bản][Bài 9] - Change Frame với Selenium - HowKteam.com', 'https://www.youtube.com/watch?v=25EzCl-PTc4', 411000, 1137),
(1400, '[Lập trình Selenium cơ bản][Bài 10] - Upload file với Selenium - HowKteam.com', 'https://www.youtube.com/watch?v=0WxBSWQ1BOw', 629000, 1137),
(1401, '[Lập trình Selenium cơ bản][Bài 11] - Profile và Proxy với user name và password- HowKteam.com', 'https://www.youtube.com/watch?v=d8iE5F0wOsE', 1350000, 1137),
(1402, 'Sau Lời Nói Anh Còn Yêu Em Remix - Hoa Trên Giấy Không Sương Hoa Vẫn Nở - Hoa Tàn Tình Tan Remix', 'https://www.youtube.com/watch?v=hFsKIFRBrZM', 5030000, 1137),
(1403, 'D01 - Giới thiệu và cài đặt Docker trên macOs, Windows, Ubuntu (Linux)', 'https://www.youtube.com/watch?v=r6JiWwh-08c', 567000, 1138),
(1404, 'D02 - Tìm hiểu Docker Image, chạy một Container', 'https://www.youtube.com/watch?v=9Gf4vRYSkK8', 1315000, 1138),
(1405, 'D03 - Lệnh Docker exec,  lưu container thành image với commit, xuất image ra file', 'https://www.youtube.com/watch?v=oNOfBQPcOs0', 705000, 1138),
(1406, 'D04 - Chia sẻ dữ liệu trong Docker, tạo và quản lý ổ đĩa docker volume', 'https://www.youtube.com/watch?v=DSP2-ip38Zw', 1025000, 1138),
(1407, 'D05 - Mạng | Networking trong Docker, tạo và quản lý network trong container Docker', 'https://www.youtube.com/watch?v=k1SwXOxvMdE', 1676000, 1138),
(1408, 'D06 - Cài đặt, tạo và chạy PHP,  phiên bản có PHP-FPM bằng Docker', 'https://www.youtube.com/watch?v=qwofZjKaeMs', 471000, 1138),
(1409, 'D07 - Cài đặt, chạy Apache HTTPD bằng Docker', 'https://www.youtube.com/watch?v=mlvSPV0m5W0', 743000, 1138),
(1410, 'D08 - Cài đặt, chạy MySQL bằng Docker', 'https://www.youtube.com/watch?v=jtjPV8tA5M0', 777000, 1138),
(1411, 'D09 - Cài đặt và chạy WordPress trên Docker', 'https://www.youtube.com/watch?v=qz_XCVKyaGI', 1041000, 1138),
(1412, 'D10 - Tra cứu thông tin Image, Container và giám sát hoạt động container Docker', 'https://www.youtube.com/watch?v=35o1liHCxwY', 697000, 1138),
(1413, 'D11 - Biên tập Dockerfile và sử dụng lệnh docker build để tạo các Image', 'https://www.youtube.com/watch?v=tjyiUPvDFKY', 1122000, 1138),
(1414, 'D12 - Sử dụng lệnh docker-compose chạy và quản lý các dịch vụ Docker', 'https://www.youtube.com/watch?v=6s9VqKyG1Ig', 1754000, 1138),
(1415, 'D13 - Cài đặt MS SQL Server phiên bản Linux trên Docker', 'https://www.youtube.com/watch?v=XKUoPBsfOeQ', 696000, 1138),
(1416, 'D14 - Sử dụng Haproxy làm server cân bằng tải với Docker', 'https://www.youtube.com/watch?v=-l05otgcInM', 1123000, 1138),
(1417, 'D15 -  Sử dụng docker-machine  tạo các Docker Host', 'https://www.youtube.com/watch?v=XPQqRK-lFyo', 1013000, 1138),
(1418, 'D16 - Khởi tạo và quản lý Docker Swarm', 'https://www.youtube.com/watch?v=6a529awrb4Q', 702000, 1138),
(1419, 'D17  - Chạy dịch vụ trên Docker Swarm', 'https://www.youtube.com/watch?v=QcURXYCZSuY', 2709000, 1138),
(1420, 'D18 - Sử dụng docker stack chạy các dịch vụ trên swarm', 'https://www.youtube.com/watch?v=fedUjqpfT0A', 1046000, 1138),
(1421, 'D19 - Mạng Overlay trong Docker Swarm', 'https://www.youtube.com/watch?v=aSQjoCqOx7k', 1686000, 1138),
(1422, 'D20 - Volume các ổ đĩa trong Docker Swarm', 'https://www.youtube.com/watch?v=DFQaj3Omo1E', 2427000, 1138),
(1423, 'K01 - Giới thiệu và cài đặt Kubernetes Cluster', 'https://www.youtube.com/watch?v=yOBeQNGX278', 2445000, 1138),
(1424, 'Top 30 Nhạc Trẻ Remix Nghe Nhiều Nhất Hiện Nay - Kẹo Bông Gòn Remix, Níu Duyên Remix, Thế Thái Remix', 'https://www.youtube.com/watch?v=b05ZfunJXx4', 7379000, 1138),
(1425, 'Ra mắt khóa Javascript nâng cao (javascript advanced) tại F8!', 'https://www.youtube.com/watch?v=MGhw6XliFgo', 108000, 1139),
(1426, 'IIFE trong Javascript là gì? Hiểu IIFE cùng F8 nha!', 'https://www.youtube.com/watch?v=N-3GU1F1UBY', 1437000, 1139),
(1427, 'Scope trong Javascript? Hiểu thật rõ về phạm vi nào!', 'https://www.youtube.com/watch?v=5N8vz_VmszE', 2187000, 1139),
(1428, 'Closure trong Javascript có phải là cái gì \"kinh khủng\"?', 'https://www.youtube.com/watch?v=xtQtGKL0NCI', 2451000, 1139),
(1429, 'Hoisting trong Javascript? Let, const có được hoisted hay không?', 'https://www.youtube.com/watch?v=3MLhU1DrUxM', 658000, 1139),
(1430, '\"use strict\" hay strict mode trong Javascript?', 'https://www.youtube.com/watch?v=w1W-j4cSPF0', 845000, 1139),
(1431, 'Primitive Types & Reference Types trong Javascript', 'https://www.youtube.com/watch?v=n4tS1Q5-EzY', 1915000, 1139),
(1432, 'Từ khóa \"this\" trong Javascript? Dễ hiểu cùng F8 nào!', 'https://www.youtube.com/watch?v=ii1Ra_zLDIo', 1501000, 1139),
(1433, 'Fn.bind() method P1? Học rồi thì xem lại cho chắc nha!', 'https://www.youtube.com/watch?v=F5z6YoR8of0', 880000, 1139),
(1434, 'Fn.bind() method P2? Thêm vài ví dụ \"khó\" hơn nào!', 'https://www.youtube.com/watch?v=6j9b2_E34JM', 1413000, 1139),
(1435, 'Fn.call() method trong Javascript?', 'https://www.youtube.com/watch?v=QxLTSdTJDXY', 1221000, 1139),
(1436, 'Fn.apply() method trong Javascript?', 'https://www.youtube.com/watch?v=a4FjX4Z-9Rs', 979000, 1139),
(1437, 'SSH01 - Giới thiệu về SSH - Sử dụng SSH - kết nối cơ bản đến VPS', 'https://www.youtube.com/watch?v=x20NiW2BM3Y', 1027000, 1140),
(1438, 'SSH02 - Cài đặt OpenSSH trên Windows và kết nối SSH đến Windows Server', 'https://www.youtube.com/watch?v=JCCADhxpTlg', 720000, 1140),
(1439, 'SSH03 - Lệnh SCP (secure copy), upload và download các file tới Server bằng giao thức SSH', 'https://www.youtube.com/watch?v=_EDwRTFBNKs', 555000, 1140),
(1440, 'SSH04 - SSH Key, phát sinh SSH Key và cấu hình xác thực bằng SSH Key', 'https://www.youtube.com/watch?v=JrhZOrvJ8Vs', 1043000, 1140),
(1441, 'SSH05 - Sử dụng SFTP Client để truyền file (upload, download) giữa máy trạm và Server', 'https://www.youtube.com/watch?v=LBuILU5zeTQ', 306000, 1140),
(1442, 'SSH06 - Gắn hệ thống file Server vào máy local bằng SSHFS, FUSE, WinFSP', 'https://www.youtube.com/watch?v=Bpi8STT6MqY', 603000, 1141),
(1443, 'SSH07 - Lệnh RSYNC đồng bộ thư mục, copy thư mục, file giữa máy local và máy server', 'https://www.youtube.com/watch?v=rCvsIhg-CFc', 797000, 1141),
(1444, 'SSH08 -  Phát sinh SSH Key và cấu hình GitHub, GitLab sử dụng SSH Key', 'https://www.youtube.com/watch?v=oMq37ermHJg', 330000, 1141),
(1445, 'SSH10 - Tạo Sock SSH, Fake IP và chuyển hướng cổng', 'https://www.youtube.com/watch?v=5B3-IUjBsM4', 515000, 1141);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `NOTI_ID` smallint(6) NOT NULL,
  `USER_ID` smallint(6) DEFAULT NULL,
  `CONTENT` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `READ_STATE` tinyint(1) DEFAULT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`NOTI_ID`, `USER_ID`, `CONTENT`, `READ_STATE`, `CREATED_AT`) VALUES
(1111, 1113, 'Chúc mừng khóa học  Sử dụng Git, GitHub và GitLab của bạn đã được duyệt!', 1, '2021-12-19 08:58:44'),
(1112, 1113, 'Chúc mừng khóa học C# Cơ bản của bạn đã được duyệt!', 1, '2021-12-19 09:18:22'),
(1113, 1113, 'Chúc mừng khóa học Lập trình Android - Java của bạn đã được duyệt!', 1, '2021-12-20 03:02:10'),
(1114, 1114, 'Chúc mừng khóa học Excel của bạn đã được duyệt!', 1, '2021-12-20 03:34:42'),
(1115, 1114, 'Chúc mừng khóa học PowerPoint của bạn đã được duyệt!', 1, '2021-12-20 03:41:15'),
(1116, 1114, 'Chúc mừng khóa học Word 2016 của bạn đã được duyệt!', 1, '2021-12-20 03:59:22'),
(1117, 1114, 'Chúc mừng khóa học Access 2016 của bạn đã được duyệt!', 1, '2021-12-20 04:35:53'),
(1118, 1114, 'Khóa học Word 2016 đã bị khóa với lý do: Bản quyền', 1, '2021-12-20 06:29:07'),
(1119, 1114, 'Khóa học Word 2016 đã được mở khóa', 1, '2021-12-20 06:29:30'),
(1120, 1112, 'Chúc mừng khóa học Học tiếng Anh qua game của bạn đã được duyệt!', 1, '2021-12-20 08:03:39'),
(1121, 1113, 'Chúc mừng khóa học Docker của bạn đã được duyệt!', 1, '2021-12-20 08:25:45'),
(1122, 1112, 'Khóa học Học tiếng Anh qua game đã bị từ chối với lý do: Không hợp lệ', 1, '2021-12-20 14:29:35'),
(1123, 1112, 'Khóa học Học tiếng Anh qua game đã bị khóa với lý do: Nội dung không phù hợp', 1, '2021-12-20 14:39:13'),
(1124, 1118, 'Chúc mừng khóa học Cắt HTML, CSS Web The Band của bạn đã được duyệt!', 1, '2021-12-21 01:06:21'),
(1125, 1113, 'Chúc mừng khóa học Quản trị Windows của bạn đã được duyệt!', 1, '2021-12-21 02:57:19'),
(1126, 1113, 'Khóa học Git, GitHub và GitLab đã bị khóa với lý do: Nội dung không phù hợp', 1, '2021-12-21 02:59:36'),
(1127, 1113, 'Khóa học Git, GitHub và GitLab đã được mở khóa', 1, '2021-12-21 03:00:01'),
(1131, 1112, 'Khóa học Học tiếng Anh qua gameđã bị khóa với lý do: không hợp lệ', 0, '2022-01-12 03:27:11'),
(1132, 1112, 'Chúc mừng khóa học aaababa của bạn đã được duyệt', 0, '0000-00-00 00:00:00'),
(1133, 1112, 'Khóa học aaababa đã bị khóa với lý do: không hợp lệ', 0, '2022-01-12 12:22:39'),
(1134, 1121, 'Chúc mừng khóa học [CSharp] Lập trình Selenium với C# - WPF  của bạn đã được duyệt', 1, '0000-00-00 00:00:00'),
(1135, 1121, 'Khóa học Lập trình Selenium với C# - WPF  đã bị khóa với lý do: Test hệ thống', 1, '2022-01-12 15:09:02'),
(1136, 1121, 'Khóa học Lập trình Selenium với C# - WPF  đã được mở khóa: ', 1, '2022-01-12 15:09:18'),
(1137, 1112, 'Chúc mừng yêu cầu chỉnh sửa khóa học Học tiếng Anh qua game của bạn đã được duyệt', 0, '0000-00-00 00:00:00'),
(1138, 1113, 'Khóa học Docker đã bị từ chối với lý do: không phù hợp', 1, '0000-00-00 00:00:00'),
(1139, 1118, 'Chúc mừng khóa học Javascript nâng cao của bạn đã được duyệt', 1, '0000-00-00 00:00:00'),
(1140, 1113, 'Khóa học Docker đã bị khóa với lý do: Kiểm thử hệ thống', 1, '2022-01-13 08:59:15'),
(1141, 1113, 'Khóa học Docker đã được mở khóa: ', 1, '2022-01-13 08:59:35'),
(1142, 1113, 'Chúc mừng yêu cầu chỉnh sửa khóa học Quản trị Windows của bạn đã được duyệt', 1, '2022-01-13 10:54:09'),
(1143, 1113, 'Chúc mừng khóa học Sử dụng SSH của bạn đã được duyệt', 0, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `PAYMENT_ID` smallint(6) NOT NULL,
  `USER_ID` smallint(6) DEFAULT NULL,
  `RECEIVER_ID` smallint(6) DEFAULT NULL,
  `AMOUNT` bigint(20) DEFAULT NULL,
  `ENROLLMENT_ID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`PAYMENT_ID`, `USER_ID`, `RECEIVER_ID`, `AMOUNT`, `ENROLLMENT_ID`) VALUES
(1111, 1112, 1111, 14000, 1111),
(1112, 1112, 1113, 6000, 1111),
(1113, 1112, 1111, 35000, 1112),
(1114, 1112, 1113, 15000, 1112),
(1115, 1114, 1111, 4000, 1113),
(1116, 1114, 1113, 16000, 1113),
(1117, 1114, 1111, 10000, 1114),
(1118, 1114, 1113, 40000, 1114),
(1119, 1113, 1111, 0, 1115),
(1120, 1113, 1114, 0, 1115),
(1121, 1115, 1111, 4000, 1116),
(1122, 1115, 1113, 16000, 1116),
(1123, 1115, 1111, 10000, 1117),
(1124, 1115, 1113, 40000, 1117),
(1125, 1115, 1111, 16000, 1118),
(1126, 1115, 1113, 64000, 1118),
(1127, 1115, 1111, 0, 1119),
(1128, 1115, 1114, 0, 1119),
(1129, 1115, 1111, 0, 1120),
(1130, 1115, 1114, 0, 1120),
(1131, 1113, 1111, 0, 1121),
(1132, 1113, 1114, 0, 1121),
(1133, 1113, 1111, 0, 1122),
(1134, 1113, 1114, 0, 1122),
(1135, 1115, 1111, 6000, 1123),
(1136, 1115, 1112, 24000, 1123),
(1137, 1117, 1111, 0, 1124),
(1138, 1117, 1114, 0, 1124),
(1139, 1117, 1111, 6000, 1125),
(1140, 1117, 1112, 24000, 1125),
(1141, 1117, 1111, 0, 1126),
(1142, 1117, 1114, 0, 1126),
(1143, 1117, 1111, 0, 1127),
(1144, 1117, 1114, 0, 1127),
(1145, 1113, 1111, 10000, 1128),
(1146, 1113, 1118, 40000, 1128),
(1147, 1121, 1111, 4000, 1129),
(1148, 1121, 1113, 16000, 1129),
(1149, 1118, 1111, 4000, 1130),
(1150, 1118, 1113, 16000, 1130),
(1151, 1113, 1111, 6000, 1131),
(1152, 1113, 1118, 24000, 1131),
(1153, 1113, 1111, 10000, 1132),
(1154, 1113, 1121, 40000, 1132);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `USER_ID` smallint(6) NOT NULL,
  `FULLNAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE_OF_BIRTH` date DEFAULT NULL,
  `EMAIL` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COIN` bigint(20) DEFAULT 0,
  `PHONE` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FACEBOOK` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LINKEDLN` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SCHOOL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AVATAR_IMG` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BACKGROUND_IMG` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BIO` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CITY_ID` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`USER_ID`, `FULLNAME`, `DATE_OF_BIRTH`, `EMAIL`, `COIN`, `PHONE`, `FACEBOOK`, `LINKEDLN`, `SCHOOL`, `AVATAR_IMG`, `BACKGROUND_IMG`, `BIO`, `CITY_ID`) VALUES
(1111, 'admin', NULL, 'truongthang2211@gmail.com', 139000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1112, 'Nguyễn Ảnh Trường Thắng', '2001-11-22', '19522204@gm.uit.edu.vn', 58000, '0812459026', 'https://www.facebook.com/truongthang2211/', NULL, 'Đại học Công Nghệ Thông Tin - Đại học Quốc Gia TPHCM', 'img/user/avatar/1642042516.jpg', 'img/user/background/1642050654.png', 'Rồi ai cũng khát', 1),
(1113, 'Xuân Thu', '2022-01-07', 'xuanthulab@gmail.com', 179000, NULL, NULL, NULL, NULL, NULL, NULL, 'Ai rồi cũng khát', NULL),
(1114, 'Huynh', '2001-02-01', 'thu@gmail.com', 130000, '0123456789', 'https://www.facebook.com/thuw.huynh', NULL, NULL, 'img/user/avatar/1639970231.png', NULL, NULL, NULL),
(1115, 'Thư', '2001-02-02', 'minhthu@gmail.com', 20000, '0123456788', NULL, NULL, 'Đại học Công nghệ thông tin - ĐHQG TPHCM', NULL, NULL, NULL, 8),
(1116, 'xuanson', '2001-06-13', 'xuanson@gmail.com', 200000, '0816465788', 'https://unica.vn/', NULL, 'Đại học UIT', 'img/user/avatar/1640011309.png', NULL, 'Love December especially 23nd.', 1),
(1117, 'thangfanboy', NULL, 'BrianNguyen811@gmail.com', 20000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1118, 'sondang', NULL, 'sondang@gmail.com', 44000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1119, 'nguyenvana', NULL, 'nguyenvana@gmail.com', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1120, 'nguyencuong', NULL, 'nguyencuong@gmail.com', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1121, 'KTeam', '2022-01-05', 'howkteam@gmail.com', 220000, '', NULL, NULL, NULL, 'img/user/avatar/1642041839.png', NULL, 'em dep lam', NULL),
(1122, 'nguoitinhtrongmong', NULL, 'nguoitinh@gmail.com', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1123, 'nguyenthang2211', NULL, 'nguyenthang2211@gmail.com', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`ACCOUNT_ID`),
  ADD UNIQUE KEY `ACCOUNT_ID` (`ACCOUNT_ID`),
  ADD UNIQUE KEY `USERNAME` (`USERNAME`),
  ADD KEY `FK_ACCOUNTS_USERS` (`USER_ID`);

--
-- Indexes for table `approvals`
--
ALTER TABLE `approvals`
  ADD PRIMARY KEY (`APPROVAL_ID`),
  ADD UNIQUE KEY `APPROVAL_ID` (`APPROVAL_ID`),
  ADD KEY `FK_APPROVALS_COURSES` (`COURSE_ID`),
  ADD KEY `FK_APPROVALS_USERS` (`APPROVER_ID`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`CITY_ID`),
  ADD UNIQUE KEY `CITY_ID` (`CITY_ID`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`COMMENT_ID`),
  ADD UNIQUE KEY `COMMENT_ID` (`COMMENT_ID`),
  ADD KEY `FK_COMMENTS_USERS` (`USER_ID`),
  ADD KEY `FK_COMMENTS_LESSONS` (`LESSON_ID`);

--
-- Indexes for table `comment_votes`
--
ALTER TABLE `comment_votes`
  ADD PRIMARY KEY (`USER_ID`,`COMMENT_ID`),
  ADD KEY `FK_CMVOTES_COMMENTS` (`COMMENT_ID`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`COURSE_ID`),
  ADD UNIQUE KEY `COURSE_ID` (`COURSE_ID`),
  ADD KEY `FK_COURSES_USERS` (`AUTHOR_ID`),
  ADD KEY `FK_COURSES_SUBTYPES` (`COURSE_TYPE_ID`);

--
-- Indexes for table `course_chapters`
--
ALTER TABLE `course_chapters`
  ADD PRIMARY KEY (`COURSE_CHAPTER_ID`),
  ADD UNIQUE KEY `COURSE_CHAPTER_ID` (`COURSE_CHAPTER_ID`),
  ADD KEY `FK_CCHAPTERS_COURSES` (`COURSE_ID`);

--
-- Indexes for table `course_gains`
--
ALTER TABLE `course_gains`
  ADD PRIMARY KEY (`COURSE_GAIN_ID`),
  ADD KEY `FK_CGAINS_COURSES` (`COURSE_ID`);

--
-- Indexes for table `course_maintypes`
--
ALTER TABLE `course_maintypes`
  ADD PRIMARY KEY (`COURSE_MAINTYPE_ID`),
  ADD UNIQUE KEY `COURSE_MAINTYPE_ID` (`COURSE_MAINTYPE_ID`);

--
-- Indexes for table `course_requires`
--
ALTER TABLE `course_requires`
  ADD PRIMARY KEY (`COURSE_REQUIRE_ID`),
  ADD UNIQUE KEY `COURSE_REQUIRE_ID` (`COURSE_REQUIRE_ID`),
  ADD KEY `FK_CREQUIRES_COURSES` (`COURSE_ID`);

--
-- Indexes for table `course_reviews`
--
ALTER TABLE `course_reviews`
  ADD PRIMARY KEY (`USER_ID`,`COURSE_ID`),
  ADD KEY `FK_CREVIEWS_COURSES` (`COURSE_ID`);

--
-- Indexes for table `course_subtypes`
--
ALTER TABLE `course_subtypes`
  ADD PRIMARY KEY (`COURSE_SUBTYPE_ID`),
  ADD UNIQUE KEY `COURSE_SUBTYPE_ID` (`COURSE_SUBTYPE_ID`),
  ADD KEY `FK_SUBTYPES_MAINTYPES` (`PARENT_TYPE_ID`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`ENROLLMENT_ID`),
  ADD UNIQUE KEY `ENROLLMENT_ID` (`ENROLLMENT_ID`),
  ADD KEY `FK_ENROLLMENTS_USERS` (`USER_ID`),
  ADD KEY `FK_ENROLLMENTS_COURSES` (`COURSE_ID`);

--
-- Indexes for table `learnings`
--
ALTER TABLE `learnings`
  ADD PRIMARY KEY (`USER_ID`,`LESSON_ID`),
  ADD KEY `FK_LEARNINGS_LESSONS` (`LESSON_ID`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`LESSON_ID`),
  ADD UNIQUE KEY `LESSON_ID` (`LESSON_ID`),
  ADD KEY `FK_LESSONS_CHAPTERS` (`CHAPTER_ID`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`NOTI_ID`),
  ADD UNIQUE KEY `NOTI_ID` (`NOTI_ID`),
  ADD KEY `FK_NOTIFICATIONS_USERS` (`USER_ID`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`PAYMENT_ID`),
  ADD UNIQUE KEY `PAYMENT_ID` (`PAYMENT_ID`),
  ADD KEY `FK_PAYMENTS_SENDER` (`USER_ID`),
  ADD KEY `FK_PAYMENTS_RECEIVER` (`RECEIVER_ID`),
  ADD KEY `FK_PAYMENTS_ENROLLMENTS` (`ENROLLMENT_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`USER_ID`),
  ADD UNIQUE KEY `USER_ID` (`USER_ID`),
  ADD UNIQUE KEY `EMAIL` (`EMAIL`),
  ADD UNIQUE KEY `PHONE` (`PHONE`),
  ADD KEY `FK_USERS_CITIES` (`CITY_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `ACCOUNT_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1124;

--
-- AUTO_INCREMENT for table `approvals`
--
ALTER TABLE `approvals`
  MODIFY `APPROVAL_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1132;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `CITY_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1111;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `COMMENT_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1123;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `COURSE_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1131;

--
-- AUTO_INCREMENT for table `course_chapters`
--
ALTER TABLE `course_chapters`
  MODIFY `COURSE_CHAPTER_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1142;

--
-- AUTO_INCREMENT for table `course_gains`
--
ALTER TABLE `course_gains`
  MODIFY `COURSE_GAIN_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1153;

--
-- AUTO_INCREMENT for table `course_maintypes`
--
ALTER TABLE `course_maintypes`
  MODIFY `COURSE_MAINTYPE_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1124;

--
-- AUTO_INCREMENT for table `course_requires`
--
ALTER TABLE `course_requires`
  MODIFY `COURSE_REQUIRE_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1132;

--
-- AUTO_INCREMENT for table `course_subtypes`
--
ALTER TABLE `course_subtypes`
  MODIFY `COURSE_SUBTYPE_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1198;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `ENROLLMENT_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1133;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `LESSON_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1446;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `NOTI_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1144;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `PAYMENT_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1155;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `USER_ID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1124;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `FK_ACCOUNTS_USERS` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `approvals`
--
ALTER TABLE `approvals`
  ADD CONSTRAINT `FK_APPROVALS_COURSES` FOREIGN KEY (`COURSE_ID`) REFERENCES `courses` (`COURSE_ID`),
  ADD CONSTRAINT `FK_APPROVALS_USERS` FOREIGN KEY (`APPROVER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `FK_COMMENTS_LESSONS` FOREIGN KEY (`LESSON_ID`) REFERENCES `lessons` (`LESSON_ID`),
  ADD CONSTRAINT `FK_COMMENTS_USERS` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `comment_votes`
--
ALTER TABLE `comment_votes`
  ADD CONSTRAINT `FK_CMVOTES_COMMENTS` FOREIGN KEY (`COMMENT_ID`) REFERENCES `comments` (`COMMENT_ID`),
  ADD CONSTRAINT `FK_CMVOTES_USERS` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `FK_COURSES_SUBTYPES` FOREIGN KEY (`COURSE_TYPE_ID`) REFERENCES `course_subtypes` (`COURSE_SUBTYPE_ID`),
  ADD CONSTRAINT `FK_COURSES_USERS` FOREIGN KEY (`AUTHOR_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `course_chapters`
--
ALTER TABLE `course_chapters`
  ADD CONSTRAINT `FK_CCHAPTERS_COURSES` FOREIGN KEY (`COURSE_ID`) REFERENCES `courses` (`COURSE_ID`);

--
-- Constraints for table `course_gains`
--
ALTER TABLE `course_gains`
  ADD CONSTRAINT `FK_CGAINS_COURSES` FOREIGN KEY (`COURSE_ID`) REFERENCES `courses` (`COURSE_ID`);

--
-- Constraints for table `course_requires`
--
ALTER TABLE `course_requires`
  ADD CONSTRAINT `FK_CREQUIRES_COURSES` FOREIGN KEY (`COURSE_ID`) REFERENCES `courses` (`COURSE_ID`);

--
-- Constraints for table `course_reviews`
--
ALTER TABLE `course_reviews`
  ADD CONSTRAINT `FK_CREVIEWS_COURSES` FOREIGN KEY (`COURSE_ID`) REFERENCES `courses` (`COURSE_ID`),
  ADD CONSTRAINT `FK_CREVIEWS_USERS` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `course_subtypes`
--
ALTER TABLE `course_subtypes`
  ADD CONSTRAINT `FK_SUBTYPES_MAINTYPES` FOREIGN KEY (`PARENT_TYPE_ID`) REFERENCES `course_maintypes` (`COURSE_MAINTYPE_ID`);

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `FK_ENROLLMENTS_COURSES` FOREIGN KEY (`COURSE_ID`) REFERENCES `courses` (`COURSE_ID`),
  ADD CONSTRAINT `FK_ENROLLMENTS_USERS` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `learnings`
--
ALTER TABLE `learnings`
  ADD CONSTRAINT `FK_LEARNINGS_LESSONS` FOREIGN KEY (`LESSON_ID`) REFERENCES `lessons` (`LESSON_ID`),
  ADD CONSTRAINT `FK_LEARNINGS_USERS` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `FK_LESSONS_CHAPTERS` FOREIGN KEY (`CHAPTER_ID`) REFERENCES `course_chapters` (`COURSE_CHAPTER_ID`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `FK_NOTIFICATIONS_USERS` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `FK_PAYMENTS_ENROLLMENTS` FOREIGN KEY (`ENROLLMENT_ID`) REFERENCES `enrollments` (`ENROLLMENT_ID`),
  ADD CONSTRAINT `FK_PAYMENTS_RECEIVER` FOREIGN KEY (`RECEIVER_ID`) REFERENCES `users` (`USER_ID`),
  ADD CONSTRAINT `FK_PAYMENTS_SENDER` FOREIGN KEY (`USER_ID`) REFERENCES `enrollments` (`USER_ID`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_USERS_CITIES` FOREIGN KEY (`CITY_ID`) REFERENCES `cities` (`CITY_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
