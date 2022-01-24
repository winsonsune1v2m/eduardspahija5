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

 Date: 24/10/2018 16:29:53
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
  `host_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `host_ip`(`host_ip`) USING BTREE,
  INDEX `app_asset_host_group_id_c2f5df06_fk_app_asset_hostgroup_id`(`group_id`) USING BTREE,
  INDEX `app_asset_host_idc_id_82734ac0_fk_app_asset_idc_id`(`idc_id`) USING BTREE,
  INDEX `app_asset_host_supplier_id_77b2b553_fk_app_asset_supplier_id`(`supplier_id`) USING BTREE,
  CONSTRAINT `app_asset_host_group_id_c2f5df06_fk_app_asset_hostgroup_id` FOREIGN KEY (`group_id`) REFERENCES `app_asset_hostgroup` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_asset_host_idc_id_82734ac0_fk_app_asset_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `app_asset_idc` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_asset_host_supplier_id_77b2b553_fk_app_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `app_asset_supplier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_asset_hostdetail_host_id_7ccadf7f_fk_app_asset_host_id`(`host_id`) USING BTREE,
  CONSTRAINT `app_asset_hostdetail_host_id_7ccadf7f_fk_app_asset_host_id` FOREIGN KEY (`host_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `app_asset_supplier` VALUES (1, '维盟', 'lzx', '10086', '10086@139.com');

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_auth_menus_menu_url_d695085b_uniq`(`menu_url`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
  UNIQUE INDEX `app_auth_perms_perms_url_989fe779_uniq`(`perms_url`) USING BTREE,
  INDEX `app_auth_perms_menus_id_57ecaabb_fk_app_auth_menus_id`(`menus_id`) USING BTREE,
  CONSTRAINT `app_auth_perms_menus_id_57ecaabb_fk_app_auth_menus_id` FOREIGN KEY (`menus_id`) REFERENCES `app_auth_menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `app_auth_perms` VALUES (86, 'post', 21, '连接phpmyadmin', '');
INSERT INTO `app_auth_perms` VALUES (87, 'post', 22, '查看审计记录', NULL);
INSERT INTO `app_auth_perms` VALUES (89, 'put', 15, '更新代码', NULL);
INSERT INTO `app_auth_perms` VALUES (90, 'other', 8, '导入服务器', '/asset/importhost/');
INSERT INTO `app_auth_perms` VALUES (91, 'other', 15, '代码回滚', '/code/rollback/');

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `lg_user`(`lg_user`) USING BTREE,
  INDEX `app_auth_remoteuser_user_id_ea3232d8_fk_app_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `app_auth_remoteuser_user_id_ea3232d8_fk_app_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_remoteuser
