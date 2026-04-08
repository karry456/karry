/*
 Navicat Premium Dump SQL

 Source Server         : student
 Source Server Type    : MySQL
 Source Server Version : 50717 (5.7.17-log)
 Source Host           : localhost:3306
 Source Schema         : secondhandplatform

 Target Server Type    : MySQL
 Target Server Version : 50717 (5.7.17-log)
 File Encoding         : 65001

 Date: 08/04/2026 10:20:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cartId` int(100) NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `productId` int(100) NOT NULL COMMENT '商品ID',
  `userId` int(100) NOT NULL COMMENT '用户ID',
  `creatTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`cartId`) USING BTREE,
  INDEX `productId`(`productId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `orderId` int(100) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `orderNO` char(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `userId` int(100) NOT NULL COMMENT '用户ID',
  `productId` int(100) NOT NULL COMMENT '商品ID',
  `paymentAmount` double NOT NULL COMMENT '支付金额',
  `status` char(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单状态',
  `payStatus` char(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '支付状态',
  `receiverName` char(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人姓名',
  `receiverPhone` char(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人电话',
  `receiverAddress` char(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人地址',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `deletedAt` tinyint(1) NOT NULL DEFAULT 1 COMMENT '软删除',
  PRIMARY KEY (`orderId`) USING BTREE,
  INDEX `productId`(`productId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, '5642', 2, 3, 28, '1', '1', '王德吉', '17783464519', '重庆', '2025-12-10 16:55:38', 1);
INSERT INTO `order` VALUES (2, '9586', 4, 7, 56, '1', '1', '胡文豪', '17854562356', '四川', '2025-12-11 09:30:24', 1);
INSERT INTO `order` VALUES (5, '91046e8f-6c9a-4928-b640-53b2269e8206', 1, 3, 3280, '1', '1', '丽丽姐', '15865487655', '西安', '2025-12-12 10:02:59', 1);
INSERT INTO `order` VALUES (8, '5ec0b8de-1a1b-4512-ad33-882780b846c8', 1, 15, 588, '1', '1', '丽丽姐', '15865487655', '西安', '2025-12-12 10:22:37', 1);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `productId` int(100) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `userId` int(100) NOT NULL COMMENT '发行用户',
  `productNo` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品编号',
  `productName` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `productPhoto` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品图片',
  `productType` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类型',
  `productPrice` double(20, 2) NOT NULL COMMENT '商品价格',
  `productState` tinyint(1) NOT NULL COMMENT '商品状态',
  `favorites` int(100) NOT NULL DEFAULT 0 COMMENT '商品收藏量',
  `productInfo` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品信息',
  `purchased` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否被购买',
  `createTime` datetime NOT NULL COMMENT '创建日期',
  `updateTime` datetime NOT NULL COMMENT '修改日期',
  PRIMARY KEY (`productId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 4, 'ITEM25042400015656', '苹果17', 'product/5e45619a02864ee49466126f941b89bd_20251211151400.webp', '手机', 4888.00, 1, 11, '个人闲置，后盖有裂痕，屏幕正常，指纹和人脸识别不支持，电池未知。功能正常，插卡即用。适合做备用机或学习用。 支持自提，售出不退不换', 1, '2025-11-29 17:41:33', '2025-12-11 16:28:25');
INSERT INTO `product` VALUES (2, 3, 'ITEM2504240001', '小米11', 'product/6b5be94819614b83ba1f124c494ef982_20251211151552.jpg', '手机', 2800.00, 0, 10, '小米11青春版 国行8+128g 双卡双待 全网通 外观看照片 换过屏幕 开机键有点硬，但是正常使用不影响 ID已退可以随便升级还原', 1, '2025-11-29 18:30:28', '2025-12-12 10:17:14');
INSERT INTO `product` VALUES (3, 5, '000db2f3-31b1-47c1-9806', '华为Mate 60 pro', 'product/fe76ae3007604f1a96b8a07aea2f6821_20251211152151.jpg', '手机', 3280.00, 0, 0, '1TB黑色 手机 9.5 成新，没磕碰，屏幕无划痕，功能全正常，无拆无修，账号已退，插卡即用 麒麟9000S处理器，性能强劲，电池健康，支持5G双卡， 顺丰包邮，售后有保障', 0, '2025-12-03 00:26:09', '2025-12-12 10:02:58');
INSERT INTO `product` VALUES (4, 3, '7697acf8-d058-415c-9917', 'AirPods Max', 'product/74db92707dd94e2d9f6b472d41137dc0_20251211152545.avif', '耳机', 2500.00, 1, 1, '自用AirPods Max紫色USB-C接口，25年9月淘宝买的，国行，盒子配件都在，成色很不错，没磕碰没划痕，功能全正常，音质超棒，降噪很厉害，头戴式戴着舒服，喜欢的可以小刀！！！包邮！！！细节私聊', 1, '2025-12-03 10:47:50', '2025-12-11 15:41:33');
INSERT INTO `product` VALUES (5, 2, 'a33f268b-276b-44e0-985b', '漫步者Lolli Pro2', 'product/79ca1ebc8c90498b9c332c4c53a4468b_20251211152858.jpg', '耳机', 98.00, 1, 1, '漫步者（EDIFIER）Lolli Pro2 真无线主动降噪蓝牙耳机  蓝牙5.3 适用苹果华为小米 白色 东西全新的，质量好，百分百正品，支持各种渠道验货。', 0, '2025-12-03 12:44:40', '2025-12-11 15:41:57');
INSERT INTO `product` VALUES (6, 3, 'c5b96147-9861-4e74-ab41', 'ROG枪神8', 'product/06afac1e190c4f16adfa71ced2d00963_20251211153245.jpg', '电脑', 6400.00, 1, 0, 'i9-14900hx 16GB+1T 99新 线下购买，自用还在质保内，平时实际电脑使用少，有意者私聊，瑕疵已拍，二手物品售出不退，广州可自提#笔记本电脑', 0, '2025-12-05 18:10:23', '2025-12-11 15:33:57');
INSERT INTO `product` VALUES (7, 1, 'a7e574e7-ad18-447f-81e1', '小米Air笔记本', 'product/694c2af1ec18413fa0e907ce6ff6a944_20251211153422.jpg', '电脑', 2000.00, 0, 0, '12.5寸笔记本 m3处理器 4G内存+128G固态硬盘 全原装无拆修 成色看图 屏幕完好无坏点 键盘干净整洁 散热正常 适合办公上网课 价格可小刀 同城自提 异地顺丰到付', 1, '2025-12-05 18:12:23', '2025-12-12 10:17:46');
INSERT INTO `product` VALUES (8, 3, '472cd900-4bf3-43a3-9398', '海马300男士高端手表', 'product/0f294b0e5cf44ec3be62e4f70b814efc_20251211153645.jpg', '手表', 4750.00, 0, 1, '闲置全新 欧米茄海马男士机械腕表 机械表\n全自动机械表 进口西铁城8215机芯\n走时准确，无佩戴可支持七天无理由退货\n全新未拆封 图片现货实拍 所见即所得', 0, '2025-12-06 23:42:16', '2025-12-12 09:19:33');
INSERT INTO `product` VALUES (9, 2, 'e23f1452-0c4b-43c3-9651', '劳力士绿水鬼', 'product/f922c6a1f38a4aa5aefb0b0c658127f5_20251211153744.jpg', '手表', 10800.00, 1, 0, '自动机械机芯，绿色表盘，钢带款。表圈和表带都是钢制，不是陶瓷，佩戴舒适，走时不正常。表带长度可调节，适合大部分手腕。外观有点老，有使用痕迹，整体成色一般般，具体看图。', 0, '2025-12-06 23:42:18', '2025-12-11 18:59:32');
INSERT INTO `product` VALUES (10, 5, '40b71823-3680-40d1-9918', '索尼ZVE10', 'product/138123a07872478a9da468236e1c007b_20251211154320.webp', '摄影摄像', 2780.00, 0, 0, '成色非常漂亮,使用非常爱惜 一直放防潮箱,几乎全新,描述不符,支持拒收,放心购买拍照和录制视频很赞,相机图片实物拍摄新手入门首选机器,支持WiFi直传照片录4k视频', 1, '2025-12-06 23:53:06', '2025-12-12 10:17:54');
INSERT INTO `product` VALUES (11, 6, 'a8781338-4d75-4ff2-add7', '木吉他', 'product/76825ae06a264ec48e4dc21b58a5a580_20251211154520.jpg', '乐器', 108.00, 1, 0, '琴很新保护的很好没有磨损磕碰，弦距也是标准的，面板是云杉木，单板，喜欢的话可以来下单', 0, '2025-12-07 00:37:30', '2025-12-11 15:46:30');
INSERT INTO `product` VALUES (12, 3, '5e6e1332-fce1-439f-b3df', '尼康D7100单反套机', 'product/d22e8bda49b64313994e93e208a5334b_20251211154712.avif', '摄影摄像', 1380.00, 1, 0, '套机带18-55镜头：1880（带全套配件）,机身取景器轻微发霉，功能正常不影响使用，介意慎拍。', 0, '2025-12-08 11:05:14', '2025-12-11 16:09:35');
INSERT INTO `product` VALUES (13, 3, '44a18ccf-30cf-4a2e-8a51', '和田玉糖玉手串', 'product/d1db98681feb4738812027c64580c8bf_20251211154837.avif', '饰品', 80.00, 0, 0, '油性好，润度高结构细腻,籽行完整，无裂纹无瑕疵。仅此一条，喜欢的不要错过。', 1, '2025-12-08 16:30:21', '2025-12-12 10:18:02');
INSERT INTO `product` VALUES (14, 5, 'a3294e35-3566-4408-b294', '海尔冰箱', 'product/993e0ea411f94483986c5945019e52bb_20251211155212.png', '家电', 280.00, 1, 0, '全新未拆封家用海尔美的冰箱公寓租房宿舍办公室用一级能效冷藏冷冻两门冰箱', 0, '2025-12-10 12:49:42', '2025-12-11 15:53:06');
INSERT INTO `product` VALUES (15, 1, '0b4aea00-04a0-4aa8-84fd', '天然和田玉', 'product/c3b6ecc138b040fe9e0c2bdbce896dbb_20251211155332.webp', '珠宝', 588.00, 0, 0, '疆且末蓝手串，天空蓝奥，这个色还挺难找的，卡12mm左右大小老型珠，油润度非常好，肉眼可见手推出油滴，底子细腻无脏杂绺裂，无黑点.', 1, '2025-12-10 12:57:52', '2025-12-12 10:22:37');
INSERT INTO `product` VALUES (16, 2, '6d2931f3-4cb9-4664-b4b1', '海尔洗衣机', 'product/e18764fc71594cf69cc5c2653df26b39_20251211155501.jpg', '家电', 180.00, 1, 0, '家用超合适，10 公斤的全新款，还有 8 公斤洗脱一体的，带蓝光杀菌和一键风干功能，居家、公寓、租房用它都是首选！', 0, '2025-12-10 16:49:56', '2025-12-11 15:55:37');
INSERT INTO `product` VALUES (17, 3, 'ab6809b7-8d0e-42d7-a18c', '索尼PS5', 'product/09e04fce10784e1a825490b116615e94_20251211155643.webp', '游戏电玩', 1899.00, 1, 0, '国行PS5数字版自定义成色【98新】全套配件齐全，无拆无修原装正品有任何问题包退支持任何方式检测【有一点卡顿都包退】额外提供一年保修，发货前都会录详细视频外观。', 0, '2025-12-10 19:34:26', '2025-12-11 15:57:16');
INSERT INTO `product` VALUES (18, 1, 'b90c7e89-6bef-4eb4-b84d', 'switch任天堂', 'product/f78ff59ae6ca4ca0a3a9bcf0894de376_20251211155817.jpg', '游戏电玩', 685.00, 1, 0, '任天堂switch 二手 成色95新最新系统版本 确保最新游戏可玩 游戏帮装好主机有全套原装配件 屏幕贴好膜 后盖正常使用痕迹', 0, '2025-12-11 00:08:26', '2025-12-11 15:59:04');
INSERT INTO `product` VALUES (19, 2, 'c05ab014-dc9b-4d45-b', '小米SU7 pro智驾版', 'product/5489689429ac4744bab0983bdef9297e_20251211160010.jpg', '二手车', 153762.00, 1, 0, '实表9000多公里，准新车状态，内外都很新，三电螺丝未动，配置丰富：全景天幕、真皮座椅、自动泊车、倒车影像、定速巡航、高阶智驾，弹射模式，手续齐全，支持过户。', 0, '2025-12-11 16:01:21', '2025-12-11 16:01:21');
INSERT INTO `product` VALUES (20, 2, 'fc525409-f553-4e2c-8', '特斯拉MODEL X', 'product/2e210e9ccd1c45ceb2f6e8396998bb56_20251211160201.jpg', '二手车', 159800.00, 1, 0, '3万多公里出点头，车头保险杠碰撞过，修复后有点小瑕疵，带可过户的免费超充，增强版辅助驾驶', 0, '2025-12-11 16:02:38', '2025-12-11 16:02:38');
INSERT INTO `product` VALUES (21, 2, '05598d74-a36a-4f7f-9', '兰博基尼LP700-4', 'product/eda96fe27d0140cda4815c46c5fd43ff_20251211160427.jpg', '二手车', 134400.00, 1, 0, '车况完美，自己偶尔开开，车子改了外观套件和智能中控大屏，现在车太多没有车位停也想把这牌照换到其他车用，所以忍痛割爱！遇缘人，车商勿扰谢谢！随时可以看车试车。', 0, '2025-12-11 16:05:01', '2025-12-11 16:05:01');
INSERT INTO `product` VALUES (22, 2, '018d911c-2c59-4a92-9', 'fender芬达电贝斯', 'product/ecaf0b51325d4ff281cff80e9b121d9f_20251211160956.webp', '乐器', 2000.00, 1, 0, '初学者成人入门家驹同款电贝斯 没学会便宜出了，急，可议价', 0, '2025-12-11 16:06:28', '2025-12-11 16:09:57');
INSERT INTO `product` VALUES (23, 2, 'e1db7d7c-6bd6-4186-9', '雅马哈YS3钢琴', 'product/4d3d77631e86433bacb0f73ec4edc2fe_20251211160730.jpg', '乐器', 1280.00, 1, 0, '2017年购入，9成新！音色纯正，手感细腻，送原装琴凳。内部保养很好，状态完美，三个踏板都正常。88键专业演奏级，适合家用或教学。价格可聊，欢迎随时来看琴试音，保证功能完好', 0, '2025-12-11 16:07:54', '2025-12-11 16:07:54');
INSERT INTO `product` VALUES (24, 2, 'e18073d6-6f3f-45a0-8', '欧米茄海马系列', 'product/18ad0a4fc9da44ef8119194e3226818a_20251211161256.webp', '手表', 899999.00, 1, 0, '全膜，41表径， 蝴蝶扣 ，银白色甲板纹，6点位独立小秒盘，搭载 8916机芯，提供60小时动储', 0, '2025-12-11 16:13:50', '2025-12-11 16:13:50');
INSERT INTO `product` VALUES (25, 2, '2c685f45-ae63-434e-8', '奔驰GLC300L动感', 'product/39bb08362fb74d8ba012b28bb9c7f777_20251211161426.webp', '二手车', 209800.00, 1, 0, '沈阳本地一手车，铁件原漆，10万公里', 0, '2025-12-11 16:14:47', '2025-12-11 16:14:47');
INSERT INTO `product` VALUES (26, 2, '5e143856-f7ab-459a-b', '美诺洗衣机', 'product/009e483ef5e741d9bc068d4b25b2830d_20251211161657.avif', '家电', 45000.00, 1, 0, 'WWR880+TWR780\n德国原装进口洗烘套装', 0, '2025-12-11 16:17:16', '2025-12-11 16:17:16');
INSERT INTO `product` VALUES (27, 2, 'ba246f7b-978b-4fd4-8', '帝瓦雷三代', 'product/98f811f1658641579095140e6753b3d8_20251211161817.avif', '耳机', 28580.00, 1, 0, '‌14Hz-35kHz超宽频响‌：从海底低音炮到云端铃声，每一处细节都听得清清楚楚，听歌/追剧/直播都沉浸感拉满\n样品/库存 可小刀 ！！', 0, '2025-12-11 16:18:42', '2025-12-11 16:18:42');
INSERT INTO `product` VALUES (28, 2, 'bc2e4f86-4ecd-43df-b', 'iPad Air', 'product/1827bac347c6406798e916b428af5157_20251211162152.avif', '平板', 3188.00, 1, 0, '25年5月淘宝买的，原价4500+\n无线局域网版,包邮，不议价，不议价，不退不换', 0, '2025-12-11 16:22:33', '2025-12-11 16:22:33');
INSERT INTO `product` VALUES (29, 4, 'cc86f3c3-aaab-4585-b', 'ROG幻14 air', 'product/fa66085cef2049c58503ac1e9c9a7fb4_20251211163303.png', '电脑', 8999.00, 1, 0, '成色: 外观有磕碰磨损，可以换a壳，屏幕完美，正品泰国代购回来，薄约1.49cm，轻约1.85kg，机制全能本', 0, '2025-12-11 16:33:46', '2025-12-11 16:40:29');
INSERT INTO `product` VALUES (30, 2, '937db0f8-d6dc-4909-b', 'iphone 17 pro', 'product/e021f3c059944bb89d9a8b09b72b02af_20251211163357.jpg', '手机', 8299.00, 1, 0, '10月9号到手，有发票，99新，贴了铁图3D热弯屏幕保护膜，带第一卫硅胶保护套。\n机器完美无质量问题，不用去摸奖了，屏幕是最好的三星屏G9N。电池健康100％', 0, '2025-12-11 16:34:56', '2025-12-11 16:44:02');
INSERT INTO `product` VALUES (31, 4, '9e112c15-7838-48e1-9', '华为笔记本电脑', 'product/422438501081414789a11efc22984c79_20251211163500.png', '电脑', 2514.00, 1, 0, '机器成色几乎全新，外观很新，无明显划痕，功能正常，无拆修。办公学习、日常使用都很流畅。a壳有轻微磕碰 有几个垫出来的凹点 不影响使用', 0, '2025-12-11 16:37:04', '2025-12-11 16:40:07');
INSERT INTO `product` VALUES (32, 2, '079d7ae3-d288-48ef-b', '佳能60d', 'product/15214486204349cd9f8d84267a2af9c6_20251211163717.avif', '摄影摄像', 1042.00, 1, 0, '采用了1810万像素，它还有一些非常实用的功能，比如可旋转液晶屏、1080p高清视频拍摄等。新手小白也能很快上手，新手也能拍出电影氛围感满满的照片！', 0, '2025-12-11 16:37:49', '2025-12-11 17:06:59');
INSERT INTO `product` VALUES (33, 4, '236d7b19-39a6-4ea8-a', '惠普暗影精灵11', 'product/733cc48fd2f54e94920920a032dddd02_20251211163757.png', '电脑', 8999.00, 1, 0, '14650H+RTX5060，16G DDR5 5600，1T固态，16寸2.5K 165Hz高刷屏，电池100%健康，鲁大师145w+，大型游戏随便玩，性能稳，无暗病无拆修，成色极品99新 8月份激活 ，原装主机+充电器，包邮，可自提', 0, '2025-12-11 16:39:43', '2025-12-11 16:40:59');
INSERT INTO `product` VALUES (34, 4, '4f4d2b00-1fb3-4ac8-8', '苹果笔记本m3', 'product/636c9a23457541c0aaab1bcc2f80d4bc_20251211164022.png', '电脑', 3699.00, 1, 0, '成色如图一对一实拍，已全方位展示。有一个边角的磕碰较为明显，底壳微压痕，其他轻微使用痕迹，整体成色还不错。二手物品，打灯挑刺高要求选手勿扰。', 0, '2025-12-11 16:42:17', '2025-12-11 16:47:59');
INSERT INTO `product` VALUES (35, 4, 'f075ed18-fba7-4613-a', '机械革命翼龙16', 'product/3316bd85fa97447aa2f1f89e47aa1e98_20251211164230.png', '电脑', 5399.00, 1, 0, '处理器锐龙AI9 H365 镁光DDR532G内存 1T长江存储PC411硬盘全是一等奖 显卡满血115wRTX5060\n屏幕2.5K 300HZ 100%dci p3色域 带人脸识别 黑橙 99新无磕碰划痕', 0, '2025-12-11 16:43:10', '2025-12-11 16:48:44');
INSERT INTO `product` VALUES (36, 4, '324634a0-d5c2-48bc-b', '联想r7000p', 'product/b0ffb3d065dd48c6b6500da30f35d793_20251211164437.png', '电脑', 6799.00, 1, 0, '原装原配，无拆无修，电池效率89%，到手直接用，支持独显直连，性能释放好，玩游戏不卡顿,性能远超3050。\n', 0, '2025-12-11 16:46:01', '2025-12-11 16:49:22');
INSERT INTO `product` VALUES (37, 4, '13e22ac7-fe05-4f9c-b', 'vivo Pad3 Pro', 'product/1d3e87682a4b4935a5ba9a91a4a203f9_20251211164715.png', '平板', 1200.00, 1, 0, '电池健康100%，系统originOS 4.0，安卓14\n天玑9300处理器，性能很强，打游戏、追剧都很流畅\n，包邮', 0, '2025-12-11 16:47:54', '2025-12-11 16:49:57');
INSERT INTO `product` VALUES (38, 4, '2af1a297-b1ff-44fb-8', '华为平板', 'product/33f9961a072e48cfb871b7e7276fa2d2_20251211164805.png', '平板', 4999.00, 1, 0, '正品保障：公司工程师备用机，多出来5台，全是全新未拆封！本人自用同款，实测续航、性能都靠谱，厂家直保2年，售后无忧！', 0, '2025-12-11 16:48:48', '2025-12-11 16:51:20');
INSERT INTO `product` VALUES (39, 4, 'df533d4d-d83f-47e1-8', '三星平板T805c', 'product/e3be27cf64cc4cd4a02d93271f0bd86a_20251211164927.png', '平板', 3999.00, 1, 0, '外屏有一条裂纹 显示效果好，原装机器，系统比较老了，安卓5.0系统。有用的上的联系。请了解清楚之后再购买，售出后不退', 0, '2025-12-11 16:49:56', '2025-12-11 16:51:41');
INSERT INTO `product` VALUES (40, 4, 'f2d746b0-1879-47e7-9', 'iPad 11代 ', 'product/fea045fda9f946049e6172dabca0f9fc_20251211165019.png', '平板', 1680.00, 1, 0, 'A16芯片，10.9寸大屏，256G大内存，追剧、办公、学习、画画、打游戏都很流畅，系统流畅不卡，ID已退，纯原无拆修无暗病，电池健康，续航很久，成色几乎全新，外观无明显划痕磕碰。', 0, '2025-12-11 16:50:56', '2025-12-11 16:53:02');
INSERT INTO `product` VALUES (41, 4, '2879fcb1-5a4d-40bc-9', 'Tab S7', 'product/3f2c16a14d5041e58b98001bbc909ad5_20251211165251.png', '平板', 6599.00, 1, 0, '屏幕显示完美(无老化烧屏），边框带原膜，后壳小划痕，定义 98 新，整机原装无拆修，如图实拍，功能全正常', 0, '2025-12-11 16:53:47', '2025-12-11 16:54:52');
INSERT INTO `product` VALUES (42, 4, 'e6207278-0144-4270-8', '索尼FX3A摄影机', 'product/4474224466204a3f87526b847a90796b_20251211165637.png', '摄影摄像', 12899.00, 1, 0, '机身完整无拆修，按键灵敏，CMOS干净无暗病。支持4K 120P高清拍摄，专业电影级别画质。E接口设计，适合电影、纪录片、广告等专业用途。配件：原装电池+充电器，随时可用。', 0, '2025-12-11 16:57:09', '2025-12-11 17:09:07');
INSERT INTO `product` VALUES (43, 4, '034f147d-ee0d-4455-a', '佳能单反550d套机 ', 'product/50073245f3e74e46be981250352385b3_20251211170323.avif', '摄影摄像', 2899.00, 1, 0, '佳能550d新手小白的不二之选。1800万像素，3寸高清大屏，支持屏幕实时取景，支持1080p全高清录像\n', 0, '2025-12-11 16:58:12', '2025-12-11 17:09:09');
INSERT INTO `product` VALUES (44, 4, 'c12bbe85-b831-44cc-a', '徕卡 Leica D-LUX7', 'product/998080811c054123809b6f47ce7cf51f_20251211170007.png', '摄影摄像', 2399.00, 1, 0, '配置相当齐全有:原装电池，2块品牌备用电池，原装充电器，充电器连接线，原装背带，数据线，包装箱，说明书、光盘都在，三码合一，自配相机包，自配皮质护套。\n外地只出高信用的', 0, '2025-12-11 17:00:57', '2025-12-11 17:09:11');
INSERT INTO `product` VALUES (45, 2, '93970af7-fd9c-4f88-b', '2022款奥迪Q5L', 'product/0f6e0d3de4874cf99e5a1d9369c0669b_20251211180944.avif', '二手车', 158000.00, 1, 0, '2.0T涡轮增压 252马力 L4发动机，自动挡/全景天窗 适时四驱、20寸轮毂、主动刹车、四种驾驶模式切换、电动感应记忆后备箱、全景天窗、换挡拨片、全液晶仪表盘、前排座椅加热 30色氛围灯，真皮电动座椅/加热，360全景影像/CarPlay，B&O音响等配置', 0, '2025-12-11 18:10:32', '2025-12-11 18:10:32');
INSERT INTO `product` VALUES (46, 2, 'eb3e4cf9-f1f8-424e-9', '兰博基尼URUS S版', 'product/7c2be976eb0c438c89386e897a1446c3_20251211181225.avif', '二手车', 338000.00, 1, 0, '万公里质保，两年内可以以购买价的85折在本门店回收！！\n保证原版\n上述都会写在合同里，放心有保障\n本店为二手车认证经销商\n合作检测机构：查博士/中国汽车流通协会', 0, '2025-12-11 18:12:26', '2025-12-11 18:12:26');
INSERT INTO `product` VALUES (47, 2, '3b33bba7-2ddb-40b0-b', '小鹏P7', 'product/a2d2268565bd462ea2abd7828c7f2aab_20251211181259.avif', '二手车', 160000.00, 1, 0, '长续航MAX   指导价18.68万那款 纯电615KM续航，全车按摩座椅通风加热，全域智驾 选装20寸轮毂，省钱比赚钱容易 二手价格买新车', 0, '2025-12-11 18:13:40', '2025-12-11 18:13:40');
INSERT INTO `product` VALUES (48, 2, '70dc004f-e080-4cd1-b', '奔驰GLA200', 'product/d7b75877bdc04f439d76ed13e83f4f25_20251211181414.avif', '二手车', 155800.00, 1, 0, '自家领导代步车，原版原漆\n3万公里，一点毛病没得\nGLA的标签一直都是女司机专属，外型柔美，内饰精致，油耗不高，养车成本也非常低，市区代步非常合适。', 0, '2025-12-11 18:14:40', '2025-12-11 18:14:40');
INSERT INTO `product` VALUES (49, 2, 'ef026abf-b39d-4d0c-8', '大疆 pocket3', 'product/a49e74e64b0e46cd9060b07b025dae3d_20251211181601.webp', '摄影摄像', 50000.00, 1, 0, '发货前会测试好封箱发货，寄回到货后也会开箱测试。收到物品也请录视频开箱以免出现不必要的误解。琐碎的配件比较多，千万注意爱护，大疆配件超级贵，如果丢失需要按表格里的价格赔付。', 0, '2025-12-11 18:17:02', '2025-12-11 18:17:02');
INSERT INTO `product` VALUES (50, 2, 'c1f2206c-ecdd-469b-8', '阿尔帕限量版金机', 'product/ade10e8ead0d4fc4bc53bf8491e0ca06_20251211181852.webp', '摄影摄像', 41000.00, 1, 0, '摄影器材的“镀金版本”是器材爱好者追求的终极目标之一，与摄影艺术追求的“金奖”殊途同归，本质均为对快乐的追求。\n阿尔帕是瑞士生产的相机名牌产品，相机的机械加工精度已经达到了“科研仪器”的水平，以工艺精湛、坚固耐用和品质优异而成为众多相机收藏家竞相追逐的对象。', 0, '2025-12-11 18:19:14', '2025-12-11 18:19:14');
INSERT INTO `product` VALUES (51, 2, '4a7faf73-bc74-4a97-a', '华为MatePadPro', 'product/4fd35158f6914af2a03b61dd619741af_20251211182021.webp', '平板', 7400.00, 1, 0, '16+1Tb 带星闪键盘、手写笔 箱配件齐全 简单使用了几天，新鲜感过了，不想用了血亏转卖，只是激活了，基本没使用，全套 2025年6月1号激活\n大刀不要问，问也不答', 0, '2025-12-11 18:20:45', '2025-12-11 18:20:45');
INSERT INTO `product` VALUES (52, 2, '3099a6d1-a711-4c86-8', 'T4Turbo学习机', 'product/63edb585c5454552854842362c0cd1ea_20251211182244.webp', '平板', 4100.00, 1, 0, '功能一切正常，无拆无修，电池健康89,外观有轻微使用痕迹，不影响正常使用,支持任何方式验机，当面交易更放心,偏远地区需补运费，售出不退不换\n有意私聊详谈', 0, '2025-12-11 18:23:38', '2025-12-11 18:23:38');
INSERT INTO `product` VALUES (53, 2, '30206149-1819-4f92-9', 'QDC帝王皇帝耳机', 'product/de9d50b8ea0b4d5e820c9b932363e772_20251211182514.webp', '耳机', 1500.00, 1, 0, '配件如图，无票，细微磨损划痕，功能正常，包邮顺丰。', 0, '2025-12-11 18:25:33', '2025-12-11 18:25:33');
INSERT INTO `product` VALUES (54, 2, '71fde745-0041-4717-8', 'T+A Solitaire ', 'product/4e166090d677407b943dcef8c4a9753b_20251211182604.avif', '耳机', 11000.00, 1, 0, '干邑白色新配色蓝牙耳机，全新未拆封，国行注册保修，现货秒发', 0, '2025-12-11 18:26:16', '2025-12-11 18:26:37');
INSERT INTO `product` VALUES (55, 2, '99c7a385-b769-4bdc-b', ' IO-12丹麦旗舰耳机', 'product/e6e698855ae54a45961a4a4019762f82_20251211182735.avif', '耳机', 5200.00, 1, 0, '实物拍摄，有电子发票，确认收货后发送，我个人自定义9.99999999成新，很轻微的使用痕迹，吹毛求疵者勿扰，所见即所得（原装耳机收纳包，耳机本体，音频线，充电线，转接头等配件，电子发票）', 0, '2025-12-11 18:27:56', '2025-12-11 18:27:56');
INSERT INTO `product` VALUES (56, 4, '5327f8ba-f145-4534-8', 'xbox手柄精英版二代 Elite 2精英二代 青春版-黑白', 'product/920b9cf2fef3413cb427b9f45aa5fd22_20251211182857.png', '游戏电玩', 489.00, 1, 0, '原装配件全套：手柄、全套替换摇杆、接收器、无线座充、收纳包都在\n支持无线充电，手感很棒，打游戏很舒服，功能全好，没怎么用，成色完美。', 0, '2025-12-11 18:29:33', '2025-12-11 18:31:58');
INSERT INTO `product` VALUES (57, 2, '79601c87-e432-4847-b', 'ZILDJIAN ', 'product/8f3e90773e6d43d6808975dc374ccfd1_20251211182824.avif', '耳机', 3252.00, 1, 0, '机有轻微使用痕迹，滤网处有点脏，具体细节看图。因家里耳机太多，闲置处理。音质方面需要自己去了解，原价3999的，二手物品请看好下单，没有质量问题售出不退。', 0, '2025-12-11 18:29:39', '2025-12-11 18:30:30');
INSERT INTO `product` VALUES (58, 4, '965e1cb3-162a-42d6-9', '任天堂（Nintendo）Switch2代主机 港版单机 标准版不含游戏 NS2游戏机掌机', 'product/a3100bae244d442bae55aed88e5b49a6_20251211183017.png', '游戏电玩', 3499.00, 1, 0, '盒子配件齐全，盒子中间纸板没了，二码合一 游戏机挺新，不带游戏送个转接头，游戏机手柄功能一切正常 摇杆、按键、联网一切正常，手柄无漂移。无拆无修，螺丝原厂状态，机器挺新，使用不多，整体状态很好挺新', 0, '2025-12-11 18:30:41', '2025-12-11 18:32:54');
INSERT INTO `product` VALUES (59, 2, '376907b9-b448-4d14-8', 'AirPods Max头戴式耳机', 'product/92b81b15eb304a42bb31f41ddc8986c3_20251211183104.avif', '耳机', 2599.00, 1, 0, '官方正品，功能完好，支持验机。配件齐全，带原装耳机盒。外观无划痕磕碰，一直佩戴保护套。适合日常通勤、休闲娱乐使用。感兴趣的朋友可以直接拍下，有任何问题欢迎私聊哦~', 0, '2025-12-11 18:31:25', '2025-12-11 18:31:25');
INSERT INTO `product` VALUES (60, 4, '95ec147b-52c0-405d-8', 'PlayStation新款索尼PS5 pro主机', 'product/2494f1084e0746ccb3e27fa9e2bd9b02_20251211183142.png', '游戏电玩', 12985.00, 1, 0, 'PlayStation索尼PS5新款pro二手游戏主机slim国行光驱港版日版，成色如图，因不懂用，售后不包退换，不包好坏，请看好再下单', 0, '2025-12-11 18:32:01', '2025-12-11 18:34:10');
INSERT INTO `product` VALUES (61, 4, 'f0510fe3-6df9-416c-8', '雷蛇毒蝰mini', 'product/19e3f51d85bf4e469763bf04ac6c568c_20251211183334.png', '游戏电玩', 99.00, 1, 0, '成色9-95新 有点小使用痕迹 功能完好无维修 配件齐全 盒子和线收到就能用\n包邮 支持自提发货前会再次测试功能确保无误在发货\n发货二十四小时内发货最晚不超过四十八小时', 0, '2025-12-11 18:34:00', '2025-12-11 18:35:01');
INSERT INTO `product` VALUES (62, 4, 'f49ce5e4-3cd7-4a45-b', 'TK RS6磁轴键盘', 'product/30d444f685f04ea9993aa786ae19a71a_20251211183634.png', '游戏电玩', 433.00, 1, 0, '粉色，自用一手新，外观良好。年初购买的，包装盒都在，功能完好无维修。因自己换了新外设所以出售，有线连接，磁轴键盘。运费协商因为太重了，价格好谈。', 0, '2025-12-11 18:37:02', '2025-12-11 18:38:10');
INSERT INTO `product` VALUES (63, 2, 'c62cad47-d953-448a-a', '精英二代手柄google', 'product/f7b6bc417d2842e1ac3a4d42003cffd6_20251211183705.webp', '游戏电玩', 450000.00, 1, 0, '做工细腻，低延迟，手感好，（官网和某东：1100元 某宝900+）稀缺品，抢完即止，\n外包装有磕碰，轻微使用痕迹（几乎看不出来）配原装充电线，白色一批\n闲置物品不退货，考虑好再拍避免不必要的麻烦，包邮中通快递 偏远地区不包邮', 0, '2025-12-11 18:37:29', '2025-12-11 18:37:29');
INSERT INTO `product` VALUES (64, 2, '7504ddd8-d9e1-49f0-a', '高仙111室外大型清扫机器人', 'product/e30049b3a210467da0b4be53dd7773d9_20251211183859.avif', '家电', 115000.00, 1, 0, '买来就用了一个月，基本全新状态，设备很稳定，也是清洁机器人的标杆，现在低价出给有需要的项目了', 0, '2025-12-11 18:39:25', '2025-12-11 18:39:25');
INSERT INTO `product` VALUES (65, 2, '060caea9-b6b6-478e-b', '智元绝尘C5扫地机器人', 'product/d7e62264d36a491e83138d5e2009819f_20251211183958.webp', '家电', 7800.00, 1, 0, '能自主上电梯、自主排班并生成作业报告、自主充电、自主加排水、自主清洁排水箱、重污识别清洁识别、远程唤醒一键启动、识别各种障碍，自动区分算法/云端学习', 0, '2025-12-11 18:40:36', '2025-12-11 18:40:36');
INSERT INTO `product` VALUES (66, 4, '54f7a566-4178-4281-9', 'FOCAL the spirit of sound劲浪', 'product/ebf688a9bbe94980871d73029bbaa79f_20251211184045.png', '家电', 2259500.00, 1, 0, '购入时间看截图，有三年换新，有个支架没拆封。总使用时长不超过50小时，放着没啥用了，几乎全新，箱说全，京东购入，之后如有问题可帮售后，信用嘎嘎好~\n北京当面交易，顺丰包邮，验货后签收，签收不退', 0, '2025-12-11 18:41:19', '2025-12-11 18:44:45');
INSERT INTO `product` VALUES (67, 2, '54e72512-d338-4b3b-a', '华为智慧屏V5', 'product/d05013571589485cad112c8c4c757859_20251211184300.avif', '家电', 18999.00, 1, 0, '98英寸，华为商城直发，免费勘测，送装一体搭载Super MiniLED鸿鹄画质，4K高清，享受超凡视界。赠送灵犀指向遥控，带来手机般的操作体验。HarmonyOS 4系统加持，支持百万应用畅玩。屏幕占比高达99%，无边视野，视觉效果满分。', 0, '2025-12-11 18:43:17', '2025-12-11 18:43:17');
INSERT INTO `product` VALUES (68, 4, 'e29b5200-6d19-40b6-9', '美的（Midea）微晶系列527十字门冰箱脉冲净化除菌净味嵌入大容量一级能效风冷无霜BCD-527WUSGPZMA', 'product/7df3cf52cefa4a878d76e773d5d27658_20251211184330.png', '家电', 4888.00, 1, 0, '1', 0, '2025-12-11 18:43:50', '2025-12-11 18:43:50');
INSERT INTO `product` VALUES (69, 4, '02cae24c-bc5d-4499-8', '莫森MS-828W实木金典小提琴', 'product/2592eeb7ef394dd3998f28fbab11faf2_20251211184524.png', '乐器', 300.00, 1, 0, '几乎全新，功能完好，送琴盒和琴弓。白松面板材，，亮光工艺，音色纯正。99新，有购买记录\n全套配件齐全，送调音器。喜欢的小伙伴欢迎私聊，价格可聊～', 0, '2025-12-11 18:45:43', '2025-12-11 18:47:38');
INSERT INTO `product` VALUES (70, 2, 'bdedd86a-29e3-462c-9', '海浪鼓', 'product/922647d679844c20aaebe983d218b3c1_20251211184543.webp', '乐器', 89999.00, 1, 0, '国麦尔 18/20/22尺寸，感受大海的声音～现货速发！价格实惠 小窗咨询吧', 0, '2025-12-11 18:46:09', '2025-12-11 18:46:09');
INSERT INTO `product` VALUES (71, 2, 'b0ed2cbc-ddac-4196-8', 'Adams定音鼓', 'product/346c46186cf74a849769380c508cc72c_20251211184639.avif', '乐器', 519999.00, 1, 0, 'Adams爱乐轻廷帕尼代表了廷帕尼声音和设计中质量的终极表达。克洛伊德·达夫模型廷帕尼具有德累斯顿风格的踏板，以及已成为所有亚当斯乐器的代名词的质量、工程和最先进的精度。', 0, '2025-12-11 18:47:00', '2025-12-11 18:47:00');
INSERT INTO `product` VALUES (72, 4, 'fb993eff-57b2-4f6e-9', '木款手工小提琴', 'product/2d612f20edac432aa35199dfc16f9dcf_20251211184737.png', '乐器', 3444.00, 1, 0, '随琴配送，琴盒，琴弓，肩托，备用琴弦一根，指位帖，松香，擦琴布，电子教程，安装好调好音发货收到即可拉。', 0, '2025-12-11 18:47:54', '2025-12-11 18:50:39');
INSERT INTO `product` VALUES (73, 4, '6b303300-477d-4a94-a', '美得理魔鲨MZ726', 'product/da638e1378c54728b9c21c72fd430774_20251211184859.png', '乐器', 3999.00, 1, 0, '纯黑色的。有一个电子音箱很多调节按钮，还有一个20公分宽的电子操作器，还有脚踏，东西配件等都是齐全的。懂行的来哦，东西是好的，藏太久，脚踏椅子会有部分生锈', 0, '2025-12-11 18:49:18', '2025-12-11 19:02:56');
INSERT INTO `product` VALUES (74, 2, '1441e89c-efa4-48fb-a', 'nubia M153', 'product/3d4cda2a765a4908976821f8a979a5c9_20251211185230.avif', '手机', 5999.00, 1, 0, '骁龙8至尊版处理器，6.78英寸高刷屏，6000mAh大电池，后置5000万三摄，AI助手功能，支持NFC、红外、超声波指纹、USB-C接口', 0, '2025-12-11 18:49:20', '2025-12-11 18:52:49');
INSERT INTO `product` VALUES (75, 4, 'e6cfc876-63aa-4217-b', '玉手镯缅甸天然绿手镯 缅甸翡翠A', 'product/2f70c84328714ebebec62ad5ecbf5cfa_20251211185205.png', '珠宝', 1999999.00, 1, 0, '1', 0, '2025-12-11 18:52:21', '2025-12-11 18:52:21');
INSERT INTO `product` VALUES (76, 4, '10cd4a16-e543-4ac0-8', '红米Note12', 'product/ba672df97e7b4da19c8eed57b2cebdf8_20251211185332.png', '手机', 1299.00, 1, 0, '全原装功能都正常用屏幕显示好触控灵敏电池耐用账号已退无拆修功能都正常成色好外屏轻微裂痕不影响 内屏好的', 0, '2025-12-11 18:53:52', '2025-12-11 18:55:02');
INSERT INTO `product` VALUES (77, 4, '2e2102fc-0d60-4b0e-9', '红米k60', 'product/b38a5259387b42bcac73da816612f45f_20251211185359.png', '手机', 699.00, 1, 0, '成色看图，除一条屏生线外，无暗病，功能都好的！\n骁龙8 Gen1，120帧，电池正常，电池12月9日还极佳\n成色还可以，正常使用痕迹，无拆无修\n顺丰包邮，如无质量问题不退不换', 0, '2025-12-11 18:54:15', '2025-12-11 18:55:16');
INSERT INTO `product` VALUES (78, 4, 'f51152b0-1d4f-4cf2-9', '小米17', 'product/b13021b098b24c3fb2d93207d6f62530_20251211185425.png', '手机', 3999.00, 1, 0, '第五代骁龙8至尊版处理器，HyperOS 3.0系统，徕卡相机四摄。机器成色很好，99修，原装配件，有充电器，不支持7天无理由退货。有质量问题，包退货包邮。功能都正常，电池健康度100。', 0, '2025-12-11 18:54:41', '2025-12-11 18:55:39');
INSERT INTO `product` VALUES (79, 4, '942b5af3-421e-41de-b', '百达翡丽', 'product/286879ed8ab64e85994087ce95ff5bfb_20251211185614.png', '手表', 3258675.00, 1, 0, '表盘超闪，星空图自动转动展示，月相功能精准！\n43mm表壳，自动机械机芯，走时稳定，送原装包装盒。顺丰包邮，支持验货，质保三年。喜欢的朋友欢迎私聊咨询具体款式，价格可聊！', 0, '2025-12-11 18:56:32', '2025-12-11 18:57:42');
INSERT INTO `product` VALUES (80, 2, 'c3e06132-4b02-43fd-9', '百达翡丽6104R', 'product/9f9952ce0eae4ec482f6bbe9c618f6ea_20251211185645.webp', '手表', 3870000.00, 1, 0, '百达翡丽6104R\n2022年二手大全套\n玫瑰金壳 原钻圈 黑盘\n自动机械机芯 44mm表径\n功能齐全 正品保证\n好价出\n喜欢私聊', 0, '2025-12-11 18:57:09', '2025-12-11 18:57:09');
INSERT INTO `product` VALUES (81, 4, '3d034b8a-4a2b-4b74-b', '劳力士ROLEX—迪通拿系列', 'product/3394a78d30bc4ef5b83ae404787a7b28_20251211185731.png', '手表', 385499.00, 1, 0, '搭配进口全自动多功能机械机芯超强夜光 陶瓷圈口316L精钢表壳\n原装保险扣 尺寸40mm 成功男士的标配 ', 0, '2025-12-11 18:57:50', '2025-12-11 18:58:50');
INSERT INTO `product` VALUES (82, 4, 'b677d6e1-a4ed-4dd1-8', 'Richard Mill理查德勒', 'product/edf9f4f377fc4545916b48be2e3da769_20251211185933.png', '手表', 3576500.00, 1, 0, '经典款式，自动机械机芯。表盘大气时尚，适合各种场合佩戴。表壳采用坚固陶瓷材质，确保耐用性。购于其他线下渠道，无附件。适合通用群体，表径40-45mm，完美搭配手腕线条。', 0, '2025-12-11 18:59:53', '2025-12-11 19:00:25');
INSERT INTO `product` VALUES (83, 4, '52770717-64aa-432b-8', '百年灵TOP TIME系列', 'product/af378287c33b4da691ba60942f6342e6_20251211190039.png', '手表', 42300.00, 1, 0, '2025年4月国行大全套，型号是AB3113281A1X1，百年灵首发试戴品，已8年延保到2033年', 0, '2025-12-11 19:01:01', '2025-12-11 19:02:04');
INSERT INTO `product` VALUES (84, 1, '01ad4ffa-16e8-4ea8-8', '测试', 'product/34e499257da24c42a828beec3f69cc8d_20251212104840.jpg', '手表', 1.00, 1, 0, '测试', 0, '2025-12-12 10:49:42', '2025-12-12 10:49:42');

-- ----------------------------
-- Table structure for productcomment
-- ----------------------------
DROP TABLE IF EXISTS `productcomment`;
CREATE TABLE `productcomment`  (
  `commentId` int(100) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `productId` int(100) NOT NULL COMMENT '商品ID',
  `userId` int(100) NOT NULL COMMENT '用户ID',
  `content` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`commentId`) USING BTREE,
  INDEX `productId`(`productId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `productcomment_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productcomment
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int(100) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `userCode` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户编号',
  `avatar` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg' COMMENT '用户头像',
  `userName` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登录名',
  `passWord` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `onlineUsername` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网名',
  `email` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `telephoneNumber` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0封禁1正常',
  `role` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2' COMMENT '0超级1普通2用户',
  `balance` double(8, 2) NOT NULL DEFAULT 0.00 COMMENT '账户余额',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`userId`, `userCode`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '58921286', 'user/e43680b432f54fb387390075e31a96bb_20251212105628.jpg', 'wangdeji', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'karry', '17783464519@qq.com', '17783464519', 1, '0', 96612.00, '2025-12-09 16:29:04', '2025-12-12 10:56:30');
INSERT INTO `user` VALUES (2, '05172975', 'user/0f3d7b8618d746afbf3e8daa7528eb3a_20251211235224.jpg', 'huwenhao', '15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225', '胡某大帅比', 'amy0414@163.com', '17582565555', 1, '1', 520.00, '2025-12-10 12:29:54', '2025-12-11 23:52:56');
INSERT INTO `user` VALUES (3, '63562591', 'user/cdefdcde62fb42c09f7346418ea55c80_20251211192228.png', 'liqiang', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '痕痕痕痕痕痕', 'amy0414@163.com', '17783464519', 1, '2', 0.00, '2025-12-10 15:35:54', '2025-12-11 19:22:30');
INSERT INTO `user` VALUES (4, '14301433', 'user/f382c60cbe8140e0bb959e34614113ce_20251211100457.png', 'huangbaoliang', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名5671', 'amy0414@163.com', '13546578525', 1, '2', 0.00, '2025-12-10 16:04:31', '2025-12-12 10:55:41');
INSERT INTO `user` VALUES (5, '67943300', 'user/2bd79d87a0474b54af98809fb57caa9c_20251211100509.png', 'zhangguang', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名6037', 'amy0414@163.com', '14585657855', 1, '2', 0.00, '2025-12-11 00:46:40', '2025-12-11 21:03:15');
INSERT INTO `user` VALUES (6, '34226117', 'user/7de7381b5d8f4aab8d9d963fc91c8827_20251211162936.jpg', 'liqiang1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名4285', 'amy0414@163.com', '17586555555', 1, '2', 8.00, '2025-12-11 01:00:00', '2025-12-11 16:29:37');
INSERT INTO `user` VALUES (7, '14724972', 'user/6a708014681642dea1941e38d386c102_20251211141916.png', 'zhouzhengyi', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名1328', 'amy0414@163.com', '17756225555', 1, '1', 0.00, '2025-12-11 11:30:02', '2025-12-11 14:19:17');
INSERT INTO `user` VALUES (8, '11026715', 'user/02a91ff0fc3742af9ca8d65788fd1a2f_20251211141927.png', 'zhouzhengyi2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名3240', 'amy0414@163.com', '17752522222', 1, '1', 5.00, '2025-12-11 11:30:40', '2025-12-11 14:19:28');
INSERT INTO `user` VALUES (9, '24641996', 'user/d87392191d624d31b65d51905de0c64e_20251211141934.png', 'wangdeji1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名4130', 'amy0414@163.com', '14455555555', 1, '1', 5.00, '2025-12-11 11:48:46', '2025-12-11 14:19:35');
INSERT INTO `user` VALUES (10, '08056781', 'user/626409aeef8344b1b3532a1f72498562_20251211141942.png', 'gaosongdeng', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名2063', '3575069220@qq.com', '18584584436', 1, '1', 10000.00, '2025-12-11 11:50:28', '2025-12-11 14:19:43');
INSERT INTO `user` VALUES (11, '02025308', 'user/4f473ead887e41a9bc254430e0df0997_20251211141948.png', '565656', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名8591', '45454586@qq.com', '15356485848', 1, '2', 0.00, '2025-12-11 12:01:29', '2025-12-11 14:19:50');
INSERT INTO `user` VALUES (12, '51844343', 'https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg', 'liqiang2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名2989', NULL, NULL, 1, '2', 0.00, '2025-12-11 22:43:11', '2025-12-11 22:43:11');
INSERT INTO `user` VALUES (13, '12056769', 'https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg', 'liqiang3', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名1957', NULL, NULL, 1, '2', 0.00, '2025-12-11 22:43:25', '2025-12-11 22:43:25');
INSERT INTO `user` VALUES (14, '47676056', 'https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg', 'liqiang4', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '二手市场未命名0842', NULL, NULL, 1, '2', 0.00, '2025-12-12 10:44:40', '2025-12-12 10:44:40');

SET FOREIGN_KEY_CHECKS = 1;
