/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50640
 Source Host           : 127.0.0.1:3306
 Source Schema         : saltops_v2

 Target Server Type    : MySQL
 Target Server Version : 50640
 File Encoding         : 65001

 Date: 27/12/2018 16:20:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app_asset_host
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_host`;
CREATE TABLE `app_asset_host`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `host_remove_port` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `host_user` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `host_passwd` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `host_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `host_msg` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `serial_num` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `purchase_date` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `overdue_date` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creat_time` datetime(6) NOT NULL,
  `group_id` int(11) NULL DEFAULT NULL,
  `idc_id` int(11) NULL DEFAULT NULL,
  `supplier_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `host_ip`(`host_ip`) USING BTREE,
  INDEX `app_asset_host_group_id_c2f5df06_fk_app_asset_hostgroup_id`(`group_id`) USING BTREE,
  INDEX `app_asset_host_idc_id_82734ac0_fk_app_asset_idc_id`(`idc_id`) USING BTREE,
  INDEX `app_asset_host_supplier_id_77b2b553_fk_app_asset_supplier_id`(`supplier_id`) USING BTREE,
  CONSTRAINT `app_asset_host_group_id_c2f5df06_fk_app_asset_hostgroup_id` FOREIGN KEY (`group_id`) REFERENCES `app_asset_hostgroup` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_asset_host_idc_id_82734ac0_fk_app_asset_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `app_asset_idc` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_asset_host_supplier_id_77b2b553_fk_app_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `app_asset_supplier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_asset_hostdetail
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_hostdetail`;
CREATE TABLE `app_asset_hostdetail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mem_size` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `swap_size` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cpu_model` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cpu_nums` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `disk_info` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `interface` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `os_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `kernel_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `os_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `host_id` int(11) NOT NULL,
  `host_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_asset_hostdetail_host_id_7ccadf7f_fk_app_asset_host_id`(`host_id`) USING BTREE,
  CONSTRAINT `app_asset_hostdetail_host_id_7ccadf7f_fk_app_asset_host_id` FOREIGN KEY (`host_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 172 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_asset_hostgroup
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_hostgroup`;
CREATE TABLE `app_asset_hostgroup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_group_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `host_group_msg` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `host_group_name`(`host_group_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_hostgroup
-- ----------------------------
INSERT INTO `app_asset_hostgroup` VALUES (9, '测试组', '测试');
INSERT INTO `app_asset_hostgroup` VALUES (10, '运维', '运维');

-- ----------------------------
-- Table structure for app_asset_idc
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_idc`;
CREATE TABLE `app_asset_idc`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idc_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idc_msg` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `idc_admin` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `idc_admin_phone` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `idc_admin_email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idc_name`(`idc_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_idc
-- ----------------------------
INSERT INTO `app_asset_idc` VALUES (4, 'test', 'test', '小贰', '10086', '10086@139.com');

-- ----------------------------
-- Table structure for app_asset_netwk
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_netwk`;
CREATE TABLE `app_asset_netwk`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `netwk_ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `netwk_remove_port` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `netwk_user` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `netwk_passwd` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `netwk_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `netwk_msg` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `serial_num` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `purchase_date` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `overdue_date` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creat_time` datetime(6) NOT NULL,
  `group_id` int(11) NULL DEFAULT NULL,
  `idc_id` int(11) NULL DEFAULT NULL,
  `supplier_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `netwk_ip`(`netwk_ip`) USING BTREE,
  INDEX `app_asset_netwk_group_id_296fe67a_fk_app_asset_hostgroup_id`(`group_id`) USING BTREE,
  INDEX `app_asset_netwk_idc_id_ce4d4607_fk_app_asset_idc_id`(`idc_id`) USING BTREE,
  INDEX `app_asset_netwk_supplier_id_fa6020c4_fk_app_asset_supplier_id`(`supplier_id`) USING BTREE,
  CONSTRAINT `app_asset_netwk_group_id_296fe67a_fk_app_asset_hostgroup_id` FOREIGN KEY (`group_id`) REFERENCES `app_asset_hostgroup` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_asset_netwk_idc_id_ce4d4607_fk_app_asset_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `app_asset_idc` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_asset_netwk_supplier_id_fa6020c4_fk_app_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `app_asset_supplier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_asset_software
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_software`;
CREATE TABLE `app_asset_software`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_version` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `server_port` varchar(1026) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `host_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_asset_software_host_id_1c4f4ada_fk_app_asset_host_id`(`host_id`) USING BTREE,
  CONSTRAINT `app_asset_software_host_id_1c4f4ada_fk_app_asset_host_id` FOREIGN KEY (`host_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_asset_supplier
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_supplier`;
CREATE TABLE `app_asset_supplier`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `supplier_head` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_head_phone` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_head_email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_asset_supplier_supplier_c7b4eaa0_uniq`(`supplier`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_supplier
-- ----------------------------
INSERT INTO `app_asset_supplier` VALUES (1, '维盟', '小贰', '10086', '10086@139.com');
INSERT INTO `app_asset_supplier` VALUES (2, '阿里云', '小贰', '10086', '10086@139.com');
INSERT INTO `app_asset_supplier` VALUES (4, '戴尔', '小贰', '10086', '10086@139.com');

-- ----------------------------
-- Table structure for app_auth_key
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_key`;
CREATE TABLE `app_auth_key`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_isa` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `key_isa_pub` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `key_msg` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_auth_key_user_id_8e329b5d_fk_app_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `app_auth_key_user_id_8e329b5d_fk_app_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_auth_menus
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_menus`;
CREATE TABLE `app_auth_menus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pmenu_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_icon` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_order` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_menus_menu_url_d695085b_uniq`(`menu_url`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_menus
-- ----------------------------
INSERT INTO `app_auth_menus` VALUES (1, '首页', '/', '一级菜单', '0', '1', 'fa fa-lg fa-dashboard', NULL);
INSERT INTO `app_auth_menus` VALUES (2, '资产管理', '/asset/', '一级菜单', '0', '2', 'fa fa-lg fa-bars', NULL);
INSERT INTO `app_auth_menus` VALUES (3, '代码管理', '/code/', '一级菜单', '0', '3', 'fa fa-lg fa-code', NULL);
INSERT INTO `app_auth_menus` VALUES (4, '系统管理', '/sys/', '一级菜单', '0', '4', 'fa fa-lg fa-desktop', NULL);
INSERT INTO `app_auth_menus` VALUES (5, '运维工具', '/tool/', '一级菜单', '0', '5', 'fa fa-lg fa-wrench', NULL);
INSERT INTO `app_auth_menus` VALUES (6, '日志审计', '/log/', '一级菜单', '0', '6', 'fa fa-lg fa-book', NULL);
INSERT INTO `app_auth_menus` VALUES (7, '后台管理', '/auth/', '一级菜单', '0', '7', 'fa fa-lg fa-cog', NULL);
INSERT INTO `app_auth_menus` VALUES (8, '服务器', '/asset/host/', '二级菜单', '2', '208', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (9, '网络设备', '/asset/netwk/', '二级菜单', '2', '209', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (10, 'IDC 机房', '/asset/idc/', '二级菜单', '2', '2010', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (11, '主机分组', '/asset/hostgroup/', '二级菜单', '2', '2011', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (12, '设备厂商', '/asset/supplier/', '二级菜单', '2', '2012', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (13, '项目管理', '/code/project/', '二级菜单', '3', '3013', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (14, '代码管理', '/code/gitcode/', '二级菜单', '3', '3014', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (15, '代码发布', '/code/publist/', '二级菜单', '3', '3015', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (16, '发布记录', '/code/log/', '二级菜单', '3', '3016', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (17, '环境部署', '/sys/sofeware/', '二级菜单', '4', '4017', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (18, '批量管理', '/sys/batch/', '二级菜单', '4', '4018', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (19, '文件管理', '/sys/filemg/', '二级菜单', '4', '4019', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (21, 'phpMyadmin', '/tool/phpmyadmin/', '二级菜单', '5', '5021', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (22, '操作日志', '/log/opslog/', '二级菜单', '6', '6022', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (23, '用户日志', '/log/userlog/', '二级菜单', '6', '6023', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (24, '角色管理', '/auth/role/', '二级菜单', '7', '7024', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (25, '用户管理', '/auth/user/', '二级菜单', '7', '7025', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (26, '菜单管理', '/auth/menu/', '二级菜单', '7', '7026', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (27, '权限管理', '/auth/perms/', '二级菜单', '7', '7027', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (28, '任务中心', '/log/tasklog/', '二级菜单', '6', '6028', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (29, 'zabbix', 'http://192.168.1.218/zabbix/', '二级菜单', '5', '5029', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (31, '秘钥管理', '/auth/key/', '二级菜单', '7', '7031', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (32, '数据库管理', '/db/', '一级菜单', '0', '32', 'fa fa-lg fa-linux', NULL);
INSERT INTO `app_auth_menus` VALUES (33, '数据库', '/db/list/', '二级菜单', '32', '32033', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (34, 'Inception', '/db/inc/', '二级菜单', '32', '32034', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (35, 'SQL工单', '/db/order/', '二级菜单', '32', '32035', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (36, '工单处理', '/db/orderlog/', '二级菜单', '32', '32036', NULL, NULL);

-- ----------------------------
-- Table structure for app_auth_perms
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_perms`;
CREATE TABLE `app_auth_perms`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `perms_req` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menus_id` int(11) NOT NULL,
  `perms_title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `perms_url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_auth_perms_menus_id_57ecaabb_fk_app_auth_menus_id`(`menus_id`) USING BTREE,
  UNIQUE INDEX `app_auth_perms_perms_url_989fe779_uniq`(`perms_url`) USING BTREE,
  CONSTRAINT `app_auth_perms_menus_id_57ecaabb_fk_app_auth_menus_id` FOREIGN KEY (`menus_id`) REFERENCES `app_auth_menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_perms
-- ----------------------------
INSERT INTO `app_auth_perms` VALUES (4, 'post', 8, '添加服务器', NULL);
INSERT INTO `app_auth_perms` VALUES (5, 'delete', 8, '删除服务器', NULL);
INSERT INTO `app_auth_perms` VALUES (6, 'put', 8, '修改服务器', NULL);
INSERT INTO `app_auth_perms` VALUES (7, 'get', 8, '查询服务器', NULL);
INSERT INTO `app_auth_perms` VALUES (8, 'post', 9, '添加网络设备', NULL);
INSERT INTO `app_auth_perms` VALUES (9, 'delete', 9, '删除网络设备', NULL);
INSERT INTO `app_auth_perms` VALUES (10, 'put', 9, '修改网络设备', NULL);
INSERT INTO `app_auth_perms` VALUES (11, 'get', 9, '查询网络设备', NULL);
INSERT INTO `app_auth_perms` VALUES (12, 'post', 10, '添加机房', NULL);
INSERT INTO `app_auth_perms` VALUES (13, 'delete', 10, '删除机房', NULL);
INSERT INTO `app_auth_perms` VALUES (14, 'put', 10, '修改机房', NULL);
INSERT INTO `app_auth_perms` VALUES (15, 'get', 10, '查询机房', NULL);
INSERT INTO `app_auth_perms` VALUES (16, 'post', 11, '添加分组', NULL);
INSERT INTO `app_auth_perms` VALUES (17, 'delete', 11, '删除分组', NULL);
INSERT INTO `app_auth_perms` VALUES (18, 'put', 11, '修改分组', NULL);
INSERT INTO `app_auth_perms` VALUES (19, 'get', 11, '查询分组', NULL);
INSERT INTO `app_auth_perms` VALUES (20, 'post', 12, '添加厂商', NULL);
INSERT INTO `app_auth_perms` VALUES (21, 'delete', 12, '删除厂商', NULL);
INSERT INTO `app_auth_perms` VALUES (22, 'put', 12, '修改厂商', NULL);
INSERT INTO `app_auth_perms` VALUES (23, 'get', 12, '查询厂商', NULL);
INSERT INTO `app_auth_perms` VALUES (24, 'post', 13, '添加项目', NULL);
INSERT INTO `app_auth_perms` VALUES (25, 'put', 13, '修改项目', NULL);
INSERT INTO `app_auth_perms` VALUES (26, 'delete', 13, '删除项目', NULL);
INSERT INTO `app_auth_perms` VALUES (27, 'get', 13, '查询项目', NULL);
INSERT INTO `app_auth_perms` VALUES (28, 'post', 14, '添加代码', NULL);
INSERT INTO `app_auth_perms` VALUES (29, 'put', 14, '修改代码', NULL);
INSERT INTO `app_auth_perms` VALUES (30, 'delete', 14, '删除代码', NULL);
INSERT INTO `app_auth_perms` VALUES (31, 'get', 14, '查询代码', NULL);
INSERT INTO `app_auth_perms` VALUES (32, 'post', 15, '添加发布', NULL);
INSERT INTO `app_auth_perms` VALUES (33, 'delete', 15, '删除发布', NULL);
INSERT INTO `app_auth_perms` VALUES (34, 'delete', 16, '删除发布记录', NULL);
INSERT INTO `app_auth_perms` VALUES (36, 'post', 17, '添加环境', NULL);
INSERT INTO `app_auth_perms` VALUES (37, 'delete', 17, '删除环境', NULL);
INSERT INTO `app_auth_perms` VALUES (38, 'put', 17, '修改环境', NULL);
INSERT INTO `app_auth_perms` VALUES (39, 'get', 17, '查询环境', NULL);
INSERT INTO `app_auth_perms` VALUES (40, 'get', 18, '访问批量管理', NULL);
INSERT INTO `app_auth_perms` VALUES (41, 'get', 19, '访问文件管理', NULL);
INSERT INTO `app_auth_perms` VALUES (43, 'get', 21, '访问phpmyadmin', NULL);
INSERT INTO `app_auth_perms` VALUES (44, 'get', 22, '查看操作日志', NULL);
INSERT INTO `app_auth_perms` VALUES (45, 'get', 23, '查看用户日志', NULL);
INSERT INTO `app_auth_perms` VALUES (46, 'post', 24, '添加角色', NULL);
INSERT INTO `app_auth_perms` VALUES (47, 'delete', 24, '删除角色', NULL);
INSERT INTO `app_auth_perms` VALUES (48, 'put', 24, '删除修改', NULL);
INSERT INTO `app_auth_perms` VALUES (49, 'get', 24, '查看角色', NULL);
INSERT INTO `app_auth_perms` VALUES (50, 'other', 24, '角色菜单授权', '/auth/addrolemenu/');
INSERT INTO `app_auth_perms` VALUES (51, 'other', 24, '角色权限授权', '/auth/addroleperms/');
INSERT INTO `app_auth_perms` VALUES (53, 'other', 24, '获取角色菜单', '/auth/rolemenu/');
INSERT INTO `app_auth_perms` VALUES (54, 'other', 24, '获取角色权限', '/auth/roleperms/');
INSERT INTO `app_auth_perms` VALUES (55, 'other', 24, '获取角色资产', '/auth/roleasset/');
INSERT INTO `app_auth_perms` VALUES (56, 'other', 24, '角色资产授权', '/auth/addroleasset/');
INSERT INTO `app_auth_perms` VALUES (57, 'other', 24, '角色项目授权', '/auth/addroleproject/');
INSERT INTO `app_auth_perms` VALUES (58, 'other', 24, '获取角色项目', '/auth/roleproject/');
INSERT INTO `app_auth_perms` VALUES (59, 'post', 25, '添加用户', NULL);
INSERT INTO `app_auth_perms` VALUES (60, 'delete', 25, '删除用户', NULL);
INSERT INTO `app_auth_perms` VALUES (61, 'put', 25, '修改用户', NULL);
INSERT INTO `app_auth_perms` VALUES (62, 'get', 25, '查询用户', NULL);
INSERT INTO `app_auth_perms` VALUES (63, 'get', 26, '查询菜单', NULL);
INSERT INTO `app_auth_perms` VALUES (64, 'put', 26, '修改菜单', NULL);
INSERT INTO `app_auth_perms` VALUES (65, 'delete', 26, '删除菜单', NULL);
INSERT INTO `app_auth_perms` VALUES (66, 'post', 26, '添加菜单', NULL);
INSERT INTO `app_auth_perms` VALUES (67, 'post', 27, '添加权限', NULL);
INSERT INTO `app_auth_perms` VALUES (68, 'delete', 27, '删除权限', NULL);
INSERT INTO `app_auth_perms` VALUES (69, 'put', 27, '修改权限', NULL);
INSERT INTO `app_auth_perms` VALUES (70, 'get', 27, '查询权限', NULL);
INSERT INTO `app_auth_perms` VALUES (71, 'get', 15, '查询发布', NULL);
INSERT INTO `app_auth_perms` VALUES (72, 'get', 16, '查询发布记录', NULL);
INSERT INTO `app_auth_perms` VALUES (73, 'other', 8, '查询服务器详细信息', '/asset/hostdetail/');
INSERT INTO `app_auth_perms` VALUES (74, 'other', 8, '服务器同步系统信息', '/asset/synchost/');
INSERT INTO `app_auth_perms` VALUES (75, 'other', 8, '过滤服务器', '/asset/searchhost/');
INSERT INTO `app_auth_perms` VALUES (76, 'other', 8, '批量删除服务器', '/asset/delhost/');
INSERT INTO `app_auth_perms` VALUES (77, 'other', 8, '连接服务器', '/asset/connecthost/');
INSERT INTO `app_auth_perms` VALUES (78, 'other', 15, '代码发布过滤', '/code/search/');
INSERT INTO `app_auth_perms` VALUES (79, 'other', 8, '导出服务器', '/asset/exporthost/');
INSERT INTO `app_auth_perms` VALUES (80, 'other', 25, '修改密码', '/auth/chpasswd/');
INSERT INTO `app_auth_perms` VALUES (81, 'other', 25, '添加远程管理用户', '/auth/addremote/');
INSERT INTO `app_auth_perms` VALUES (82, 'other', 18, '上传文件', '/sys/upfile/');
INSERT INTO `app_auth_perms` VALUES (83, 'other', 18, '执行命令', '/sys/runcmd/');
INSERT INTO `app_auth_perms` VALUES (84, 'other', 18, '执行脚本', '/sys/script/');
INSERT INTO `app_auth_perms` VALUES (85, 'other', 18, '计划任务', '/sys/cron/');
INSERT INTO `app_auth_perms` VALUES (86, 'post', 21, '连接phpmyadmin', NULL);
INSERT INTO `app_auth_perms` VALUES (87, 'post', 22, '查看审计记录', NULL);
INSERT INTO `app_auth_perms` VALUES (88, 'put', 15, '更新代码', NULL);
INSERT INTO `app_auth_perms` VALUES (89, 'other', 15, '查看更新记录', '/code/gitlog/');
INSERT INTO `app_auth_perms` VALUES (91, 'get', 28, '查看任务', NULL);
INSERT INTO `app_auth_perms` VALUES (92, 'post', 28, '任务日志', NULL);
INSERT INTO `app_auth_perms` VALUES (93, 'other', 17, '安装软件服务', '/sys/install/');
INSERT INTO `app_auth_perms` VALUES (94, 'other', 19, '删除文件', '/sys/removefile/');
INSERT INTO `app_auth_perms` VALUES (95, 'other', 19, '文件编辑', '/sys/editfile/');
INSERT INTO `app_auth_perms` VALUES (96, 'other', 19, '保存文件', '/sys/savefile/');
INSERT INTO `app_auth_perms` VALUES (97, 'get', 31, '访问秘钥管理', NULL);
INSERT INTO `app_auth_perms` VALUES (98, 'post', 31, '增加秘钥', NULL);
INSERT INTO `app_auth_perms` VALUES (99, 'put', 31, '修改秘钥', NULL);
INSERT INTO `app_auth_perms` VALUES (100, 'delete', 31, '删除秘钥', NULL);
INSERT INTO `app_auth_perms` VALUES (101, 'other', 31, '查看秘钥', '/auth/checkey/');
INSERT INTO `app_auth_perms` VALUES (102, 'get', 33, '访问数据库列表', NULL);
INSERT INTO `app_auth_perms` VALUES (103, 'post', 33, '添加数据库', NULL);
INSERT INTO `app_auth_perms` VALUES (104, 'delete', 33, '删除数据库', NULL);
INSERT INTO `app_auth_perms` VALUES (105, 'put', 33, '修改数据库', NULL);
INSERT INTO `app_auth_perms` VALUES (106, 'post', 34, '添加Inception', NULL);
INSERT INTO `app_auth_perms` VALUES (107, 'put', 34, '修改Inception', NULL);
INSERT INTO `app_auth_perms` VALUES (108, 'get', 34, '访问Inception配置', NULL);
INSERT INTO `app_auth_perms` VALUES (109, 'get', 35, '访问SQL工单', NULL);
INSERT INTO `app_auth_perms` VALUES (110, 'post', 35, '申请SQL工单', NULL);
INSERT INTO `app_auth_perms` VALUES (111, 'get', 36, '访问工单处理记录', NULL);
INSERT INTO `app_auth_perms` VALUES (112, 'post', 36, '工单处理', NULL);

-- ----------------------------
-- Table structure for app_auth_remoteuser
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_remoteuser`;
CREATE TABLE `app_auth_remoteuser`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lg_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lg_passwd` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lg_key` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `user_id` int(11) NOT NULL,
  `lg_key_pass` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_auth_remoteuser_user_id_ea3232d8_fk_app_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `app_auth_remoteuser_user_id_ea3232d8_fk_app_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_remoteuser
-- ----------------------------
INSERT INTO `app_auth_remoteuser` VALUES (5, '', 'b\'\'', '', 1, 'b\'\'');

-- ----------------------------
-- Table structure for app_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_role`;
CREATE TABLE `app_auth_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_msg` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_title`(`role_title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role
-- ----------------------------
INSERT INTO `app_auth_role` VALUES (1, 'administrator', '超级管理员-（禁止删改）');

-- ----------------------------
-- Table structure for app_auth_role_host
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_role_host`;
CREATE TABLE `app_auth_role_host`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `host_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_role_host_role_id_host_id_b84cf1fc_uniq`(`role_id`, `host_id`) USING BTREE,
  INDEX `app_auth_role_host_host_id_8f5ad2a4_fk_app_asset_host_id`(`host_id`) USING BTREE,
  CONSTRAINT `app_auth_role_host_host_id_8f5ad2a4_fk_app_asset_host_id` FOREIGN KEY (`host_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_auth_role_host_role_id_9eb7afaf_fk_app_auth_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_auth_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 358 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_auth_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_role_menu`;
CREATE TABLE `app_auth_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menus_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_role_menu_role_id_menus_id_a36454cb_uniq`(`role_id`, `menus_id`) USING BTREE,
  INDEX `app_auth_role_menu_menus_id_7ef9f003_fk_app_auth_menus_id`(`menus_id`) USING BTREE,
  CONSTRAINT `app_auth_role_menu_menus_id_7ef9f003_fk_app_auth_menus_id` FOREIGN KEY (`menus_id`) REFERENCES `app_auth_menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_auth_role_menu_role_id_16d6bb84_fk_app_auth_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_auth_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 682 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_menu
-- ----------------------------
INSERT INTO `app_auth_role_menu` VALUES (648, 1, 1);
INSERT INTO `app_auth_role_menu` VALUES (649, 1, 2);
INSERT INTO `app_auth_role_menu` VALUES (655, 1, 3);
INSERT INTO `app_auth_role_menu` VALUES (660, 1, 4);
INSERT INTO `app_auth_role_menu` VALUES (664, 1, 5);
INSERT INTO `app_auth_role_menu` VALUES (667, 1, 6);
INSERT INTO `app_auth_role_menu` VALUES (671, 1, 7);
INSERT INTO `app_auth_role_menu` VALUES (650, 1, 8);
INSERT INTO `app_auth_role_menu` VALUES (651, 1, 9);
INSERT INTO `app_auth_role_menu` VALUES (652, 1, 10);
INSERT INTO `app_auth_role_menu` VALUES (653, 1, 11);
INSERT INTO `app_auth_role_menu` VALUES (654, 1, 12);
INSERT INTO `app_auth_role_menu` VALUES (656, 1, 13);
INSERT INTO `app_auth_role_menu` VALUES (657, 1, 14);
INSERT INTO `app_auth_role_menu` VALUES (658, 1, 15);
INSERT INTO `app_auth_role_menu` VALUES (659, 1, 16);
INSERT INTO `app_auth_role_menu` VALUES (661, 1, 17);
INSERT INTO `app_auth_role_menu` VALUES (662, 1, 18);
INSERT INTO `app_auth_role_menu` VALUES (663, 1, 19);
INSERT INTO `app_auth_role_menu` VALUES (665, 1, 21);
INSERT INTO `app_auth_role_menu` VALUES (668, 1, 22);
INSERT INTO `app_auth_role_menu` VALUES (669, 1, 23);
INSERT INTO `app_auth_role_menu` VALUES (672, 1, 24);
INSERT INTO `app_auth_role_menu` VALUES (673, 1, 25);
INSERT INTO `app_auth_role_menu` VALUES (674, 1, 26);
INSERT INTO `app_auth_role_menu` VALUES (675, 1, 27);
INSERT INTO `app_auth_role_menu` VALUES (670, 1, 28);
INSERT INTO `app_auth_role_menu` VALUES (666, 1, 29);
INSERT INTO `app_auth_role_menu` VALUES (676, 1, 31);
INSERT INTO `app_auth_role_menu` VALUES (677, 1, 32);
INSERT INTO `app_auth_role_menu` VALUES (678, 1, 33);
INSERT INTO `app_auth_role_menu` VALUES (679, 1, 34);
INSERT INTO `app_auth_role_menu` VALUES (680, 1, 35);
INSERT INTO `app_auth_role_menu` VALUES (681, 1, 36);

-- ----------------------------
-- Table structure for app_auth_role_netwk
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_role_netwk`;
CREATE TABLE `app_auth_role_netwk`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `netwk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_role_netwk_role_id_netwk_id_d7fd7a9e_uniq`(`role_id`, `netwk_id`) USING BTREE,
  INDEX `app_auth_role_netwk_netwk_id_65b51976_fk_app_asset_netwk_id`(`netwk_id`) USING BTREE,
  CONSTRAINT `app_auth_role_netwk_netwk_id_65b51976_fk_app_asset_netwk_id` FOREIGN KEY (`netwk_id`) REFERENCES `app_asset_netwk` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_auth_role_netwk_role_id_c2eec4e1_fk_app_auth_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_auth_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_auth_role_perms
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_role_perms`;
CREATE TABLE `app_auth_role_perms`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `perms_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_role_perms_role_id_perms_id_f73ba1cb_uniq`(`role_id`, `perms_id`) USING BTREE,
  INDEX `app_auth_role_perms_perms_id_05bc8fc8_fk_app_auth_perms_id`(`perms_id`) USING BTREE,
  CONSTRAINT `app_auth_role_perms_perms_id_05bc8fc8_fk_app_auth_perms_id` FOREIGN KEY (`perms_id`) REFERENCES `app_auth_perms` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_auth_role_perms_role_id_d1dbe279_fk_app_auth_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_auth_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2540 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_perms
-- ----------------------------
INSERT INTO `app_auth_role_perms` VALUES (2435, 1, 4);
INSERT INTO `app_auth_role_perms` VALUES (2436, 1, 5);
INSERT INTO `app_auth_role_perms` VALUES (2437, 1, 6);
INSERT INTO `app_auth_role_perms` VALUES (2438, 1, 7);
INSERT INTO `app_auth_role_perms` VALUES (2445, 1, 8);
INSERT INTO `app_auth_role_perms` VALUES (2446, 1, 9);
INSERT INTO `app_auth_role_perms` VALUES (2447, 1, 10);
INSERT INTO `app_auth_role_perms` VALUES (2448, 1, 11);
INSERT INTO `app_auth_role_perms` VALUES (2449, 1, 12);
INSERT INTO `app_auth_role_perms` VALUES (2450, 1, 13);
INSERT INTO `app_auth_role_perms` VALUES (2451, 1, 14);
INSERT INTO `app_auth_role_perms` VALUES (2452, 1, 15);
INSERT INTO `app_auth_role_perms` VALUES (2453, 1, 16);
INSERT INTO `app_auth_role_perms` VALUES (2454, 1, 17);
INSERT INTO `app_auth_role_perms` VALUES (2455, 1, 18);
INSERT INTO `app_auth_role_perms` VALUES (2456, 1, 19);
INSERT INTO `app_auth_role_perms` VALUES (2457, 1, 20);
INSERT INTO `app_auth_role_perms` VALUES (2458, 1, 21);
INSERT INTO `app_auth_role_perms` VALUES (2459, 1, 22);
INSERT INTO `app_auth_role_perms` VALUES (2460, 1, 23);
INSERT INTO `app_auth_role_perms` VALUES (2461, 1, 24);
INSERT INTO `app_auth_role_perms` VALUES (2462, 1, 25);
INSERT INTO `app_auth_role_perms` VALUES (2463, 1, 26);
INSERT INTO `app_auth_role_perms` VALUES (2464, 1, 27);
INSERT INTO `app_auth_role_perms` VALUES (2465, 1, 28);
INSERT INTO `app_auth_role_perms` VALUES (2466, 1, 29);
INSERT INTO `app_auth_role_perms` VALUES (2467, 1, 30);
INSERT INTO `app_auth_role_perms` VALUES (2468, 1, 31);
INSERT INTO `app_auth_role_perms` VALUES (2469, 1, 32);
INSERT INTO `app_auth_role_perms` VALUES (2470, 1, 33);
INSERT INTO `app_auth_role_perms` VALUES (2475, 1, 34);
INSERT INTO `app_auth_role_perms` VALUES (2477, 1, 36);
INSERT INTO `app_auth_role_perms` VALUES (2478, 1, 37);
INSERT INTO `app_auth_role_perms` VALUES (2479, 1, 38);
INSERT INTO `app_auth_role_perms` VALUES (2480, 1, 39);
INSERT INTO `app_auth_role_perms` VALUES (2482, 1, 40);
INSERT INTO `app_auth_role_perms` VALUES (2487, 1, 41);
INSERT INTO `app_auth_role_perms` VALUES (2491, 1, 43);
INSERT INTO `app_auth_role_perms` VALUES (2493, 1, 44);
INSERT INTO `app_auth_role_perms` VALUES (2495, 1, 45);
INSERT INTO `app_auth_role_perms` VALUES (2498, 1, 46);
INSERT INTO `app_auth_role_perms` VALUES (2499, 1, 47);
INSERT INTO `app_auth_role_perms` VALUES (2500, 1, 48);
INSERT INTO `app_auth_role_perms` VALUES (2501, 1, 49);
INSERT INTO `app_auth_role_perms` VALUES (2502, 1, 50);
INSERT INTO `app_auth_role_perms` VALUES (2503, 1, 51);
INSERT INTO `app_auth_role_perms` VALUES (2504, 1, 53);
INSERT INTO `app_auth_role_perms` VALUES (2505, 1, 54);
INSERT INTO `app_auth_role_perms` VALUES (2506, 1, 55);
INSERT INTO `app_auth_role_perms` VALUES (2507, 1, 56);
INSERT INTO `app_auth_role_perms` VALUES (2508, 1, 57);
INSERT INTO `app_auth_role_perms` VALUES (2509, 1, 58);
INSERT INTO `app_auth_role_perms` VALUES (2510, 1, 59);
INSERT INTO `app_auth_role_perms` VALUES (2511, 1, 60);
INSERT INTO `app_auth_role_perms` VALUES (2512, 1, 61);
INSERT INTO `app_auth_role_perms` VALUES (2513, 1, 62);
INSERT INTO `app_auth_role_perms` VALUES (2516, 1, 63);
INSERT INTO `app_auth_role_perms` VALUES (2517, 1, 64);
INSERT INTO `app_auth_role_perms` VALUES (2518, 1, 65);
INSERT INTO `app_auth_role_perms` VALUES (2519, 1, 66);
INSERT INTO `app_auth_role_perms` VALUES (2520, 1, 67);
INSERT INTO `app_auth_role_perms` VALUES (2521, 1, 68);
INSERT INTO `app_auth_role_perms` VALUES (2522, 1, 69);
INSERT INTO `app_auth_role_perms` VALUES (2523, 1, 70);
INSERT INTO `app_auth_role_perms` VALUES (2471, 1, 71);
INSERT INTO `app_auth_role_perms` VALUES (2476, 1, 72);
INSERT INTO `app_auth_role_perms` VALUES (2439, 1, 73);
INSERT INTO `app_auth_role_perms` VALUES (2440, 1, 74);
INSERT INTO `app_auth_role_perms` VALUES (2441, 1, 75);
INSERT INTO `app_auth_role_perms` VALUES (2442, 1, 76);
INSERT INTO `app_auth_role_perms` VALUES (2443, 1, 77);
INSERT INTO `app_auth_role_perms` VALUES (2472, 1, 78);
INSERT INTO `app_auth_role_perms` VALUES (2444, 1, 79);
INSERT INTO `app_auth_role_perms` VALUES (2514, 1, 80);
INSERT INTO `app_auth_role_perms` VALUES (2515, 1, 81);
INSERT INTO `app_auth_role_perms` VALUES (2483, 1, 82);
INSERT INTO `app_auth_role_perms` VALUES (2484, 1, 83);
INSERT INTO `app_auth_role_perms` VALUES (2485, 1, 84);
INSERT INTO `app_auth_role_perms` VALUES (2486, 1, 85);
INSERT INTO `app_auth_role_perms` VALUES (2492, 1, 86);
INSERT INTO `app_auth_role_perms` VALUES (2494, 1, 87);
INSERT INTO `app_auth_role_perms` VALUES (2473, 1, 88);
INSERT INTO `app_auth_role_perms` VALUES (2474, 1, 89);
INSERT INTO `app_auth_role_perms` VALUES (2496, 1, 91);
INSERT INTO `app_auth_role_perms` VALUES (2497, 1, 92);
INSERT INTO `app_auth_role_perms` VALUES (2481, 1, 93);
INSERT INTO `app_auth_role_perms` VALUES (2488, 1, 94);
INSERT INTO `app_auth_role_perms` VALUES (2489, 1, 95);
INSERT INTO `app_auth_role_perms` VALUES (2490, 1, 96);
INSERT INTO `app_auth_role_perms` VALUES (2524, 1, 97);
INSERT INTO `app_auth_role_perms` VALUES (2525, 1, 98);
INSERT INTO `app_auth_role_perms` VALUES (2526, 1, 99);
INSERT INTO `app_auth_role_perms` VALUES (2527, 1, 100);
INSERT INTO `app_auth_role_perms` VALUES (2528, 1, 101);
INSERT INTO `app_auth_role_perms` VALUES (2529, 1, 102);
INSERT INTO `app_auth_role_perms` VALUES (2530, 1, 103);
INSERT INTO `app_auth_role_perms` VALUES (2531, 1, 104);
INSERT INTO `app_auth_role_perms` VALUES (2532, 1, 105);
INSERT INTO `app_auth_role_perms` VALUES (2533, 1, 106);
INSERT INTO `app_auth_role_perms` VALUES (2534, 1, 107);
INSERT INTO `app_auth_role_perms` VALUES (2535, 1, 108);
INSERT INTO `app_auth_role_perms` VALUES (2536, 1, 109);
INSERT INTO `app_auth_role_perms` VALUES (2537, 1, 110);
INSERT INTO `app_auth_role_perms` VALUES (2538, 1, 111);
INSERT INTO `app_auth_role_perms` VALUES (2539, 1, 112);

-- ----------------------------
-- Table structure for app_auth_role_project
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_role_project`;
CREATE TABLE `app_auth_role_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `gitcode_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_auth_role_project_gitcode_id_d1f3c5bb_fk_app_code_gitcode_id`(`gitcode_id`) USING BTREE,
  UNIQUE INDEX `app_auth_role_project_role_id_project_id_09f71818_uniq`(`role_id`, `gitcode_id`) USING BTREE,
  CONSTRAINT `app_auth_role_project_gitcode_id_d1f3c5bb_fk_app_code_gitcode_id` FOREIGN KEY (`gitcode_id`) REFERENCES `app_code_gitcode` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_auth_role_project_role_id_8f081530_fk_app_auth_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_auth_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_auth_user
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_user`;
CREATE TABLE `app_auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ready_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `passwd` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `creat_time` datetime(6) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_user
-- ----------------------------
INSERT INTO `app_auth_user` VALUES (1, 'admin', '小贰', 'b\'d4721440af5b9f9f9a9915f5b2358ffb\'', '10086@139.com', '10086', '/static/img/user/11.jpg', '在线', '2018-10-11 06:13:37.757161', '2018-12-27 08:19:14.964313');

-- ----------------------------
-- Table structure for app_auth_user_role
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_user_role`;
CREATE TABLE `app_auth_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_user_role_user_id_role_id_4407ef40_uniq`(`user_id`, `role_id`) USING BTREE,
  INDEX `app_auth_user_role_role_id_987f89e1_fk_app_auth_role_id`(`role_id`) USING BTREE,
  CONSTRAINT `app_auth_user_role_role_id_987f89e1_fk_app_auth_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_auth_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_auth_user_role_user_id_2363d45d_fk_app_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_user_role
-- ----------------------------
INSERT INTO `app_auth_user_role` VALUES (5, 1, 1);

-- ----------------------------
-- Table structure for app_code_gitcode
-- ----------------------------
DROP TABLE IF EXISTS `app_code_gitcode`;
CREATE TABLE `app_code_gitcode`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `git_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `git_msg` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `git_url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `project_id` int(11) NULL DEFAULT NULL,
  `git_passwd` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `git_sshkey` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `git_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `git_name`(`git_name`) USING BTREE,
  UNIQUE INDEX `git_url`(`git_url`) USING BTREE,
  INDEX `app_code_gitcode_project_id_24ec459d_fk_app_code_project_id`(`project_id`) USING BTREE,
  CONSTRAINT `app_code_gitcode_project_id_24ec459d_fk_app_code_project_id` FOREIGN KEY (`project_id`) REFERENCES `app_code_project` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_code_project
-- ----------------------------
DROP TABLE IF EXISTS `app_code_project`;
CREATE TABLE `app_code_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `project_msg` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_name`(`project_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_code_project
-- ----------------------------
INSERT INTO `app_code_project` VALUES (2, '运维平台', '运维管理平台');

-- ----------------------------
-- Table structure for app_code_publist
-- ----------------------------
DROP TABLE IF EXISTS `app_code_publist`;
CREATE TABLE `app_code_publist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publist_dir` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `publist_msg` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `current_version` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version_info` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publist_date` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gitcode_id` int(11) NOT NULL,
  `host_ip_id` int(11) NOT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_code_publist_gitcode_id_08f6579e_fk_app_code_gitcode_id`(`gitcode_id`) USING BTREE,
  INDEX `app_code_publist_host_ip_id_55ba2063_fk_app_asset_host_id`(`host_ip_id`) USING BTREE,
  CONSTRAINT `app_code_publist_gitcode_id_08f6579e_fk_app_code_gitcode_id` FOREIGN KEY (`gitcode_id`) REFERENCES `app_code_gitcode` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_code_publist_host_ip_id_55ba2063_fk_app_asset_host_id` FOREIGN KEY (`host_ip_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_code_publistrecord
-- ----------------------------
DROP TABLE IF EXISTS `app_code_publistrecord`;
CREATE TABLE `app_code_publistrecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `current_version` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version_info` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publist_date` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publist_id` int(11) NOT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_code_publistreco_publist_id_3e2d949d_fk_app_code_`(`publist_id`) USING BTREE,
  CONSTRAINT `app_code_publistreco_publist_id_3e2d949d_fk_app_code_` FOREIGN KEY (`publist_id`) REFERENCES `app_code_publist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_code_wchartlog
-- ----------------------------
DROP TABLE IF EXISTS `app_code_wchartlog`;
CREATE TABLE `app_code_wchartlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `from_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `up_connect` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `up_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `add_time` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 158 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_db_backdb
-- ----------------------------
DROP TABLE IF EXISTS `app_db_backdb`;
CREATE TABLE `app_db_backdb`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `back_db_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `back_db_port` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `back_db_user` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `back_db_passwd` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_db_backdb
-- ----------------------------
INSERT INTO `app_db_backdb` VALUES (15, '192.168.1.126', '3306', 'root', '*E74858DB86EBA20BC33D0AECAE8A8108C56B17FA');

-- ----------------------------
-- Table structure for app_db_db
-- ----------------------------
DROP TABLE IF EXISTS `app_db_db`;
CREATE TABLE `app_db_db`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `db_host_id` int(11) NOT NULL,
  `db_port` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `db_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `db_env` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `db_msg` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `db_passwd` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `db_status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_db_db_user_id_7d876b8e_fk_app_auth_user_id`(`user_id`) USING BTREE,
  INDEX `app_db_db_db_host_id_db5b84f4`(`db_host_id`) USING BTREE,
  CONSTRAINT `app_db_db_db_host_id_db5b84f4_fk_app_asset_host_id` FOREIGN KEY (`db_host_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_db_db_user_id_7d876b8e_fk_app_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_db_incdb
-- ----------------------------
DROP TABLE IF EXISTS `app_db_incdb`;
CREATE TABLE `app_db_incdb`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inc_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inc_port` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inc_ip`(`inc_ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_db_incdb
-- ----------------------------
INSERT INTO `app_db_incdb` VALUES (22, '192.168.1.126', '6669');

-- ----------------------------
-- Table structure for app_db_inception
-- ----------------------------
DROP TABLE IF EXISTS `app_db_inception`;
CREATE TABLE `app_db_inception`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inc_title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inc_option` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inc_default` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inc_msg` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inc_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_db_inception
-- ----------------------------
INSERT INTO `app_db_inception` VALUES (1, 'inception_check_insert_field', 'ON/OFF', 'ON', '是不是要检查插入语句中的列链表的存在性', 'ON');
INSERT INTO `app_db_inception` VALUES (2, 'inception_check_dml_where', 'ON/OFF', 'ON', '在DML语句中没有WHERE条件时，是不是要报错', 'ON');
INSERT INTO `app_db_inception` VALUES (3, 'inception_check_dml_limit', 'ON/OFF', 'ON', '在DML语句中使用了LIMIT时，是不是要报错', 'ON');
INSERT INTO `app_db_inception` VALUES (4, 'inception_check_dml_orderby', 'ON/OFF', 'ON', '在DML语句中使用了Order By时，是不是要报错', 'ON');
INSERT INTO `app_db_inception` VALUES (5, 'inception_enable_select_star', 'ON/OFF', 'OFF', '是否允许 select * from', 'ON');
INSERT INTO `app_db_inception` VALUES (6, 'inception_enable_orderby_rand', 'ON/OFF', 'OFF', '是否允许order by rand', 'OFF');
INSERT INTO `app_db_inception` VALUES (7, 'inception_enable_nullable', 'ON/OFF', 'OFF', '创建或者新增列是否允许为NULL', 'ON');
INSERT INTO `app_db_inception` VALUES (8, 'inception_enable_foreign_key', 'ON/OFF', 'OFF', '是否支持外键', 'ON');
INSERT INTO `app_db_inception` VALUES (9, 'inception_enable_not_innodb', 'ON/OFF', 'OFF', '新建表指定的存储引擎不是Innodb时，用来控制是否报错，如果设置为ON，则不报错，否则会报错。', 'ON');
INSERT INTO `app_db_inception` VALUES (10, 'inception_check_table_comment', 'ON/OFF', 'ON', '建表时，表没有注释时报错', 'OFF');
INSERT INTO `app_db_inception` VALUES (11, 'inception_check_column_comment', 'ON/OFF', 'ON', '建表时，列没有注释时报错', 'OFF');
INSERT INTO `app_db_inception` VALUES (12, 'inception_check_primary_key', 'ON/OFF', 'ON', '建表时，如果没有主键，则报错', 'ON');
INSERT INTO `app_db_inception` VALUES (13, 'inception_enable_partition_table', 'ON/OFF', 'OFF', '是不是支持分区表', 'OFF');
INSERT INTO `app_db_inception` VALUES (14, 'inception_enable_enum_set_bit', 'ON/OFF', 'OFF', '是不是支持enum,set,bit数据类型', 'OFF');
INSERT INTO `app_db_inception` VALUES (15, 'inception_check_index_prefix', 'ON/OFF', 'ON', '是不是要检查索引名字前缀为\"idx_\"，检查唯一索引前缀是不是\"uniq_\"', 'ON');
INSERT INTO `app_db_inception` VALUES (16, 'inception_enable_autoincrement_unsigned', 'ON/OFF', 'ON', '自增列是不是要为无符号型', 'ON');
INSERT INTO `app_db_inception` VALUES (17, 'inception_check_autoincrement_init_value', 'ON/OFF', 'ON', '当建表时自增列的值指定的不为1，则报错', 'ON');
INSERT INTO `app_db_inception` VALUES (18, 'inception_check_autoincrement_datatype', 'ON/OFF', 'ON', '当建表时自增列的类型不为int或者bigint时报错', 'ON');
INSERT INTO `app_db_inception` VALUES (19, 'inception_check_timestamp_default', 'ON/OFF', 'ON', '建表时，如果没有为timestamp类型指定默认值，则报错', 'OFF');
INSERT INTO `app_db_inception` VALUES (20, 'inception_enable_column_charset', 'ON/OFF', 'OFF', '允许列自己设置字符集', 'OFF');
INSERT INTO `app_db_inception` VALUES (21, 'inception_check_autoincrement_name', 'ON/OFF', 'ON', '建表时，如果指定的自增列的名字不为ID，则报错，说明是有意义的，给提示', 'ON');
INSERT INTO `app_db_inception` VALUES (22, 'inception_merge_alter_table', 'ON/OFF', 'ON', '在多个改同一个表的语句出现是，报错，提示合成一个', 'OFF');
INSERT INTO `app_db_inception` VALUES (23, 'inception_check_column_default_value', 'ON/OFF', 'ON', '检查在建表、修改列、新增列时，新的列属性是不是要有默认值', 'OFF');
INSERT INTO `app_db_inception` VALUES (24, 'inception_enable_blob_type', 'ON/OFF', 'ON', '检查是不是支持BLOB字段，包括建表、修改列、新增列操作', 'ON');
INSERT INTO `app_db_inception` VALUES (25, 'inception_enable_identifer_keyword', 'ON/OFF', 'OFF', '检查在SQL语句中，是不是有标识符被写成MySQL的关键字，默认值为报警。', 'ON');
INSERT INTO `app_db_inception` VALUES (26, 'autocommit', 'ON/OFF', 'OFF', '这个参数的作用是为了匹配Python客户端每次自动设置auto_commit=0的，如果取消则会报错，针对Inception本身没有实际意义', 'OFF');
INSERT INTO `app_db_inception` VALUES (27, 'general_log', 'ON/OFF', 'ON', '这个参数就是原生的MySQL的参数，用来记录在Inception服务上执行过哪些语句，用来定位一些问题等', 'ON');
INSERT INTO `app_db_inception` VALUES (28, 'inception_check_identifier', 'ON/OFF', 'ON', '发现名字中存在除数字、字母、下划线之外的字符时，会报Identifier“invalidname”isinvalid,validoptions:[a-z,A-Z,0-9,_]', 'ON');
INSERT INTO `app_db_inception` VALUES (29, 'inception_enable_orderby_rand', 'ON/OFF', 'OFF', '语句中出现orderbyrand()时，用来控制是否报错，设置为ON表示不报错，否则会报错', 'OFF');
INSERT INTO `app_db_inception` VALUES (30, 'inception_enable_sql_statistic', 'ON/OFF', 'ON', '备库实例是否存储sql统计信息', 'ON');

-- ----------------------------
-- Table structure for app_db_workorderlog
-- ----------------------------
DROP TABLE IF EXISTS `app_db_workorderlog`;
CREATE TABLE `app_db_workorderlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sql` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `msg` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `from_user` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `db_id` int(11) NULL DEFAULT NULL,
  `review_user_id` int(11) NULL DEFAULT NULL,
  `status` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inc_status` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `exec_result` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_db_workorderlog_db_id_c789ab17_fk_app_db_db_id`(`db_id`) USING BTREE,
  INDEX `app_db_workorderlog_review_user_id_5588bd3d_fk_app_auth_user_id`(`review_user_id`) USING BTREE,
  CONSTRAINT `app_db_workorderlog_db_id_c789ab17_fk_app_db_db_id` FOREIGN KEY (`db_id`) REFERENCES `app_db_db` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_db_workorderlog_review_user_id_5588bd3d_fk_app_auth_user_id` FOREIGN KEY (`review_user_id`) REFERENCES `app_auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_log_opslog
-- ----------------------------
DROP TABLE IF EXISTS `app_log_opslog`;
CREATE TABLE `app_log_opslog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hostname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `audit_log` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_log_taskrecord
-- ----------------------------
DROP TABLE IF EXISTS `app_log_taskrecord`;
CREATE TABLE `app_log_taskrecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `task_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `task_result` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `task_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_log_taskrecord_task_user_id_db7792d0_fk_app_auth_user_id`(`task_user_id`) USING BTREE,
  CONSTRAINT `app_log_taskrecord_task_user_id_db7792d0_fk_app_auth_user_id` FOREIGN KEY (`task_user_id`) REFERENCES `app_auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_log_userlog
-- ----------------------------
DROP TABLE IF EXISTS `app_log_userlog`;
CREATE TABLE `app_log_userlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url_title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ready_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2405 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_sys_envsofeware
-- ----------------------------
DROP TABLE IF EXISTS `app_sys_envsofeware`;
CREATE TABLE `app_sys_envsofeware`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sofeware_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sofeware_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `install_script` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_sys_envsofeware
-- ----------------------------
INSERT INTO `app_sys_envsofeware` VALUES (2, 'rsync', '3.0.9', 'cd /usr/local/src/ \nwget http://rsync.samba.org/ftp/rsync/src/rsync-3.0.9.tar.gz \ntar zxvf rsync-3.0.9.tar.gz \ncd rsync-3.0.9\n./configure --prefix=/usr/local/rsync \nmake && make install\necho \"backup\" > /usr/local/rsync/rsync.passwd\nchmod 0600 /usr/local/rsync/rsync.passwd');

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 173 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add permission', 1, 'add_permission');
INSERT INTO `auth_permission` VALUES (2, 'Can change permission', 1, 'change_permission');
INSERT INTO `auth_permission` VALUES (3, 'Can delete permission', 1, 'delete_permission');
INSERT INTO `auth_permission` VALUES (4, 'Can view permission', 1, 'view_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can add group', 2, 'add_group');
INSERT INTO `auth_permission` VALUES (6, 'Can change group', 2, 'change_group');
INSERT INTO `auth_permission` VALUES (7, 'Can delete group', 2, 'delete_group');
INSERT INTO `auth_permission` VALUES (8, 'Can view group', 2, 'view_group');
INSERT INTO `auth_permission` VALUES (9, 'Can add user', 3, 'add_user');
INSERT INTO `auth_permission` VALUES (10, 'Can change user', 3, 'change_user');
INSERT INTO `auth_permission` VALUES (11, 'Can delete user', 3, 'delete_user');
INSERT INTO `auth_permission` VALUES (12, 'Can view user', 3, 'view_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add menus', 6, 'add_menus');
INSERT INTO `auth_permission` VALUES (22, 'Can change menus', 6, 'change_menus');
INSERT INTO `auth_permission` VALUES (23, 'Can delete menus', 6, 'delete_menus');
INSERT INTO `auth_permission` VALUES (24, 'Can view menus', 6, 'view_menus');
INSERT INTO `auth_permission` VALUES (25, 'Can add perms', 7, 'add_perms');
INSERT INTO `auth_permission` VALUES (26, 'Can change perms', 7, 'change_perms');
INSERT INTO `auth_permission` VALUES (27, 'Can delete perms', 7, 'delete_perms');
INSERT INTO `auth_permission` VALUES (28, 'Can view perms', 7, 'view_perms');
INSERT INTO `auth_permission` VALUES (29, 'Can add role', 8, 'add_role');
INSERT INTO `auth_permission` VALUES (30, 'Can change role', 8, 'change_role');
INSERT INTO `auth_permission` VALUES (31, 'Can delete role', 8, 'delete_role');
INSERT INTO `auth_permission` VALUES (32, 'Can view role', 8, 'view_role');
INSERT INTO `auth_permission` VALUES (33, 'Can add user', 9, 'add_user');
INSERT INTO `auth_permission` VALUES (34, 'Can change user', 9, 'change_user');
INSERT INTO `auth_permission` VALUES (35, 'Can delete user', 9, 'delete_user');
INSERT INTO `auth_permission` VALUES (36, 'Can view user', 9, 'view_user');
INSERT INTO `auth_permission` VALUES (37, 'Can add host', 10, 'add_host');
INSERT INTO `auth_permission` VALUES (38, 'Can change host', 10, 'change_host');
INSERT INTO `auth_permission` VALUES (39, 'Can delete host', 10, 'delete_host');
INSERT INTO `auth_permission` VALUES (40, 'Can view host', 10, 'view_host');
INSERT INTO `auth_permission` VALUES (41, 'Can add host group', 11, 'add_hostgroup');
INSERT INTO `auth_permission` VALUES (42, 'Can change host group', 11, 'change_hostgroup');
INSERT INTO `auth_permission` VALUES (43, 'Can delete host group', 11, 'delete_hostgroup');
INSERT INTO `auth_permission` VALUES (44, 'Can view host group', 11, 'view_hostgroup');
INSERT INTO `auth_permission` VALUES (45, 'Can add idc', 12, 'add_idc');
INSERT INTO `auth_permission` VALUES (46, 'Can change idc', 12, 'change_idc');
INSERT INTO `auth_permission` VALUES (47, 'Can delete idc', 12, 'delete_idc');
INSERT INTO `auth_permission` VALUES (48, 'Can view idc', 12, 'view_idc');
INSERT INTO `auth_permission` VALUES (49, 'Can add netwk', 13, 'add_netwk');
INSERT INTO `auth_permission` VALUES (50, 'Can change netwk', 13, 'change_netwk');
INSERT INTO `auth_permission` VALUES (51, 'Can delete netwk', 13, 'delete_netwk');
INSERT INTO `auth_permission` VALUES (52, 'Can view netwk', 13, 'view_netwk');
INSERT INTO `auth_permission` VALUES (53, 'Can add supplier', 14, 'add_supplier');
INSERT INTO `auth_permission` VALUES (54, 'Can change supplier', 14, 'change_supplier');
INSERT INTO `auth_permission` VALUES (55, 'Can delete supplier', 14, 'delete_supplier');
INSERT INTO `auth_permission` VALUES (56, 'Can view supplier', 14, 'view_supplier');
INSERT INTO `auth_permission` VALUES (57, 'Can add wchart req', 15, 'add_wchartreq');
INSERT INTO `auth_permission` VALUES (58, 'Can change wchart req', 15, 'change_wchartreq');
INSERT INTO `auth_permission` VALUES (59, 'Can delete wchart req', 15, 'delete_wchartreq');
INSERT INTO `auth_permission` VALUES (60, 'Can view wchart req', 15, 'view_wchartreq');
INSERT INTO `auth_permission` VALUES (61, 'Can add publist record', 16, 'add_publistrecord');
INSERT INTO `auth_permission` VALUES (62, 'Can change publist record', 16, 'change_publistrecord');
INSERT INTO `auth_permission` VALUES (63, 'Can delete publist record', 16, 'delete_publistrecord');
INSERT INTO `auth_permission` VALUES (64, 'Can view publist record', 16, 'view_publistrecord');
INSERT INTO `auth_permission` VALUES (65, 'Can add git mg', 17, 'add_gitmg');
INSERT INTO `auth_permission` VALUES (66, 'Can change git mg', 17, 'change_gitmg');
INSERT INTO `auth_permission` VALUES (67, 'Can delete git mg', 17, 'delete_gitmg');
INSERT INTO `auth_permission` VALUES (68, 'Can view git mg', 17, 'view_gitmg');
INSERT INTO `auth_permission` VALUES (69, 'Can add publist', 18, 'add_publist');
INSERT INTO `auth_permission` VALUES (70, 'Can change publist', 18, 'change_publist');
INSERT INTO `auth_permission` VALUES (71, 'Can delete publist', 18, 'delete_publist');
INSERT INTO `auth_permission` VALUES (72, 'Can view publist', 18, 'view_publist');
INSERT INTO `auth_permission` VALUES (73, 'Can add project', 19, 'add_project');
INSERT INTO `auth_permission` VALUES (74, 'Can change project', 19, 'change_project');
INSERT INTO `auth_permission` VALUES (75, 'Can delete project', 19, 'delete_project');
INSERT INTO `auth_permission` VALUES (76, 'Can view project', 19, 'view_project');
INSERT INTO `auth_permission` VALUES (77, 'Can add git code', 20, 'add_gitcode');
INSERT INTO `auth_permission` VALUES (78, 'Can change git code', 20, 'change_gitcode');
INSERT INTO `auth_permission` VALUES (79, 'Can delete git code', 20, 'delete_gitcode');
INSERT INTO `auth_permission` VALUES (80, 'Can view git code', 20, 'view_gitcode');
INSERT INTO `auth_permission` VALUES (81, 'Can add wchartlog', 15, 'add_wchartlog');
INSERT INTO `auth_permission` VALUES (82, 'Can change wchartlog', 15, 'change_wchartlog');
INSERT INTO `auth_permission` VALUES (83, 'Can delete wchartlog', 15, 'delete_wchartlog');
INSERT INTO `auth_permission` VALUES (84, 'Can view wchartlog', 15, 'view_wchartlog');
INSERT INTO `auth_permission` VALUES (85, 'Can add env install', 21, 'add_envinstall');
INSERT INTO `auth_permission` VALUES (86, 'Can change env install', 21, 'change_envinstall');
INSERT INTO `auth_permission` VALUES (87, 'Can delete env install', 21, 'delete_envinstall');
INSERT INTO `auth_permission` VALUES (88, 'Can view env install', 21, 'view_envinstall');
INSERT INTO `auth_permission` VALUES (89, 'Can add env sofeware', 21, 'add_envsofeware');
INSERT INTO `auth_permission` VALUES (90, 'Can change env sofeware', 21, 'change_envsofeware');
INSERT INTO `auth_permission` VALUES (91, 'Can delete env sofeware', 21, 'delete_envsofeware');
INSERT INTO `auth_permission` VALUES (92, 'Can view env sofeware', 21, 'view_envsofeware');
INSERT INTO `auth_permission` VALUES (93, 'Can add ops log', 22, 'add_opslog');
INSERT INTO `auth_permission` VALUES (94, 'Can change ops log', 22, 'change_opslog');
INSERT INTO `auth_permission` VALUES (95, 'Can delete ops log', 22, 'delete_opslog');
INSERT INTO `auth_permission` VALUES (96, 'Can view ops log', 22, 'view_opslog');
INSERT INTO `auth_permission` VALUES (97, 'Can add user log', 23, 'add_userlog');
INSERT INTO `auth_permission` VALUES (98, 'Can change user log', 23, 'change_userlog');
INSERT INTO `auth_permission` VALUES (99, 'Can delete user log', 23, 'delete_userlog');
INSERT INTO `auth_permission` VALUES (100, 'Can view user log', 23, 'view_userlog');
INSERT INTO `auth_permission` VALUES (101, 'Can add host detail', 24, 'add_hostdetail');
INSERT INTO `auth_permission` VALUES (102, 'Can change host detail', 24, 'change_hostdetail');
INSERT INTO `auth_permission` VALUES (103, 'Can delete host detail', 24, 'delete_hostdetail');
INSERT INTO `auth_permission` VALUES (104, 'Can view host detail', 24, 'view_hostdetail');
INSERT INTO `auth_permission` VALUES (105, 'Can add software', 25, 'add_software');
INSERT INTO `auth_permission` VALUES (106, 'Can change software', 25, 'change_software');
INSERT INTO `auth_permission` VALUES (107, 'Can delete software', 25, 'delete_software');
INSERT INTO `auth_permission` VALUES (108, 'Can view software', 25, 'view_software');
INSERT INTO `auth_permission` VALUES (109, 'Can add remote user', 26, 'add_remoteuser');
INSERT INTO `auth_permission` VALUES (110, 'Can change remote user', 26, 'change_remoteuser');
INSERT INTO `auth_permission` VALUES (111, 'Can delete remote user', 26, 'delete_remoteuser');
INSERT INTO `auth_permission` VALUES (112, 'Can view remote user', 26, 'view_remoteuser');
INSERT INTO `auth_permission` VALUES (113, 'Can add crontab', 27, 'add_crontabschedule');
INSERT INTO `auth_permission` VALUES (114, 'Can change crontab', 27, 'change_crontabschedule');
INSERT INTO `auth_permission` VALUES (115, 'Can delete crontab', 27, 'delete_crontabschedule');
INSERT INTO `auth_permission` VALUES (116, 'Can view crontab', 27, 'view_crontabschedule');
INSERT INTO `auth_permission` VALUES (117, 'Can add interval', 28, 'add_intervalschedule');
INSERT INTO `auth_permission` VALUES (118, 'Can change interval', 28, 'change_intervalschedule');
INSERT INTO `auth_permission` VALUES (119, 'Can delete interval', 28, 'delete_intervalschedule');
INSERT INTO `auth_permission` VALUES (120, 'Can view interval', 28, 'view_intervalschedule');
INSERT INTO `auth_permission` VALUES (121, 'Can add periodic task', 29, 'add_periodictask');
INSERT INTO `auth_permission` VALUES (122, 'Can change periodic task', 29, 'change_periodictask');
INSERT INTO `auth_permission` VALUES (123, 'Can delete periodic task', 29, 'delete_periodictask');
INSERT INTO `auth_permission` VALUES (124, 'Can view periodic task', 29, 'view_periodictask');
INSERT INTO `auth_permission` VALUES (125, 'Can add periodic tasks', 30, 'add_periodictasks');
INSERT INTO `auth_permission` VALUES (126, 'Can change periodic tasks', 30, 'change_periodictasks');
INSERT INTO `auth_permission` VALUES (127, 'Can delete periodic tasks', 30, 'delete_periodictasks');
INSERT INTO `auth_permission` VALUES (128, 'Can view periodic tasks', 30, 'view_periodictasks');
INSERT INTO `auth_permission` VALUES (129, 'Can add task state', 31, 'add_taskmeta');
INSERT INTO `auth_permission` VALUES (130, 'Can change task state', 31, 'change_taskmeta');
INSERT INTO `auth_permission` VALUES (131, 'Can delete task state', 31, 'delete_taskmeta');
INSERT INTO `auth_permission` VALUES (132, 'Can view task state', 31, 'view_taskmeta');
INSERT INTO `auth_permission` VALUES (133, 'Can add saved group result', 32, 'add_tasksetmeta');
INSERT INTO `auth_permission` VALUES (134, 'Can change saved group result', 32, 'change_tasksetmeta');
INSERT INTO `auth_permission` VALUES (135, 'Can delete saved group result', 32, 'delete_tasksetmeta');
INSERT INTO `auth_permission` VALUES (136, 'Can view saved group result', 32, 'view_tasksetmeta');
INSERT INTO `auth_permission` VALUES (137, 'Can add task', 33, 'add_taskstate');
INSERT INTO `auth_permission` VALUES (138, 'Can change task', 33, 'change_taskstate');
INSERT INTO `auth_permission` VALUES (139, 'Can delete task', 33, 'delete_taskstate');
INSERT INTO `auth_permission` VALUES (140, 'Can view task', 33, 'view_taskstate');
INSERT INTO `auth_permission` VALUES (141, 'Can add worker', 34, 'add_workerstate');
INSERT INTO `auth_permission` VALUES (142, 'Can change worker', 34, 'change_workerstate');
INSERT INTO `auth_permission` VALUES (143, 'Can delete worker', 34, 'delete_workerstate');
INSERT INTO `auth_permission` VALUES (144, 'Can view worker', 34, 'view_workerstate');
INSERT INTO `auth_permission` VALUES (145, 'Can add task record', 35, 'add_taskrecord');
INSERT INTO `auth_permission` VALUES (146, 'Can change task record', 35, 'change_taskrecord');
INSERT INTO `auth_permission` VALUES (147, 'Can delete task record', 35, 'delete_taskrecord');
INSERT INTO `auth_permission` VALUES (148, 'Can view task record', 35, 'view_taskrecord');
INSERT INTO `auth_permission` VALUES (149, 'Can add key', 36, 'add_key');
INSERT INTO `auth_permission` VALUES (150, 'Can change key', 36, 'change_key');
INSERT INTO `auth_permission` VALUES (151, 'Can delete key', 36, 'delete_key');
INSERT INTO `auth_permission` VALUES (152, 'Can view key', 36, 'view_key');
INSERT INTO `auth_permission` VALUES (153, 'Can add db', 37, 'add_db');
INSERT INTO `auth_permission` VALUES (154, 'Can change db', 37, 'change_db');
INSERT INTO `auth_permission` VALUES (155, 'Can delete db', 37, 'delete_db');
INSERT INTO `auth_permission` VALUES (156, 'Can view db', 37, 'view_db');
INSERT INTO `auth_permission` VALUES (157, 'Can add inception', 38, 'add_inception');
INSERT INTO `auth_permission` VALUES (158, 'Can change inception', 38, 'change_inception');
INSERT INTO `auth_permission` VALUES (159, 'Can delete inception', 38, 'delete_inception');
INSERT INTO `auth_permission` VALUES (160, 'Can view inception', 38, 'view_inception');
INSERT INTO `auth_permission` VALUES (161, 'Can add inc db', 39, 'add_incdb');
INSERT INTO `auth_permission` VALUES (162, 'Can change inc db', 39, 'change_incdb');
INSERT INTO `auth_permission` VALUES (163, 'Can delete inc db', 39, 'delete_incdb');
INSERT INTO `auth_permission` VALUES (164, 'Can view inc db', 39, 'view_incdb');
INSERT INTO `auth_permission` VALUES (165, 'Can add back db', 40, 'add_backdb');
INSERT INTO `auth_permission` VALUES (166, 'Can change back db', 40, 'change_backdb');
INSERT INTO `auth_permission` VALUES (167, 'Can delete back db', 40, 'delete_backdb');
INSERT INTO `auth_permission` VALUES (168, 'Can view back db', 40, 'view_backdb');
INSERT INTO `auth_permission` VALUES (169, 'Can add work order log', 41, 'add_workorderlog');
INSERT INTO `auth_permission` VALUES (170, 'Can change work order log', 41, 'change_workorderlog');
INSERT INTO `auth_permission` VALUES (171, 'Can delete work order log', 41, 'delete_workorderlog');
INSERT INTO `auth_permission` VALUES (172, 'Can view work order log', 41, 'view_workorderlog');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for celery_taskmeta
-- ----------------------------
DROP TABLE IF EXISTS `celery_taskmeta`;
CREATE TABLE `celery_taskmeta`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `result` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `date_done` datetime(6) NOT NULL,
  `traceback` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `task_id`(`task_id`) USING BTREE,
  INDEX `celery_taskmeta_hidden_23fd02dc`(`hidden`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for celery_tasksetmeta
-- ----------------------------
DROP TABLE IF EXISTS `celery_tasksetmeta`;
CREATE TABLE `celery_tasksetmeta`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskset_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `result` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date_done` datetime(6) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `taskset_id`(`taskset_id`) USING BTREE,
  INDEX `celery_tasksetmeta_hidden_593cfc24`(`hidden`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (10, 'app_asset', 'host');
INSERT INTO `django_content_type` VALUES (24, 'app_asset', 'hostdetail');
INSERT INTO `django_content_type` VALUES (11, 'app_asset', 'hostgroup');
INSERT INTO `django_content_type` VALUES (12, 'app_asset', 'idc');
INSERT INTO `django_content_type` VALUES (13, 'app_asset', 'netwk');
INSERT INTO `django_content_type` VALUES (25, 'app_asset', 'software');
INSERT INTO `django_content_type` VALUES (14, 'app_asset', 'supplier');
INSERT INTO `django_content_type` VALUES (36, 'app_auth', 'key');
INSERT INTO `django_content_type` VALUES (6, 'app_auth', 'menus');
INSERT INTO `django_content_type` VALUES (7, 'app_auth', 'perms');
INSERT INTO `django_content_type` VALUES (26, 'app_auth', 'remoteuser');
INSERT INTO `django_content_type` VALUES (8, 'app_auth', 'role');
INSERT INTO `django_content_type` VALUES (9, 'app_auth', 'user');
INSERT INTO `django_content_type` VALUES (20, 'app_code', 'gitcode');
INSERT INTO `django_content_type` VALUES (17, 'app_code', 'gitmg');
INSERT INTO `django_content_type` VALUES (19, 'app_code', 'project');
INSERT INTO `django_content_type` VALUES (18, 'app_code', 'publist');
INSERT INTO `django_content_type` VALUES (16, 'app_code', 'publistrecord');
INSERT INTO `django_content_type` VALUES (15, 'app_code', 'wchartlog');
INSERT INTO `django_content_type` VALUES (40, 'app_db', 'backdb');
INSERT INTO `django_content_type` VALUES (37, 'app_db', 'db');
INSERT INTO `django_content_type` VALUES (39, 'app_db', 'incdb');
INSERT INTO `django_content_type` VALUES (38, 'app_db', 'inception');
INSERT INTO `django_content_type` VALUES (41, 'app_db', 'workorderlog');
INSERT INTO `django_content_type` VALUES (22, 'app_log', 'opslog');
INSERT INTO `django_content_type` VALUES (35, 'app_log', 'taskrecord');
INSERT INTO `django_content_type` VALUES (23, 'app_log', 'userlog');
INSERT INTO `django_content_type` VALUES (21, 'app_sys', 'envsofeware');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (1, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (27, 'djcelery', 'crontabschedule');
INSERT INTO `django_content_type` VALUES (28, 'djcelery', 'intervalschedule');
INSERT INTO `django_content_type` VALUES (29, 'djcelery', 'periodictask');
INSERT INTO `django_content_type` VALUES (30, 'djcelery', 'periodictasks');
INSERT INTO `django_content_type` VALUES (31, 'djcelery', 'taskmeta');
INSERT INTO `django_content_type` VALUES (32, 'djcelery', 'tasksetmeta');
INSERT INTO `django_content_type` VALUES (33, 'djcelery', 'taskstate');
INSERT INTO `django_content_type` VALUES (34, 'djcelery', 'workerstate');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'app_asset', '0001_initial', '2018-12-27 07:48:55.190228');
INSERT INTO `django_migrations` VALUES (2, 'app_code', '0001_initial', '2018-12-27 07:48:59.726487');
INSERT INTO `django_migrations` VALUES (3, 'app_auth', '0001_initial', '2018-12-27 07:49:14.806350');
INSERT INTO `django_migrations` VALUES (4, 'app_db', '0001_initial', '2018-12-27 07:49:18.838580');
INSERT INTO `django_migrations` VALUES (5, 'app_log', '0001_initial', '2018-12-27 07:49:20.444672');
INSERT INTO `django_migrations` VALUES (6, 'app_sys', '0001_initial', '2018-12-27 07:49:20.760690');
INSERT INTO `django_migrations` VALUES (7, 'contenttypes', '0001_initial', '2018-12-27 07:49:21.278720');
INSERT INTO `django_migrations` VALUES (8, 'contenttypes', '0002_remove_content_type_name', '2018-12-27 07:49:22.384783');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0001_initial', '2018-12-27 07:49:30.226232');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0002_alter_permission_name_max_length', '2018-12-27 07:49:31.034278');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0003_alter_user_email_max_length', '2018-12-27 07:49:31.567308');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0004_alter_user_username_opts', '2018-12-27 07:49:31.674314');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0005_alter_user_last_login_null', '2018-12-27 07:49:32.153342');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0006_require_contenttypes_0002', '2018-12-27 07:49:32.206345');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0007_alter_validators_add_error_messages', '2018-12-27 07:49:32.262348');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0008_alter_user_username_max_length', '2018-12-27 07:49:32.887384');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0009_alter_user_last_name_max_length', '2018-12-27 07:49:33.506419');
INSERT INTO `django_migrations` VALUES (18, 'djcelery', '0001_initial', '2018-12-27 07:49:39.545765');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2018-12-27 07:49:40.100796');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for djcelery_crontabschedule
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_crontabschedule`;
CREATE TABLE `djcelery_crontabschedule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hour` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `day_of_week` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `day_of_month` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `month_of_year` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for djcelery_intervalschedule
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_intervalschedule`;
CREATE TABLE `djcelery_intervalschedule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for djcelery_periodictask
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictask`;
CREATE TABLE `djcelery_periodictask`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `task` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `args` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kwargs` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `queue` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `exchange` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `routing_key` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expires` datetime(6) NULL DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) NULL DEFAULT NULL,
  `total_run_count` int(10) UNSIGNED NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `crontab_id` int(11) NULL DEFAULT NULL,
  `interval_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_`(`crontab_id`) USING BTREE,
  INDEX `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_`(`interval_id`) USING BTREE,
  CONSTRAINT `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for djcelery_periodictasks
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictasks`;
CREATE TABLE `djcelery_periodictasks`  (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for djcelery_taskstate
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_taskstate`;
CREATE TABLE `djcelery_taskstate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `task_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tstamp` datetime(6) NOT NULL,
  `args` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `kwargs` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `eta` datetime(6) NULL DEFAULT NULL,
  `expires` datetime(6) NULL DEFAULT NULL,
  `result` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `traceback` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `runtime` double NULL DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `worker_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `task_id`(`task_id`) USING BTREE,
  INDEX `djcelery_taskstate_state_53543be4`(`state`) USING BTREE,
  INDEX `djcelery_taskstate_name_8af9eded`(`name`) USING BTREE,
  INDEX `djcelery_taskstate_tstamp_4c3f93a1`(`tstamp`) USING BTREE,
  INDEX `djcelery_taskstate_hidden_c3905e57`(`hidden`) USING BTREE,
  INDEX `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id`(`worker_id`) USING BTREE,
  CONSTRAINT `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for djcelery_workerstate
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_workerstate`;
CREATE TABLE `djcelery_workerstate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_heartbeat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `hostname`(`hostname`) USING BTREE,
  INDEX `djcelery_workerstate_last_heartbeat_4539b544`(`last_heartbeat`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
