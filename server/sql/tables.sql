-- ----------------------------
-- Table structure for `album`
-- ----------------------------
DROP TABLE IF EXISTS `album`;
CREATE TABLE `album` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `artist_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `keywords` TEXT, 
  `created` datetime NOT NULL,
  `checked` datetime NOT NULL,
  PRIMARY KEY (`album_id`, `artist_id`),
  FULLTEXT (keywords)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `artist`
-- ----------------------------
DROP TABLE IF EXISTS `artist`;
CREATE TABLE `artist` (
  `artist_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`artist_id`),
  CONSTRAINT unique_uri UNIQUE (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `album_region`
-- ----------------------------
DROP TABLE IF EXISTS `album_region`;
CREATE TABLE `album_region` (
  `album_id` int(11) NOT NULL,
  `region` varchar(9) NOT NULL,
  `created` datetime NOT NULL,
  `active` varchar(10) NOT NULL,
  PRIMARY KEY (`album_id`,`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `album_review`
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) NOT NULL,
  `feed_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `album_genre`
-- ----------------------------
DROP TABLE IF EXISTS `album_genre`;
CREATE TABLE `album_genre` (
  `album_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  PRIMARY KEY (`album_id`,`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -- ----------------------------
-- -- Table structure for `feed`
-- -- ----------------------------
-- DROP TABLE IF EXISTS `feed`;
-- CREATE TABLE `feed` (
--   `feed_id` int(11) NOT NULL AUTO_INCREMENT,
--   `name` varchar(255) NOT NULL,
--   `slug` varchar(255) NOT NULL,
--   `homepage_url` varchar(255) NOT NULL,
--   `module` varchar(40) NOT NULL,
--   `active` tinyint(4) NOT NULL DEFAULT '1',
--   `public` tinyint(4) NOT NULL DEFAULT '1',
--   PRIMARY KEY (`feed_id`),
--   CONSTRAINT unique_slug UNIQUE (`slug`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;