-- ----------------------------
INSERT INTO `app_auth_remoteuser` VALUES (2, 'root', 'b\'98c4ce2f2a0cf6b90fafd83bfecee875\'', '', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 304 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `app_auth_role_menu` VALUES (70, 1, 21);
INSERT INTO `app_auth_role_menu` VALUES (72, 1, 22);
INSERT INTO `app_auth_role_menu` VALUES (73, 1, 23);
INSERT INTO `app_auth_role_menu` VALUES (75, 1, 24);
INSERT INTO `app_auth_role_menu` VALUES (76, 1, 25);
INSERT INTO `app_auth_role_menu` VALUES (77, 1, 26);
INSERT INTO `app_auth_role_menu` VALUES (78, 1, 27);
INSERT INTO `app_auth_role_menu` VALUES (280, 2, 1);
INSERT INTO `app_auth_role_menu` VALUES (281, 2, 2);
INSERT INTO `app_auth_role_menu` VALUES (287, 2, 3);
INSERT INTO `app_auth_role_menu` VALUES (292, 2, 4);
INSERT INTO `app_auth_role_menu` VALUES (296, 2, 5);
INSERT INTO `app_auth_role_menu` VALUES (299, 2, 6);
INSERT INTO `app_auth_role_menu` VALUES (302, 2, 7);
INSERT INTO `app_auth_role_menu` VALUES (282, 2, 8);
INSERT INTO `app_auth_role_menu` VALUES (283, 2, 9);
INSERT INTO `app_auth_role_menu` VALUES (284, 2, 10);
INSERT INTO `app_auth_role_menu` VALUES (285, 2, 11);
INSERT INTO `app_auth_role_menu` VALUES (286, 2, 12);
INSERT INTO `app_auth_role_menu` VALUES (288, 2, 13);
INSERT INTO `app_auth_role_menu` VALUES (289, 2, 14);
INSERT INTO `app_auth_role_menu` VALUES (290, 2, 15);
INSERT INTO `app_auth_role_menu` VALUES (291, 2, 16);
INSERT INTO `app_auth_role_menu` VALUES (293, 2, 17);
INSERT INTO `app_auth_role_menu` VALUES (294, 2, 18);
INSERT INTO `app_auth_role_menu` VALUES (295, 2, 19);
INSERT INTO `app_auth_role_menu` VALUES (298, 2, 21);
INSERT INTO `app_auth_role_menu` VALUES (300, 2, 22);
INSERT INTO `app_auth_role_menu` VALUES (301, 2, 23);
INSERT INTO `app_auth_role_menu` VALUES (303, 2, 25);

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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1955 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_role_perms
-- ----------------------------
INSERT INTO `app_auth_role_perms` VALUES (1873, 1, 4);
INSERT INTO `app_auth_role_perms` VALUES (1874, 1, 5);
INSERT INTO `app_auth_role_perms` VALUES (1875, 1, 6);
INSERT INTO `app_auth_role_perms` VALUES (1876, 1, 7);
INSERT INTO `app_auth_role_perms` VALUES (1883, 1, 8);
INSERT INTO `app_auth_role_perms` VALUES (1884, 1, 9);
INSERT INTO `app_auth_role_perms` VALUES (1885, 1, 10);
INSERT INTO `app_auth_role_perms` VALUES (1886, 1, 11);
INSERT INTO `app_auth_role_perms` VALUES (1887, 1, 12);
INSERT INTO `app_auth_role_perms` VALUES (1888, 1, 13);
INSERT INTO `app_auth_role_perms` VALUES (1889, 1, 14);
INSERT INTO `app_auth_role_perms` VALUES (1890, 1, 15);
INSERT INTO `app_auth_role_perms` VALUES (1891, 1, 16);
INSERT INTO `app_auth_role_perms` VALUES (1892, 1, 17);
INSERT INTO `app_auth_role_perms` VALUES (1893, 1, 18);
INSERT INTO `app_auth_role_perms` VALUES (1894, 1, 19);
INSERT INTO `app_auth_role_perms` VALUES (1895, 1, 20);
INSERT INTO `app_auth_role_perms` VALUES (1896, 1, 21);
INSERT INTO `app_auth_role_perms` VALUES (1897, 1, 22);
INSERT INTO `app_auth_role_perms` VALUES (1898, 1, 23);
INSERT INTO `app_auth_role_perms` VALUES (1899, 1, 24);
INSERT INTO `app_auth_role_perms` VALUES (1900, 1, 25);
INSERT INTO `app_auth_role_perms` VALUES (1901, 1, 26);
INSERT INTO `app_auth_role_perms` VALUES (1902, 1, 27);
INSERT INTO `app_auth_role_perms` VALUES (1903, 1, 28);
INSERT INTO `app_auth_role_perms` VALUES (1904, 1, 29);
INSERT INTO `app_auth_role_perms` VALUES (1905, 1, 30);
INSERT INTO `app_auth_role_perms` VALUES (1906, 1, 31);
INSERT INTO `app_auth_role_perms` VALUES (1907, 1, 32);
INSERT INTO `app_auth_role_perms` VALUES (1908, 1, 33);
INSERT INTO `app_auth_role_perms` VALUES (1912, 1, 34);
INSERT INTO `app_auth_role_perms` VALUES (1914, 1, 36);
INSERT INTO `app_auth_role_perms` VALUES (1915, 1, 37);
INSERT INTO `app_auth_role_perms` VALUES (1916, 1, 38);
INSERT INTO `app_auth_role_perms` VALUES (1917, 1, 39);
INSERT INTO `app_auth_role_perms` VALUES (1918, 1, 40);
INSERT INTO `app_auth_role_perms` VALUES (1923, 1, 41);
INSERT INTO `app_auth_role_perms` VALUES (1924, 1, 43);
INSERT INTO `app_auth_role_perms` VALUES (1926, 1, 44);
INSERT INTO `app_auth_role_perms` VALUES (1928, 1, 45);
INSERT INTO `app_auth_role_perms` VALUES (1929, 1, 46);
INSERT INTO `app_auth_role_perms` VALUES (1930, 1, 47);
INSERT INTO `app_auth_role_perms` VALUES (1931, 1, 48);
INSERT INTO `app_auth_role_perms` VALUES (1932, 1, 49);
INSERT INTO `app_auth_role_perms` VALUES (1933, 1, 50);
INSERT INTO `app_auth_role_perms` VALUES (1934, 1, 51);
INSERT INTO `app_auth_role_perms` VALUES (1935, 1, 53);
INSERT INTO `app_auth_role_perms` VALUES (1936, 1, 54);
INSERT INTO `app_auth_role_perms` VALUES (1937, 1, 55);
INSERT INTO `app_auth_role_perms` VALUES (1938, 1, 56);
INSERT INTO `app_auth_role_perms` VALUES (1939, 1, 57);
INSERT INTO `app_auth_role_perms` VALUES (1940, 1, 58);
INSERT INTO `app_auth_role_perms` VALUES (1941, 1, 59);
INSERT INTO `app_auth_role_perms` VALUES (1942, 1, 60);
INSERT INTO `app_auth_role_perms` VALUES (1943, 1, 61);
INSERT INTO `app_auth_role_perms` VALUES (1944, 1, 62);
INSERT INTO `app_auth_role_perms` VALUES (1947, 1, 63);
INSERT INTO `app_auth_role_perms` VALUES (1948, 1, 64);
INSERT INTO `app_auth_role_perms` VALUES (1949, 1, 65);
INSERT INTO `app_auth_role_perms` VALUES (1950, 1, 66);
INSERT INTO `app_auth_role_perms` VALUES (1951, 1, 67);
INSERT INTO `app_auth_role_perms` VALUES (1952, 1, 68);
INSERT INTO `app_auth_role_perms` VALUES (1953, 1, 69);
INSERT INTO `app_auth_role_perms` VALUES (1954, 1, 70);
INSERT INTO `app_auth_role_perms` VALUES (1909, 1, 71);
INSERT INTO `app_auth_role_perms` VALUES (1913, 1, 72);
INSERT INTO `app_auth_role_perms` VALUES (1877, 1, 73);
INSERT INTO `app_auth_role_perms` VALUES (1878, 1, 74);
INSERT INTO `app_auth_role_perms` VALUES (1879, 1, 75);
INSERT INTO `app_auth_role_perms` VALUES (1880, 1, 76);
INSERT INTO `app_auth_role_perms` VALUES (1881, 1, 77);
INSERT INTO `app_auth_role_perms` VALUES (1910, 1, 78);
INSERT INTO `app_auth_role_perms` VALUES (1882, 1, 79);
INSERT INTO `app_auth_role_perms` VALUES (1945, 1, 80);
INSERT INTO `app_auth_role_perms` VALUES (1946, 1, 81);
INSERT INTO `app_auth_role_perms` VALUES (1919, 1, 82);
INSERT INTO `app_auth_role_perms` VALUES (1920, 1, 83);
INSERT INTO `app_auth_role_perms` VALUES (1921, 1, 84);
INSERT INTO `app_auth_role_perms` VALUES (1922, 1, 85);
INSERT INTO `app_auth_role_perms` VALUES (1925, 1, 86);
INSERT INTO `app_auth_role_perms` VALUES (1927, 1, 87);
INSERT INTO `app_auth_role_perms` VALUES (1911, 1, 89);
INSERT INTO `app_auth_role_perms` VALUES (1595, 2, 7);
INSERT INTO `app_auth_role_perms` VALUES (1599, 2, 11);
INSERT INTO `app_auth_role_perms` VALUES (1600, 2, 15);
INSERT INTO `app_auth_role_perms` VALUES (1601, 2, 19);
INSERT INTO `app_auth_role_perms` VALUES (1602, 2, 23);
INSERT INTO `app_auth_role_perms` VALUES (1603, 2, 27);
INSERT INTO `app_auth_role_perms` VALUES (1604, 2, 31);
INSERT INTO `app_auth_role_perms` VALUES (1608, 2, 36);
INSERT INTO `app_auth_role_perms` VALUES (1609, 2, 37);
INSERT INTO `app_auth_role_perms` VALUES (1610, 2, 38);
INSERT INTO `app_auth_role_perms` VALUES (1611, 2, 39);
INSERT INTO `app_auth_role_perms` VALUES (1612, 2, 40);
INSERT INTO `app_auth_role_perms` VALUES (1617, 2, 41);
INSERT INTO `app_auth_role_perms` VALUES (1618, 2, 43);
INSERT INTO `app_auth_role_perms` VALUES (1619, 2, 44);
INSERT INTO `app_auth_role_perms` VALUES (1621, 2, 45);
INSERT INTO `app_auth_role_perms` VALUES (1622, 2, 59);
INSERT INTO `app_auth_role_perms` VALUES (1623, 2, 60);
INSERT INTO `app_auth_role_perms` VALUES (1624, 2, 61);
INSERT INTO `app_auth_role_perms` VALUES (1625, 2, 62);
INSERT INTO `app_auth_role_perms` VALUES (1605, 2, 71);
INSERT INTO `app_auth_role_perms` VALUES (1607, 2, 72);
INSERT INTO `app_auth_role_perms` VALUES (1596, 2, 73);
INSERT INTO `app_auth_role_perms` VALUES (1597, 2, 75);
INSERT INTO `app_auth_role_perms` VALUES (1598, 2, 77);
INSERT INTO `app_auth_role_perms` VALUES (1606, 2, 78);
INSERT INTO `app_auth_role_perms` VALUES (1626, 2, 80);
INSERT INTO `app_auth_role_perms` VALUES (1627, 2, 81);
INSERT INTO `app_auth_role_perms` VALUES (1613, 2, 82);
INSERT INTO `app_auth_role_perms` VALUES (1614, 2, 83);
INSERT INTO `app_auth_role_perms` VALUES (1615, 2, 84);
INSERT INTO `app_auth_role_perms` VALUES (1616, 2, 85);
INSERT INTO `app_auth_role_perms` VALUES (1620, 2, 87);

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `app_auth_user` VALUES (1, 'admin', '小贰', 'b\'d4721440af5b9f9f9a9915f5b2358ffb\'', '10086@139.com', '10086', '', '在线', '2018-10-11 06:13:37.757161', '2018-10-24 08:28:53.874372');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_auth_user_role
-- ----------------------------
INSERT INTO `app_auth_user_role` VALUES (4, 1, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_code_publist_gitcode_id_08f6579e_fk_app_code_gitcode_id`(`gitcode_id`) USING BTREE,
  INDEX `app_code_publist_host_ip_id_55ba2063_fk_app_asset_host_id`(`host_ip_id`) USING BTREE,
  CONSTRAINT `app_code_publist_gitcode_id_08f6579e_fk_app_code_gitcode_id` FOREIGN KEY (`gitcode_id`) REFERENCES `app_code_gitcode` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app_code_publist_host_ip_id_55ba2063_fk_app_asset_host_id` FOREIGN KEY (`host_ip_id`) REFERENCES `app_asset_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for app_code_publistrecord
-- ----------------------------
DROP TABLE IF EXISTS `app_code_publistrecord`;
CREATE TABLE `app_code_publistrecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `current_version` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `version_info` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publist_date` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_code_publistrecord_current_version_af51c124_uniq`(`current_version`) USING BTREE,
  INDEX `app_code_publistreco_publist_id_3e2d949d_fk_app_code_`(`publist_id`) USING BTREE,
  CONSTRAINT `app_code_publistreco_publist_id_3e2d949d_fk_app_code_` FOREIGN KEY (`publist_id`) REFERENCES `app_code_publist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_log_opslog
-- ----------------------------
INSERT INTO `app_log_opslog` VALUES (1, '192.168.1.190', 'gogs 服务器', 'root', '2018-10-23 17:34:54', 'Last login: Tue Oct 23 17:35:13 2018 from 192.168.1.126\n[root@localhost ~]# ls\nanaconda-ks.cfg          max_user_watches~  max_user_watchez~\njdk-8u161-linux-x64.rpm  max_user_watchex~\nlogstash.tar.gz          max_user_watchey~\n[root@localhost ~]#');

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
) ENGINE = InnoDB AUTO_INCREMENT = 258 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of app_log_userlog
-- ----------------------------
INSERT INTO `app_log_userlog` VALUES (1, 'admin', '查询发布记录', '小贰', '成功', '2018-10-24 03:51:16.535627');
INSERT INTO `app_log_userlog` VALUES (2, 'admin', '查看用户日志', '小贰', '成功', '2018-10-24 03:51:27.622261');
INSERT INTO `app_log_userlog` VALUES (3, 'admin', '查看用户日志', '小贰', '成功', '2018-10-24 03:54:18.243020');
INSERT INTO `app_log_userlog` VALUES (4, 'admin', '查看用户日志', '小贰', '成功', '2018-10-24 03:54:48.882772');
INSERT INTO `app_log_userlog` VALUES (5, 'admin', '查询项目', '小贰', '成功', '2018-10-24 04:40:13.039585');
INSERT INTO `app_log_userlog` VALUES (6, 'admin', '查询发布', '小贰', '成功', '2018-10-24 04:40:14.609675');
INSERT INTO `app_log_userlog` VALUES (7, 'admin', '版本更新', '小贰', '成功', '2018-10-24 04:40:18.244883');
INSERT INTO `app_log_userlog` VALUES (8, 'admin', '查询权限', '小贰', '成功', '2018-10-24 04:40:44.392378');
INSERT INTO `app_log_userlog` VALUES (9, 'admin', '删除权限', '小贰', '成功', '2018-10-24 04:40:52.362834');
INSERT INTO `app_log_userlog` VALUES (10, 'admin', '查询权限', '小贰', '成功', '2018-10-24 04:40:54.816975');
INSERT INTO `app_log_userlog` VALUES (11, 'admin', '查询发布', '小贰', '成功', '2018-10-24 04:40:58.463183');
INSERT INTO `app_log_userlog` VALUES (12, 'admin', '查询发布', '小贰', '成功', '2018-10-24 04:43:18.078169');
INSERT INTO `app_log_userlog` VALUES (13, 'admin', '查询发布', '小贰', '成功', '2018-10-24 04:43:23.019451');
INSERT INTO `app_log_userlog` VALUES (14, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 04:56:06.994148');
INSERT INTO `app_log_userlog` VALUES (15, 'admin', '服务器同步系统信息', '小贰', '成功', '2018-10-24 04:56:14.238563');
INSERT INTO `app_log_userlog` VALUES (16, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 04:56:34.564725');
INSERT INTO `app_log_userlog` VALUES (17, 'admin', '查询服务器详细信息', '小贰', '成功', '2018-10-24 04:56:40.271052');
INSERT INTO `app_log_userlog` VALUES (18, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 04:56:44.879315');
INSERT INTO `app_log_userlog` VALUES (19, 'admin', '过滤服务器', '小贰', '成功', '2018-10-24 04:56:55.123901');
INSERT INTO `app_log_userlog` VALUES (20, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 04:57:39.091416');
INSERT INTO `app_log_userlog` VALUES (21, 'admin', '查询服务器详细信息', '小贰', '成功', '2018-10-24 04:57:48.156934');
INSERT INTO `app_log_userlog` VALUES (22, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 04:57:51.405120');
INSERT INTO `app_log_userlog` VALUES (23, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 04:58:05.638934');
INSERT INTO `app_log_userlog` VALUES (24, 'admin', '查询服务器详细信息', '小贰', '成功', '2018-10-24 04:58:09.774171');
INSERT INTO `app_log_userlog` VALUES (25, 'admin', '服务器同步系统信息', '小贰', '成功', '2018-10-24 04:58:17.794630');
INSERT INTO `app_log_userlog` VALUES (26, 'admin', '查询服务器详细信息', '小贰', '成功', '2018-10-24 04:58:33.008500');
INSERT INTO `app_log_userlog` VALUES (27, 'test', '登录', '测试', '成功', '2018-10-24 06:08:10.183421');
INSERT INTO `app_log_userlog` VALUES (28, 'test', '查询服务器', '测试', '成功', '2018-10-24 06:08:13.101587');
INSERT INTO `app_log_userlog` VALUES (29, 'test', '查询发布', '测试', '成功', '2018-10-24 06:08:17.932864');
INSERT INTO `app_log_userlog` VALUES (30, 'test', '查询用户', '测试', '成功', '2018-10-24 06:08:32.136676');
INSERT INTO `app_log_userlog` VALUES (31, 'admin', '登录', '小贰', '成功', '2018-10-24 06:09:06.439638');
INSERT INTO `app_log_userlog` VALUES (32, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:09:09.494813');
INSERT INTO `app_log_userlog` VALUES (33, 'admin', '查询菜单', '小贰', '成功', '2018-10-24 06:09:16.875235');
INSERT INTO `app_log_userlog` VALUES (34, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:09:28.961926');
INSERT INTO `app_log_userlog` VALUES (35, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:09:32.386122');
INSERT INTO `app_log_userlog` VALUES (36, 'admin', '获取角色权限', '小贰', '成功', '2018-10-24 06:09:34.144223');
INSERT INTO `app_log_userlog` VALUES (37, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:10:24.946129');
INSERT INTO `app_log_userlog` VALUES (38, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:10:28.260318');
INSERT INTO `app_log_userlog` VALUES (39, 'admin', '查询权限', '小贰', '成功', '2018-10-24 06:10:29.645397');
INSERT INTO `app_log_userlog` VALUES (40, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:10:49.150513');
INSERT INTO `app_log_userlog` VALUES (41, 'admin', '查询权限', '小贰', '成功', '2018-10-24 06:10:52.242690');
INSERT INTO `app_log_userlog` VALUES (42, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:10:53.298750');
INSERT INTO `app_log_userlog` VALUES (43, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:10:58.876069');
INSERT INTO `app_log_userlog` VALUES (44, 'admin', '查询权限', '小贰', '成功', '2018-10-24 06:11:06.339496');
INSERT INTO `app_log_userlog` VALUES (45, 'admin', '查询菜单', '小贰', '成功', '2018-10-24 06:11:07.784579');
INSERT INTO `app_log_userlog` VALUES (46, 'admin', '修改菜单', '小贰', '成功', '2018-10-24 06:11:13.055880');
INSERT INTO `app_log_userlog` VALUES (47, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:11:15.418015');
INSERT INTO `app_log_userlog` VALUES (48, 'admin', '删除修改', '小贰', '成功', '2018-10-24 06:11:17.048109');
INSERT INTO `app_log_userlog` VALUES (49, 'admin', '删除修改', '小贰', '成功', '2018-10-24 06:11:19.232234');
INSERT INTO `app_log_userlog` VALUES (50, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:11:21.683374');
INSERT INTO `app_log_userlog` VALUES (51, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:11:23.041451');
INSERT INTO `app_log_userlog` VALUES (52, 'admin', '查询权限', '小贰', '成功', '2018-10-24 06:11:24.742549');
INSERT INTO `app_log_userlog` VALUES (53, 'admin', '查询菜单', '小贰', '成功', '2018-10-24 06:11:27.955732');
INSERT INTO `app_log_userlog` VALUES (54, 'admin', '修改菜单', '小贰', '成功', '2018-10-24 06:11:33.374042');
INSERT INTO `app_log_userlog` VALUES (55, 'admin', '修改菜单', '小贰', '成功', '2018-10-24 06:11:57.328413');
INSERT INTO `app_log_userlog` VALUES (56, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:11:59.468535');
INSERT INTO `app_log_userlog` VALUES (57, 'admin', '获取角色权限', '小贰', '成功', '2018-10-24 06:12:00.769609');
INSERT INTO `app_log_userlog` VALUES (58, 'admin', '角色权限授权', '小贰', '成功', '2018-10-24 06:12:04.538825');
INSERT INTO `app_log_userlog` VALUES (59, 'admin', '登录', '小贰', '成功', '2018-10-24 06:12:15.789468');
INSERT INTO `app_log_userlog` VALUES (60, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:12:18.280611');
INSERT INTO `app_log_userlog` VALUES (61, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:12:43.178035');
INSERT INTO `app_log_userlog` VALUES (62, 'admin', '登录', '小贰', '成功', '2018-10-24 06:13:51.317932');
INSERT INTO `app_log_userlog` VALUES (63, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:13:53.986085');
INSERT INTO `app_log_userlog` VALUES (64, 'test', '登录', '测试', '成功', '2018-10-24 06:16:52.906319');
INSERT INTO `app_log_userlog` VALUES (65, 'test', '查询用户', '测试', '成功', '2018-10-24 06:16:54.741424');
INSERT INTO `app_log_userlog` VALUES (66, 'test', '查询环境', '测试', '成功', '2018-10-24 06:17:00.937778');
INSERT INTO `app_log_userlog` VALUES (67, 'test', '访问文件管理', '测试', '成功', '2018-10-24 06:17:03.761939');
INSERT INTO `app_log_userlog` VALUES (68, 'test', '查询环境', '测试', '成功', '2018-10-24 06:17:19.792856');
INSERT INTO `app_log_userlog` VALUES (69, 'test', '查询环境', '测试', '成功', '2018-10-24 06:18:44.093678');
INSERT INTO `app_log_userlog` VALUES (70, 'test', '查询环境', '测试', '成功', '2018-10-24 06:19:03.127767');
INSERT INTO `app_log_userlog` VALUES (71, 'test', '访问批量管理', '测试', '成功', '2018-10-24 06:20:44.352557');
INSERT INTO `app_log_userlog` VALUES (72, 'test', '访问文件管理', '测试', '成功', '2018-10-24 06:20:47.916760');
INSERT INTO `app_log_userlog` VALUES (73, 'test', '查询服务器', '测试', '成功', '2018-10-24 06:21:25.380903');
INSERT INTO `app_log_userlog` VALUES (74, 'test', '连接服务器', '测试', '成功', '2018-10-24 06:21:34.453422');
INSERT INTO `app_log_userlog` VALUES (75, 'test', '查看操作日志', '测试', '成功', '2018-10-24 06:21:45.321044');
INSERT INTO `app_log_userlog` VALUES (76, 'test', '查看操作日志', '测试', '成功', '2018-10-24 06:21:50.616347');
INSERT INTO `app_log_userlog` VALUES (77, 'test', '查询发布', '测试', '成功', '2018-10-24 06:22:59.804304');
INSERT INTO `app_log_userlog` VALUES (78, 'admin', '登录', '小贰', '成功', '2018-10-24 06:23:11.029946');
INSERT INTO `app_log_userlog` VALUES (79, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:23:14.742158');
INSERT INTO `app_log_userlog` VALUES (80, 'admin', '代码发布过滤', '小贰', '成功', '2018-10-24 06:23:16.721272');
INSERT INTO `app_log_userlog` VALUES (81, 'admin', '查询权限', '小贰', '成功', '2018-10-24 06:23:31.563120');
INSERT INTO `app_log_userlog` VALUES (82, 'admin', '添加权限', '小贰', '成功', '2018-10-24 06:23:51.364253');
INSERT INTO `app_log_userlog` VALUES (83, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:23:55.727503');
INSERT INTO `app_log_userlog` VALUES (84, 'admin', '获取角色权限', '小贰', '成功', '2018-10-24 06:23:56.695558');
INSERT INTO `app_log_userlog` VALUES (85, 'admin', '角色权限授权', '小贰', '成功', '2018-10-24 06:24:04.623011');
INSERT INTO `app_log_userlog` VALUES (86, 'admin', '登录', '小贰', '成功', '2018-10-24 06:24:13.658528');
INSERT INTO `app_log_userlog` VALUES (87, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:24:18.826824');
INSERT INTO `app_log_userlog` VALUES (88, 'admin', '代码发布过滤', '小贰', '成功', '2018-10-24 06:24:20.935944');
INSERT INTO `app_log_userlog` VALUES (89, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:24:25.912229');
INSERT INTO `app_log_userlog` VALUES (90, 'admin', '代码发布过滤', '小贰', '成功', '2018-10-24 06:24:27.367312');
INSERT INTO `app_log_userlog` VALUES (91, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:24:45.872371');
INSERT INTO `app_log_userlog` VALUES (92, 'admin', '获取角色权限', '小贰', '成功', '2018-10-24 06:24:47.136443');
INSERT INTO `app_log_userlog` VALUES (93, 'admin', '登录', '小贰', '成功', '2018-10-24 06:24:58.022066');
INSERT INTO `app_log_userlog` VALUES (94, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:25:00.777223');
INSERT INTO `app_log_userlog` VALUES (95, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:25:04.869457');
INSERT INTO `app_log_userlog` VALUES (96, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:26:27.110161');
INSERT INTO `app_log_userlog` VALUES (97, 'admin', '查询发布', '小贰', '失败', '2018-10-24 06:31:22.776072');
INSERT INTO `app_log_userlog` VALUES (98, 'admin', '查询项目', '小贰', '失败', '2018-10-24 06:31:26.649294');
INSERT INTO `app_log_userlog` VALUES (99, 'admin', '查询项目', '小贰', '成功', '2018-10-24 06:31:57.630066');
INSERT INTO `app_log_userlog` VALUES (100, 'admin', '查询代码', '小贰', '成功', '2018-10-24 06:31:58.599121');
INSERT INTO `app_log_userlog` VALUES (101, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:31:59.410168');
INSERT INTO `app_log_userlog` VALUES (102, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:33:59.231021');
INSERT INTO `app_log_userlog` VALUES (103, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:34:26.046555');
INSERT INTO `app_log_userlog` VALUES (104, 'admin', '查询权限', '小贰', '成功', '2018-10-24 06:41:30.726845');
INSERT INTO `app_log_userlog` VALUES (105, 'admin', '修改权限', '小贰', '成功', '2018-10-24 06:41:36.937200');
INSERT INTO `app_log_userlog` VALUES (106, 'admin', '查询权限', '小贰', '成功', '2018-10-24 06:42:40.881858');
INSERT INTO `app_log_userlog` VALUES (107, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:43:08.307426');
INSERT INTO `app_log_userlog` VALUES (108, 'admin', '更新代码', '小贰', '失败', '2018-10-24 06:43:11.125588');
INSERT INTO `app_log_userlog` VALUES (109, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:43:15.964864');
INSERT INTO `app_log_userlog` VALUES (110, 'admin', '查看角色', '小贰', '成功', '2018-10-24 06:43:16.838914');
INSERT INTO `app_log_userlog` VALUES (111, 'admin', '获取角色权限', '小贰', '成功', '2018-10-24 06:43:18.200992');
INSERT INTO `app_log_userlog` VALUES (112, 'admin', '角色权限授权', '小贰', '成功', '2018-10-24 06:43:24.068328');
INSERT INTO `app_log_userlog` VALUES (113, 'admin', '登录', '小贰', '成功', '2018-10-24 06:43:33.959894');
INSERT INTO `app_log_userlog` VALUES (114, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:43:36.814057');
INSERT INTO `app_log_userlog` VALUES (115, 'admin', '更新代码', '小贰', '成功', '2018-10-24 06:43:39.689221');
INSERT INTO `app_log_userlog` VALUES (116, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 06:58:17.808447');
INSERT INTO `app_log_userlog` VALUES (117, 'admin', '查询发布', '小贰', '成功', '2018-10-24 06:58:20.799618');
INSERT INTO `app_log_userlog` VALUES (118, 'admin', '查询用户', '小贰', '成功', '2018-10-24 06:58:24.153810');
INSERT INTO `app_log_userlog` VALUES (119, 'admin', '查询发布记录', '小贰', '成功', '2018-10-24 06:59:08.683357');
INSERT INTO `app_log_userlog` VALUES (120, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 07:16:46.909884');
INSERT INTO `app_log_userlog` VALUES (121, 'admin', '过滤服务器', '小贰', '成功', '2018-10-24 07:16:49.478031');
INSERT INTO `app_log_userlog` VALUES (122, 'admin', '查询项目', '小贰', '成功', '2018-10-24 07:17:14.617469');
INSERT INTO `app_log_userlog` VALUES (123, 'admin', '查询发布', '小贰', '成功', '2018-10-24 07:17:16.273563');
INSERT INTO `app_log_userlog` VALUES (124, 'admin', '代码发布过滤', '小贰', '成功', '2018-10-24 07:17:18.538693');
INSERT INTO `app_log_userlog` VALUES (125, 'admin', '访问批量管理', '小贰', '成功', '2018-10-24 07:17:42.689074');
INSERT INTO `app_log_userlog` VALUES (126, 'admin', '执行命令', '小贰', '成功', '2018-10-24 07:18:00.058068');
INSERT INTO `app_log_userlog` VALUES (127, 'admin', '查看操作日志', '小贰', '成功', '2018-10-24 07:18:23.680419');
INSERT INTO `app_log_userlog` VALUES (128, 'admin', '查看审计记录', '小贰', '成功', '2018-10-24 07:18:25.691534');
INSERT INTO `app_log_userlog` VALUES (129, 'admin', '查看角色', '小贰', '成功', '2018-10-24 07:18:50.736966');
INSERT INTO `app_log_userlog` VALUES (130, 'admin', '获取角色权限', '小贰', '成功', '2018-10-24 07:18:53.923149');
INSERT INTO `app_log_userlog` VALUES (131, 'admin', '登录', '小贰', '成功', '2018-10-24 08:24:07.487992');
INSERT INTO `app_log_userlog` VALUES (132, 'admin', '查询用户', '小贰', '成功', '2018-10-24 08:24:10.690175');
INSERT INTO `app_log_userlog` VALUES (133, 'admin', '修改用户', '小贰', '成功', '2018-10-24 08:24:15.261436');
INSERT INTO `app_log_userlog` VALUES (134, 'admin', '修改用户', '小贰', '成功', '2018-10-24 08:24:25.065997');
INSERT INTO `app_log_userlog` VALUES (135, 'admin', '删除用户', '小贰', '成功', '2018-10-24 08:24:27.793153');
INSERT INTO `app_log_userlog` VALUES (136, 'admin', '查询用户', '小贰', '成功', '2018-10-24 08:24:29.484250');
INSERT INTO `app_log_userlog` VALUES (137, 'admin', '查看角色', '小贰', '成功', '2018-10-24 08:24:31.178347');
INSERT INTO `app_log_userlog` VALUES (138, 'admin', '查看操作日志', '小贰', '成功', '2018-10-24 08:24:34.613543');
INSERT INTO `app_log_userlog` VALUES (139, 'admin', '查看用户日志', '小贰', '成功', '2018-10-24 08:24:37.105686');
INSERT INTO `app_log_userlog` VALUES (140, 'admin', '查询环境', '小贰', '成功', '2018-10-24 08:24:42.763009');
INSERT INTO `app_log_userlog` VALUES (141, 'admin', '访问批量管理', '小贰', '成功', '2018-10-24 08:24:44.037082');
INSERT INTO `app_log_userlog` VALUES (142, 'admin', '访问文件管理', '小贰', '成功', '2018-10-24 08:24:46.817241');
INSERT INTO `app_log_userlog` VALUES (143, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:24:51.674519');
INSERT INTO `app_log_userlog` VALUES (144, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:24:54.885703');
INSERT INTO `app_log_userlog` VALUES (145, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:24:57.363844');
INSERT INTO `app_log_userlog` VALUES (146, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:16.840958');
INSERT INTO `app_log_userlog` VALUES (147, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:25:17.777012');
INSERT INTO `app_log_userlog` VALUES (148, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:45.831617');
INSERT INTO `app_log_userlog` VALUES (149, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:48.170750');
INSERT INTO `app_log_userlog` VALUES (150, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:49.995855');
INSERT INTO `app_log_userlog` VALUES (151, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:51.622948');
INSERT INTO `app_log_userlog` VALUES (152, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:53.771071');
INSERT INTO `app_log_userlog` VALUES (153, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:56.092203');
INSERT INTO `app_log_userlog` VALUES (154, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:25:56.506227');
INSERT INTO `app_log_userlog` VALUES (155, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:25:58.980369');
INSERT INTO `app_log_userlog` VALUES (156, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:00.736469');
INSERT INTO `app_log_userlog` VALUES (157, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:02.530572');
INSERT INTO `app_log_userlog` VALUES (158, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:04.201667');
INSERT INTO `app_log_userlog` VALUES (159, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:04.560688');
INSERT INTO `app_log_userlog` VALUES (160, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:06.455796');
INSERT INTO `app_log_userlog` VALUES (161, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:06.748813');
INSERT INTO `app_log_userlog` VALUES (162, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:08.243899');
INSERT INTO `app_log_userlog` VALUES (163, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:08.514914');
INSERT INTO `app_log_userlog` VALUES (164, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:10.143007');
INSERT INTO `app_log_userlog` VALUES (165, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:11.104062');
INSERT INTO `app_log_userlog` VALUES (166, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:12.963168');
INSERT INTO `app_log_userlog` VALUES (167, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:13.111177');
INSERT INTO `app_log_userlog` VALUES (168, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:14.654265');
INSERT INTO `app_log_userlog` VALUES (169, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:15.043287');
INSERT INTO `app_log_userlog` VALUES (170, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:17.182410');
INSERT INTO `app_log_userlog` VALUES (171, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:17.317418');
INSERT INTO `app_log_userlog` VALUES (172, 'admin', '删除发布', '小贰', '成功', '2018-10-24 08:26:18.966512');
INSERT INTO `app_log_userlog` VALUES (173, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:19.506543');
INSERT INTO `app_log_userlog` VALUES (174, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:26:21.302645');
INSERT INTO `app_log_userlog` VALUES (175, 'admin', '查询发布记录', '小贰', '成功', '2018-10-24 08:26:22.168695');
INSERT INTO `app_log_userlog` VALUES (176, 'admin', '查询代码', '小贰', '成功', '2018-10-24 08:26:23.037745');
INSERT INTO `app_log_userlog` VALUES (177, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:26.317932');
INSERT INTO `app_log_userlog` VALUES (178, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:29.589119');
INSERT INTO `app_log_userlog` VALUES (179, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:31.992257');
INSERT INTO `app_log_userlog` VALUES (180, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:33.818361');
INSERT INTO `app_log_userlog` VALUES (181, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:35.574462');
INSERT INTO `app_log_userlog` VALUES (182, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:37.342563');
INSERT INTO `app_log_userlog` VALUES (183, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:39.426682');
INSERT INTO `app_log_userlog` VALUES (184, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:41.063776');
INSERT INTO `app_log_userlog` VALUES (185, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:43.237900');
INSERT INTO `app_log_userlog` VALUES (186, 'admin', '查询代码', '小贰', '成功', '2018-10-24 08:26:43.968942');
INSERT INTO `app_log_userlog` VALUES (187, 'admin', '删除代码', '小贰', '成功', '2018-10-24 08:26:45.879051');
INSERT INTO `app_log_userlog` VALUES (188, 'admin', '查询代码', '小贰', '成功', '2018-10-24 08:26:46.397081');
INSERT INTO `app_log_userlog` VALUES (189, 'admin', '查询代码', '小贰', '成功', '2018-10-24 08:26:47.762159');
INSERT INTO `app_log_userlog` VALUES (190, 'admin', '查询项目', '小贰', '成功', '2018-10-24 08:26:49.119236');
INSERT INTO `app_log_userlog` VALUES (191, 'admin', '删除项目', '小贰', '成功', '2018-10-24 08:26:51.948398');
INSERT INTO `app_log_userlog` VALUES (192, 'admin', '删除项目', '小贰', '成功', '2018-10-24 08:26:53.547490');
INSERT INTO `app_log_userlog` VALUES (193, 'admin', '删除项目', '小贰', '成功', '2018-10-24 08:26:55.514602');
INSERT INTO `app_log_userlog` VALUES (194, 'admin', '查询项目', '小贰', '成功', '2018-10-24 08:26:55.819620');
INSERT INTO `app_log_userlog` VALUES (195, 'admin', '删除项目', '小贰', '成功', '2018-10-24 08:26:57.821734');
INSERT INTO `app_log_userlog` VALUES (196, 'admin', '查询项目', '小贰', '成功', '2018-10-24 08:26:58.041747');
INSERT INTO `app_log_userlog` VALUES (197, 'admin', '查询项目', '小贰', '成功', '2018-10-24 08:26:59.515831');
INSERT INTO `app_log_userlog` VALUES (198, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 08:27:01.377938');
INSERT INTO `app_log_userlog` VALUES (199, 'admin', '批量删除服务器', '小贰', '成功', '2018-10-24 08:27:08.481344');
INSERT INTO `app_log_userlog` VALUES (200, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 08:27:09.427398');
INSERT INTO `app_log_userlog` VALUES (201, 'admin', '批量删除服务器', '小贰', '成功', '2018-10-24 08:27:15.180727');
INSERT INTO `app_log_userlog` VALUES (202, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 08:27:15.471744');
INSERT INTO `app_log_userlog` VALUES (203, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 08:27:17.116838');
INSERT INTO `app_log_userlog` VALUES (204, 'admin', '查询网络设备', '小贰', '成功', '2018-10-24 08:27:17.841879');
INSERT INTO `app_log_userlog` VALUES (205, 'admin', '查询机房', '小贰', '成功', '2018-10-24 08:27:18.531919');
INSERT INTO `app_log_userlog` VALUES (206, 'admin', '查询分组', '小贰', '成功', '2018-10-24 08:27:19.102951');
INSERT INTO `app_log_userlog` VALUES (207, 'admin', '查询厂商', '小贰', '成功', '2018-10-24 08:27:19.600980');
INSERT INTO `app_log_userlog` VALUES (208, 'admin', '查询项目', '小贰', '成功', '2018-10-24 08:27:21.407083');
INSERT INTO `app_log_userlog` VALUES (209, 'admin', '查询服务器', '小贰', '成功', '2018-10-24 08:27:24.009232');
INSERT INTO `app_log_userlog` VALUES (210, 'admin', '查询网络设备', '小贰', '成功', '2018-10-24 08:27:24.669270');
INSERT INTO `app_log_userlog` VALUES (211, 'admin', '删除网络设备', '小贰', '成功', '2018-10-24 08:27:27.715444');
INSERT INTO `app_log_userlog` VALUES (212, 'admin', '查询网络设备', '小贰', '成功', '2018-10-24 08:27:28.120467');
INSERT INTO `app_log_userlog` VALUES (213, 'admin', '查询机房', '小贰', '成功', '2018-10-24 08:27:29.271533');
INSERT INTO `app_log_userlog` VALUES (214, 'admin', '删除机房', '小贰', '成功', '2018-10-24 08:27:31.816679');
INSERT INTO `app_log_userlog` VALUES (215, 'admin', '查询机房', '小贰', '成功', '2018-10-24 08:27:31.989689');
INSERT INTO `app_log_userlog` VALUES (216, 'admin', '删除机房', '小贰', '成功', '2018-10-24 08:27:33.655784');
INSERT INTO `app_log_userlog` VALUES (217, 'admin', '查询机房', '小贰', '成功', '2018-10-24 08:27:33.843795');
INSERT INTO `app_log_userlog` VALUES (218, 'admin', '删除机房', '小贰', '成功', '2018-10-24 08:27:36.503947');
INSERT INTO `app_log_userlog` VALUES (219, 'admin', '查询机房', '小贰', '成功', '2018-10-24 08:27:36.714959');
INSERT INTO `app_log_userlog` VALUES (220, 'admin', '查询分组', '小贰', '成功', '2018-10-24 08:27:37.698015');
INSERT INTO `app_log_userlog` VALUES (221, 'admin', '删除分组', '小贰', '成功', '2018-10-24 08:27:40.427171');
INSERT INTO `app_log_userlog` VALUES (222, 'admin', '查询分组', '小贰', '成功', '2018-10-24 08:27:40.919199');
INSERT INTO `app_log_userlog` VALUES (223, 'admin', '删除分组', '小贰', '成功', '2018-10-24 08:27:43.886369');
INSERT INTO `app_log_userlog` VALUES (224, 'admin', '查询分组', '小贰', '成功', '2018-10-24 08:27:44.143384');
INSERT INTO `app_log_userlog` VALUES (225, 'admin', '删除分组', '小贰', '成功', '2018-10-24 08:27:47.777592');
INSERT INTO `app_log_userlog` VALUES (226, 'admin', '查询分组', '小贰', '成功', '2018-10-24 08:27:48.060608');
INSERT INTO `app_log_userlog` VALUES (227, 'admin', '删除分组', '小贰', '成功', '2018-10-24 08:27:49.907713');
INSERT INTO `app_log_userlog` VALUES (228, 'admin', '查询分组', '小贰', '成功', '2018-10-24 08:27:50.160728');
INSERT INTO `app_log_userlog` VALUES (229, 'admin', '删除分组', '小贰', '成功', '2018-10-24 08:27:51.879826');
INSERT INTO `app_log_userlog` VALUES (230, 'admin', '查询分组', '小贰', '成功', '2018-10-24 08:27:52.122840');
INSERT INTO `app_log_userlog` VALUES (231, 'admin', '查询厂商', '小贰', '成功', '2018-10-24 08:27:56.006062');
INSERT INTO `app_log_userlog` VALUES (232, 'admin', '删除厂商', '小贰', '成功', '2018-10-24 08:27:58.681215');
INSERT INTO `app_log_userlog` VALUES (233, 'admin', '查询厂商', '小贰', '成功', '2018-10-24 08:27:58.845225');
INSERT INTO `app_log_userlog` VALUES (234, 'admin', '删除厂商', '小贰', '成功', '2018-10-24 08:28:00.451316');
INSERT INTO `app_log_userlog` VALUES (235, 'admin', '查询厂商', '小贰', '成功', '2018-10-24 08:28:00.683330');
INSERT INTO `app_log_userlog` VALUES (236, 'admin', '删除厂商', '小贰', '成功', '2018-10-24 08:28:02.188416');
INSERT INTO `app_log_userlog` VALUES (237, 'admin', '查询厂商', '小贰', '成功', '2018-10-24 08:28:02.317423');
INSERT INTO `app_log_userlog` VALUES (238, 'admin', '查询厂商', '小贰', '成功', '2018-10-24 08:28:06.531664');
INSERT INTO `app_log_userlog` VALUES (239, 'admin', '查询项目', '小贰', '成功', '2018-10-24 08:28:09.682844');
INSERT INTO `app_log_userlog` VALUES (240, 'admin', '查询代码', '小贰', '成功', '2018-10-24 08:28:10.300880');
INSERT INTO `app_log_userlog` VALUES (241, 'admin', '查询代码', '小贰', '成功', '2018-10-24 08:28:11.051923');
INSERT INTO `app_log_userlog` VALUES (242, 'admin', '查询发布', '小贰', '成功', '2018-10-24 08:28:11.490948');
INSERT INTO `app_log_userlog` VALUES (243, 'admin', '查询发布记录', '小贰', '成功', '2018-10-24 08:28:12.307995');
INSERT INTO `app_log_userlog` VALUES (244, 'admin', '查询环境', '小贰', '成功', '2018-10-24 08:28:14.142099');
INSERT INTO `app_log_userlog` VALUES (245, 'admin', '修改环境', '小贰', '成功', '2018-10-24 08:28:19.102383');
INSERT INTO `app_log_userlog` VALUES (246, 'admin', '访问批量管理', '小贰', '成功', '2018-10-24 08:28:23.503635');
INSERT INTO `app_log_userlog` VALUES (247, 'admin', '访问文件管理', '小贰', '成功', '2018-10-24 08:28:24.247677');
INSERT INTO `app_log_userlog` VALUES (248, 'admin', '访问文件管理', '小贰', '成功', '2018-10-24 08:28:31.190075');
INSERT INTO `app_log_userlog` VALUES (249, 'admin', '访问文件管理', '小贰', '成功', '2018-10-24 08:28:33.354198');
INSERT INTO `app_log_userlog` VALUES (250, 'admin', '访问批量管理', '小贰', '成功', '2018-10-24 08:28:34.263250');
INSERT INTO `app_log_userlog` VALUES (251, 'admin', '访问phpmyadmin', '小贰', '成功', '2018-10-24 08:28:38.524494');
INSERT INTO `app_log_userlog` VALUES (252, 'admin', '查看操作日志', '小贰', '成功', '2018-10-24 08:28:40.717620');
INSERT INTO `app_log_userlog` VALUES (253, 'admin', '查看用户日志', '小贰', '成功', '2018-10-24 08:28:41.948690');
INSERT INTO `app_log_userlog` VALUES (254, 'admin', '查看角色', '小贰', '成功', '2018-10-24 08:28:52.690304');
INSERT INTO `app_log_userlog` VALUES (255, 'admin', '查询用户', '小贰', '成功', '2018-10-24 08:28:53.800368');
INSERT INTO `app_log_userlog` VALUES (256, 'admin', '查询菜单', '小贰', '成功', '2018-10-24 08:28:56.061497');
INSERT INTO `app_log_userlog` VALUES (257, 'admin', '查询权限', '小贰', '成功', '2018-10-24 08:28:58.055611');

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
INSERT INTO `app_sys_envsofeware` VALUES (1, 'php', '7.2.4', 'echo \"1232\" >/home/test.txt');

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
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `django_migrations` VALUES (33, 'app_asset', '0002_hostdetail', '2018-10-15 07:24:35.656774');
INSERT INTO `django_migrations` VALUES (34, 'app_asset', '0003_auto_20181015_1525', '2018-10-15 07:25:15.682063');
INSERT INTO `django_migrations` VALUES (35, 'app_asset', '0004_auto_20181015_1527', '2018-10-15 07:27:38.710244');
INSERT INTO `django_migrations` VALUES (36, 'app_asset', '0005_auto_20181015_1602', '2018-10-15 08:02:21.195356');
INSERT INTO `django_migrations` VALUES (37, 'app_asset', '0006_host_host_status', '2018-10-15 08:38:47.979432');
INSERT INTO `django_migrations` VALUES (38, 'app_asset', '0007_software', '2018-10-15 09:50:03.860999');
INSERT INTO `django_migrations` VALUES (39, 'app_asset', '0008_auto_20181016_1527', '2018-10-16 07:27:11.974410');
INSERT INTO `django_migrations` VALUES (40, 'app_code', '0010_auto_20181018_1124', '2018-10-18 03:24:31.134935');
INSERT INTO `django_migrations` VALUES (41, 'app_auth', '0008_remoteuser', '2018-10-22 01:13:43.115134');
INSERT INTO `django_migrations` VALUES (42, 'app_code', '0010_auto_20181022_0913', '2018-10-22 01:13:43.236141');
INSERT INTO `django_migrations` VALUES (43, 'app_code', '0011_auto_20181024_1048', '2018-10-24 02:48:37.647631');
INSERT INTO `django_migrations` VALUES (44, 'app_log', '0002_auto_20181024_1118', '2018-10-24 03:19:27.355428');
INSERT INTO `django_migrations` VALUES (45, 'app_auth', '0009_auto_20181024_1134', '2018-10-24 03:34:04.834617');
INSERT INTO `django_migrations` VALUES (46, 'app_auth', '0010_auto_20181024_1138', '2018-10-24 03:41:36.517452');

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
INSERT INTO `django_session` VALUES ('0hxvozangdff8557d7m6x2f7wi5nu5pj', 'MGUxMWU4N2EzYTE5ZDQ4ODZjYjRmMzgzMWI5MGYwMDczMTM2MTFlMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBwX2F1dGgudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IiIsInVzZXJuYW1lIjoiXHU1YzBmXHU4ZDMwIiwidXNlcl9uYW1lIjoiYWRtaW4iLCJyb2xlX2lkIjoxLCJtZW51X2FsbF9saXN0IjpbeyJtZW51X3RpdGxlIjoiXHU5OTk2XHU5ODc1IiwibWVudV91cmwiOiIvIiwibWVudV9udW0iOiIxIiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtZGFzaGJvYXJkIiwibWVudV90d28iOltdfSx7Im1lbnVfdGl0bGUiOiJcdThkNDRcdTRlYTdcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hc3NldC8iLCJtZW51X251bSI6IjIiLCJtZW51X2ljb24iOiJmYSBmYS1sZyBmYS1iYXJzIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTY3MGRcdTUyYTFcdTU2NjgiLCJtZW51X3VybCI6Ii9hc3NldC9ob3N0LyIsIm1lbnVfbnVtIjoiMjA4IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjIifSx7Im1lbnVfdGl0bGUiOiJcdTdmNTFcdTdlZGNcdThiYmVcdTU5MDciLCJtZW51X3VybCI6Ii9hc3NldC9uZXR3ay8iLCJtZW51X251bSI6IjIwOSIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIyIn0seyJtZW51X3RpdGxlIjoiSURDIFx1NjczYVx1NjIzZiIsIm1lbnVfdXJsIjoiL2Fzc2V0L2lkYy8iLCJtZW51X251bSI6IjIwMTAiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMiJ9LHsibWVudV90aXRsZSI6Ilx1NGUzYlx1NjczYVx1NTIwNlx1N2VjNCIsIm1lbnVfdXJsIjoiL2Fzc2V0L2hvc3Rncm91cC8iLCJtZW51X251bSI6IjIwMTEiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMiJ9LHsibWVudV90aXRsZSI6Ilx1OGJiZVx1NTkwN1x1NTM4Mlx1NTU0NiIsIm1lbnVfdXJsIjoiL2Fzc2V0L3N1cHBsaWVyLyIsIm1lbnVfbnVtIjoiMjAxMiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIyIn1dfSx7Im1lbnVfdGl0bGUiOiJcdTRlZTNcdTc4MDFcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9jb2RlLyIsIm1lbnVfbnVtIjoiMyIsIm1lbnVfaWNvbiI6ImZhIGZhLWxnIGZhLWNvZGUiLCJtZW51X3R3byI6W3sibWVudV90aXRsZSI6Ilx1OTg3OVx1NzZlZVx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL2NvZGUvcHJvamVjdC8iLCJtZW51X251bSI6IjMwMTMiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NGVlM1x1NzgwMVx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL2NvZGUvZ2l0Y29kZS8iLCJtZW51X251bSI6IjMwMTQiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NGVlM1x1NzgwMVx1NTNkMVx1NWUwMyIsIm1lbnVfdXJsIjoiL2NvZGUvcHVibGlzdC8iLCJtZW51X251bSI6IjMwMTUiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiMyJ9LHsibWVudV90aXRsZSI6Ilx1NTNkMVx1NWUwM1x1OGJiMFx1NWY1NSIsIm1lbnVfdXJsIjoiL2NvZGUvbG9nLyIsIm1lbnVfbnVtIjoiMzAxNiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiIzIn1dfSx7Im1lbnVfdGl0bGUiOiJcdTdjZmJcdTdlZGZcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9zeXMvIiwibWVudV9udW0iOiI0IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtZGVza3RvcCIsIm1lbnVfdHdvIjpbeyJtZW51X3RpdGxlIjoiXHU3M2FmXHU1ODgzXHU5MGU4XHU3ZjcyIiwibWVudV91cmwiOiIvc3lzL3NvZmV3YXJlLyIsIm1lbnVfbnVtIjoiNDAxNyIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI0In0seyJtZW51X3RpdGxlIjoiXHU2Mjc5XHU5MWNmXHU3YmExXHU3NDA2IiwibWVudV91cmwiOiIvc3lzL2JhdGNoLyIsIm1lbnVfbnVtIjoiNDAxOCIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI0In0seyJtZW51X3RpdGxlIjoiXHU2NTg3XHU0ZWY2XHU3YmExXHU3NDA2IiwibWVudV91cmwiOiIvc3lzL2ZpbGVtZy8iLCJtZW51X251bSI6IjQwMTkiLCJtZW51X2ljb24iOm51bGwsInBtZW51X2lkIjoiNCJ9XX0seyJtZW51X3RpdGxlIjoiXHU4ZmQwXHU3ZWY0XHU1ZGU1XHU1MTc3IiwibWVudV91cmwiOiIvdG9vbC8iLCJtZW51X251bSI6IjUiLCJtZW51X2ljb24iOiJmYSBmYS1sZyBmYS13cmVuY2giLCJtZW51X3R3byI6W3sibWVudV90aXRsZSI6InBocE15YWRtaW4iLCJtZW51X3VybCI6Ii90b29sL3BocG15YWRtaW4vIiwibWVudV9udW0iOiI1MDIxIiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjUifV19LHsibWVudV90aXRsZSI6Ilx1NjVlNVx1NWZkN1x1NWJhMVx1OGJhMSIsIm1lbnVfdXJsIjoiL2xvZy8iLCJtZW51X251bSI6IjYiLCJtZW51X2ljb24iOiJmYSBmYS1sZyBmYS1ib29rIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTY0Y2RcdTRmNWNcdTY1ZTVcdTVmZDciLCJtZW51X3VybCI6Ii9sb2cvb3BzbG9nLyIsIm1lbnVfbnVtIjoiNjAyMiIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI2In0seyJtZW51X3RpdGxlIjoiXHU3NTI4XHU2MjM3XHU2NWU1XHU1ZmQ3IiwibWVudV91cmwiOiIvbG9nL3VzZXJsb2cvIiwibWVudV9udW0iOiI2MDIzIiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjYifV19LHsibWVudV90aXRsZSI6Ilx1NTQwZVx1NTNmMFx1N2JhMVx1NzQwNiIsIm1lbnVfdXJsIjoiL2F1dGgvIiwibWVudV9udW0iOiI3IiwibWVudV9pY29uIjoiZmEgZmEtbGcgZmEtY29nIiwibWVudV90d28iOlt7Im1lbnVfdGl0bGUiOiJcdTg5ZDJcdTgyNzJcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3JvbGUvIiwibWVudV9udW0iOiI3MDI0IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTc1MjhcdTYyMzdcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3VzZXIvIiwibWVudV9udW0iOiI3MDI1IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL21lbnUvIiwibWVudV9udW0iOiI3MDI2IiwibWVudV9pY29uIjpudWxsLCJwbWVudV9pZCI6IjcifSx7Im1lbnVfdGl0bGUiOiJcdTY3NDNcdTk2NTBcdTdiYTFcdTc0MDYiLCJtZW51X3VybCI6Ii9hdXRoL3Blcm1zLyIsIm1lbnVfbnVtIjoiNzAyNyIsIm1lbnVfaWNvbiI6bnVsbCwicG1lbnVfaWQiOiI3In1dfV0sInBlcm1zX2FsbF9saXN0Ijp7Ii9hc3NldC9ob3N0LyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9hc3NldC9uZXR3ay8iOlsiUE9TVCIsIkRFTEVURSIsIlBVVCIsIkdFVCJdLCIvYXNzZXQvaWRjLyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9hc3NldC9ob3N0Z3JvdXAvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2Fzc2V0L3N1cHBsaWVyLyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9jb2RlL3Byb2plY3QvIjpbIlBPU1QiLCJQVVQiLCJERUxFVEUiLCJHRVQiXSwiL2NvZGUvZ2l0Y29kZS8iOlsiUE9TVCIsIlBVVCIsIkRFTEVURSIsIkdFVCJdLCIvY29kZS9wdWJsaXN0LyI6WyJQT1NUIiwiREVMRVRFIiwiR0VUIiwiUFVUIl0sIi9jb2RlL2xvZy8iOlsiREVMRVRFIiwiR0VUIl0sIi9zeXMvc29mZXdhcmUvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL3N5cy9iYXRjaC8iOlsiR0VUIl0sIi9zeXMvZmlsZW1nLyI6WyJHRVQiXSwiL3Rvb2wvcGhwbXlhZG1pbi8iOlsiR0VUIiwiUE9TVCJdLCIvbG9nL29wc2xvZy8iOlsiR0VUIiwiUE9TVCJdLCIvbG9nL3VzZXJsb2cvIjpbIkdFVCJdLCIvYXV0aC9yb2xlLyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9hdXRoL3VzZXIvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2F1dGgvbWVudS8iOlsiR0VUIiwiUFVUIiwiREVMRVRFIiwiUE9TVCJdLCIvYXV0aC9wZXJtcy8iOlsiUE9TVCIsIkRFTEVURSIsIlBVVCIsIkdFVCJdLCIvYXV0aC9hZGRyb2xlbWVudS8iOlsiUE9TVCIsIkRFTEVURSIsIlBVVCIsIkdFVCJdLCIvYXV0aC9hZGRyb2xlcGVybXMvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2F1dGgvcm9sZW1lbnUvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2F1dGgvcm9sZXBlcm1zLyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9hdXRoL3JvbGVhc3NldC8iOlsiUE9TVCIsIkRFTEVURSIsIlBVVCIsIkdFVCJdLCIvYXV0aC9hZGRyb2xlYXNzZXQvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2F1dGgvYWRkcm9sZXByb2plY3QvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2F1dGgvcm9sZXByb2plY3QvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2Fzc2V0L2hvc3RkZXRhaWwvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2Fzc2V0L3N5bmNob3N0LyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9hc3NldC9zZWFyY2hob3N0LyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9hc3NldC9kZWxob3N0LyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9hc3NldC9jb25uZWN0aG9zdC8iOlsiUE9TVCIsIkRFTEVURSIsIlBVVCIsIkdFVCJdLCIvY29kZS9zZWFyY2gvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2Fzc2V0L2V4cG9ydGhvc3QvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2F1dGgvY2hwYXNzd2QvIjpbIlBPU1QiLCJERUxFVEUiLCJQVVQiLCJHRVQiXSwiL2F1dGgvYWRkcmVtb3RlLyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9zeXMvdXBmaWxlLyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9zeXMvcnVuY21kLyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9zeXMvc2NyaXB0LyI6WyJQT1NUIiwiREVMRVRFIiwiUFVUIiwiR0VUIl0sIi9zeXMvY3Jvbi8iOlsiUE9TVCIsIkRFTEVURSIsIlBVVCIsIkdFVCJdfSwicmVtb3RlX3VzZXIiOiJyb290IiwicmVtb3RlX3Bhc3N3ZCI6Ik9uZWRheTAzMTMiLCJyZW1vdGVfc3Noa2V5IjoiIiwiY3VyX2RpciI6In4iLCJjdXJfaG9zdCI6IjE5Mi4xNjguMS4xMjYifQ==', '2018-10-25 08:28:58.206620');

SET FOREIGN_KEY_CHECKS = 1;
