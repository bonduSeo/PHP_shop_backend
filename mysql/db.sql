-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.7-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- shop 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `shop`;

-- 테이블 shop.t_category 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate1` varchar(100) NOT NULL DEFAULT '',
  `cate2` varchar(100) NOT NULL DEFAULT '',
  `cate3` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 shop.t_category:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_category` DISABLE KEYS */;
INSERT IGNORE INTO `t_category` (`id`, `cate1`, `cate2`, `cate3`) VALUES
	(1, '전자제품', '컴퓨터', '악세사리'),
	(2, '전자제품', '컴퓨터', '노트북'),
	(3, '전자제품', '컴퓨터', '조립식'),
	(4, '전자제품', '가전제품', '텔레비전'),
	(5, '전자제품', '가전제품', '냉장고'),
	(6, '생필품', '주방용품', '조리도구');
/*!40000 ALTER TABLE `t_category` ENABLE KEYS */;

-- 테이블 shop.t_product 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(200) NOT NULL DEFAULT '',
  `product_price` int(11) NOT NULL DEFAULT 0,
  `delivery_price` int(11) NOT NULL DEFAULT 0,
  `add_delivery_price` int(11) DEFAULT 0,
  `tags` varchar(100) DEFAULT NULL,
  `outbound_days` int(11) NOT NULL DEFAULT 5,
  `seller_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `active_yn` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `t_seller` (`id`),
  CONSTRAINT `t_product_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `t_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 shop.t_product:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_product` ENABLE KEYS */;

-- 테이블 shop.t_product_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_product_img` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1-섬네일, 2-제품이미지, 3-제품설명이미지',
  `path` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `t_product_img_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 shop.t_product_img:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_product_img` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_product_img` ENABLE KEYS */;

-- 테이블 shop.t_seller 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_seller` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 shop.t_seller:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_seller` DISABLE KEYS */;
INSERT IGNORE INTO `t_seller` (`id`, `NAME`, `email`, `phone`) VALUES
	(1, '테스트', 'mic@mic.com', '010-0000-1111');
/*!40000 ALTER TABLE `t_seller` ENABLE KEYS */;

-- 테이블 shop.t_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_user` (
  `iuser` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `social_type` int(10) unsigned NOT NULL COMMENT '0-local, 1-kakao, 2-naver, 3-google, 4-github, 5-facebook',
  `email` varchar(50) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1-buyer, 2-seller',
  `nickname` varchar(50) DEFAULT NULL,
  `profile_img` varchar(100) DEFAULT NULL,
  `thumb_img` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`iuser`),
  UNIQUE KEY `social_type` (`social_type`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 shop.t_user:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT IGNORE INTO `t_user` (`iuser`, `social_type`, `email`, `type`, `nickname`, `profile_img`, `thumb_img`, `created_at`, `updated_at`) VALUES
	(1, 1, 'mic1@mic.com', 1, '홍길동1', '이미지1', '이미지2', '2022-07-18 10:34:16', '2022-07-18 10:34:18'),
	(2, 1, 'mic2@mic.com', 1, '홍길동2', '이미지1', '이미지2', '2022-07-18 10:34:29', '2022-07-18 10:34:29'),
	(3, 1, 'pkd1426@naver.com', 1, '박경도', 'http://k.kakaocdn.net/dn/k6c9n/btrF4hA42wj/A4IcwR7Y1BBiFTYsjill01/img_640x640.jpg', 'http://k.kakaocdn.net/dn/k6c9n/btrF4hA42wj/A4IcwR7Y1BBiFTYsjill01/img_110x110.jpg', '2022-07-18 11:18:49', '2022-07-18 17:02:44');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
