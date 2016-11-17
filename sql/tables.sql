-- ----------------------------
-- Table structure for `feed`
-- ----------------------------
DROP TABLE IF EXISTS `feed`;
CREATE TABLE `feed` (
  `feed_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `homepage_url` varchar(255) NOT NULL,
  `module` varchar(40) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `public` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`feed_id`),
  CONSTRAINT unique_slug UNIQUE (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;