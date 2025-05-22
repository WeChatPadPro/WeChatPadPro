SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for device_info_entity
-- ----------------------------
DROP TABLE IF EXISTS `device_info_entity`;
CREATE TABLE `device_info_entity` (
  `wxid` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `uuidone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uuidtwo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imei` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deviceid` varbinary(255) DEFAULT NULL,
  `devicename` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `language` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `devicebrand` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `realcountry` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `iphonever` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `boudleid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ostype` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `adsource` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ostypenumber` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `corecount` int unsigned DEFAULT NULL,
  `carriername` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `softtypexml` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `clientcheckdataxml` varchar(4096) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `guid2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`wxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for license_key
-- ----------------------------
DROP TABLE IF EXISTS `license_key`;
CREATE TABLE `license_key` (
  `id` int NOT NULL AUTO_INCREMENT,
  `device_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` int DEFAULT NULL,
  `license` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expiry_date` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `wx_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nick_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for user_business_log
-- ----------------------------
DROP TABLE IF EXISTS `user_business_log`;
CREATE TABLE `user_business_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `business_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ex_result` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for user_info_entity
-- ----------------------------
DROP TABLE IF EXISTS `user_info_entity`;
CREATE TABLE `user_info_entity` (
  `targetIp` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uin` int unsigned DEFAULT NULL,
  `wxId` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `userName` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `headurl` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cookie` varbinary(255) DEFAULT NULL,
  `sessionKey` varbinary(255) DEFAULT NULL,
  `shorthost` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longhost` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ecpukey` varbinary(255) DEFAULT NULL,
  `ecprkey` varbinary(255) DEFAULT NULL,
  `checksumkey` varbinary(255) DEFAULT NULL,
  `autoauthkey` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` int DEFAULT NULL,
  `synckey` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `favsynckey` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login_rsa_ver` int unsigned DEFAULT NULL,
  `err_msg` text COLLATE utf8mb4_general_ci,
  `device_create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_auth_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wxId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log` (
  `targetIp` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `u_uid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nick_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ret_code` int DEFAULT NULL,
  `err_msg` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
