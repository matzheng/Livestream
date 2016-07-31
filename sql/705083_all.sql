SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS  `qw_links`;
CREATE TABLE `qw_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `o` (`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS  `qw_live`;
CREATE TABLE `qw_live` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL COMMENT '分类id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `keywords` varchar(255) NOT NULL COMMENT '关键词',
  `description` varchar(255) NOT NULL COMMENT '摘要',
  `thumbnail` varchar(255) NOT NULL COMMENT '缩略图',
  `content` text NOT NULL COMMENT '内容',
  `liveurl` varchar(100) NOT NULL COMMENT '直播地址',
  `liveprice` int(10) NOT NULL,
  `t` int(10) unsigned NOT NULL COMMENT '时间',
  `n` int(10) unsigned NOT NULL COMMENT '点击',
  `r` smallint(5) unsigned NOT NULL COMMENT '是否推荐',
  PRIMARY KEY (`aid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_live`(`aid`,`sid`,`title`,`keywords`,`description`,`thumbnail`,`content`,`liveurl`,`liveprice`,`t`,`n`,`r`) values
('5','7','化学品安全培训 ','','eqweqwewqeqw','/Public/attached/201607/1469929412.png','<span style="color:#454545;font-family:Helvetica, sans-serif;font-size:13px;line-height:19.5px;background-color:#FFFFFF;">   </span><span style="color:#454545;font-size:13px;line-height:19.5px;font-family:Arial;background-color:#FFFFFF;">化学品是日常企业生产过程中最为常用的生产原料。但化学品引起的火灾、爆炸、人身伤亡事故也随时发生。之所以化学品会引起事故，很大程度上是因为操作人员对化学品认识不足，违反安全操作规程所致。本课程介绍了化学品定义、化学品标识标志、常见化学品危险辨识、化学品操作和安全管理控制措施等知识。学员通过本课程的学习，将会对化学品的安全使用、储存、运输以及个人防护有着全新的认知。</span>','http://www.google.com','1','1469927183','0','1'),
('6','7','办公安全培训直播','','rwerewr','/Public/attached/201607/1469929428.png','<span style="color:#454545;font-family:Helvetica, sans-serif;font-size:13px;line-height:19.5px;background-color:#FFFFFF;"> </span><span style="color:#454545;font-size:13px;line-height:19.5px;font-family:Arial;background-color:#FFFFFF;">在办公区域中，散落在地板上的小型物件，一个打开的抽屉，一条临时牵拉或铺设的电线，这些平常看似不会造成伤害的东西，却都是办公室工作人员时刻面临的安全风险。本课程是专门为办公室人员定制的安全课程，在这里我们将重点介绍办公室内常见的安全风险，以及如何辨识、防范、管控这些安全风险，维护工作人员的身心健康。</span>','http://www.baidu.com','99900','1469933360','0','1'),
('7','7','上锁挂牌培训直播','','','/Public/attached/201607/1469585227.jpg','<p>
<span style="color:#454545;font-family:Helvetica, sans-serif;font-size:13px;line-height:19.5px;background-color:#FFFFFF;"> 员工在被允许执行设置、保养或维修等工作前，为了避免设备的突然运作或能量释放，需要对设备进行上锁挂牌。而不恰当的操作步骤和方法都会给自己带来不可估量的意外伤害。本课程依据国家、行业相关要求并结合实践经验，制作了包括上锁挂牌安全意识教育、基本操作要点、执行步骤、管理流程以及上锁挂牌执行中会遇到的特殊情况处理等内容在内的培训课程。本课程可以使学员得到充足的培训，为现实工作中挂牌上锁的执行奠定坚实基础。</span>
</p>
<p style="text-align:center;">
<span style="color:#454545;font-family:Helvetica, sans-serif;font-size:13px;line-height:19.5px;background-color:#FFFFFF;"><img src="/Public/attached/image/20160730/20160730142517_28753.png" alt="" /><br />
</span>
</p>','http://www.baidu.com','99900','1469933351','0','1');
DROP TABLE IF EXISTS  `qw_auth_group`;
CREATE TABLE `qw_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_auth_group`(`id`,`title`,`status`,`rules`) values
('1','超级管理员','1','1,2,58,65,59,60,61,62,3,56,4,6,5,7,8,9,10,51,52,53,57,11,54,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,36,37,38,39,40,41,42,43,44,45,46,47,63,48,49,50,55'),
('2','管理员','1','13,14,23,22,21,20,19,18,17,16,15,24,36,34,33,32,31,30,29,27,26,25,1'),
('3','普通用户','1','1'),
('6','333','0','1,2');
DROP TABLE IF EXISTS  `qw_coursecate`;
CREATE TABLE `qw_coursecate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '0正常，1单页，2外',
  `pid` int(11) NOT NULL COMMENT '父ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `seotitle` varchar(200) NOT NULL DEFAULT '' COMMENT 'SEO标题',
  `keywords` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `thumbnail` varchar(155) NOT NULL COMMENT '缩略图',
  `price` int(11) NOT NULL COMMENT '价格',
  `content` text NOT NULL,
  `url` varchar(255) NOT NULL,
  `cattemplate` varchar(100) NOT NULL,
  `contemplate` varchar(100) NOT NULL,
  `o` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`),
  KEY `id_3` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_coursecate`(`id`,`type`,`pid`,`name`,`seotitle`,`keywords`,`description`,`thumbnail`,`price`,`content`,`url`,`cattemplate`,`contemplate`,`o`) values
('7','0','0','线上课程','','','','','0','','','','','0'),
('8','0','7','上锁挂牌','','','这是上锁挂牌培训这是上锁挂牌培训这是上锁挂牌培训这是上锁挂牌培训这是上锁挂牌培训这是上锁挂牌培训','/Public/attached/201607/1469626966.png','10','','','','','0'),
('9','0','7','安全月-员工作业安全意识养成培训','','','       在作业过程中，员工往往因为缺乏安全意识和基本知识，而造成各种安全事故。甚至因此威胁自身和其他人员的人身安全。本次课程，我们将通过学习安全意识培养以及其他各类常见作业安全基本知识、风险辨识和控制的相关内容提高作业人员对危险的认识和自身的安全意识。','/Public/attached/201607/1469928617.png','0','','','','','0'),
('10','0','7','实验室安全课程 ','','','    实验室是各类化学品的使用、试验的集中地，其中几乎覆盖到化学品安全、电气安全、消防安全、个人防护、设备安全以及职业卫生等多类安全管理，是安全管理的重点部门。本课程分类讲述了个人防护装备的使用、安全设备、安全行为、安全操作、常见风险辨识等内容，是实验室常见安全风险及注意事项管理的指南。通过学习本课程，学员将会对实验室的安全管理有个整体和直接的掌握。
','/Public/attached/201607/1469929384.png','0','','','','','0'),
('11','0','7','现场急救知识 ','','','工业企业运转过程中，避免不了会发生意外伤亡事故，当意外发生时，必须有人懂得怎么进行现场救护和处理，这是避免事态扩大，也是企业安全管理的基本要求。所以，工厂必须配备一定数量的经过专业培训的急救人员。','/Public/attached/201607/1469929412.png','0','','','','','0'),
('12','0','7','起重作业培训 ','','','起重作业不但是现代生产、检修与项目施工中最常见的作业种类之一，而且是事故发生率和严重性都较高的高危作业之一。所以起重作业的安全管理是我们必须重视和加强的。本课程囊括了起重作业基本的安全操作知识要点、安全作业流程，同时也教授了国家、行业对起重作业安全管理的特殊要求，并结合新颖的互动课件模式，为培训者提供了良好的培训界面，提高了培训效率、效果，使员工更容易掌握。','/Public/attached/201607/1469929428.png','0','','','','','0');
DROP TABLE IF EXISTS  `qw_log`;
CREATE TABLE `qw_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `t` int(10) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `log` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_log`(`id`,`name`,`t`,`ip`,`log`) values
('11','admin','1464923752','27.115.50.170','登录失败。'),
('12','admin','1464923777','27.115.50.170','登录成功。'),
('13','admin','1464924698','27.115.50.170','登录成功。'),
('14','admin','1464924853','27.115.50.170','新增文章，AID：4'),
('15','admin','1464925391','27.115.50.170','编辑文章，AID：4'),
('16','admin','1464925423','27.115.50.170','编辑文章，AID：4'),
('17','admin','1464925457','27.115.50.170','编辑文章，AID：4'),
('18','admin','1464925576','27.115.50.170','删除文章，AID：3'),
('19','admin','1464925582','27.115.50.170','删除文章，AID：2'),
('20','admin','1464925586','27.115.50.170','删除文章，AID：1'),
('21','admin','1464925898','27.115.50.170','新增文章，AID：5'),
('22','admin','1464926007','27.115.50.170','编辑文章，AID：4'),
('23','admin','1464930423','27.115.50.170','新增文章，AID：6'),
('24','admin','1464930818','27.115.50.170','新增文章，AID：7'),
('25','admin','1464931017','27.115.50.170','新增文章，AID：8'),
('26','admin','1464931120','27.115.50.170','编辑文章，AID：8'),
('27','admin','1464931156','27.115.50.170','编辑文章，AID：4'),
('28','admin','1464931248','27.115.50.170','编辑文章，AID：5'),
('29','admin','1464931336','27.115.50.170','编辑文章，AID：6'),
('30','admin','1464931377','27.115.50.170','编辑文章，AID：7'),
('31','admin','1464931390','27.115.50.170','编辑文章，AID：7'),
('32','admin','1464934519','27.115.50.170','编辑文章，AID：8'),
('33','admin','1464938531','27.115.50.170','编辑文章，AID：8'),
('34','admin','1464938565','27.115.50.170','编辑文章，AID：8'),
('35','admin','1464938608','27.115.50.170','编辑文章，AID：8'),
('36','admin','1464938644','27.115.50.170','编辑文章，AID：7'),
('37','admin','1464938691','27.115.50.170','编辑文章，AID：6'),
('38','admin','1464938719','27.115.50.170','编辑文章，AID：5'),
('39','admin','1464938792','27.115.50.170','编辑文章，AID：5'),
('40','admin','1464938844','27.115.50.170','编辑文章，AID：5'),
('41','admin','1464938888','27.115.50.170','编辑文章，AID：5'),
('42','admin','1464938931','27.115.50.170','编辑文章，AID：4'),
('43','admin','1464939197','27.115.50.170','编辑文章，AID：4'),
('44','admin','1464939297','27.115.50.170','编辑文章，AID：7'),
('45','admin','1464939343','27.115.50.170','编辑文章，AID：6'),
('46','admin','1464940821','27.115.50.170','编辑文章，AID：4'),
('47','admin','1464940848','27.115.50.170','编辑文章，AID：4'),
('48','admin','1464940900','27.115.50.170','编辑文章，AID：5'),
('49','admin','1464940955','27.115.50.170','编辑文章，AID：6'),
('50','admin','1464941035','27.115.50.170','编辑文章，AID：7'),
('51','admin','1464941064','27.115.50.170','编辑文章，AID：7'),
('52','admin','1464941137','27.115.50.170','编辑文章，AID：8'),
('53','admin','1464941591','27.115.50.170','编辑文章，AID：4'),
('54','admin','1464941619','27.115.50.170','编辑文章，AID：4'),
('55','admin','1464941664','27.115.50.170','编辑文章，AID：4'),
('56','admin','1464941718','27.115.50.170','编辑文章，AID：4'),
('57','admin','1464941909','27.115.50.170','编辑文章，AID：4'),
('58','admin','1464942033','27.115.50.170','编辑文章，AID：4'),
('59','admin','1464942062','27.115.50.170','编辑文章，AID：5'),
('60','admin','1464942121','27.115.50.170','编辑文章，AID：6'),
('61','admin','1464942154','27.115.50.170','编辑文章，AID：7'),
('62','admin','1464942183','27.115.50.170','编辑文章，AID：8'),
('63','admin','1464942222','27.115.50.170','编辑文章，AID：8'),
('64','admin','1464942247','27.115.50.170','编辑文章，AID：7'),
('65','admin','1465175814','27.115.50.170','编辑文章，AID：6'),
('66','admin','1465176049','27.115.50.170','编辑文章，AID：6'),
('67','admin','1465181187','27.115.50.170','编辑文章，AID：6'),
('68','admin','1465181644','27.115.50.170','登录失败。'),
('69','admin','1465181658','27.115.50.170','登录失败。'),
('70','admin','1465181708','27.115.50.170','登录成功。'),
('71','admin','1465181847','27.115.50.170','编辑文章，AID：6'),
('72','admin','1465280391','27.115.50.170','修改个人资料'),
('73','admin','1465280410','27.115.50.170','登录成功。'),
('74','admin','1465282251','27.115.50.170','新增文章，AID：9'),
('75','admin','1465282447','27.115.50.170','编辑文章，AID：9'),
('76','admin','1465282690','27.115.50.170','编辑文章，AID：9'),
('77','admin','1465282731','27.115.50.170','编辑文章，AID：9'),
('78','admin','1465282781','27.115.50.170','编辑文章，AID：9'),
('79','admin','1465282806','27.115.50.170','编辑文章，AID：9'),
('80','admin','1465286431','27.115.50.170','登录成功。'),
('81','admin','1465286503','27.115.50.170','编辑文章，AID：9'),
('82','admin','1465287325','27.115.50.170','编辑文章，AID：9'),
('83','admin','1465287350','27.115.50.170','编辑文章，AID：9'),
('84','admin','1465287405','27.115.50.170','编辑文章，AID：9'),
('85','admin','1465287582','27.115.50.170','编辑文章，AID：9'),
('86','admin','1465287704','27.115.50.170','编辑文章，AID：9'),
('87','admin','1465287788','27.115.50.170','编辑文章，AID：9'),
('88','admin','1465287932','27.115.50.170','编辑文章，AID：9'),
('89','admin','1465287950','27.115.50.170','编辑文章，AID：9'),
('90','admin','1465287966','27.115.50.170','编辑文章，AID：9'),
('91','admin','1465288049','27.115.50.170','编辑文章，AID：4'),
('92','admin','1465288112','27.115.50.170','编辑文章，AID：4'),
('93','admin','1465288146','27.115.50.170','编辑文章，AID：5'),
('94','admin','1465288212','27.115.50.170','编辑文章，AID：6'),
('95','admin','1465288257','27.115.50.170','编辑文章，AID：6'),
('96','admin','1465288287','27.115.50.170','编辑文章，AID：7'),
('97','admin','1465288334','27.115.50.170','编辑文章，AID：8'),
('98','admin','1465288366','27.115.50.170','编辑文章，AID：7'),
('99','admin','1465289142','27.115.50.170','编辑文章，AID：9'),
('100','admin','1465289172','27.115.50.170','编辑文章，AID：9'),
('101','admin','1465289253','27.115.50.170','编辑文章，AID：9'),
('102','admin','1465289329','27.115.50.170','编辑文章，AID：9'),
('103','admin','1465289718','27.115.50.170','编辑文章，AID：6'),
('104','admin','1465289852','27.115.50.170','编辑文章，AID：6'),
('105','admin','1465356981','27.115.50.170','编辑文章，AID：9'),
('106','admin','1465357125','27.115.50.170','编辑文章，AID：9'),
('107','admin','1465781011','27.115.50.170','编辑文章，AID：9'),
('108','admin','1465781172','27.115.50.170','编辑文章，AID：9'),
('109','admin','1465781594','27.115.50.170','编辑文章，AID：9'),
('110','admin','1465781680','27.115.50.170','编辑文章，AID：9'),
('111','admin','1466577779','58.38.250.132','新增文章，AID：10'),
('112','admin','1467263308','180.157.221.68','新增文章，AID：11'),
('113','admin','1467264122','180.157.221.68','编辑文章，AID：11'),
('114','admin','1467264526','180.157.221.68','编辑文章，AID：11'),
('115','admin','1467264675','180.157.221.68','编辑文章，AID：11'),
('116','admin','1467264926','180.157.221.68','编辑文章，AID：11'),
('117','admin','1467265326','180.157.221.68','编辑文章，AID：11'),
('118','admin','1467265426','180.157.221.68','编辑文章，AID：11'),
('119','admin','1467280598','180.157.221.68','编辑文章，AID：11'),
('120','admin','1467280800','180.157.221.68','编辑文章，AID：11'),
('121','admin','1468545516','222.67.81.164','登录成功。'),
('122','admin','1468545584','222.67.81.164','新增菜单，名称：订单管理'),
('123','admin','1468545609','222.67.81.164','新增菜单，名称：订单列表'),
('124','admin','1469758920','180.175.163.239','登录失败。'),
('125','admin','1469759007','180.170.62.182','登录失败。'),
('126','admin','1469759054','180.170.62.182','登录成功。'),
('127','admin','1469933224','114.111.166.53','登录成功。'),
('128','admin','1469933254','114.111.166.53','编辑菜单，ID：68'),
('129','admin','1469933280','114.111.166.53','编辑菜单，ID：69'),
('130','admin','1469933293','114.111.166.53','编辑菜单，ID：70'),
('131','admin','1469933307','114.111.166.53','编辑菜单，ID：74'),
('132','admin','1469933322','114.111.166.53','编辑菜单，ID：75'),
('133','admin','1469933351','114.111.166.53','编辑文章，AID：7'),
('134','admin','1469933360','114.111.166.53','编辑文章，AID：6'),
('135','admin','1469935065','61.173.57.47','登录失败。'),
('136','admin','1469935106','61.173.57.47','登录失败。'),
('137','admin','1469935134','61.173.57.47','登录成功。');
DROP TABLE IF EXISTS  `qw_devlog`;
CREATE TABLE `qw_devlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v` varchar(225) NOT NULL COMMENT '版本号',
  `y` int(4) NOT NULL COMMENT '年分',
  `t` int(10) NOT NULL COMMENT '发布日期',
  `log` text NOT NULL COMMENT '更新日志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_devlog`(`id`,`v`,`y`,`t`,`log`) values
('1','1.0.0','2016','1440259200','QWADMIN第一个版本发布。');
DROP TABLE IF EXISTS  `qw_setting`;
CREATE TABLE `qw_setting` (
  `k` varchar(100) NOT NULL COMMENT '变量',
  `v` varchar(255) NOT NULL COMMENT '值',
  `type` tinyint(1) NOT NULL COMMENT '0系统，1自定义',
  `name` varchar(255) NOT NULL COMMENT '说明',
  PRIMARY KEY (`k`),
  KEY `k` (`k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_setting`(`k`,`v`,`type`,`name`) values
('description','网站描述','0',''),
('footer','2016©恰维网络','0',''),
('keywords','关键词','0',''),
('sitename','恰维网络','0',''),
('test','测试','1','测试变量'),
('title','QWADMIN','0','');
DROP TABLE IF EXISTS  `qw_article`;
CREATE TABLE `qw_article` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL COMMENT '分类id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `keywords` varchar(255) NOT NULL COMMENT '关键词',
  `description` varchar(255) NOT NULL COMMENT '摘要',
  `thumbnail` varchar(255) NOT NULL COMMENT '缩略图',
  `content` text NOT NULL COMMENT '内容',
  `t` int(10) unsigned NOT NULL COMMENT '时间',
  `n` int(10) unsigned NOT NULL COMMENT '点击',
  PRIMARY KEY (`aid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_article`(`aid`,`sid`,`title`,`keywords`,`description`,`thumbnail`,`content`,`t`,`n`) values
('4','36','为生命坚守最后一道防线','应急救援,EHS培训,安全培训,孙健,中石化爆炸','2013年11月22日，中石化管道储运分公司东黄输油管道泄漏原油进入市政排水暗渠，在形成密闭空间的暗渠内油气积聚遇火花发生爆炸，事故造成62人死亡、136人受伤，直接经济损失7.5亿元。一起普通事故，却因“事故应急救援不力，现场处置措施不当”导致事故扩大并恶化。','/Public/attached/201606/1464925409.png','<p class="MsoNormal" align="center" style="text-align:center;text-indent:24.1pt;">
	<strong><span style="font-size:12px;"><br />
</span></strong> 
</p>
<p class="MsoNormal" align="center" style="text-align:center;text-indent:24.1pt;">
	<strong><span style="font-size:24px;">为生命坚守最后一道防线</span></strong> 
</p>
<p class="MsoNormal" align="center" style="text-align:right;text-indent:24.1pt;">
	<span style="font-size:16px;"><strong>来源：中国安全生产杂志</strong></span> 
</p>
<p class="MsoNormal" style="text-indent:24.1000pt;">
	<b> </b><b></b> 
</p>
<p class="MsoNormal" style="text-indent:24.1000pt;">
	<b><span style="font-size:16px;">声明：下文中提到的翎岳智能科技有限公司系上海菁坤智能科技有限公司的母公司。以下是《中国安全生产杂志》报道的关于生产企业应急救援体系建设的全文。</span></b><b></b> 
</p>
<p class="MsoNormal" align="center" style="text-indent:24.1000pt;text-align:center;">
	<b> </b> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">2013年11月22日，中石化管道储运分公司东黄输油管道泄漏原油进入市政排水暗渠，在形成密闭空间的暗渠内油气积聚遇火花发生爆炸，事故造成62人死亡、136人受伤，直接经济损失7.5亿元。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">一起普通事故，却因“事故应急救援不力，现场处置措施不当”导致事故扩大并恶化，事故一出，国人瞩目。事故暴露出的“对应急救援处置工作重视不够”“对管道泄漏突发事件的应急预案缺乏演练，应急救援人员对自己的职责和应对措施不熟悉”等涉及应急救援、现场处置的诸多问题如同火上浇油，导致了悲剧的不断扩大。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">无独有偶，类似的教训从未停止过。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">2007年9月1日，江苏省扬州市宝应县广洋湖镇健宝有限公司组织工人清理藕制品的腌制池时，1人硫化氢中毒后，8人盲目参与施救，最终造成6人死亡、3人重伤。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">2009年11月7日，南京市六合区龙溪化工有限公司在停产检修增白剂车间3号硫化釜过程中，1名职工发生硫化氢中毒，另外2名盲目施救，最终3人全部死亡。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">2009年7月3日，北京市通州区新华联北区悦豪物业公司因排污不畅，安排工程部维修人员维修污水井中的污水提升泵，先后有3人下井作业，在出现中毒情况后，又有7人下井救援，最终10人全部中毒。事故导致6名物业人员死亡，1名消防队员在救出多人之后其所佩戴的空气呼吸器面罩被受困者拽掉而死亡。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">……</span> 
</p>
<p class="MsoNormal" align="center" style="text-indent:21.1000pt;text-align:center;">
	<b><span style="font-size:16px;">多次警示仍未有效遏制</span></b><b></b> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">近年来，随着改革开放的逐渐深入，大量的工业项目不断投资建设，国民经济实现了快速发展。值得注意的是，经济腾飞的同时也伴随着各类生产安全事故的发生，化学品泄露造成的大面积人员疏散、化学品储存码头的连环爆炸、市政井下作业的硫化氢中毒、大修期间的中毒缺氧窒息以及化学品运输过程中的惨烈爆炸火灾等等事故一直没有得到有效遏制，值得警惕的是，此类事故发生后，一旦应急救援不力，现场处置不当，极易导致事故的进一步扩大、时态的不断恶化。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">早在2007年，国家安全监管总局专门就应急救援施救不当造成的伤亡扩大事故发出通报，通报指出，2006年仅1至8月份，据不完全统计，全国共发生因施救不当造成伤亡扩大的重大事故25起，死亡95人。这些事故发生时遇险人员仅为41人，但由于现场处置不当，导致了事故扩大，共造成59名施救人员死亡，教训极其深刻。2012年5月份以来，因现场处置不当导致事故扩大的较大事故开始呈多发态势，发生的11起事故事发时只有14人涉险，最终却导致40人死亡、8人受伤。2012年6月，国务院安委办专门就有效防范和坚决遏制因盲目施救导致事故扩大再次发出警示，提出明确要求。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">类似事故的频发，不得不引起我们的深思。生产安全事故发生后如何能在最短的时间内形成战斗力，迅速控制事故事态的进一步扩大，防止事故的进一步蔓延，最大限度地挽救人民生命财产安全，成为国家安全监管部门关注的重点之一。</span> 
</p>
<p class="MsoNormal" align="center" style="text-indent:21.1000pt;text-align:center;">
	<b><span style="font-size:16px;">“纸上谈兵”难起实战效能</span></b><b></b> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">遗憾的是，国家虽然已经出台了涉及应急救援的相关法令法规，国家安全监管总局也发布过很多有关应急救援体系建设的文件通知，但是不可讳言地说，目前国内的应急救援体系建设的成效不但落后于发达国家，而且也滞后于经济发展的步伐，也没有形成切实有效的执行力和影响力。很多企业所谓的应急救援预案仅仅停留在文件、会场和口头上，一旦发生事故，很难起到实战效用。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">针对国内企业的应急救援现状，记者采访了华南理工大学的陈国华教授。作为国内应急救援专家，陈国华多年来一直致力于大中型化工园区应急救援体系建设方面的研究，经过多年的调查研究，他总结了国内的应急救援体系建设的共性。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">缺乏有效的应急救援培训体系。</span></b><span style="font-size:16px;">陈国华告诉记者，迄今为止，国内现有的安全生产培训体系和安全教育课程内容大多侧重于安全工艺及基础的安全管理，没有积累起系统化的、标准化的应急救援培训体系，更不用提实战性、高仿真的应急救援、现场处置的培训了。他同时指出，国家现有的一些仿真的应急救援培训也多侧重于地震救援和火灾救援，而企业生产过程中的化学品泄露、有限空间等行业领域的应急救援以及高空救援等专业科目则落后很多。综合来看，主要表现在以下几个方面：缺乏体系化的理论和系统实用的教材，而现有的教材多侧重工艺与工程、缺乏应急救援标准化培训环节；缺乏实用、生动的培训手段和场地，培训方式单一、培训形式比较陈旧，缺乏多媒体素材支持等；缺乏先进的实物培训装备和实际操练的培训设施；缺乏理论与实践相结合的师资力量，目前现有的一线师资力量几乎没有机会接触到国际上先进的应急救援体系。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">企业一线应急救援队伍建设不容乐观。</span></b><span style="font-size:16px;">陈国华介绍说，我国目前大多数生产企业都没有专业的应急救援队伍，有些企业虽然名义上也指定一些所谓的应急响应救援人员，但基本上都没有接受过专业的实战训练，同时也缺乏专业的救援设备和装备，事发时无法迅速进行现场处置，因此，大部分事故的应急救援只能依赖于公安消防部门。然而，公安消防部门更擅长的是火灾救援，对于化学品、有限空间等救援无论从救援理论、救援技术、救援装备还是救援经验上都远远不足。同时，由于路途、空间等各种原因，经常是等消防部门赶到事故现场时，事态已经在不断扩大中难以遏制了，之初的中小事故已然升级演变成为更高等级的事故了。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">陈国华强调说，国内很多企业,尤其是中小企业的应急救援队伍建设“纸上谈兵”的比较多，一旦发生事故，很难起到“来之能战、战之能胜”实战效用。</span> 
</p>
<p class="MsoNormal" align="center" style="text-indent:21.1000pt;text-align:center;">
	<b><span style="font-size:16px;">塞拉尼斯：应急人员个个都有“真本事”</span></b><b></b> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">南京化学工业园作为国家级化学工业园区，规划总面积45平方公里，重点发展石油化工、基本有机化工原料、精细化工、高分子材料、新型化工材料、生命医药项目，属于安全生产监管的重点区域。随着园区投资的加大，企业经济蓬勃发展的同时，也曾伴随着生产事故不同程度地出现。园区管委会高度重视引导企业进行应急救援体系方面的建设，园区每年都要与一些优秀企业联合举办高仿真的应急救援演练，并组织相关企业观摩交流，共同促进园区在应急救援方体系建设地面的发展水平。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">塞拉尼斯(Celanese)是世界上最大的乙酰基产品制造商，其位于南京化工园区的塞拉尼斯（南京）化工有限公司（以下简称塞拉尼斯公司）是园区的安全标杆性企业，一直以来就非常重视在企业一线应急响应方面的发展和投入。公司安全环保部负责人介绍说，公司在应急救援和现场处置方面的最成功的经验主要表现在应急响应与作业安全一体化，坚持把风险预控作为企业安全生产工作的关键。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">——</span></b><b><span style="font-size:16px;">坚持未雨绸缪。</span></b><span style="font-size:16px;">该负责人介绍说，应急救援的关键是要先找出安全事故的易发部位和易发环节，只有找出薄弱环节和部位，才能在第一时间对目标进行响应，应急才能做到有的放矢，对症下药。基于这种考虑，塞拉尼斯公司对厂区内的重大危险源进行了专项细致地评估，针对评估出的重大危险源可能出现的问题都制定了专项应急预案，并在培训演练中不断细化、实战化。同时，公司的应急响应小组成员也从一线职工尤其是涉及重大危险源区域的岗位上进行专门选拔。为使应急响应小组的成员个个都有“真本事”，塞拉尼斯公司对选拔出来的应急响应小组成员先后进行了多频次、接近实战效果的专项应急演练，通过演练考核最终实现优胜劣汰。该负责人告诉记者，应急响应小组成员都是兼职的，平时都分布在生产一线的重要岗位作为职工参与生产，在作业中注重抓现场的生产安全，同时监督督促他人安全生产；一旦发生突发事件，便迅速转变为公司的应急响应专业人员参与现场处置，就像电影所讲的那样“待战事、发奇效”。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">——</span></b><b><span style="font-size:16px;">强化实战演练。</span></b><span style="font-size:16px;">安全生产月期间，记者在位于天津塘沽的国家级应急救援实战培训演练基地——中海油培训基地实地参观了应急救援专项实战培训，正好也看到了来自塞拉尼斯公司应急响应小组成员参加的有限空间应急救援实训。当天的实训项目是模拟从高约四五米，只能顶端出入的大罐中拯救一名“中毒”的工人。记者在模拟现场看到，在接到救援命令后，施救人员带着相关装备迅速赶到事发现场，在事发现场简单勘察后马上进行施救分工，根据分工，一名施救人员马上开始穿戴呼吸防护装备，三名施救人员携带吊救设备迅速爬到罐顶进行安装固定，其他施救人员在罐旁进行接应准备。一切准备妥当后，入罐施救人员通过吊救设备匀速从罐顶降入罐底，在对被救助者进行简单救助后，随即给被救助者穿戴快速供气呼吸器并连接吊救装备，发出救援信号，罐顶的施救人员开始起吊，一分钟后，被救助者在施救人员的保护下升至罐顶，罐顶的两名施救人员对被救助者迅速进行接力施救，非常专业地将被救助者从罐中转移到罐外的吊救设备上，并加装了与地面连接的保护绳，随后，开始往下放，在地面施救人员的配合下，被救助者安全地从罐顶缓</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">降至地面，早就在罐旁等候的担架马上派上了用场，医护人员在进行简单的现场处置后，被救助者迅速被抬上救护车，至此，一次比较成功的有限空间救援在有条不紊、从容不迫中圆满地划上了句号。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">塞拉尼斯公司一名参加实训的职工告诉记者，公司每年都要组织类似的大大小小的实战培训，经过多次演练后，基本掌握了现场应急救援处置的要领、技能防护措施和需要注意的问题，即使真的遇到突发事件，肯定也会按部就班，不至于手忙脚乱、手无举措。据现场的教官讲，本次实训课程接近实战，同时也非常专业比较复杂，对于学员来说，无论是基础理论知识还是实战应急救援能力都具有比较大的挑战性，通常企业的应急队员至少需要24至28小时才能通过最终评估考核。但是塞拉尼斯公司参训的学员们在培训过程中所表现出事故应对能力让现场的教官都非常惊叹，所有学员只用了不到2天就全部通过了最终的考核测试，表现出了极高的现场处置素养和应急救援能力</span> 
</p>
<p class="MsoNormal" align="center" style="text-indent:21.1000pt;text-align:center;">
	<b><span style="font-size:16px;">慧生公司：“练为战”</span></b><b></b> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">同样位于南京化学工业园区的慧生（南京）清洁能源股份有限公司，也引起了记者的注意。惠生（南京）清洁能源股份有限公司（以下简称惠生公司）是惠生集团旗下子公司，以煤为原料，采用洁净煤生产技术，为企业客户长期供应高质量的一氧化碳、甲醇、氢气、合成气、硫磺及丁辛醇等化工原料。相对来讲风险源较多，风险系数也较高。惠生公司QHSE部门负责人王德维介绍说，慧生公司非常重视一线应急管理体系的建设，经过多方筛选和评审，与国内专业的生产事故应急救援实战培训机构——上海翎岳智能科技有限公司（以下简称上海翎岳公司）合作，经过近三年的不懈努力和累积，目前公司已经拥有四支接受过严格应急救援实战培训和考核测试的全天候应急响应小组，小组成员虽然全部是兼职的，但在企业一线应急管理方面都积累了丰富的经验教训。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">——</span></b><b><span style="font-size:16px;">全程全方位全员监控。</span></b><span style="font-size:16px;">王德维介绍说，慧生公司在企业一线应急管理方面做了大量的努力和尝试，其中关键一点是事故应急预控管理优先法则。慧生公司开发建立了一套入厂作业管理系统，为所有外来进厂的作业人员全部配备了可以准确定位的IC卡，卡内储存了有关危险作业人员的信息和作业类型审批情况，实施全程全方位监控。一方面，公司的安全管理人员随时可以通过手持POS机监督审核所有外来作业人员的作业资格与作业许可审批情况，对于不规范的作业和未经审批的作业可以随时中止。另一方面，中控室可以随时监控作业区域的情况，随时定位现场作业的人员位置，一旦有事故发生，可以在第一时间知道事故发生的地点、作业人数和作业类型，可以立即启动相应的应急预案。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">——</span></b><b><span style="font-size:16px;">注重强化一线应急体系建设。</span></b><span style="font-size:16px;">王德维告诉记者，除此之外，他们还在一线应急体系建设方面进行了很多探索，并初步总结出应急体系建设的四个步骤。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">首先，反复推敲修订应急预案。慧生公司的应急管理人员与上海翎岳公司合作，逐项评估重大危险源的应急预案，做到事无巨细，细到每一个阀门、每一个锚点、每一个应急设施的具体使用。翎岳公司的应急实战培训专家多次实地深入作业现场，与他们反复推敲推演并逐步模拟演练。王德维介绍说，通常一个典型的危险作业场景的模拟演练需要1至3天的时间，目的就是争取做到每一项应急预案都提前经过演练并可以通过实战考验。比如发生一般的甲醇泄漏，一线的职工都会迅速采取胶皮垫抱箍压紧包扎以及关闭阀门、泵等措施进行现场处置，类似的演练已经做过了多次了，就是确保事故发生时头脑清醒、有条不紊。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">其次，精心挑选应急队员。一线职工是及时处理事故、紧急避险、自救互救的重要环节，同时也是事故及早发现、及时上报的关键，一般的危险化学品事故在这一层次上能够及时处理。为此，慧生公司的应急管理人员采纳了上海翎岳公司独有的一套4INS ERT测评工具，从一线职工中进行一线应急队员的选拔，从体能、身高、臂力、智力、平衡、心理、反应全方位进行测评，科学合理地选拔了每组7人的一线应急响应小组。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">第三，配备实用的应急装备。王德维告诉记者，之前公司配备的应急装备基本上都是消防器材，消防器材对于常规的工业企业效果可能比较明显，而对于化工企业效果就不是很理想，甚至会“火上浇油”。王德维介绍说，比如甲醇着火时，应使用专用泡沫消防枪（栓）进行灭火，并同时打开喷淋冷却系统，这时绝对不能使用水枪。根据应急预案，惠生公司按照上海翎岳应急专家的建议重新筛选配备了相应的应急装备，不求“最贵”但求“最对”，剔除了一些好看不实用的装备，重新配备了一些经常使用并且实用的装备，譬如应急救援单元、移动供气车、经济实用的硅藻土、气动带压堵漏工具等。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">第四，“练为战”。王德维告诉记者，为了能使应急队员在事故发生后迅速形成战斗力，具有实战本领，慧生公司坚持“练为战”，专门聘请翎岳应急专家根据实际工作场所为应急小组安排了为期4天的应急救援实战培训，从基础应急预控理论、应急装备、防护技术、垂直救援、侧向救援以及复杂救援都做了专项培训。在实际测评中，之前所有的小组成员都可以在5分30秒之内成功地将被救者从复杂的气化炉中救出，如今这个时间已经压缩到了4分钟左右，应急实战效果非常明显。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">王德维认为，应急救援只是所有应急管理中最后的一个环节。救援不是目的，风险控制才是关键。加强应急救援体系建设，强化应急救援队伍演练培训，可以使应急救援队员们对危险源的防控措施更加熟悉，现场处置手段更加熟练，使企业对事故的应对更加有条不紊；相反，企业及职工对危险源的危害性和预防措施的了解更有助于对事故的防控，也有助于作业安全，两者相辅相成。</span> 
</p>
<p class="MsoNormal" align="center" style="text-indent:21.1000pt;text-align:center;">
	<b><span style="font-size:16px;">应急救援组织</span></b><b><span style="font-size:16px;">建设的六步</span></b><b></b> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">记者在天津塘沽的中海油培训基地观摩过应急救援现场培训，上海翎岳公司的实战培训团队现场为学员们手把手教授各种应急救援技能和技巧。记者为此也采访了进行培训的上海翎岳公司负责人孙健，希望对企事业单位应急救援体系建设有所帮助。</span> 
</p>
<p class="MsoNormal" style="text-align:center;text-indent:21pt;">
	<img src="/Public/attached/image/20160603/20160603034407_21950.png" alt="" /> 
</p>
<p class="MsoNormal" align="center" style="text-indent:21.1000pt;text-align:center;">
	<b><span style="font-size:16px;">孙健在中海油培训基地现场讲解</span></b> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">孙健告诉记者，他曾在几年前接受过美国OSHA、EPA、MSHA等机构的安全培训和应急管理培训，作为从事安全防护和安全培训十多年的专业人士，深感国内安全生产事故应急救援方面存在巨大的差距，他回国后一直致力于国内安全生产应急救援实战培训体系方面的探索。他告诉记者，回国后他先后为多个国家级应急救援实战培训演练基地提供过咨询规划设计外，还带领团队为20多家国内知名企业的应急响应小组提供过专项培训，充分体验了国内企业对应急救援实战培训的从怀疑到期待过程，也通过培训与很多企业的应急管理者建立起了信任和友谊。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">——</span></b><b><span style="font-size:16px;">应急得当可有效控制事故蔓延</span></b><span style="font-size:16px;">。孙健介绍说，欧美等发达国家经过多年的探索和发展，早已形成了由政府、消防部门、企业、民间机构共同构建的一体化应急救援体系。体系规定，具有一定规模的企业必须配备专业的应急救援队伍（可以兼职），必须配备专门的应急救援装备并接受多科目的应急救援实战培训。一旦发生一般性事故（如小型火灾、一般泄露、非复杂情况下的人员中毒等），受过专业实战训练的企业应急救援小组会立即按照之前演练过多遍的应急救援预案先进行现场处置，防止事态的进一步扩大。他告诉记者，根据国内外的一些数据和成功经验显示，绝大部分的事故都能在消防队伍到达前有效控制住或者消除掉。所以，加强企业应急救援体系建设，强化企业应急救援理论培训和实战仿真模拟救援培训对于降低安全事故发生率就显得尤为其重要。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">——一线应急救援组织</span></b><b><span style="font-size:16px;">建设</span></b><b><span style="font-size:16px;">流程</span></b><b><span style="font-size:16px;">。</span></b><span style="font-size:16px;">孙健介绍说，他服务的上海翎岳公司在引进国外先进救援理论、救援技术的基础上，加上多年实战应急培训经验的积累，结合国内的企业安全发展现状，率先提出了企业一线应急救援组织建设的标准和发展流程，这也是国内第一套科学化、实战化的企业应急救援组织建设体系。</span> 
</p>
<p class="MsoNormal" style="margin-left:-0.1000pt;text-indent:21.1000pt;">
	<b><span style="font-size:16px;">第一步</span></b><b><span style="font-size:16px;">，</span></b><b><span style="font-size:16px;">重大危险源辨识</span></b><b><span style="font-size:16px;">。</span></b><span style="font-size:16px;">孙健介绍说，目前国内很多企业把风险评估只是作为应付检查或企业开工生产的程序而已，甚至把对企业重大危险源的辨识完全依赖于社会的安全评价机构，对企业危险源的真正起源及隐患程度不管不问，甚至一无所知，这是完全错误的做法。另外，不容忽视的是，相对于欧美发达国家在安全工艺与安全防护的高度一体化，而我国的安全防护技术和防护装备研究则相对落后，安全评价更多关注的是工艺流程，对于很多仅靠生产工艺工程不能完全避免的重大隐患缺乏必要的关注，这样的安全评估结果势必导致企业的应急预案无的放矢，很难经得起实战考验。针对国内这种情况，公司提取了国外安全评估体系中具体的安全防护评估模块加以细化，推出Real&nbsp;Safety安全防护评价方法，聚焦于现有生产工艺和工程技术不能根除的重大危险源，协助企业找出这些重大危险源的根本所在，并给出具体的防护措施和防护整改方案。</span> 
</p>
<p class="MsoNormal" style="margin-left:-0.1000pt;text-indent:21.1000pt;">
	<b><span style="font-size:16px;">第二步</span></b><b><span style="font-size:16px;">，</span></b><b><span style="font-size:16px;">应急救援组织建设</span></b><b><span style="font-size:16px;">。</span></b><span style="font-size:16px;">孙健介绍说，在他们接触的60多家大中型企业中，竟然有高达30%左右的企业并没有认识到一线应急救援组织的重要性，约有70%的企业已经开始认识到建立企业一线应急救援组织的重要性和必要性，但却心有余而力不足，无从下手。</span> 
</p>
<p class="MsoNormal" style="margin-left:-0.1000pt;text-indent:21.0000pt;">
	<span style="font-size:16px;">为此，翎岳公司在总结事故教训、考虑企业救援需求的基础上，总结出企业一线应急救援小组的最佳精干搭配组合，即每组6+1的7人一线应急响应小组。他补充说，这7人小组可以形成一个独立精干的救援小组，可以承担有限空间救援、化学品泄露事故初期处置、小型火灾救援等任务。小组设组长（Team Leader）1名（承担现场指挥、内外沟通职能）、主力队员（Major Rescuer）1组2名（承担主要救援任务、通常需要进入受限空间救援）、策应队员（Minor Rescuer）1组2名（承担救援后备力量及策应任务、通常承担化学品泄露现场处置任务）、辅助人员（Supporter）2名（承担外部看护、装备供给及救援协助）。孙健强调，应急救援组织建设重点在于如何科学地从一线工人中选拔合适的应急队员，需要从体能、身高、臂力、智力、平衡、心理、反应等全方位进行测评，合理科学进行选拔。比如进入受限空间救援主力救援队员合理身高应在160～170cm之间，体重在55～65Kg之间，单臂力量要强，要有非常好的协调性和平衡感觉，反应敏锐、性格沉稳等。</span> 
</p>
<p class="MsoNormal" style="margin-left:-0.1000pt;text-indent:21.1000pt;">
	<b><span style="font-size:16px;">第</span></b><b><span style="font-size:16px;">三</span></b><b><span style="font-size:16px;">步</span></b><b><span style="font-size:16px;">，</span></b><b><span style="font-size:16px;">应急救援预案修订</span></b><b><span style="font-size:16px;">。</span></b><span style="font-size:16px;">孙健告诉记者，据初步考察，国内约有70%企业的应急预案基本都停留在理论层面上，几乎没有实质性内容。孙健建议，企业要想修订一套完全可以经得住实战检验的应急预案，需要从事故预控措施（譬如锚点设置）、进入方式（是否经过吊救系统进入）、安全装备（防护装备和救援器材选择配置）、通讯方式（至少5种沟通方式选择）、事故报警（报警程序及报警方式）、救援方式（侧向、垂直、复杂、导引等各种救援形式选择）等全流程进行细致化评估，并在实际现场反复模拟演练，充分印证每一个技术环节的可行性和安全性，使其更加贴合实际需求、更加贴近实战需求，形成企业最终版本的应急救援预案，并公示阐述给相关人员使其完全理解接受。</span> 
</p>
<p class="MsoNormal" style="margin-left:-0.1000pt;text-indent:21.1000pt;">
	<b><span style="font-size:16px;">第</span></b><b><span style="font-size:16px;">四</span></b><b><span style="font-size:16px;">步</span></b><b><span style="font-size:16px;">，</span></b><b><span style="font-size:16px;">应急救援装备配置</span></b><b><span style="font-size:16px;">。</span></b><span style="font-size:16px;">孙健介绍说，应急救援装备的配置应该以适用和实用作为配备的唯一标准，应该根据对应的工作场所和应急预案选择合适的应急装备，包括锚点选择和架设、吊救系统选择（三脚架、单臂救援系统、侧向救援系统、或营救单元）、安全带和连接绳类型、速降自锁装置、安全爬升器材、呼吸防护装备、气体检测仪表、软担架及吊蓝、通讯器材、紧急供气装备等。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">第</span></b><b><span style="font-size:16px;">五</span></b><b><span style="font-size:16px;">步</span></b><b><span style="font-size:16px;">，</span></b><b><span style="font-size:16px;">应急救援</span></b><b><span style="font-size:16px;">技术培训。</span></b><span style="font-size:16px;">经过选拔的应急队员，也配备了合适的应急装备，接下来就要进行一系列专业的应急救援培训，通常需要参加为期5～7天的基础培训。利用受限空间模拟罐、多功能模拟训练塔、化学品泄露模拟训练罐等模拟设施按照理论（占20%）、模拟（占30%）、实战（占50%）比例逐步递进。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.1000pt;">
	<b><span style="font-size:16px;">第</span></b><b><span style="font-size:16px;">六</span></b><b><span style="font-size:16px;">步</span></b><b><span style="font-size:16px;">，</span></b><b><span style="font-size:16px;">应急救援</span></b><b><span style="font-size:16px;">组织验收测评。</span></b><span style="font-size:16px;">如何验证经过严格培训之后的应急救援组织在关键时候能否发挥其快速响应的效能呢？孙健介绍说，他们在消化吸收国外先进的生产事故应急救援评价验收标准的基础上，结合国内的实际状况，并在长达5年企业一线应急救援队伍实战培训经验积累的基础上，推出了4INS ERT应急救援技术测评体系，这也是迄今为止国内唯一一套模块化、标准化、实战化验收测评体系，共计4个科目、18个模块、5项基本测试标准。对于救援人员从安全防护基础理论、应急救援基础理论、防护装备、救援装备、救援流程、救援组织、救援时间以及救援结果等进行多方位的科学化、细致化测评。</span> 
</p>
<p class="MsoNormal" style="text-indent:21.0000pt;">
	<span style="font-size:16px;">安全生产，预防为主。掌控住了安全风险，就等于遏制住了生产事故。孙健认为，应急救援不是简单意义上的亡羊补牢，它的最高境界应该是应急响应与作业安全一体化，通俗地讲就是既亡羊补牢，但更注重未雨绸缪，即事故发生前监督督促作业安全（生产安全），事故发生时迅速响应、及时现场处置掌控风险，两者在日常生产中相辅相成、相互促进，不可割裂。同时，他也借本刊向广大企业尤其是高危行业企业进行呼吁，安全才是最大的效益，安全发展才是企业最旺盛的生命力。他希望广大企业管理者能充分认识到安全生产的重要性，认识到应急救援是企业安全发展最后一道防线的重要性，认识到生命只有在安全中才能永葆鲜活，端正思想、科学部署，为企业干部职工的生命撑起安全伞。</span> 
</p>','1457519516','0'),
('5','36','校企联合，探索在线教育学习新模式','线上教育,线上学习,安酷学院,菁坤,孙健,','2015年9月18日下午，上海开放大学18位公共安全管理学院的老师们莅临上海菁坤智能科技有限公司，双方就在线教育培训课件的开发与应用进行了探讨和交流。','/Public/attached/201606/1464925662.png','<p class="MsoNormal" style="text-align:center;text-indent:21pt;">
	<span style="font-size:14px;"><strong><span style="font-size:14px;"><br />
</span></strong></span> 
</p>
<p class="MsoNormal" style="text-align:center;text-indent:21pt;">
	<span style="font-size:14px;"><strong><span style="font-size:24px;">校企联合，探索在线教育学习新模式</span></strong><strong><span style="font-size:18px;"></span></strong><br />
</span> 
</p>
<p class="MsoNormal" style="text-align:center;text-indent:21pt;">
	<span style="font-size:14px;"><strong><span style="font-size:14px;"><br />
</span></strong></span> 
</p>
<p class="MsoNormal" style="text-indent:21.0pt;">
	<span style="font-size:16px;">2015</span><span style="font-size:16px;">年</span><span style="font-size:16px;">9</span><span style="font-size:16px;">月</span><span style="font-size:16px;">18</span><span style="font-size:16px;">日下午，上海开放大学</span><span style="font-size:16px;">18</span><span style="font-size:16px;">位公共安全管理学院的老师们莅临上海菁坤智能科技有限公司，双方就在线教育培训课件的开发与应用进行了探讨和交流。</span> 
</p>
<p class="MsoNormal" style="text-align:center;text-indent:21pt;">
	<img src="/Public/attached/image/20160603/20160603034855_41375.png" alt="" /> 
</p>
<p class="MsoNormal" align="center" style="text-align:center;text-indent:20.25pt;">
	<strong><span style="font-size:16px;">现场交流图</span></strong> 
</p>
<p class="MsoNormal" style="text-align:left;text-indent:20.25pt;">
	<span style="font-size:14px;"></span> 
</p>
<p class="MsoNormal" style="text-align:left;text-indent:20.25pt;">
	<span style="font-size:16px;">上海菁坤智能科技有限公司</span><span style="font-size:16px;">CEO</span><span style="font-size:16px;">孙健先生介绍了目前国内一线产业工人安全培训的现状，以及该公司在线教育平台（安酷学院）所倡导的双</span><span style="font-size:16px;">O2O</span><span style="font-size:16px;">混合式学习模式，即线上—线下（</span><span style="font-size:16px;">Offline –Online</span><span style="font-size:16px;">）、工作—生活（</span><span style="font-size:16px;">Office –Offtime</span><span style="font-size:16px;">）双结合。并提出在制作培训课件时，不仅要切合企业一线员工的实际需求，更要符合当前碎片化、移动化、游戏化、社区化的学习新趋势。</span> 
</p>
<p class="MsoNormal" style="text-align:center;text-indent:20.25pt;">
	<span style="line-height:1.5;"> </span><img src="/Public/attached/image/20160603/20160603035037_58675.png" alt="" /> 
</p>
<p class="MsoNormal" style="text-align:center;text-indent:68.25pt;">
	<strong><span style="font-size:16px;">上海菁坤智能科技有限公司</span></strong><span style="font-size:16px;"><strong>CEO</strong></span><strong><span style="font-size:16px;">孙健先生介绍“双</span></strong><span style="font-size:16px;"><strong>O2O</strong></span><strong><span style="font-size:16px;">”混合式学习模式 </span></strong> 
</p>
<p class="MsoNormal" style="text-indent:20.25pt;">
	<span style="line-height:1.5;font-size:14px;"><br />
</span> 
</p>
<p class="MsoNormal" style="text-indent:20.25pt;">
	<span style="line-height:1.5;font-size:16px;">上海开放大学老师们对孙总演示互动式课件的制作软件表示出极大的兴趣，并就孙总提出的在线自学、考试测验、互助学习、重点答疑、互动答疑、线下辅导相结合的混合式教育模式进行了交流探讨。</span> 
</p>
<p class="MsoNormal" style="text-indent:20.25pt;">
	<span style="font-size:16px;">最后上海开放大学城市公共安全管理学院院长范军女士表示，通过此次交流探讨，学院对在线教育模式和培训课件的表现形式有了新的认识，并对孙总提出的大学应该“走出去，引进来”（即走出去看看企业、市场的实际需求；引进来外部先进的技术和教学资源）表示出极大的认同。</span> 
</p>
<p class="MsoNormal" style="text-align:center;text-indent:20.25pt;">
	<img src="/Public/attached/image/20160603/20160603035133_36688.png" alt="" /> 
</p>
<p class="MsoNormal" align="center" style="text-align:center;text-indent:21.0pt;">
	<strong><span style="font-size:16px;">上海开放大学城市公共安全管理学院院长范军女士发表观点</span></strong> 
</p>
<p class="MsoNormal" style="text-indent:21.0pt;">
	<span style="line-height:1.5;font-size:16px;">范院长同时也对学院的老师们提出要求，希望老师们能够通过今日的交流互动，在今后教学工作中，在在线教育课件开发上要开放创新，设计出更贴合企业及学生实际需求的课件。</span> 
</p>
<p class="MsoNormal" style="text-indent:20.25pt;">
	<span style="font-size:16px;">上海开放大学的前身是上海电视大学，首创的三分屏教育模式颠覆了传统的课堂式教学，并开创了空中教学的新理念。</span> 
</p>
<p class="MsoNormal" style="text-indent:20.25pt;">
	<span style="font-size:16px;">菁坤公司所独创国内第一套可以实现在线离线双模式以及</span><span style="font-size:16px;">3</span><span style="font-size:16px;">网运营（局域网、互联网、移动互联网）的网络教育平台。引进国外的专业交互式电子课程制作软件，结合自己研发的电子课件开发制作模板以及流程，可以快速地制作精美的交互式电子课件，成为国内最快速的标准化电子课程制作系统。</span> 
</p>
<p class="MsoNormal" style="text-indent:20.25pt;">
	<span style="font-size:16px;">双方的合作可以帮助上海开放大学将空中教学带上一个新的层次。</span> 
</p>','1459589553','0'),
('6','36','香港卫视直击3.12深圳“互联网+安全培训”分享大会','菁坤,孙健,互联网+安全,线上学习,安酷学院,EHS培训,安全培训,','3月12日下午，由国内著名公益安全社群“健人说安全”、中国EHS管理学会以及深圳当地EHS培训机构和企业共同举办的“互联网+安全培训”首站线下分享会在深圳举行。来自深圳、广州、珠海、江门等广东各地的EHS行业精英云集，共同探讨在国家安监局和国家工信部提出的“两化融合”战略大背景下，如何利用互联网的思维方法和工具帮助企业提升全员安全生产效率。','/Public/attached/201606/1464930260.png','<p style="text-align:center;text-indent:2em;">
	<span style="font-size:14px;"><strong><span style="font-size:18px;"><br />
</span></strong></span> 
</p>
<p style="text-align:center;text-indent:2em;">
	<span style="font-size:14px;"><strong><span style="font-size:24px;font-family:\'Microsoft YaHei\';">香港卫视直击3.12深圳“互联网+安全培训”分享大会</span></strong><strong><span style="font-size:18px;"></span></strong><strong><span style="font-size:18px;"></span></strong><br />
</span> 
</p>
<p style="text-align:center;text-indent:2em;">
	<span style="font-size:14px;"><strong><span style="font-size:18px;"><br />
</span></strong></span> 
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;font-family:\'Microsoft YaHei\';"> 3月12日下午，由国内著名公益安全社群“健人说安全”、中国EHS管理学会以及深圳当地EHS培训机构和企业共同举办的“互联网+安全培训”首站线下分享会在深圳举行。来自深圳、广州、珠海、江门等广东各地的EHS行业精英云集，共同探讨在国家安监局和国家工信部提出的“两化融合”战略大背景下，如何利用互联网的思维方法和工具帮助企业提升全员安全生产效率。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><span style="font-size:14px;"></span><img src="/Public/attached/image/20160603/20160603050520_19035.png" alt="" /></span> 
</div>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;font-family:\'Microsoft YaHei\';"><strong>深圳分享会参会人员合影</strong></span> 
</p>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><strong><br />
</strong></span> 
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;font-family:\'Microsoft YaHei\';"> 在深圳市政府2016年“安全执法年”的号召下，此次线下分享会特意邀请著名的安全培训教育专家孙健先生，针对生产企业安全培训成本高、覆盖率低、难以考核等痛点，为来自珠三角的几十名安全管理者分享该如何利用互联网的思维、方法和工具来为企业提供全员覆盖的高绩效安全培训，从而降低作业过程中的安全事故发生率。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603050541_45683.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;font-family:\'Microsoft YaHei\';"><strong>孙健老师分享互联网+安全培训模式</strong></span> 
</div>
<p style="text-indent:2em;">
	<br />
<span style="font-size:16px;font-family:\'Microsoft YaHei\';"> 香港卫视的记者也来到分享会现场，对孙健老师进行了现场采访。孙健老师在采访中表示，大部分安全管理者和企业运营管理者都知道安全对企业的重要性，但是过去出于种种考虑，比如时间、精力、资源不够，工具匮乏等因素，企业无法实现安全培训的有效落地。但是如果利用互联网的思维方法和工具，就能实现线上线下结合，帮助企业以最低的成本将安全培训全员覆盖，高绩效落地。</span> 
</p>
<p style="text-indent:2em;">
	<span style="font-size:14px;"><br />
</span> 
</p>
<div style="text-align:center;">
<script src="https://player.polyv.net/script/polyvplayer.min.js"></script>
<div id="d1374417cd3d6d03d327b8f9302269e2_d"></div>
<script>
var player = polyvObject(\'#d1374417cd3d6d03d327b8f9302269e2_d\').videoPlayer({
    \'width\':\'708\',
    \'height\':\'490\',
    \'vid\' : \'d1374417cd3d6d03d327b8f9302269e2_d\'
});
</script>
</div>
<div style="text-align:center;">
<span style="line-height:1.5;font-size:16px;font-family:\'Microsoft YaHei\';"><strong>香港卫视对本次互联网+安全培训”分享会的报道</strong></span> 
</div>
<p style="text-indent:2em;">
	<br />
<span style="font-size:16px;font-family:\'Microsoft YaHei\';"> 分享会现场气氛活跃，互动热烈。火爆的场面一直持续到晚宴上。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><img src="http://www.safecoo.com/Public/attached/image/20160603/20160603050558_20376.png" alt="" /><span style="line-height:1.5;"></span> 
</div>
<div style="text-align:center;">
	<span style="line-height:1.5;font-size:16px;font-family:\'Microsoft YaHei\';"><strong>分享会晚宴期间大家在热烈交流</strong></span> 
</div>
<p style="text-indent:2em;">
	<br />
<span style="font-size:16px;font-family:\'Microsoft YaHei\';"> 分享会结束后，到会的几十名安全管理人员表示，没想到安全培训可以如此有趣和有效，互联网+安全这种培训模式值得企业思考和运用。</span> 
</p>','1462181603','0'),
('7','36','互联网＋安全培训教育公益讲座在天津举行','菁坤,孙健,互联网+安全,线上学习,安酷学院,EHS培训,安全培训,','3月19日，一场以“互联网+的安全培训教育”为主题的公益讲座在天津举行。来自空中客车、波音复合材料、天津石化等几十家企业负责安全生产的EHS工程师参加了这次盛会。当天活动中，安全培训教育专家孙健同与会嘉宾分享了安全培训教育经验以及在生产过程中如何应用个人防护装备等进行了讲解。','/Public/attached/201606/1464930555.png','<p style="text-align:center;text-indent:2em;">
	<strong><span style="font-size:18px;"><br />
</span></strong> 
</p>
<p style="text-align:center;text-indent:2em;">
	<strong><span style="font-size:24px;">互联网＋安全培训教育公益讲座在天津举行</span></strong><strong><span style="font-size:18px;"></span></strong> 
</p>
<p style="text-align:center;text-indent:2em;">
	<strong><span style="font-size:18px;"><br />
</span></strong> 
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;"> 天津北方网讯：3月19日，一场以“互联网+的安全培训教育”为主题的公益讲座在天津举行。来自空中客车、波音复合材料、天津石化等几十家企业负责安全生产的EHS工程师参加了这次盛会。当天活动中，安全培训教育专家孙健同与会嘉宾分享了安全培训教育经验以及在生产过程中如何应用个人防护装备等进行了讲解。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603051055_25071.png" alt="" /></span> 
</div>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;"><strong>“互联网+的安全培训教育”公益讲座在天津举行</strong></span> 
</p>
<p style="text-indent:2em;">
	<br />
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;"> 培训活动相关负责人向记者表示，在过去传统的培训方式中，老师讲授条条框框的文件枯燥无味，形式乏味，难以理解，经常出现培训后职工对安全知识印象不深，造成把培训知识“还”给老师的现象。而且负责生产的一线职工大部分都是80、90后，如何通过寓教于乐的方式以吸引他们参与培训才是最好的方式。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603051120_93447.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<span style="line-height:1.5;"></span><span style="line-height:1.5;font-size:16px;"><strong>安全培训教育专家孙健同与会嘉宾分享安全培训教育经验</strong></span> 
</div>
<p style="text-indent:2em;">
	<br />
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;"> 如今，“互联网＋”融合式安全培训教育模式在全国悄然兴起。在讲座中，安全培训教育专家孙健演示的安全生产云培训平台，提供了包括动漫、视频等在内的多媒体课件，含讲解、演示、案例、训练、故事，并采用“学、练、赛、考”渐进式巩固的教学方法，让参与互动的嘉宾感到新鲜有趣。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603051146_33771.png" alt="" /></span> 
</div>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;"><strong>参会嘉宾通过软件回答安全知识问题</strong></span> 
</p>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><br />
</span> 
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;"> 在国家安监局会同国家工信部提出“两化融合”战略的大背景前提下，如何利用互联网的信息技术手段提高工业安全生产的管理水准，将是未来企业培训发展方向。而融合式安全培训教育模式，利用互联网优势，将线上学习和线下学习结合起来，让企业员工的安全培训变得有趣、有料并有效，真正实现企业一线员工培训的全员覆盖，让企业一线员工及其管理者享受到互联网带来的优势。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603051205_43421.png" alt="" /></span> 
</div>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;"><strong>参会嘉宾分享安全培训教育经验</strong></span> 
</p>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><br />
</span> 
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;"> 目前该培训机构已服务全国40家企业，总上线人数达到11万人。极大解决了中石化等企业一线员工及一线安全生产管理人员的安全知识与技能的培训学习落地。</span> 
</p>
<p style="text-indent:2em;">
	<br />
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;">北方网原文报道链接：</span><a href="http://news.enorth.com.cn/system/2016/03/20/030874621.shtml" target="_blank"><span style="font-size:16px;">http://news.enorth.com.cn/system/2016/03/20/030874621.shtml</span></a> 
</p>
<p style="text-indent:2em;">
	<br />
</p>','1463045629','0'),
('8','36','如何形成快速有效的企业一线应急响应？','应急救援,EHS培训,安全培训,菁坤,孙健','3月31日，一场以“如何形成快速有效的企业一线应急响应”为主题的安全公益讲座在苏州举行，200多名苏州资深EHS工程师参加了这次盛会。当天活动中，国内应急救援培训专家孙健同与会嘉宾分享了国内外应急响应的发展状况以及企业如何才能建设一支能够快速响应的应急救援团队？','/Public/attached/201606/1464930905.png','<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><span style="font-size:14px;"><strong><span style="font-size:18px;"><br />
</span></strong></span></span> 
</p>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><span style="font-size:14px;"> <strong><span style="font-size:24px;">如何形成快速有效的企业一线应急响应？</span></strong><span style="font-size:18px;"><strong></strong></span></span></span> 
</p>
<p style="text-align:center;text-indent:2em;">
	<span style="line-height:1.5;"><span style="font-size:14px;"><strong><span style="font-size:18px;"><br />
</span></strong></span></span> 
</p>
<p style="text-align:left;text-indent:2em;">
	<span style="line-height:1.5;font-size:16px;"><span style="font-size:16px;"> 3月31日，一场以“如何形成快速有效的企业一线应急响应”为主题的安全公益讲座在苏州举行，200多名苏州资深EHS工程师参加了这次盛会。当天活动中，国内应急救援培训专家孙健同与会嘉宾分享了国内外应急响应的发展状况以及企业如何才能建设一支能够快速响应的应急救援团队？ </span></span> 
</p>
<p style="text-align:center;">
	<span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603051541_43172.png" alt="" /></span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;"><strong>孙健老师在台上分享应急救援相关知识</strong> </span> 
</div>
<p style="text-indent:2em;">
	<span style="font-size:14px;"></span> 
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;"> 孙健老师曾先后去澳大利亚安全管理机构、美国OSHA、 MSHA、EPA、AMA、ASTD接受过系统化的应急救援实战培训和安全技术培训。他回国后深感于国内应急救援方面与国外的巨大差距，一直致力于国内应急救援实战体系的探索，先后为中海油天津塘沽应急救援实战演练基地、广州大亚湾石化区化学品事故应急救援基地等多个国家级应急救援实战培训基地提供过咨询规划。所以在本次分享会上，孙健老师聊起他在应急救援方面的实战经验，很快便吸引了会场200多名EHS人员的目光。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603051613_13877.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;"><strong>台下的EHS人员在专心记录孙健老师分享的应急救援经验</strong></span> 
</div>
<p style="text-indent:2em;">
	<br />
</p>
<p style="text-indent:2em;">
	<span style="font-size:16px;"> 孙健老师带领的团队先后为拜耳中国、天津石化、大连安监局保税区、上海石化、惠生南京等多家大型企业提供过应急救援培训。所以在提到企业应急救援上的痛点和需求时，孙健老师可谓是鞭辟入里，引起了全场EHS人员的共鸣。</span> 
</p>
<div style="text-align:center;">
	<span style="line-height:1.5;"> </span><span style="line-height:1.5;"><img src="/Public/attached/image/20160603/20160603051647_69281.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<span style="line-height:1.5;"><strong></strong></span><span style="line-height:1.5;font-size:16px;"><strong>孙健老师与台下EHS人员互动交流</strong></span> 
</div>
<p style="text-indent:2em;">
	<br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp; &nbsp;应急救援涉及的主题很多，由于当天时间有限，孙健老师无法面面俱到，也无法一一解答在场嘉宾的问题。所以在当天会议结束之后的一个月内，孙健老师又在“健人说安全”微信群里免费开设了《化学品泄漏应急救援》课程，获得了群内小伙伴的一致赞赏。</span>
</p>','1463909653','0'),
('9','36','“互联网+安全”培训教育新模式如何在生产企业落地实施？','互联网+安全，菁坤公司，孙健，安全培训，安酷学院','在全国第15个安全生产月之际，为全面加强安全生产宣传教育，推动国家安监总局以及工信部所提倡“两化融合”的安全信息化落地，苏州市安全生产管理协会选择上海菁坤智能科技有限公司作为苏州市安全信息化落地共建单位。6月6日下午1:30分，菁坤公司创始人孙健先生和他带领的安酷团队亲赴苏州，为示范单位讲解如何利用安酷学院推动企业安全信息化落地？','/Public/attached/201606/1465281587.jpg','<p style="text-indent:2em;">
	<span style="font-size:16px;"></span>
</p>
<div style="text-align:center;">
	<strong><span style="font-size:24px;">“互联网+安全”培训教育新模式如何在生产企业落地实施？</span></strong> 
</div>
<div style="text-align:center;">
	<strong><span style="font-size:18px;">——苏州安全生产管理协会与上海菁坤公司联合推动企业安全信息化落地</span></strong> 
</div>
<br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp; &nbsp;在全国第15个安全生产月之际，为全面加强安全生产宣传教育，协助各企业充分利用新媒体，推动国家安监总局以及工信部所提倡“两化融合”的安全信息化落地，苏州市安全生产管理协会选择上海菁坤智能科技有限公司作为苏州市安全信息化落地共建单位的技术平台提供方，以共同推进苏州市安全生产管理协会会员单位的安全信息化落地步伐。</span><br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp;为了让示范单位能更好地体验安酷学院的线上课程，推动企业的安全信息化落地，6月6日下午，上海菁坤智能科技有限公司创始人孙健先生和他的安酷团队亲赴苏州，为示范单位讲解如何利用安酷学院推动企业安全信息化落地？</span><br />
<div style="text-align:center;">
	<span style="font-size:16px;line-height:1.5;"><img src="/Public/attached/image/20160613/20160613013215_93042.png" alt="" /> </span><span style="font-size:16px;line-height:1.5;"></span> 
</div>
<div style="text-align:center;">
	<strong>菁坤公司创始人孙健先生在讲解“互联网+安全”培训教育模式</strong> 
</div>
<br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp; &nbsp;在项目说明会上，苏州市安全生产管理协会杨秘书长向大家宣布，在6月15日~9月15日为期三个月的活动期间，苏州市安全生产管理协会将扶持一批会员单位作为苏州安全信息化落地示范单位。这批单位将免费导入安酷学院“作业安全和应急响应”系列课程和“安全闯关游戏”，以孵化自有安全培训信息化体系。</span><br />
<span style="font-size:16px;"> 期间正值安全生产月，企事业单位可以借助安酷学院现有课程和模板DIY课程在短期内实现安全培训全员覆盖，并且即时得到学员学习和考试记录，以完美呈现安全月绩效，安酷产品可以协助苏州企事业单位一臂之力。</span><br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp; 当天下午，苏州创元、中国铁塔、海格新能源、BOE京东方光科技、大金空调及安监部门等几十家企事业相关EHS人士参加了孙健先生分享的“互联网+安全”企业安全信息化落地说明会。</span><br />
<div style="text-align:center;">
	<span style="font-size:16px;line-height:1.5;"> </span><span style="font-size:16px;line-height:1.5;"><img src="/Public/attached/image/20160613/20160613013230_99102.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<strong>台下EHS人士在认真记录孙老师的分享</strong> 
</div>
<br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp; 说明会上，孙健老师分享道，要将“互联网+安全”培训教育成功在企业实施有四大条件要素：硬件（服务器、宽带&amp;Wifi、学习终端）、软件（eLearning学习平台、微信学习接口）、内容（学习课件开发、学习课件购买、其它支持材料）和运营（企业内部推广）。孙老师强调，虽然安酷可以提供硬件、软件和内容这三大要素，但企业的运营却至关重要。因为长久以来，企业员工已经习惯了面对面的线下培训，要改变这种固有模式、让企业系统地接受“互联网+安全”这种新安全培训模式并不是一件简单的事。</span><br />
<div style="text-align:center;">
	<span style="font-size:16px;line-height:1.5;"> </span><span style="font-size:16px;line-height:1.5;"><img src="/Public/attached/image/20160613/20160613013244_16452.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<strong>企业在推行“互联网+安全”培训模式可能会遇到的情况，如何克服障碍？孙健老师在讲解</strong> 
</div>
<br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp; &nbsp;让员工接受“互联网+安全”这种新培训教育模式，实现数字化管理，孙老师紧接着分享了企业EHS人员将安全信息化在企业内部成功落地推广的解决方法，那就是“胡萝卜+大棒”的奖惩机制。</span><br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp;&nbsp;所谓“大棒”，是指企业出台相应的规章制度，要求员工必须在规定时间内学完课程并通过考试，而“胡萝卜”则 是给规定时间内学完课程的员工以必要的奖励，刺激员工的学习积极性。</span><br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp;为调动员工的学习积极性，推进企业安全信息化落地，孙老师表示，安酷团队为企业、学习管理者和一线员工分别制定了三套不同的奖励机制。在三个月活动期间，上线试用人数占员工人数80%以上的企业，能充分利用课程模板、游戏模板将单位课程转换为线上课程的安全管理人员，在规定时间内，完成课程并且成绩优良的员工个人，都有机会获取丰厚奖品。</span><br />
<br />
<div style="text-align:center;">
	<span style="font-size:16px;line-height:1.5;"> </span><span style="font-size:16px;line-height:1.5;"><img src="/Public/attached/image/20160613/20160613013300_56418.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<strong>孙健老师在讲解安酷学院现有的作业安全系列课程</strong> 
</div>
<br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp;之后，孙老师针对员工如何登录安酷学院这个平台进行线上课程学习、管理者如何根据工作岗位不同和职能不同给他们分配不同的学习课程、管理员如何了解员工们的上线学习情况和测试情况等常见问题给出了相应的答案，这些问题都可以在菁坤公司官网——常见问题栏目里得到解答。</span><br />
<div style="text-align:center;">
	<span style="font-size:16px;line-height:1.5;"> </span><span style="font-size:16px;line-height:1.5;"><img src="/Public/attached/image/20160613/20160613013312_75646.png" alt="" /></span> 
</div>
<div style="text-align:center;">
	<span style="font-size:16px;line-height:1.5;"><strong>台下EHS人士在认真听讲“互联网+安全”培训教育新模式</strong></span> 
</div>
<br />
<span style="font-size:16px;">&nbsp; &nbsp; &nbsp;会议最后，杨秘书长进行了总结发言。杨秘书长表示，90%以上的事故都是由于人的不安全行为造成的，而安全培训可以减少人为失误，从而避免事故的发生。同时杨秘书长对孙总带领的安酷团队表示感谢，感谢菁坤公司将新媒体新技术运用到传统的安全培训上，帮助苏州企业逐步建立起信息化、系统化、专业化的安全培训。</span><br />
<span style="font-size:16px;"></span><span style="font-size:16px;"></span> 
<p>
	<br />
</p>','1465289329','0'),
('10','37','安酷大学开课啦','安酷大学开课啦','安酷大学开课啦','','安酷大学开课啦','1466577779','0'),
('11','36','应急救援，安酷和你练起来——受限空间应急救援演练真实大记录','应急救援,安酷,受限空间,救援演练,菁坤','6月21日~23日，安酷团队应邀为某外资集团公司进行长达三天的受限空间应急救援实战培训，这是为该公司进行的第四期培训。','/Public/attached/201606/1467256450.png','<div style="text-align:center;">
	<span style="font-size:24px;line-height:36px;"><b><span style="font-size:24px;">应急救援，安酷和你练起来</span><span style="font-size:24px;"></span><br />
<span style="font-size:18px;">——受限空间应急救援演练真实大记录</span><br />
	<div style="text-align:left;">
		<span style="font-weight:normal;"><b></b></span><span style="font-weight:normal;font-size:16px;line-height:1.5;">6月21日~23日，安酷团队应邀为某外资集团公司进行长达三天的受限空间应急救援实战培训，这是为该公司进行的第四期培训。</span> 
	</div>
</b></span> 
</div>
<p>
	<span style="font-size:16px;"><br />
</span> 
</p>
<span style="font-size:18px;"><strong>应急救援实战培训第一天：救援理论培训和救援装备的演练</strong></span><span style="font-size:18px;"></span><br />
<span style="font-size:16px;">21日上午，应急救援实战培训第一阶段——应急救援装备训练营开始了。 在一个小时的理论培训之后，安酷团队和救援小组学员便开始呼吸防护的实战演练。</span><br />
<p style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630052641_45263.png" alt="" /> 
</p>
<h4 style="text-align:center;">
	<span style="font-size:16px;line-height:1.5;"><strong>孙老师在讲解全面罩&amp;半面罩呼吸器、自背式空呼，移动供气源的检查要点</strong></span> 
</h4>
<span style="font-size:16px;"> 
<p style="text-align:center;">
	<strong><br />
</strong> 
</p>
</span> <span style="font-size:16px;"> 
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050137_15662.png" alt="" /> 
</div>
</span> <span style="font-size:16px;"> 
<p style="text-align:center;">
	<strong><strong>安酷团队实战专家蒋老师在讲解空气呼吸器佩戴前的检查要点</strong></strong> 
</p>
<p style="text-align:center;">
	<strong><br />
</strong> 
</p>
</span> <span style="font-size:16px;"> 
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050236_79546.png" alt="" /> 
</div>
</span> <span style="font-size:16px;"> 
<p style="text-align:center;">
	<strong><strong>应急小组成员在一一亲自体验学习呼吸保护装备的使用</strong></strong> 
</p>
<p style="text-align:center;">
	<strong><br />
</strong> 
</p>
<p style="text-align:center;">
	<strong><img src="/Public/attached/image/20160630/20160630054153_21505.png" alt="" /><br />
</strong> 
</p>
<p style="text-align:center;">
	<strong>蒋老师在讲解受限空间应急救援常用的设备移动供气源</strong> 
</p>
<p style="text-align:center;">
	<strong><br />
</strong> 
</p>
</span> <span style="font-size:16px;"> 
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050302_68483.png" alt="" /> 
</div>
</span> <span style="font-size:16px;"> 
<div style="text-align:center;">
	<strong>蒋老师表示，紧急供气包的恒流供气装置，大大提升了被救者的存活机率。</strong> 
</div>
</span> <br />
<span style="font-size:16px;">在安酷团队讲解完呼吸救援防护装备知识之后，救援队员就按照自己在应急队伍中的编号，扮演的角色来进行实际练习。</span><br />
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050322_45823.png" alt="" /> 
</div>
<p>
	<span style="font-size:16px;"><br />
</span> 
</p>
<p>
	<span style="font-size:16px;">关于SCBA、防化服及移动供气装置的呼吸防护培训告一段落，蒋老师对上午讲解的如何穿戴呼吸防护装备进行了简短的总结回顾。</span> 
</p>
<p style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050411_53513.png" alt="" /> 
</p>
<p style="text-align:center;">
	<br />
</p>
<span style="font-size:16px;">一小时的午餐休息时间之后，孙老师带领大家进行了一些提神醒脑的小游戏，热身游戏之后，安酷团队里有“小表妹”之称的美女罗老师上场，开始讲解便携式气体检测仪表在受限空间应急救援进入前后的具体应用以及常见问题，解决方法。</span><br />
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050426_38176.png" alt="" /> 
</div>
<span style="font-size:16px;"> 
<div style="text-align:center;">
	<strong>美女“小表妹”罗老师在讲解便携式气体检测仪表</strong> 
</div>
</span> <br />
<strong><span style="font-size:18px;">应急救援实战培训第二天：“高空模拟训练塔” </span></strong><strong><span style="font-size:18px;"></span></strong><br />
<span style="font-size:16px;">受限空间应急救援训练营第二天进行的是高空模拟训练塔和受限空间综合试训。</span><br />
<span style="font-size:16px;">在训练开始前，安酷团队细心讲解了登上高空模拟训练塔前的安全注意事项，之后学员正式进行登塔训练。</span><br />
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050456_45824.png" alt="" /> 
</div>
<span style="font-size:16px;">之后安酷团队为学员讲解如何搭建三脚架吊救系统，进行受限空间施救（如下图）。</span><br />
<p style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050511_57804.png" alt="" /> 
</p>
<p style="text-align:center;">
	<br />
</p>
<span style="font-size:16px;">等学员掌握三脚架吊救系统技巧后，安酷团队便带领大家进入下一项训练项目：高处救援演练。</span><br />
<p>
	<span style="font-size:16px;"> </span> 
</p>
<p style="text-align:center;">
	<span style="font-size:16px;"><img src="/Public/attached/image/20160630/20160630050524_71755.png" alt="" /><br />
</span> 
</p>
<span style="font-size:16px;"> 
<p style="text-align:center;">
	<strong>上图就是学员在模拟训练塔中用假人进行受限空间底部救援的模拟训练。</strong> 
</p>
<p style="text-align:center;">
	<strong><br />
</strong> 
</p>
</span> 
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050548_16610.png" alt="" /> 
</div>
<span style="font-size:16px;"> 
<div style="text-align:center;">
	<strong>学员在外部实训罐进行之高空放“人”训练</strong> 
</div>
</span> 
<p>
	<span style="font-size:16px;"><br />
</span> 
</p>
<p>
	<span style="font-size:18px;"><strong>应急救援实战培训第三天：综合实战演练</strong></span><span style="font-size:18px;"><strong></strong></span> 
</p>
<span style="font-size:16px;">第三天进行的是真实罐体受限空间的综合实战演练。</span><br />
<span style="font-size:16px;">也许是感受到了学员们的热情干劲，老天爷也格外配合，连日的滂沱大雨停了下来，六月的烈日也没有出现，蓝天白云，天气晴好。学员将在今天对真实受限空间环境进行应急救援实战演练。 </span><br />
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050631_35749.png" alt="" /> 
</div>
<p>
	<span style="font-size:16px;">在实战训练前，孙老师对应急演练中的注意事项进行了讲解，并一一了检查救援队伍中各编号队员的准备情况（如上图所示）。</span> 
</p>
<p>
	<span style="font-size:16px;"><br />
</span> 
</p>
<span style="font-size:16px;">在安酷教官的引导下，5名救援队员依照分工次序依次登顶，后面的一个人要检查前面队员的装备和动作，其中一号队员要额外带牵引绳和速差器，方便接引其他工作人员。 </span><br />
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050711_93996.png" alt="" /> 
</div>
<span style="font-size:16px;"> 
<p style="text-align:center;">
	<strong>救援队员上塔</strong> 
</p>
<p style="text-align:center;">
	<strong><br />
</strong> 
</p>
</span> 
<p style="text-align:center;">
	<span style="font-size:16px;"><img src="/Public/attached/image/20160630/20160630050737_15452.png" alt="" /><br />
</span> 
</p>
<p style="text-align:center;">
	<span style="font-size:16px;"><strong>救援设备上塔</strong></span> 
</p>
<p style="text-align:center;">
	<span style="font-size:16px;"><strong><br />
</strong></span> 
</p>
<span style="font-size:16px;"> 
<div style="text-align:center;">
	<img src="/Public/attached/image/20160630/20160630050755_39789.png" alt="" /> 
</div>
</span> 
<div style="text-align:center;">
	<strong><span style="font-size:12px;">罐内施救，并将被救者缓缓放到地面</span></strong> 
</div>
<span style="font-size:16px;"> </span><br />
<span style="font-size:16px;">在为期三天的受限空间应急救援实战培训中，应急救援学员掌握了从理论到实战、从简单到复杂，循序渐进的一整套完整救援体系。</span><br />
<span style="font-size:16px;"><strong>孙健老师带领的安酷团队主导或参与多个国家级应急救援演练基地建设，在8年多的应急救援实训过程中摸索累积了丰富的经验，学员可以完整体验救援理论方法（理论篇）、救援装备选择与应用（装备篇）、多功能模拟训练塔训练技能（技能篇）、受限空间综合试训（试训篇）、受限空间综合实战训练（实训篇）这五个部分。</strong></span><span style="font-size:16px;"><strong></strong></span><br />
<span style="font-size:16px;">国家安全生产监督管理今年6月份公布了《生产安全事故应急预案管理办法》（总局令第88号），其中“第三十三条 生产经营单位应当制定本单位的应急预案演练计划，根据本单位的事故风险特点，每年至少组织一次综合应急预案演练或者专项应急预案演练，每半年至少组织一次现场处置方案演练。”</span><br />
<div>
	<br />
</div>','1467263308','0');
DROP TABLE IF EXISTS  `qw_auth_group_access`;
CREATE TABLE `qw_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_auth_group_access`(`uid`,`group_id`) values
('1','1'),
('2','3');
DROP TABLE IF EXISTS  `qw_category`;
CREATE TABLE `qw_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '0正常，1单页，2外链',
  `pid` int(11) NOT NULL COMMENT '父ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `seotitle` varchar(200) NOT NULL COMMENT 'SEO标题',
  `keywords` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `url` varchar(255) NOT NULL,
  `cattemplate` varchar(100) NOT NULL,
  `contemplate` varchar(100) NOT NULL,
  `o` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `fsid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_category`(`id`,`type`,`pid`,`name`,`seotitle`,`keywords`,`description`,`content`,`url`,`cattemplate`,`contemplate`,`o`) values
('36','0','0','公司新闻','','','','','','','','0'),
('37','0','0','HSE','','','','','','','','0');
DROP TABLE IF EXISTS  `qw_auth_rule`;
CREATE TABLE `qw_auth_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `icon` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `islink` tinyint(1) NOT NULL DEFAULT '1',
  `o` int(11) NOT NULL COMMENT '排序',
  `tips` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_auth_rule`(`id`,`pid`,`name`,`title`,`icon`,`type`,`status`,`condition`,`islink`,`o`,`tips`) values
('1','0','Index/index','控制台','menu-icon fa fa-tachometer','1','1','','1','1','友情提示：经常查看操作日志，发现异常以便及时追查原因。'),
('2','0','','系统设置','menu-icon fa fa-cog','1','1','','1','2',''),
('3','2','Setting/setting','网站设置','menu-icon fa fa-caret-right','1','1','','1','3','这是网站设置的提示。'),
('4','2','Menu/index','后台菜单','menu-icon fa fa-caret-right','1','1','','1','4',''),
('5','2','Menu/add','新增菜单','menu-icon fa fa-caret-right','1','1','','1','5',''),
('6','4','Menu/edit','编辑菜单','','1','1','','0','6',''),
('7','2','Menu/update','保存菜单','menu-icon fa fa-caret-right','1','1','','0','7',''),
('8','2','Menu/del','删除菜单','menu-icon fa fa-caret-right','1','1','','0','8',''),
('9','2','Database/backup','数据库备份','menu-icon fa fa-caret-right','1','1','','1','9',''),
('10','9','Database/recovery','数据库还原','','1','1','','0','10',''),
('11','2','Update/update','在线升级','menu-icon fa fa-caret-right','1','1','','1','11',''),
('12','2','Update/devlog','开发日志','menu-icon fa fa-caret-right','1','1','','1','12',''),
('13','0','','用户及组','menu-icon fa fa-users','1','1','','1','13',''),
('14','13','Member/index','用户管理','menu-icon fa fa-caret-right','1','1','','1','14',''),
('15','13','Member/add','新增用户','menu-icon fa fa-caret-right','1','1','','1','15',''),
('16','13','Member/edit','编辑用户','menu-icon fa fa-caret-right','1','1','','0','16',''),
('17','13','Member/update','保存用户','menu-icon fa fa-caret-right','1','1','','0','17',''),
('18','13','Member/del','删除用户','','1','1','','0','18',''),
('19','13','Group/index','用户组管理','menu-icon fa fa-caret-right','1','1','','1','19',''),
('20','13','Group/add','新增用户组','menu-icon fa fa-caret-right','1','1','','1','20',''),
('21','13','Group/edit','编辑用户组','menu-icon fa fa-caret-right','1','1','','0','21',''),
('22','13','Group/update','保存用户组','menu-icon fa fa-caret-right','1','1','','0','22',''),
('23','13','Group/del','删除用户组','','1','1','','0','23',''),
('24','0','','网站内容','menu-icon fa fa-desktop','1','1','','1','24',''),
('25','24','Article/index','文章管理','menu-icon fa fa-caret-right','1','1','','1','25','网站虽然重要，身体更重要，出去走走吧。'),
('26','24','Article/add','新增文章','menu-icon fa fa-caret-right','1','1','','1','26',''),
('27','24','Article/edit','编辑文章','menu-icon fa fa-caret-right','1','1','','0','27',''),
('29','24','Article/update','保存文章','menu-icon fa fa-caret-right','1','1','','0','29',''),
('30','24','Article/del','删除文章','','1','1','','0','30',''),
('31','24','Category/index','分类管理','menu-icon fa fa-caret-right','1','1','','1','31',''),
('32','24','Category/add','新增分类','menu-icon fa fa-caret-right','1','1','','1','32',''),
('33','24','Category/edit','编辑分类','menu-icon fa fa-caret-right','1','1','','0','33',''),
('34','24','Category/update','保存分类','menu-icon fa fa-caret-right','1','1','','0','34',''),
('36','24','Category/del','删除分类','','1','1','','0','36',''),
('37','0','','其它功能','menu-icon fa fa-legal','1','1','','1','37',''),
('38','37','Link/index','友情链接','menu-icon fa fa-caret-right','1','1','','1','38',''),
('39','37','Link/add','增加链接','','1','1','','1','39',''),
('40','37','Link/edit','编辑链接','','1','1','','0','40',''),
('41','37','Link/update','保存链接','','1','1','','0','41',''),
('42','37','Link/del','删除链接','','1','1','','0','42',''),
('43','37','Flash/index','焦点图','menu-icon fa fa-desktop','1','1','','1','43',''),
('44','37','Flash/add','新增焦点图','','1','1','','1','44',''),
('45','37','Flash/update','保存焦点图','','1','1','','0','45',''),
('46','37','Flash/edit','编辑焦点图','','1','1','','0','46',''),
('47','37','Flash/del','删除焦点图','','1','1','','0','47',''),
('48','0','Personal/index','个人中心','menu-icon fa fa-user','1','1','','1','48',''),
('49','48','Personal/profile','个人资料','menu-icon fa fa-user','1','1','','1','49',''),
('50','48','Logout/index','退出','','1','1','','1','50',''),
('51','9','Database/export','备份','','1','1','','0','51',''),
('52','9','Database/optimize','数据优化','','1','1','','0','52',''),
('53','9','Database/repair','修复表','','1','1','','0','53',''),
('54','11','Update/updating','升级安装','','1','1','','0','54',''),
('55','48','Personal/update','资料保存','','1','1','','0','55',''),
('56','3','Setting/update','设置保存','','1','1','','0','56',''),
('57','9','Database/del','备份删除','','1','1','','0','57',''),
('58','2','variable/index','自定义变量','','1','1','','1','0',''),
('59','58','variable/add','新增变量','','1','1','','0','0',''),
('60','58','variable/edit','编辑变量','','1','1','','0','0',''),
('61','58','variable/update','保存变量','','1','1','','0','0',''),
('62','58','variable/del','删除变量','','1','1','','0','0',''),
('63','37','Facebook/add','用户反馈','','1','1','','1','63',''),
('66','0','','订单管理','menu-icon fa fa-desktop','1','1','','1','35',''),
('67','66','Order/index','订单列表','','1','1','','1','36',''),
('68','0','','课程管理','menu-icon fa fa-desktop','1','1','','0','24',''),
('69','68','Course/index','所有课程','menu-icon fa fa-caret-right','1','1','','0','25','网站虽然重要，身体更重要，出去走走吧。'),
('70','68','Course/add','新增课程','menu-icon fa fa-caret-right','1','1','','0','26',''),
('71','68','Course/edit','编辑课程','menu-icon fa fa-caret-right','1','1','','0','27',''),
('72','68','Course/update','保存课程','menu-icon fa fa-caret-right','1','1','','0','29',''),
('73','68','Course/del','删除课程','','1','1','','0','30',''),
('74','68','Coursecate/index','分类管理','menu-icon fa fa-caret-right','1','1','','0','31',''),
('75','68','Coursecate/add','新增分类','menu-icon fa fa-caret-right','1','1','','0','32',''),
('76','68','Coursecate/edit','编辑分类','menu-icon fa fa-caret-right','1','1','','0','33',''),
('77','68','Coursecate/update','保存分类','menu-icon fa fa-caret-right','1','1','','0','34',''),
('78','68','Coursecate/del','删除分类','','1','1','','0','36',''),
('79','0','','直播','menu-icon fa fa-desktop','1','1','','1','24',''),
('80','79','Live/index','所有列表','menu-icon fa fa-caret-right','1','1','','1','25','网站虽然重要，身体更重要，出去走走吧。'),
('81','79','Live/add','新增直播','menu-icon fa fa-caret-right','1','1','','1','26',''),
('82','79','Live/edit','编辑直播','menu-icon fa fa-caret-right','1','1','','0','27',''),
('83','79','Live/update','保存直播','menu-icon fa fa-caret-right','1','1','','0','29',''),
('84','79','Live/del','删除课程','','1','1','','0','30',''),
('85','79','Livecate/index','分类管理','menu-icon fa fa-caret-right','1','1','','1','31',''),
('86','79','Livecate/add','新增分类','menu-icon fa fa-caret-right','1','1','','1','32',''),
('87','79','Livecate/edit','编辑分类','menu-icon fa fa-caret-right','1','1','','0','33',''),
('88','79','Livecate/update','保存分类','menu-icon fa fa-caret-right','1','1','','0','34',''),
('89','79','Livecate/del','删除分类','','1','1','','0','36','');
DROP TABLE IF EXISTS  `qw_livecate`;
CREATE TABLE `qw_livecate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '0正常，1单页，2外',
  `pid` int(11) NOT NULL COMMENT '父ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `seotitle` varchar(200) NOT NULL COMMENT 'SEO标题',
  `keywords` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `url` varchar(255) NOT NULL,
  `cattemplate` varchar(100) NOT NULL,
  `contemplate` varchar(100) NOT NULL,
  `o` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`),
  KEY `id_3` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_livecate`(`id`,`type`,`pid`,`name`,`seotitle`,`keywords`,`description`,`content`,`url`,`cattemplate`,`contemplate`,`o`) values
('7','0','0','直播预告','','','','','','','','0');
DROP TABLE IF EXISTS  `qw_reginfo`;
CREATE TABLE `qw_reginfo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(10) NOT NULL DEFAULT '',
  `email` varchar(100) DEFAULT NULL,
  `phonenum` char(12) NOT NULL,
  `companyname` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `verify_code` varchar(100) NOT NULL DEFAULT '',
  `resign` varchar(100) NOT NULL DEFAULT '',
  `station` varchar(100) NOT NULL DEFAULT '',
  `idnum` char(19) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_reginfo`(`id`,`name`,`email`,`phonenum`,`companyname`,`place`,`verify_code`,`resign`,`station`,`idnum`) values
('1','adsfaf','asdfasfas@qq.com','asdfsaqerw','rwqrwq','rewqrqw','','','',''),
('2','qrqrw','rwerq#@fff','Fdfs','Ffff','ff','','','',''),
('3','adsfaf','asdfasfas@qq.com','asdfsaqerw','rwqrwq','rewqrqw','','','',''),
('4','杨浩','692830308@qq.com','15221672423','上海菁坤','上海','','','',''),
('5','luo yingme','18013104690@163.com','18013104690','菁坤','苏州','','','',''),
('6','KKK','KKK','KKK','KKK','888','','','',''),
('7','ffff','ffff@fff','ffff','fff','fff','','','',''),
('8','法撒旦飞洒发rqwe','erqwrq@1qq.cm','fdsfafsad','qrwerwqr','werwqrwqre','','','',''),
('9','admin','admin@qq.com','test1111','wqrwqr','teaafs','','','',''),
('10','陈文元','378905452@qq.com','18012656566','昆山宝盐','江苏','','','','');
DROP TABLE IF EXISTS  `qw_member`;
CREATE TABLE `qw_member` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(225) NOT NULL,
  `head` varchar(255) NOT NULL COMMENT '头像',
  `sex` tinyint(1) NOT NULL COMMENT '0保密1男，2女',
  `birthday` int(10) NOT NULL COMMENT '生日',
  `phone` varchar(20) NOT NULL COMMENT '电话',
  `qq` varchar(20) NOT NULL COMMENT 'QQ',
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `password` varchar(32) NOT NULL,
  `t` int(10) unsigned NOT NULL COMMENT '注册时间',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_member`(`uid`,`user`,`head`,`sex`,`birthday`,`phone`,`qq`,`email`,`password`,`t`) values
('1','admin','/Public/attached/201601/1453389194.png','1','1420128000','13800138000','331349451','xieyanwei@qq.com','89d5289073059452728627e2e07d157c','1442505600');
DROP TABLE IF EXISTS  `qw_h_user`;
CREATE TABLE `qw_h_user` (
  `uid` int(10) NOT NULL AUTO_INCREMENT,
  `companyname` varchar(100) NOT NULL DEFAULT '',
  `username` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(36) NOT NULL DEFAULT '',
  `name` char(10) NOT NULL DEFAULT '',
  `email` varchar(50) DEFAULT '',
  `phonenum` char(12) NOT NULL,
  `t` int(10) unsigned NOT NULL COMMENT '时间',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_h_user`(`uid`,`companyname`,`username`,`password`,`name`,`email`,`phonenum`,`t`) values
('30','admin','admin','21232f297a57a5a743894a0e4a801fc3','admin','513826081@qq.com','18583898763','1469850474'),
('31','admin','admin2','c84258e9c39059a89ab77d846ddab909','admin2','sfddfs@qq.com','18583898769','1469932482'),
('32','addafa','admin3','21232f297a57a5a743894a0e4a801fc3','dafs','51382e6081@qq.com','18583898761','1469932653'),
('33','admin5','admin5','21232f297a57a5a743894a0e4a801fc3','sdfsadf','5138226081@qq.com','18583898767','1469932813');
DROP TABLE IF EXISTS  `qw_orders`;
CREATE TABLE `qw_orders` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` char(10) NOT NULL DEFAULT '',
  `companyname` varchar(100) DEFAULT NULL,
  `phonenum` char(12) NOT NULL,
  `total_fee` int(11) NOT NULL,
  `order_number` varchar(25) NOT NULL COMMENT '订单号',
  `ali_order_num` varchar(75) NOT NULL DEFAULT '' COMMENT '支付宝订单号',
  `order_version` varchar(30) NOT NULL COMMENT '订单类型',
  `t` int(10) unsigned NOT NULL COMMENT '时间',
  `n` tinyint(4) unsigned NOT NULL COMMENT '是否支付成功',
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_orders`(`oid`,`uname`,`companyname`,`phonenum`,`total_fee`,`order_number`,`ali_order_num`,`order_version`,`t`,`n`) values
('28','ouiouy',null,'erte','1','JK201607152357933','2016071521001004310232335014','300人以上版','1468548090','1'),
('29','uuuu',null,'safsafsa','1','JK201607157088284','2016071521001004310228511176','300人以上版','1468549886','1'),
('30','fdsfsdf','sadfasdfsd','fdsafsaf','1','JK201607159021215','2016071521001004310229770758','51-100人版','1468550609','1'),
('31','qerqwerew','ewrqwerqwe','rewqrqwr','1','JK201607154760162','2016071521001004310231056902','1-50人版','1468551327','1'),
('32','owerwqer','qweqweqwe','111111111','1','JK201607156670356','','300人以上版','1468552127','0'),
('33','wqrqwrwq','s2f1sd2f','12122','1','JK201607158106272','2016071521001004310226693868','51-100人版','1468552170','1'),
('34','3333','145646','123345','840000','JK201607157313394','','51-100人版','1468552727','0');
DROP TABLE IF EXISTS  `qw_live_orders`;
CREATE TABLE `qw_live_orders` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `gid` int(11) NOT NULL COMMENT '商品id',
  `total_fee` smallint(6) NOT NULL,
  `order_number` varchar(25) NOT NULL COMMENT '订单',
  `ali_order_num` varchar(75) NOT NULL DEFAULT '',
  `order_name` varchar(30) NOT NULL COMMENT '名称',
  `t` int(10) unsigned NOT NULL COMMENT '时间',
  `n` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否支付成功',
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_live_orders`(`oid`,`uid`,`gid`,`total_fee`,`order_number`,`ali_order_num`,`order_name`,`t`,`n`) values
('8','30','6','1','JK201607308898514','2016073021001004310228919475','qwrwqer','1469850479','1'),
('9','30','6','1','JK201607303128927','2016073021001004310229626718','qwrwqer','1469851295','1'),
('10','30','6','1','JK201607306758562','2016073021001004310230459744','qwrwqer','1469879111','1'),
('11','30','7','1','JK201607318176739','2016073121001004310229206185','上锁挂牌培训直播','1469931946','1'),
('12','30','5','1','JK201607318883421','2016073121001004310229017382','化学品安全培训 ','1469932233','1'),
('13','33','6','1','JK201607312402287','','办公安全培训直播','1469932829','0'),
('14','33','5','1','JK201607316663242','2016073121001004310228468157','化学品安全培训 ','1469933126','1');
DROP TABLE IF EXISTS  `qw_flash`;
CREATE TABLE `qw_flash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `pic` varchar(255) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `o` (`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS  `qw_course`;
CREATE TABLE `qw_course` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL COMMENT '分类id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `keywords` varchar(255) NOT NULL COMMENT '关键词',
  `description` varchar(255) NOT NULL COMMENT '摘要',
  `thumbnail` varchar(255) NOT NULL COMMENT '缩略图',
  `content` text NOT NULL COMMENT '内容',
  `courseurl` varchar(100) NOT NULL COMMENT '模板地址',
  `t` int(10) unsigned NOT NULL COMMENT '时间',
  `n` int(10) unsigned NOT NULL COMMENT '点击',
  `r` smallint(5) unsigned NOT NULL COMMENT '是否推荐',
  PRIMARY KEY (`aid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

insert into `qw_course`(`aid`,`sid`,`title`,`keywords`,`description`,`thumbnail`,`content`,`courseurl`,`t`,`n`,`r`) values
('7','8','垂直电梯安全 ','','垂直电梯安全 ','/Public/attached/201607/1469584504.jpg','现如今，电梯运用遍布都市人生活、工作的方方面面。电梯给我们带来便捷的同时也伴随着安全风险。要防止事故发生，不但要努力提升电梯安全系数，同时，也需要我们掌握安全乘坐电梯的知识。本课程将重点介绍垂直电梯的安全使用，为企业员工及其他人员安全使用电梯提供专业培训，以减少因电梯的使用不当带来的人员伤害。','/Public/courses/online/upload579816d51e/story_html5.html','1469585109','0','1'),
('8','8','受限空间','','test2','/Public/attached/201607/1469585527.jpg','描述
 很多企业特别是石油化工行业中的单位都会涉及到在受限空间中作业、维修，而受限空间通常存在缺氧、有毒气体等危害。作业人员由于缺乏相关安全知识以及风险识别，因此受限空间经常发生重特大事故。本课程主要讲述了受限空间的基本知识、作业风险、危险辨识、安全流程以及相关装备的使用方法，同时介绍了事故发生后的救援措施。通过本课程的学习，作业人员能够掌握进入受限空间作业时的安全知识和技能，减少事故的发生。
课时
在线学习：受限空间培训
课程主题：受限空间作业安全
课程时长：50分钟
目标学员：生产型企业的一线安全管理者、生产班组长、一线基层工人和承包商相关人员、动火作业管理、执行人员
课程知识点：','/Public/courses/online/upload5798188246/story_html5.html','1469585538','0','1'),
('9','8','员工作业安全意识养成培训 ','','员工作业安全意识养成培训 ','/Public/attached/201607/1469585554.jpg','员工作业安全意识养成培训 ','/Public/courses/online/upload57981897ae/story_html5.html','1469585559','0','0');
SET FOREIGN_KEY_CHECKS = 1;

