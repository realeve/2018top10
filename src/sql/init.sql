/*
 Navicat Premium Data Transfer

 Source Server         : RDS_PUBLIC
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : rm-m5ew9z2tfz4r61x00qo.mysql.rds.aliyuncs.com:3306
 Source Schema         : weixin

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 03/02/2019 10:08:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_cbpm_vote_user_address
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cbpm_vote_user_address`;
CREATE TABLE `tbl_cbpm_vote_user_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `prov` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `openid` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rec_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_cbpm_vote_main
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cbpm_vote_main`;
CREATE TABLE `tbl_cbpm_vote_main`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NULL DEFAULT NULL,
  `nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `openid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` int(11) NULL DEFAULT NULL,
  `headimgurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `country` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `vote_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rec_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_cbpm_vote_list
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cbpm_vote_list`;
CREATE TABLE `tbl_cbpm_vote_list`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vote_id` int(11) NULL DEFAULT NULL,
  `vote_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `vote_nums` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_cbpm_vote_list
-- ----------------------------
INSERT INTO `tbl_cbpm_vote_list` VALUES (1, 0, '中国人民银行党委书记郭树清调研印钞造币企业，充分肯定行业地位和发展成绩，高瞻远瞩指明行业战略发展方向', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (2, 1, '积极探索国有企业党建“三个有机结合”，全面从严治党向纵深推进', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (3, 2, '圆满实现年度各项工作目标  降本增效创佳绩', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (4, 3, '人民币质量提升成果显著，纪念钞（币）新产品广受好评', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (5, 4, '“五项改革”扎实推进，制度建设取得丰硕成果', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (6, 5, '对外宣传取得突破，品牌影响进一步深化', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (7, 6, '国际市场再创佳绩，全产业链输出“中国制造”', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (8, 7, '全面贯彻落实总体安全观，行业持续稳定安全发展', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (9, 8, '风险防控体系进一步建立健全，主动防控和化解各类风险', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (10, 9, '货币文化产业升级，经济、社会效益双丰收', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (11, 10, '装备研发成果显著，国产设备保障有力', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (12, 11, '积极开拓金融服务市场，深入推进现金全生命周期管理', 0);
INSERT INTO `tbl_cbpm_vote_list` VALUES (13, 12, '整合多方资源，青年“双创”活动获成果', 0);

-- ----------------------------
-- Table structure for tbl_cbpm_vote_companylist
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cbpm_vote_companylist`;
CREATE TABLE `tbl_cbpm_vote_companylist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_cbpm_vote_companylist
-- ----------------------------
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (1, '非中钞员工');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (2, '总公司本部');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (3, '成都印钞有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (4, '北京印钞有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (5, '上海印钞有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (6, '西安印钞有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (7, '石家庄印钞有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (8, '南昌印钞有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (9, '广州印钞有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (10, '南京造币有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (11, '上海造币有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (12, '沈阳造币有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (13, '保定钞票纸业有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (14, '昆山钞票纸业有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (15, '中钞印制技术研究院有限公司(技术中心)');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (16, '中钞特种防伪科技有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (17, '中钞油墨有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (18, '中钞钞券设计制版有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (19, '中钞光华印制有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (20, '中钞华森实业有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (21, '中钞实业有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (22, '中钞信用卡产业发展有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (23, '中钞长城金融设备控股有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (24, '中钞国鼎投资有限公司');
INSERT INTO `tbl_cbpm_vote_companylist` VALUES (25, '北京晟昌物业管理有限责任公司');

-- ----------------------------
-- Triggers structure for table tbl_cbpm_vote_user_address
-- ----------------------------
DROP TRIGGER IF EXISTS `vote_address_time`;
delimiter ;;
CREATE TRIGGER `vote_address_time` BEFORE INSERT ON `tbl_cbpm_vote_user_address` FOR EACH ROW SET new.rec_time = CURRENT_TIMESTAMP
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tbl_cbpm_vote_main
-- ----------------------------
DROP TRIGGER IF EXISTS `vote_time`;
delimiter ;;
CREATE TRIGGER `vote_time` BEFORE INSERT ON `tbl_cbpm_vote_main` FOR EACH ROW SET new.rec_time = CURRENT_TIMESTAMP
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
