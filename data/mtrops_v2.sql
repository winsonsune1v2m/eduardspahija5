/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50640
 Source Host           : 127.0.0.1:3306
 Source Schema         : mtrops_v2

 Target Server Type    : MySQL
 Target Server Version : 50640
 File Encoding         : 65001

 Date: 12/10/2018 17:45:24
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_host
-- ----------------------------
INSERT INTO `app_asset_host` VALUES (1, '127.0.0.1', '22', 'root', 'b\'d4721440af5b9f9f9a9915f5b2358ffb\'', '物理机', '测试', '123456', '123456', '4656', '2018-10-09 09:32:56.052939', 3, 1, 1);
INSERT INTO `app_asset_host` VALUES (2, '127.0.0.2', '22', 'root', 'b\'52b1f17f30c2ec0c7b0ecc64b46c1cda\'', '虚拟机', '', '', '', '', '2018-10-10 06:54:14.235656', 5, 1, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_hostgroup
-- ----------------------------
INSERT INTO `app_asset_hostgroup` VALUES (3, '服务器-运维', '运维服务器');
INSERT INTO `app_asset_hostgroup` VALUES (4, '路由器-运维', '运维路由器');
INSERT INTO `app_asset_hostgroup` VALUES (5, '服务器-测试', '测试服务器');
INSERT INTO `app_asset_hostgroup` VALUES (6, '交换机-测试', '测试-交换机');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_idc
-- ----------------------------
INSERT INTO `app_asset_idc` VALUES (1, '木头人', '木头人', 'lzx', '10086', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_netwk
-- ----------------------------
INSERT INTO `app_asset_netwk` VALUES (1, '172.16.1.1', '22', 'admin', 'b\'d4721440af5b9f9f9a9915f5b2358ffb\'', '路由器', '', '', '', '', '2018-10-12 06:28:47.383167', 4, 1, 1);
INSERT INTO `app_asset_netwk` VALUES (2, '172.16.2.1', '22', 'admin', 'b\'d4721440af5b9f9f9a9915f5b2358ffb\'', '交换机', '', '', '', '', '2018-10-12 07:10:09.984164', 6, 1, 1);

-- ----------------------------
-- Table structure for app_asset_supplier
-- ----------------------------
DROP TABLE IF EXISTS `app_asset_supplier`;
CREATE TABLE `app_asset_supplier`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_head` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_head_phone` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_head_email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_asset_supplier
-- ----------------------------
INSERT INTO `app_asset_supplier` VALUES (1, '维盟', 'lzx', '10086', '');

-- ----------------------------
-- Table structure for app_auth_menus
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_menus`;
CREATE TABLE `app_auth_menus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pmenu_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_icon` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_order` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_menus
-- ----------------------------
INSERT INTO `app_auth_menus` VALUES (1, '首页', '/', '一级菜单', '0', '1', 'fa fa-lg fa-dashboard', NULL);
INSERT INTO `app_auth_menus` VALUES (2, '资产管理', '', '一级菜单', '0', '2', 'fa fa-lg fa-bars', NULL);
INSERT INTO `app_auth_menus` VALUES (3, '代码管理', '', '一级菜单', '0', '3', 'fa fa-lg fa-code', NULL);
INSERT INTO `app_auth_menus` VALUES (4, '系统管理', '', '一级菜单', '0', '4', 'fa fa-lg fa-desktop', NULL);
INSERT INTO `app_auth_menus` VALUES (5, '运维工具', '', '一级菜单', '0', '5', 'fa fa-lg fa-wrench', NULL);
INSERT INTO `app_auth_menus` VALUES (6, '日志审计', '', '一级菜单', '0', '6', 'fa fa-lg fa-address-card', NULL);
INSERT INTO `app_auth_menus` VALUES (7, '后台管理', '', '一级菜单', '0', '7', 'fa fa-lg fa-cog', NULL);
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
INSERT INTO `app_auth_menus` VALUES (20, 'webssh', '/tool/webssh/', '二级菜单', '5', '5020', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (21, 'phpMyadmin', '/tool/phpmyadmin/', '二级菜单', '5', '5021', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (22, '操作日志', '/log/opslog/', '二级菜单', '6', '6022', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (23, '用户日志', '/log/userlog/', '二级菜单', '6', '6023', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (24, '角色管理', '/auth/role/', '二级菜单', '7', '7024', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (25, '用户管理', '/auth/user/', '二级菜单', '7', '7025', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (26, '菜单管理', '/auth/menu/', '二级菜单', '7', '7026', NULL, NULL);
INSERT INTO `app_auth_menus` VALUES (27, '权限管理', '/auth/perms/', '二级菜单', '7', '7027', NULL, NULL);

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
  CONSTRAINT `app_auth_perms_menus_id_57ecaabb_fk_app_auth_menus_id` FOREIGN KEY (`menus_id`) REFERENCES `app_auth_menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `app_auth_perms` VALUES (35, 'other', 16, '更新发布请求', '');
INSERT INTO `app_auth_perms` VALUES (36, 'post', 17, '添加环境', NULL);
INSERT INTO `app_auth_perms` VALUES (37, 'delete', 17, '删除环境', NULL);
INSERT INTO `app_auth_perms` VALUES (38, 'put', 17, '修改环境', NULL);
INSERT INTO `app_auth_perms` VALUES (39, 'get', 17, '查询环境', NULL);
INSERT INTO `app_auth_perms` VALUES (40, 'get', 18, '访问批量管理', NULL);
INSERT INTO `app_auth_perms` VALUES (41, 'get', 19, '访问文件管理', NULL);
INSERT INTO `app_auth_perms` VALUES (42, 'get', 20, '访问webssh', NULL);
INSERT INTO `app_auth_perms` VALUES (43, 'get', 21, '访问phpmyadmin', NULL);
INSERT INTO `app_auth_perms` VALUES (44, 'get', 22, '查看操作日志', NULL);
INSERT INTO `app_auth_perms` VALUES (45, 'get', 23, '查看用户日志', NULL);
INSERT INTO `app_auth_perms` VALUES (46, 'get', 24, '添加角色', NULL);
INSERT INTO `app_auth_perms` VALUES (47, 'delete', 24, '删除角色', NULL);
INSERT INTO `app_auth_perms` VALUES (48, 'put', 24, '删除修改', NULL);
INSERT INTO `app_auth_perms` VALUES (49, 'get', 24, '查看角色', NULL);
INSERT INTO `app_auth_perms` VALUES (50, 'other', 24, '角色菜单授权', '/auth/addrolemenu/');
INSERT INTO `app_auth_perms` VALUES (51, 'other', 24, '角色权限授权', '/auth/addroleperms/');

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
INSERT INTO `app_auth_role` VALUES (1, 'administrator', '超级管理员');
INSERT INTO `app_auth_role` VALUES (2, 'admin', '管理员');

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_host
-- ----------------------------
INSERT INTO `app_auth_role_host` VALUES (14, 1, 1);
INSERT INTO `app_auth_role_host` VALUES (15, 1, 2);
INSERT INTO `app_auth_role_host` VALUES (16, 2, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 280 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_menu
-- ----------------------------
INSERT INTO `app_auth_role_menu` VALUES (52, 1, 1);
INSERT INTO `app_auth_role_menu` VALUES (53, 1, 2);
INSERT INTO `app_auth_role_menu` VALUES (59, 1, 3);
INSERT INTO `app_auth_role_menu` VALUES (64, 1, 4);
INSERT INTO `app_auth_role_menu` VALUES (68, 1, 5);
INSERT INTO `app_auth_role_menu` VALUES (71, 1, 6);
INSERT INTO `app_auth_role_menu` VALUES (74, 1, 7);
INSERT INTO `app_auth_role_menu` VALUES (54, 1, 8);
INSERT INTO `app_auth_role_menu` VALUES (55, 1, 9);
INSERT INTO `app_auth_role_menu` VALUES (56, 1, 10);
INSERT INTO `app_auth_role_menu` VALUES (57, 1, 11);
INSERT INTO `app_auth_role_menu` VALUES (58, 1, 12);
INSERT INTO `app_auth_role_menu` VALUES (60, 1, 13);
INSERT INTO `app_auth_role_menu` VALUES (61, 1, 14);
INSERT INTO `app_auth_role_menu` VALUES (62, 1, 15);
INSERT INTO `app_auth_role_menu` VALUES (63, 1, 16);
INSERT INTO `app_auth_role_menu` VALUES (65, 1, 17);
INSERT INTO `app_auth_role_menu` VALUES (66, 1, 18);
INSERT INTO `app_auth_role_menu` VALUES (67, 1, 19);
INSERT INTO `app_auth_role_menu` VALUES (69, 1, 20);
INSERT INTO `app_auth_role_menu` VALUES (70, 1, 21);
INSERT INTO `app_auth_role_menu` VALUES (72, 1, 22);
INSERT INTO `app_auth_role_menu` VALUES (73, 1, 23);
INSERT INTO `app_auth_role_menu` VALUES (75, 1, 24);
INSERT INTO `app_auth_role_menu` VALUES (76, 1, 25);
INSERT INTO `app_auth_role_menu` VALUES (77, 1, 26);
INSERT INTO `app_auth_role_menu` VALUES (78, 1, 27);
INSERT INTO `app_auth_role_menu` VALUES (258, 2, 1);
INSERT INTO `app_auth_role_menu` VALUES (259, 2, 2);
INSERT INTO `app_auth_role_menu` VALUES (265, 2, 3);
INSERT INTO `app_auth_role_menu` VALUES (270, 2, 4);
INSERT INTO `app_auth_role_menu` VALUES (274, 2, 5);
INSERT INTO `app_auth_role_menu` VALUES (277, 2, 6);
INSERT INTO `app_auth_role_menu` VALUES (260, 2, 8);
INSERT INTO `app_auth_role_menu` VALUES (261, 2, 9);
INSERT INTO `app_auth_role_menu` VALUES (262, 2, 10);
INSERT INTO `app_auth_role_menu` VALUES (263, 2, 11);
INSERT INTO `app_auth_role_menu` VALUES (264, 2, 12);
INSERT INTO `app_auth_role_menu` VALUES (266, 2, 13);
INSERT INTO `app_auth_role_menu` VALUES (267, 2, 14);
INSERT INTO `app_auth_role_menu` VALUES (268, 2, 15);
INSERT INTO `app_auth_role_menu` VALUES (269, 2, 16);
INSERT INTO `app_auth_role_menu` VALUES (271, 2, 17);
INSERT INTO `app_auth_role_menu` VALUES (272, 2, 18);
INSERT INTO `app_auth_role_menu` VALUES (273, 2, 19);
INSERT INTO `app_auth_role_menu` VALUES (275, 2, 20);
INSERT INTO `app_auth_role_menu` VALUES (276, 2, 21);
INSERT INTO `app_auth_role_menu` VALUES (278, 2, 22);
INSERT INTO `app_auth_role_menu` VALUES (279, 2, 23);

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_netwk
-- ----------------------------
INSERT INTO `app_auth_role_netwk` VALUES (11, 1, 1);
INSERT INTO `app_auth_role_netwk` VALUES (12, 1, 2);

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
) ENGINE = InnoDB AUTO_INCREMENT = 164 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_perms
-- ----------------------------
INSERT INTO `app_auth_role_perms` VALUES (116, 1, 4);
INSERT INTO `app_auth_role_perms` VALUES (117, 1, 5);
INSERT INTO `app_auth_role_perms` VALUES (118, 1, 6);
INSERT INTO `app_auth_role_perms` VALUES (119, 1, 7);
INSERT INTO `app_auth_role_perms` VALUES (120, 1, 8);
INSERT INTO `app_auth_role_perms` VALUES (121, 1, 9);
INSERT INTO `app_auth_role_perms` VALUES (122, 1, 10);
INSERT INTO `app_auth_role_perms` VALUES (123, 1, 11);
INSERT INTO `app_auth_role_perms` VALUES (124, 1, 12);
INSERT INTO `app_auth_role_perms` VALUES (125, 1, 13);
INSERT INTO `app_auth_role_perms` VALUES (126, 1, 14);
INSERT INTO `app_auth_role_perms` VALUES (127, 1, 15);
INSERT INTO `app_auth_role_perms` VALUES (128, 1, 16);
INSERT INTO `app_auth_role_perms` VALUES (129, 1, 17);
INSERT INTO `app_auth_role_perms` VALUES (130, 1, 18);
INSERT INTO `app_auth_role_perms` VALUES (131, 1, 19);
INSERT INTO `app_auth_role_perms` VALUES (132, 1, 20);
INSERT INTO `app_auth_role_perms` VALUES (133, 1, 21);
INSERT INTO `app_auth_role_perms` VALUES (134, 1, 22);
INSERT INTO `app_auth_role_perms` VALUES (135, 1, 23);
INSERT INTO `app_auth_role_perms` VALUES (136, 1, 24);
INSERT INTO `app_auth_role_perms` VALUES (137, 1, 25);
INSERT INTO `app_auth_role_perms` VALUES (138, 1, 26);
INSERT INTO `app_auth_role_perms` VALUES (139, 1, 27);
INSERT INTO `app_auth_role_perms` VALUES (140, 1, 28);
INSERT INTO `app_auth_role_perms` VALUES (141, 1, 29);
INSERT INTO `app_auth_role_perms` VALUES (142, 1, 30);
INSERT INTO `app_auth_role_perms` VALUES (143, 1, 31);
INSERT INTO `app_auth_role_perms` VALUES (144, 1, 32);
INSERT INTO `app_auth_role_perms` VALUES (145, 1, 33);
INSERT INTO `app_auth_role_perms` VALUES (146, 1, 34);
INSERT INTO `app_auth_role_perms` VALUES (147, 1, 35);
INSERT INTO `app_auth_role_perms` VALUES (148, 1, 36);
INSERT INTO `app_auth_role_perms` VALUES (149, 1, 37);
INSERT INTO `app_auth_role_perms` VALUES (150, 1, 38);
INSERT INTO `app_auth_role_perms` VALUES (151, 1, 39);
INSERT INTO `app_auth_role_perms` VALUES (152, 1, 40);
INSERT INTO `app_auth_role_perms` VALUES (153, 1, 41);
INSERT INTO `app_auth_role_perms` VALUES (154, 1, 42);
INSERT INTO `app_auth_role_perms` VALUES (155, 1, 43);
INSERT INTO `app_auth_role_perms` VALUES (156, 1, 44);
INSERT INTO `app_auth_role_perms` VALUES (157, 1, 45);
INSERT INTO `app_auth_role_perms` VALUES (158, 1, 46);
INSERT INTO `app_auth_role_perms` VALUES (159, 1, 47);
INSERT INTO `app_auth_role_perms` VALUES (160, 1, 48);
INSERT INTO `app_auth_role_perms` VALUES (161, 1, 49);
INSERT INTO `app_auth_role_perms` VALUES (162, 1, 50);
INSERT INTO `app_auth_role_perms` VALUES (163, 1, 51);
INSERT INTO `app_auth_role_perms` VALUES (84, 2, 4);
INSERT INTO `app_auth_role_perms` VALUES (85, 2, 5);
INSERT INTO `app_auth_role_perms` VALUES (86, 2, 6);
INSERT INTO `app_auth_role_perms` VALUES (87, 2, 7);
INSERT INTO `app_auth_role_perms` VALUES (88, 2, 8);
INSERT INTO `app_auth_role_perms` VALUES (89, 2, 9);
INSERT INTO `app_auth_role_perms` VALUES (90, 2, 10);
INSERT INTO `app_auth_role_perms` VALUES (91, 2, 11);
INSERT INTO `app_auth_role_perms` VALUES (92, 2, 12);
INSERT INTO `app_auth_role_perms` VALUES (93, 2, 13);
INSERT INTO `app_auth_role_perms` VALUES (94, 2, 14);
INSERT INTO `app_auth_role_perms` VALUES (95, 2, 15);
INSERT INTO `app_auth_role_perms` VALUES (96, 2, 16);
INSERT INTO `app_auth_role_perms` VALUES (97, 2, 17);
INSERT INTO `app_auth_role_perms` VALUES (98, 2, 18);
INSERT INTO `app_auth_role_perms` VALUES (99, 2, 19);
INSERT INTO `app_auth_role_perms` VALUES (100, 2, 20);
INSERT INTO `app_auth_role_perms` VALUES (101, 2, 21);
INSERT INTO `app_auth_role_perms` VALUES (102, 2, 22);
INSERT INTO `app_auth_role_perms` VALUES (103, 2, 23);
INSERT INTO `app_auth_role_perms` VALUES (104, 2, 24);
INSERT INTO `app_auth_role_perms` VALUES (105, 2, 25);
INSERT INTO `app_auth_role_perms` VALUES (106, 2, 26);
INSERT INTO `app_auth_role_perms` VALUES (107, 2, 27);
INSERT INTO `app_auth_role_perms` VALUES (108, 2, 28);
INSERT INTO `app_auth_role_perms` VALUES (109, 2, 29);
INSERT INTO `app_auth_role_perms` VALUES (110, 2, 30);
INSERT INTO `app_auth_role_perms` VALUES (111, 2, 31);
INSERT INTO `app_auth_role_perms` VALUES (112, 2, 32);
INSERT INTO `app_auth_role_perms` VALUES (113, 2, 33);
INSERT INTO `app_auth_role_perms` VALUES (114, 2, 34);
INSERT INTO `app_auth_role_perms` VALUES (115, 2, 35);

-- ----------------------------
-- Table structure for app_auth_role_project
-- ----------------------------
DROP TABLE IF EXISTS `app_auth_role_project`;
CREATE TABLE `app_auth_role_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `gitcode_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_role_project_role_id_project_id_09f71818_uniq`(`role_id`, `gitcode_id`) USING BTREE,
  INDEX `app_auth_role_project_gitcode_id_d1f3c5bb_fk_app_code_gitcode_id`(`gitcode_id`) USING BTREE,
  CONSTRAINT `app_auth_role_project_gitcode_id_d1f3c5bb_fk_app_code_gitcode_id` FOREIGN KEY (`gitcode_id`) REFERENCES `app_code_gitcode` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_auth_role_project_role_id_8f081530_fk_app_auth_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_auth_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_project
-- ----------------------------
INSERT INTO `app_auth_role_project` VALUES (11, 1, 2);
INSERT INTO `app_auth_role_project` VALUES (12, 1, 3);
INSERT INTO `app_auth_role_project` VALUES (3, 2, 3);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_user
-- ----------------------------
INSERT INTO `app_auth_user` VALUES (1, 'admin', '小贰', 'b\'d4721440af5b9f9f9a9915f5b2358ffb\'', '1343208940@139.com', '1343208940', '', '离线', '2018-10-11 06:13:37.757161', '2018-10-12 09:07:22.390394');
INSERT INTO `app_auth_user` VALUES (2, 'test', '测试', 'b\'5968466f35ac295977e8cc1d0a244247\'', '10086@139.com', '10086', '', '离线', '2018-10-12 01:05:58.167311', '2018-10-12 09:07:11.442768');

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_user_role
-- ----------------------------
INSERT INTO `app_auth_user_role` VALUES (2, 1, 1);
INSERT INTO `app_auth_user_role` VALUES (3, 2, 2);

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
  `git_sshkey` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `git_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `git_name`(`git_name`) USING BTREE,
  UNIQUE INDEX `git_url`(`git_url`) USING BTREE,
  INDEX `app_code_gitcode_project_id_24ec459d_fk_app_code_project_id`(`project_id`) USING BTREE,
  CONSTRAINT `app_code_gitcode_project_id_24ec459d_fk_app_code_project_id` FOREIGN KEY (`project_id`) REFERENCES `app_code_project` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_code_gitcode
-- ----------------------------
INSERT INTO `app_code_gitcode` VALUES (2, 'mtrops_v2', '运维管理平台 第二版', 'https://gitee.com/12x/mtrops_v2.git', 2, 'b\'98c4ce2f2a0cf6b90fafd83bfecee875\'', '', 'git');
INSERT INTO `app_code_gitcode` VALUES (3, 'test', '12321', '1111111111111', 3, 'b\'\'', '', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_code_project
-- ----------------------------
INSERT INTO `app_code_project` VALUES (2, '运维平台', '运维管理平台');
INSERT INTO `app_code_project` VALUES (3, '测试', '测试项目');

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_code_publist_gitcode_id_08f6579e_fk_app_code_gitcode_id`(`gitcode_id`) USING BTREE,
  INDEX `app_code_publist_host_ip_id_55ba2063_fk_app_asset_host_id`(`host_ip_id`) USING BTREE,
  CONSTRAINT `app_code_publist_gitcode_id_08f6579e_fk_app_code_gitcode_id` FOREIGN KEY (`gitcode_id`) REFERENCES `app_code_gitcode` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_code_publist_host_ip_id_55ba2063_fk_app_asset_host_id` FOREIGN KEY (`host_ip_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_code_publist
-- ----------------------------
INSERT INTO `app_code_publist` VALUES (1, '/', '测试', NULL, NULL, NULL, NULL, 2, 1);
INSERT INTO `app_code_publist` VALUES (2, '/', '测试', NULL, NULL, NULL, NULL, 2, 2);
INSERT INTO `app_code_publist` VALUES (3, '', '', NULL, NULL, NULL, NULL, 3, 2);

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_code_publistreco_publist_id_3e2d949d_fk_app_code_`(`publist_id`) USING BTREE,
  CONSTRAINT `app_code_publistreco_publist_id_3e2d949d_fk_app_code_` FOREIGN KEY (`publist_id`) REFERENCES `app_code_publist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_code_wchartlog
-- ----------------------------
INSERT INTO `app_code_wchartlog` VALUES (1, 'mtrops_v2', 'lzx', 'test', '10086', 'done', '2018-10-11 08:23:11.000000');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_log_userlog
-- ----------------------------
DROP TABLE IF EXISTS `app_log_userlog`;
CREATE TABLE `app_log_userlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url_title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `active` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_sys_envsofeware
-- ----------------------------
INSERT INTO `app_sys_envsofeware` VALUES (1, 'php', '7.2.4', '2321');

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
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (10, 'app_asset', 'host');
INSERT INTO `django_content_type` VALUES (11, 'app_asset', 'hostgroup');
INSERT INTO `django_content_type` VALUES (12, 'app_asset', 'idc');
INSERT INTO `django_content_type` VALUES (13, 'app_asset', 'netwk');
INSERT INTO `django_content_type` VALUES (14, 'app_asset', 'supplier');
INSERT INTO `django_content_type` VALUES (6, 'app_auth', 'menus');
INSERT INTO `django_content_type` VALUES (7, 'app_auth', 'perms');
INSERT INTO `django_content_type` VALUES (8, 'app_auth', 'role');
INSERT INTO `django_content_type` VALUES (9, 'app_auth', 'user');
INSERT INTO `django_content_type` VALUES (20, 'app_code', 'gitcode');
INSERT INTO `django_content_type` VALUES (17, 'app_code', 'gitmg');
INSERT INTO `django_content_type` VALUES (19, 'app_code', 'project');
INSERT INTO `django_content_type` VALUES (18, 'app_code', 'publist');
INSERT INTO `django_content_type` VALUES (16, 'app_code', 'publistrecord');
INSERT INTO `django_content_type` VALUES (15, 'app_code', 'wchartlog');
INSERT INTO `django_content_type` VALUES (22, 'app_log', 'opslog');
INSERT INTO `django_content_type` VALUES (23, 'app_log', 'userlog');
INSERT INTO `django_content_type` VALUES (21, 'app_sys', 'envsofeware');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (1, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
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
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'app_asset', '0001_initial', '2018-10-09 08:26:24.472633');
INSERT INTO `django_migrations` VALUES (2, 'app_auth', '0001_initial', '2018-10-09 08:26:31.314025');
INSERT INTO `django_migrations` VALUES (3, 'app_auth', '0002_auto_20181009_0901', '2018-10-09 08:26:32.724105');
INSERT INTO `django_migrations` VALUES (4, 'contenttypes', '0001_initial', '2018-10-09 08:26:33.150130');
INSERT INTO `django_migrations` VALUES (5, 'contenttypes', '0002_remove_content_type_name', '2018-10-09 08:26:34.106184');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0001_initial', '2018-10-09 08:26:41.095584');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2018-10-09 08:26:41.856628');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2018-10-09 08:26:42.540667');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2018-10-09 08:26:42.585669');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2018-10-09 08:26:42.951690');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2018-10-09 08:26:42.984692');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2018-10-09 08:26:43.029695');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2018-10-09 08:26:43.651730');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2018-10-09 08:26:44.296767');
INSERT INTO `django_migrations` VALUES (15, 'sessions', '0001_initial', '2018-10-09 08:26:44.820797');
INSERT INTO `django_migrations` VALUES (16, 'app_code', '0001_initial', '2018-10-10 01:58:55.424677');
INSERT INTO `django_migrations` VALUES (17, 'app_code', '0002_auto_20181010_1036', '2018-10-10 02:36:17.692448');
INSERT INTO `django_migrations` VALUES (18, 'app_code', '0003_auto_20181010_1433', '2018-10-10 06:33:10.734388');
INSERT INTO `django_migrations` VALUES (19, 'app_code', '0004_auto_20181010_1434', '2018-10-10 06:34:06.329568');
INSERT INTO `django_migrations` VALUES (20, 'app_code', '0005_auto_20181010_1435', '2018-10-10 06:35:47.226339');
INSERT INTO `django_migrations` VALUES (21, 'app_code', '0006_auto_20181010_1436', '2018-10-10 06:36:16.408008');
INSERT INTO `django_migrations` VALUES (22, 'app_code', '0007_auto_20181010_1503', '2018-10-10 07:03:51.736687');
INSERT INTO `django_migrations` VALUES (23, 'app_code', '0008_auto_20181010_1608', '2018-10-10 08:08:36.563886');
INSERT INTO `django_migrations` VALUES (24, 'app_code', '0009_auto_20181010_2034', '2018-10-11 00:19:10.389463');
INSERT INTO `django_migrations` VALUES (25, 'app_sys', '0001_initial', '2018-10-11 02:35:05.222167');
INSERT INTO `django_migrations` VALUES (26, 'app_sys', '0002_auto_20181011_1114', '2018-10-11 03:14:55.137863');
INSERT INTO `django_migrations` VALUES (27, 'app_auth', '0003_user_last_login', '2018-10-11 06:57:38.378196');
INSERT INTO `django_migrations` VALUES (28, 'app_log', '0001_initial', '2018-10-11 06:57:39.116239');
INSERT INTO `django_migrations` VALUES (29, 'app_auth', '0004_perms_perms_url', '2018-10-12 00:53:47.356511');
INSERT INTO `django_migrations` VALUES (30, 'app_auth', '0005_auto_20181012_1455', '2018-10-12 06:55:56.476346');
INSERT INTO `django_migrations` VALUES (31, 'app_auth', '0006_auto_20181012_1537', '2018-10-12 07:37:26.091744');
INSERT INTO `django_migrations` VALUES (32, 'app_auth', '0007_auto_20181012_1643', '2018-10-12 08:43:55.769940');

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
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('03b88e8u1uctdv9hk8yf7ruast4hxysi', 'YmI3NTc5OWNkNDdmNTg3ZTNiMTJlNTU5Y2MyNDAyNmRhNzM3YTFhNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBwX2F1dGgudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IiIsInVzZXJuYW1lIjoiXHU1YzBmXHU4ZDMwIiwicm9sZV9pZCI6MSwibWVudV9hbGxfbGlzdCI6W3sibWVudV90aXRsZSI6Ilx1OTk5Nlx1OTg3NSIsIm1lbnVfdXJsIjoiLyIsIm1lbnVfbnVtIjoiMSIsIm1lbnVfaWNvbiI6ImZhIGZhLWxnIGZhLWRhc2hib2FyZCIsIm1lbnVfdHdvIjpbXX0seyJtZW51X3RpdGxlIjoiXHU4ZDQ0XHU0ZWE3XHU3YmExXHU3NDA2IiwibWVudV91cmwiOiIiLCJtZW51X251bSI6IjIiLCJtZW51X2ljb24iOiJmYSBmYS1sZyBmYS1iYXJzIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTY3MGRcdTUyYTFcdTU2NjgiLCJtZW51X3VybCI6Ii9hc3NldC9ob3N0LyIsIm1lbnVfbnVtIjoiMjA4IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjIifSx7Im1lbnVfdGl0bGUiOiJcdTdmNTFcdTdlZGNcdThiYmVcdTU5MDciLCJtZW51X3VybCI6Ii9hc3NldC9uZXR3ay8iLCJtZW51X251bSI6IjIwOSIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIyIn0seyJtZW51X3RpdGxlIjoiSURDIFx1NjczYVx1NjIzZiIsIm1lbnVfdXJsIjoiL2Fzc2V0L2lkYy8iLCJtZW51X251bSI6IjIwMTAiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMiJ9LHsibWVudV90aXRsZSI6Ilx1NGUzYlx1NjczYVx1NTIwNlx1N2VjNCIsIm1lbnVfdXJsIjoiL2Fzc2V0L2hvc3Rncm91cC8iLCJtZW51X251bSI6IjIwMTEiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMiJ9LHsibWVudV90aXRsZSI6Ilx1OGJiZVx1NTkwN1x1NTM4Mlx1NTU0NiIsIm1lbnVfdXJsIjoiL2Fzc2V0L3N1cHBsaWVyLyIsIm1lbnVfbnVtIjoiMjAxMiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIyIn1dfSx7Im1lbnVfdGl0bGUiOiJcdTRlZTNcdTc4MDFcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6IiIsIm1lbnVfbnVtIjoiMyIsIm1lbnVfaWNvbiI6ImZhIGZhLWxnIGZhLWNvZGUiLCJtZW51X3R3byI6W3sibWVudV90aXRsZSI6Ilx1OTg3OVx1NzZlZVx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL2NvZGUvcHJvamVjdC8iLCJtZW51X251bSI6IjMwMTMiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NGVlM1x1NzgwMVx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL2NvZGUvZ2l0Y29kZS8iLCJtZW51X251bSI6IjMwMTQiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NGVlM1x1NzgwMVx1NTNkMVx1NWUwMyIsIm1lbnVfdXJsIjoiL2NvZGUvcHVibGlzdC8iLCJtZW51X251bSI6IjMwMTUiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NTNkMVx1NWUwM1x1OGJiMFx1NWY1NSIsIm1lbnVfdXJsIjoiL2NvZGUvbG9nLyIsIm1lbnVfbnVtIjoiMzAxNiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIzIn1dfSx7Im1lbnVfdGl0bGUiOiJcdTdjZmJcdTdlZGZcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6IiIsIm1lbnVfbnVtIjoiNCIsIm1lbnVfaWNvbiI6ImZhIGZhLWxnIGZhLWRlc2t0b3AiLCJtZW51X3R3byI6W3sibWVudV90aXRsZSI6Ilx1NzNhZlx1NTg4M1x1OTBlOFx1N2Y3MiIsIm1lbnVfdXJsIjoiL3N5cy9zb2Zld2FyZS8iLCJtZW51X251bSI6IjQwMTciLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiNCJ9LHsibWVudV90aXRsZSI6Ilx1NjI3OVx1OTFjZlx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL3N5cy9iYXRjaC8iLCJtZW51X251bSI6IjQwMTgiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiNCJ9LHsibWVudV90aXRsZSI6Ilx1NjU4N1x1NGVmNlx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL3N5cy9maWxlbWcvIiwibWVudV9udW0iOiI0MDE5IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjQifV19LHsibWVudV90aXRsZSI6Ilx1OGZkMFx1N2VmNFx1NWRlNVx1NTE3NyIsIm1lbnVfdXJsIjoiIiwibWVudV9udW0iOiI1IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtd3JlbmNoIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJ3ZWJzc2giLCJtZW51X3VybCI6Ii90b29sL3dlYnNzaC8iLCJtZW51X251bSI6IjUwMjAiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiNSJ9LHsibWVudV90aXRsZSI6InBocE15YWRtaW4iLCJtZW51X3VybCI6Ii90b29sL3BocG15YWRtaW4vIiwibWVudV9udW0iOiI1MDIxIiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjUifV19LHsibWVudV90aXRsZSI6Ilx1NjVlNVx1NWZkN1x1NWJhMVx1OGJhMSIsIm1lbnVfdXJsIjoiIiwibWVudV9udW0iOiI2IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtYWRkcmVzcy1jYXJkIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTY0Y2RcdTRmNWNcdTY1ZTVcdTVmZDciLCJtZW51X3VybCI6Ii9sb2cvb3BzbG9nLyIsIm1lbnVfbnVtIjoiNjAyMiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI2In0seyJtZW51X3RpdGxlIjoiXHU3NTI4XHU2MjM3XHU2NWU1XHU1ZmQ3IiwibWVudV91cmwiOiIvbG9nL3VzZXJsb2cvIiwibWVudV9udW0iOiI2MDIzIiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjYifV19LHsibWVudV90aXRsZSI6Ilx1NTQwZVx1NTNmMFx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiIiwibWVudV9udW0iOiI3IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtY29nIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTg5ZDJcdTgyNzJcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3JvbGUvIiwibWVudV9udW0iOiI3MDI0IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTc1MjhcdTYyMzdcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3VzZXIvIiwibWVudV9udW0iOiI3MDI1IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL21lbnUvIiwibWVudV9udW0iOiI3MDI2IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTY3NDNcdTk2NTBcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3Blcm1zLyIsIm1lbnVfbnVtIjoiNzAyNyIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI3In1dfV19', '2018-10-13 09:36:55.957837');
INSERT INTO `django_session` VALUES ('0cghh0lxgol3l5z0z8o3sf4b2x9yjfe7', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 09:48:19.868976');
INSERT INTO `django_session` VALUES ('0yakilfb5bfv0emewcj6e74d339xs768', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 09:48:46.620506');
INSERT INTO `django_session` VALUES ('3ydmbnzjxby6qbwojdfjcxfa351tpiw9', 'YzQ3NmRmY2FkOTBhNGVhMDBmNzg5OTdiYjVmN2Y3NjYyMDBhYzYyMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBwX2F1dGgudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IiIsInVzZXJuYW1lIjoibHp4In0=', '2018-10-12 07:42:41.689817');
INSERT INTO `django_session` VALUES ('6w5g4scjnhbtsejtikt3gjar9q57j477', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 09:46:27.799566');
INSERT INTO `django_session` VALUES ('bthzp0bfvvzqwyjkvsklbfpx1f0hua28', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 09:48:36.232912');
INSERT INTO `django_session` VALUES ('k89dub82x3zazaof8g8e54z7wgxkm2gj', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 09:48:59.643251');
INSERT INTO `django_session` VALUES ('lqp0404o0qokema3fti6et5w0a2gszrc', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-13 08:55:33.676858');
INSERT INTO `django_session` VALUES ('me6zgia1pgmx4pqoaofftpda7pziljot', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 09:46:50.651873');
INSERT INTO `django_session` VALUES ('xjdg0nl2vxqblzjd570ktq54mrc6zhpc', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-13 08:54:50.991417');
INSERT INTO `django_session` VALUES ('yin5xjqrrnmhgcqgmjtva1ouwev9apje', 'ZjVjMGU1YTllZThkNGZlYWQxYzQ4ZmE0NmM4ZTM5N2FkNTExNTkwODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBwX2F1dGgudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IiIsInVzZXJuYW1lIjoibHp4IiwibWVudV9hbGxfbGlzdCI6W3sibWVudV90aXRsZSI6Ilx1OTk5Nlx1OTg3NSIsIm1lbnVfdXJsIjoiLyIsIm1lbnVfbnVtIjoiMSIsIm1lbnVfaWNvbiI6ImZhIGZhLWxnIGZhLWRhc2hib2FyZCIsIm1lbnVfdHdvIjpbXX0seyJtZW51X3RpdGxlIjoiXHU4ZDQ0XHU0ZWE3XHU3YmExXHU3NDA2IiwibWVudV91cmwiOiIiLCJtZW51X251bSI6IjIiLCJtZW51X2ljb24iOiJmYSBmYS1sZyBmYS1iYXJzIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTY3MGRcdTUyYTFcdTU2NjgiLCJtZW51X3VybCI6Ii9hc3NldC9ob3N0LyIsIm1lbnVfbnVtIjoiMjA4IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjIifSx7Im1lbnVfdGl0bGUiOiJcdTdmNTFcdTdlZGNcdThiYmVcdTU5MDciLCJtZW51X3VybCI6Ii9hc3NldC9uZXR3ay8iLCJtZW51X251bSI6IjIwOSIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIyIn0seyJtZW51X3RpdGxlIjoiSURDIFx1NjczYVx1NjIzZiIsIm1lbnVfdXJsIjoiL2Fzc2V0L2lkYy8iLCJtZW51X251bSI6IjIwMTAiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMiJ9LHsibWVudV90aXRsZSI6Ilx1NGUzYlx1NjczYVx1NTIwNlx1N2VjNCIsIm1lbnVfdXJsIjoiL2Fzc2V0L2hvc3Rncm91cC8iLCJtZW51X251bSI6IjIwMTEiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMiJ9LHsibWVudV90aXRsZSI6Ilx1OGJiZVx1NTkwN1x1NTM4Mlx1NTU0NiIsIm1lbnVfdXJsIjoiL2Fzc2V0L3N1cHBsaWVyLyIsIm1lbnVfbnVtIjoiMjAxMiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIyIn1dfSx7Im1lbnVfdGl0bGUiOiJcdTRlZTNcdTc4MDFcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6IiIsIm1lbnVfbnVtIjoiMyIsIm1lbnVfaWNvbiI6ImZhIGZhLWxnIGZhLWNvZGUiLCJtZW51X3R3byI6W3sibWVudV90aXRsZSI6Ilx1OTg3OVx1NzZlZVx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL2NvZGUvcHJvamVjdC8iLCJtZW51X251bSI6IjMwMTMiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NGVlM1x1NzgwMVx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL2NvZGUvZ2l0Y29kZS8iLCJtZW51X251bSI6IjMwMTQiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NGVlM1x1NzgwMVx1NTNkMVx1NWUwMyIsIm1lbnVfdXJsIjoiL2NvZGUvcHVibGlzdC8iLCJtZW51X251bSI6IjMwMTUiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NTNkMVx1NWUwM1x1OGJiMFx1NWY1NSIsIm1lbnVfdXJsIjoiL2NvZGUvbG9nLyIsIm1lbnVfbnVtIjoiMzAxNiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIzIn1dfSx7Im1lbnVfdGl0bGUiOiJcdTdjZmJcdTdlZGZcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6IiIsIm1lbnVfbnVtIjoiNCIsIm1lbnVfaWNvbiI6ImZhIGZhLWxnIGZhLWRlc2t0b3AiLCJtZW51X3R3byI6W3sibWVudV90aXRsZSI6Ilx1NzNhZlx1NTg4M1x1OTBlOFx1N2Y3MiIsIm1lbnVfdXJsIjoiL3N5cy9zb2Zld2FyZS8iLCJtZW51X251bSI6IjQwMTciLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiNCJ9LHsibWVudV90aXRsZSI6Ilx1NjI3OVx1OTFjZlx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL3N5cy9iYXRjaC8iLCJtZW51X251bSI6IjQwMTgiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiNCJ9LHsibWVudV90aXRsZSI6Ilx1NjU4N1x1NGVmNlx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL3N5cy9maWxlbWcvIiwibWVudV9udW0iOiI0MDE5IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjQifV19LHsibWVudV90aXRsZSI6Ilx1OGZkMFx1N2VmNFx1NWRlNVx1NTE3NyIsIm1lbnVfdXJsIjoiIiwibWVudV9udW0iOiI1IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtd3JlbmNoIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJ3ZWJzc2giLCJtZW51X3VybCI6Ii90b29sL3dlYnNzaC8iLCJtZW51X251bSI6IjUwMjAiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiNSJ9LHsibWVudV90aXRsZSI6InBocE15YWRtaW4iLCJtZW51X3VybCI6Ii90b29sL3BocG15YWRtaW4vIiwibWVudV9udW0iOiI1MDIxIiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjUifV19LHsibWVudV90aXRsZSI6Ilx1NjVlNVx1NWZkN1x1NWJhMVx1OGJhMSIsIm1lbnVfdXJsIjoiIiwibWVudV9udW0iOiI2IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtYWRkcmVzcy1jYXJkIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTY0Y2RcdTRmNWNcdTY1ZTVcdTVmZDciLCJtZW51X3VybCI6Ii9sb2cvb3BzbG9nLyIsIm1lbnVfbnVtIjoiNjAyMiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI2In0seyJtZW51X3RpdGxlIjoiXHU3NTI4XHU2MjM3XHU2NWU1XHU1ZmQ3IiwibWVudV91cmwiOiIvbG9nL3VzZXJsb2cvIiwibWVudV9udW0iOiI2MDIzIiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjYifV19LHsibWVudV90aXRsZSI6Ilx1NTQwZVx1NTNmMFx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiIiwibWVudV9udW0iOiI3IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtY29nIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTg5ZDJcdTgyNzJcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3JvbGUvIiwibWVudV9udW0iOiI3MDI0IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTc1MjhcdTYyMzdcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3VzZXIvIiwibWVudV9udW0iOiI3MDI1IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL21lbnUvIiwibWVudV9udW0iOiI3MDI2IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTY3NDNcdTk2NTBcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3Blcm1zLyIsIm1lbnVfbnVtIjoiNzAyNyIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI3In1dfV19', '2018-10-12 09:51:29.216806');
INSERT INTO `django_session` VALUES ('yvyqh77aiip4a7evzayn9qign3utk62m', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 07:51:51.825283');
INSERT INTO `django_session` VALUES ('z4itvxsaar71j1ejgjus5xh0kyu2jx8q', 'YTlmZjFjMGMwM2ExOGVjM2E3ODhlOWZjNTg0NzFiY2VjOGIwZTBkMTp7fQ==', '2018-10-12 07:50:36.125953');

SET FOREIGN_KEY_CHECKS = 1;
