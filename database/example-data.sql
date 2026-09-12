-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: dpress_dev
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dp_auth_attempt`
--

DROP TABLE IF EXISTS `dp_auth_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_auth_attempt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scope` varchar(32) NOT NULL,
  `key_hash` char(64) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_scope_key_hash_created_at` (`scope`,`key_hash`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_auth_attempt`
--

LOCK TABLES `dp_auth_attempt` WRITE;
/*!40000 ALTER TABLE `dp_auth_attempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `dp_auth_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_block`
--

DROP TABLE IF EXISTS `dp_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_block` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `place` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(100) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT 0,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `settings` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_place` (`place`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_block`
--

LOCK TABLES `dp_block` WRITE;
/*!40000 ALTER TABLE `dp_block` DISABLE KEYS */;
INSERT INTO `dp_block` VALUES (1,'category_list','footer','Categories',0,1,'[]'),(2,'markdown','footer','Support',1,1,'{\"markdown\":\"If this was useful, [buy me a coffee](https:\\/\\/ko-fi.com\\/).\",\"html\":\"<p>If this was useful, <a href=\\\"https:\\/\\/ko-fi.com\\/\\\">buy me a coffee<\\/a>.<\\/p>\\n\"}'),(3,'tag_cloud','sidebar','Tags',0,1,'{\"limit\":\"20\"}'),(4,'category_list','sidebar','Categories',1,1,'[]'),(5,'markdown','sidebar','About this site',2,1,'{\"markdown\":\"A **markdown** block: whatever you write, beside the content.\\r\\n\\r\\nIt is the same markdown as everywhere else, so `media#12`, [internal links](post#1) and\\r\\nshortcodes all work in here.\",\"html\":\"<p>A <strong>markdown<\\/strong> block: whatever you write, beside the content.<\\/p>\\n<p>It is the same markdown as everywhere else, so <code>media#12<\\/code>, <a href=\\\"http:\\/\\/localhost\\/dynart-dpress-app\\/public\\/post\\/welcome-to-dpress\\\">internal links<\\/a> and\\nshortcodes all work in here.<\\/p>\\n\"}'),(6,'markdown','home_top','',0,1,'{\"markdown\":\"Welcome. This block sits in `home_top`, a place only the front page\'s layout renders, so it is on this page and on no other.\",\"html\":\"<p>Welcome. This block sits in <code>home_top<\\/code>, a place only the front page\'s layout renders, so it is on this page and on no other.<\\/p>\\n\"}');
/*!40000 ALTER TABLE `dp_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_category`
--

DROP TABLE IF EXISTS `dp_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `thumbnail_media_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` longtext DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_slug` (`slug`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_category`
--

LOCK TABLES `dp_category` WRITE;
/*!40000 ALTER TABLE `dp_category` DISABLE KEYS */;
INSERT INTO `dp_category` VALUES (1,NULL,NULL,'News','news',NULL,0),(2,NULL,NULL,'Guides','guides',NULL,0),(3,2,NULL,'How to','how-to',NULL,0);
/*!40000 ALTER TABLE `dp_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_category_aud`
--

DROP TABLE IF EXISTS `dp_category_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_category_aud` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `thumbnail_media_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` longtext DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`id`,`rev_id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_category_aud`
--

LOCK TABLES `dp_category_aud` WRITE;
/*!40000 ALTER TABLE `dp_category_aud` DISABLE KEYS */;
INSERT INTO `dp_category_aud` VALUES (1,NULL,NULL,'News','news',NULL,0,2,'add'),(2,NULL,NULL,'Guides','guides',NULL,0,2,'add'),(3,2,NULL,'How to','how-to',NULL,0,2,'add');
/*!40000 ALTER TABLE `dp_category_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content`
--

DROP TABLE IF EXISTS `dp_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL DEFAULT 'post',
  `parent_id` int(11) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `featured_media_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `markdown` longtext NOT NULL,
  `lead_html` longtext DEFAULT NULL,
  `body_html` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'draft',
  `published_at` datetime DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_slug` (`slug`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_author_id` (`author_id`),
  KEY `idx_published_at` (`published_at`),
  KEY `idx_type_status_published_at` (`type`,`status`,`published_at`),
  KEY `featured_media_id` (`featured_media_id`),
  CONSTRAINT `dp_content_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `dp_user` (`id`),
  CONSTRAINT `dp_content_ibfk_2` FOREIGN KEY (`featured_media_id`) REFERENCES `dp_media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content`
--

LOCK TABLES `dp_content` WRITE;
/*!40000 ALTER TABLE `dp_content` DISABLE KEYS */;
INSERT INTO `dp_content` VALUES (1,'post',NULL,1,2,'Welcome to dpress!','welcome-to-dpress','This is the lead. Everything before the separator shows up in listings, and only that.\r\n\r\n---\r\n\r\n## And this is the body\r\n\r\nThe body is everything after the first line that is nothing but three dashes. A post with no\r\nseparator is all lead and no body, which is exactly what a short note is.\r\n\r\n{{ video(\'media#1\') }}\r\n\r\nMarkdown works as you would expect: **bold**, *italic*, `inline code` and [links](https://example.com).\r\n\r\n- a list item\r\n- another one\r\n\r\n> A blockquote, for good measure.\r\n\r\n> [!WARNING]\r\n> Do not do this on a live site.\r\n\r\n> [!DANGER]\r\n> Very dangerous.\r\n\r\n> [!INFO]\r\n> The setting is in **Settings → Code theme**.\r\n\r\n```php\r\n<?php\r\n\r\nclass ThisIsATest {\r\n\r\n    private int $test = 0;\r\n\r\n    public function __construct() {\r\n        $this->test = 1;\r\n    }\r\n}\r\n```','<p>This is the lead. Everything before the separator shows up in listings, and only that.</p>\n','<h2>And this is the body</h2>\n<p>The body is everything after the first line that is nothing but three dashes. A post with no\nseparator is all lead and no body, which is exactly what a short note is.</p><!--dpress-sc eyJuIjoidmlkZW8iLCJhIjpbIm1lZGlhIzEiXX0=-->\n<p>Markdown works as you would expect: <strong>bold</strong>, <em>italic</em>, <code>inline code</code> and <a href=\"https://example.com\">links</a>.</p>\n<ul>\n<li>a list item</li>\n<li>another one</li>\n</ul>\n<blockquote class=\"callout callout-quote\">\n<p>A blockquote, for good measure.</p>\n</blockquote>\n<blockquote class=\"callout callout-warning\">\n<p>Do not do this on a live site.</p>\n</blockquote>\n<blockquote class=\"callout callout-danger\">\n<p>Very dangerous.</p>\n</blockquote>\n<blockquote class=\"callout callout-info\">\n<p>The setting is in <strong>Settings → Code theme</strong>.</p>\n</blockquote>\n<pre class=\"language-php\" data-enlighter-language=\"php\">&lt;?php\n\nclass ThisIsATest {\n\n    private int $test = 0;\n\n    public function __construct() {\n        $this-&gt;test = 1;\n    }\n}\n</pre>\n','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:51'),(2,'post',NULL,2,NULL,'Árvíztűrő tükörfúrógép','arvizturo-tukorfurogep','Az ékezetes címekből is olvasható URL lesz, mert a slug az ékezeteket az alapbetűre képezi le.\r\n\r\n---\r\n\r\nEz a törzsszöveg. A cím slugja `arvizturo-tukorfurogep` lett, nem pedig kötőjelek sora.','<p>Az ékezetes címekből is olvasható URL lesz, mert a slug az ékezeteket az alapbetűre képezi le.</p>\n','<p>Ez a törzsszöveg. A cím slugja <code>arvizturo-tukorfurogep</code> lett, nem pedig kötőjelek sora.</p>\n','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50'),(3,'post',NULL,2,4,'A short note','a-short-note','No separator here, so the whole thing is the lead and there is no body.','<p>No separator here, so the whole thing is the lead and there is no body.</p>\n','','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50'),(4,'post',NULL,1,NULL,'Something unfinished','something-unfinished','A draft. Visitors get a 404; anybody who may edit posts can preview it.\n\n---\n\nStill being written.','<p>A draft. Visitors get a 404; anybody who may edit posts can preview it.</p>\n','<p>Still being written.</p>\n','draft',NULL,0,'2026-09-12 11:14:50','2026-09-12 11:14:50'),(5,'page',NULL,1,NULL,'About','about','About this site.\n\n---\n\nPages are hierarchical. This one has a child.','<p>About this site.</p>\n','<p>Pages are hierarchical. This one has a child.</p>\n','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50'),(6,'page',5,1,NULL,'Contact','contact','How to get in touch.','<p>How to get in touch.</p>\n','','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50');
/*!40000 ALTER TABLE `dp_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content_attachment`
--

DROP TABLE IF EXISTS `dp_content_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content_attachment` (
  `content_id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`content_id`,`media_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `dp_content_attachment_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `dp_content` (`id`),
  CONSTRAINT `dp_content_attachment_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `dp_media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content_attachment`
--

LOCK TABLES `dp_content_attachment` WRITE;
/*!40000 ALTER TABLE `dp_content_attachment` DISABLE KEYS */;
INSERT INTO `dp_content_attachment` VALUES (1,3,0),(1,4,0),(1,5,0);
/*!40000 ALTER TABLE `dp_content_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content_attachment_aud`
--

DROP TABLE IF EXISTS `dp_content_attachment_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content_attachment_aud` (
  `content_id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`content_id`,`media_id`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content_attachment_aud`
--

LOCK TABLES `dp_content_attachment_aud` WRITE;
/*!40000 ALTER TABLE `dp_content_attachment_aud` DISABLE KEYS */;
INSERT INTO `dp_content_attachment_aud` VALUES (1,3,0,2,'add'),(1,4,0,2,'add'),(1,5,0,2,'add');
/*!40000 ALTER TABLE `dp_content_attachment_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content_aud`
--

DROP TABLE IF EXISTS `dp_content_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content_aud` (
  `id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'post',
  `parent_id` int(11) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `featured_media_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `markdown` longtext NOT NULL,
  `lead_html` longtext DEFAULT NULL,
  `body_html` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'draft',
  `published_at` datetime DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`id`,`rev_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_author_id` (`author_id`),
  KEY `idx_published_at` (`published_at`),
  KEY `idx_type_status_published_at` (`type`,`status`,`published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content_aud`
--

LOCK TABLES `dp_content_aud` WRITE;
/*!40000 ALTER TABLE `dp_content_aud` DISABLE KEYS */;
INSERT INTO `dp_content_aud` VALUES (1,'post',NULL,1,2,'Welcome to dpress','welcome-to-dpress','This is the lead. Everything before the separator shows up in listings, and only that.\r\n\r\n---\r\n\r\n## And this is the body\r\n\r\nThe body is everything after the first line that is nothing but three dashes. A post with no\r\nseparator is all lead and no body, which is exactly what a short note is.\r\n\r\n{{ video(\'media#1\') }}\r\n\r\nMarkdown works as you would expect: **bold**, *italic*, `inline code` and [links](https://example.com).\r\n\r\n- a list item\r\n- another one\r\n\r\n> A blockquote, for good measure.\r\n\r\n> [!WARNING]\r\n> Do not do this on a live site.\r\n\r\n> [!DANGER]\r\n> Very dangerous.\r\n\r\n> [!INFO]\r\n> The setting is in **Settings → Code theme**.\r\n\r\n```php\r\n<?php\r\n\r\nclass ThisIsATest {\r\n\r\n    private int $test = 0;\r\n\r\n    public function __construct() {\r\n        $this->test = 1;\r\n    }\r\n}\r\n```','<p>This is the lead. Everything before the separator shows up in listings, and only that.</p>\n','<h2>And this is the body</h2>\n<p>The body is everything after the first line that is nothing but three dashes. A post with no\nseparator is all lead and no body, which is exactly what a short note is.</p><!--dpress-sc eyJuIjoidmlkZW8iLCJhIjpbIm1lZGlhIzEiXX0=-->\n<p>Markdown works as you would expect: <strong>bold</strong>, <em>italic</em>, <code>inline code</code> and <a href=\"https://example.com\">links</a>.</p>\n<ul>\n<li>a list item</li>\n<li>another one</li>\n</ul>\n<blockquote class=\"callout callout-quote\">\n<p>A blockquote, for good measure.</p>\n</blockquote>\n<blockquote class=\"callout callout-warning\">\n<p>Do not do this on a live site.</p>\n</blockquote>\n<blockquote class=\"callout callout-danger\">\n<p>Very dangerous.</p>\n</blockquote>\n<blockquote class=\"callout callout-info\">\n<p>The setting is in <strong>Settings → Code theme</strong>.</p>\n</blockquote>\n<pre class=\"language-php\" data-enlighter-language=\"php\">&lt;?php\n\nclass ThisIsATest {\n\n    private int $test = 0;\n\n    public function __construct() {\n        $this-&gt;test = 1;\n    }\n}\n</pre>\n','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:51',2,'mod'),(1,'post',NULL,1,2,'Welcome to dpress!','welcome-to-dpress','This is the lead. Everything before the separator shows up in listings, and only that.\r\n\r\n---\r\n\r\n## And this is the body\r\n\r\nThe body is everything after the first line that is nothing but three dashes. A post with no\r\nseparator is all lead and no body, which is exactly what a short note is.\r\n\r\n{{ video(\'media#1\') }}\r\n\r\nMarkdown works as you would expect: **bold**, *italic*, `inline code` and [links](https://example.com).\r\n\r\n- a list item\r\n- another one\r\n\r\n> A blockquote, for good measure.\r\n\r\n> [!WARNING]\r\n> Do not do this on a live site.\r\n\r\n> [!DANGER]\r\n> Very dangerous.\r\n\r\n> [!INFO]\r\n> The setting is in **Settings → Code theme**.\r\n\r\n```php\r\n<?php\r\n\r\nclass ThisIsATest {\r\n\r\n    private int $test = 0;\r\n\r\n    public function __construct() {\r\n        $this->test = 1;\r\n    }\r\n}\r\n```','<p>This is the lead. Everything before the separator shows up in listings, and only that.</p>\n','<h2>And this is the body</h2>\n<p>The body is everything after the first line that is nothing but three dashes. A post with no\nseparator is all lead and no body, which is exactly what a short note is.</p><!--dpress-sc eyJuIjoidmlkZW8iLCJhIjpbIm1lZGlhIzEiXX0=-->\n<p>Markdown works as you would expect: <strong>bold</strong>, <em>italic</em>, <code>inline code</code> and <a href=\"https://example.com\">links</a>.</p>\n<ul>\n<li>a list item</li>\n<li>another one</li>\n</ul>\n<blockquote class=\"callout callout-quote\">\n<p>A blockquote, for good measure.</p>\n</blockquote>\n<blockquote class=\"callout callout-warning\">\n<p>Do not do this on a live site.</p>\n</blockquote>\n<blockquote class=\"callout callout-danger\">\n<p>Very dangerous.</p>\n</blockquote>\n<blockquote class=\"callout callout-info\">\n<p>The setting is in <strong>Settings → Code theme</strong>.</p>\n</blockquote>\n<pre class=\"language-php\" data-enlighter-language=\"php\">&lt;?php\n\nclass ThisIsATest {\n\n    private int $test = 0;\n\n    public function __construct() {\n        $this-&gt;test = 1;\n    }\n}\n</pre>\n','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:51',3,'mod'),(2,'post',NULL,2,NULL,'Árvíztűrő tükörfúrógép','arvizturo-tukorfurogep','Az ékezetes címekből is olvasható URL lesz, mert a slug az ékezeteket az alapbetűre képezi le.\r\n\r\n---\r\n\r\nEz a törzsszöveg. A cím slugja `arvizturo-tukorfurogep` lett, nem pedig kötőjelek sora.','<p>Az ékezetes címekből is olvasható URL lesz, mert a slug az ékezeteket az alapbetűre képezi le.</p>\n','<p>Ez a törzsszöveg. A cím slugja <code>arvizturo-tukorfurogep</code> lett, nem pedig kötőjelek sora.</p>\n','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add'),(3,'post',NULL,2,4,'A short note','a-short-note','No separator here, so the whole thing is the lead and there is no body.','<p>No separator here, so the whole thing is the lead and there is no body.</p>\n','','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50',2,'mod'),(4,'post',NULL,1,NULL,'Something unfinished','something-unfinished','A draft. Visitors get a 404; anybody who may edit posts can preview it.\n\n---\n\nStill being written.','<p>A draft. Visitors get a 404; anybody who may edit posts can preview it.</p>\n','<p>Still being written.</p>\n','draft',NULL,0,'2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add'),(5,'page',NULL,1,NULL,'About','about','About this site.\n\n---\n\nPages are hierarchical. This one has a child.','<p>About this site.</p>\n','<p>Pages are hierarchical. This one has a child.</p>\n','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add'),(6,'page',5,1,NULL,'Contact','contact','How to get in touch.','<p>How to get in touch.</p>\n','','published','2026-09-12 11:14:50',0,'2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add');
/*!40000 ALTER TABLE `dp_content_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content_category`
--

DROP TABLE IF EXISTS `dp_content_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content_category` (
  `content_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `dp_content_category_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `dp_content` (`id`),
  CONSTRAINT `dp_content_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `dp_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content_category`
--

LOCK TABLES `dp_content_category` WRITE;
/*!40000 ALTER TABLE `dp_content_category` DISABLE KEYS */;
INSERT INTO `dp_content_category` VALUES (1,1),(2,3),(3,1);
/*!40000 ALTER TABLE `dp_content_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content_category_aud`
--

DROP TABLE IF EXISTS `dp_content_category_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content_category_aud` (
  `content_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`content_id`,`category_id`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content_category_aud`
--

LOCK TABLES `dp_content_category_aud` WRITE;
/*!40000 ALTER TABLE `dp_content_category_aud` DISABLE KEYS */;
INSERT INTO `dp_content_category_aud` VALUES (1,1,2,'add'),(2,3,2,'add'),(3,1,2,'add');
/*!40000 ALTER TABLE `dp_content_category_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content_tag`
--

DROP TABLE IF EXISTS `dp_content_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content_tag` (
  `content_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `dp_content_tag_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `dp_content` (`id`),
  CONSTRAINT `dp_content_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `dp_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content_tag`
--

LOCK TABLES `dp_content_tag` WRITE;
/*!40000 ALTER TABLE `dp_content_tag` DISABLE KEYS */;
INSERT INTO `dp_content_tag` VALUES (1,1),(1,2),(1,3),(1,4),(2,2),(3,1);
/*!40000 ALTER TABLE `dp_content_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_content_tag_aud`
--

DROP TABLE IF EXISTS `dp_content_tag_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_content_tag_aud` (
  `content_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`content_id`,`tag_id`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_content_tag_aud`
--

LOCK TABLES `dp_content_tag_aud` WRITE;
/*!40000 ALTER TABLE `dp_content_tag_aud` DISABLE KEYS */;
INSERT INTO `dp_content_tag_aud` VALUES (1,1,2,'add'),(1,2,2,'add'),(1,3,2,'add'),(1,4,2,'add'),(2,2,2,'add'),(3,1,2,'add');
/*!40000 ALTER TABLE `dp_content_tag_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_media`
--

DROP TABLE IF EXISTS `dp_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `category` varchar(20) NOT NULL DEFAULT 'other',
  `size` int(11) NOT NULL DEFAULT 0,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `alt` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `caption` longtext DEFAULT NULL,
  `uploaded_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_path` (`path`),
  KEY `idx_category` (`category`),
  KEY `idx_uploaded_by` (`uploaded_by`),
  KEY `idx_deleted_at` (`deleted_at`),
  CONSTRAINT `dp_media_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `dp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_media`
--

LOCK TABLES `dp_media` WRITE;
/*!40000 ALTER TABLE `dp_media` DISABLE KEYS */;
INSERT INTO `dp_media` VALUES (1,'2026/09/fox-892cd6.mp4','Fox.mp4','video/mp4','video',575872,NULL,NULL,'Example Fox',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL),(2,'2026/09/sunset-photo-cedbb3.jpg','Sunset Photo.jpg','image/jpeg','image',24991,1200,800,'Example Sunset Photo',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL),(3,'2026/09/icon-2b1f51.svg','icon.svg','image/svg+xml','image',113,NULL,NULL,'Example icon',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL),(4,'2026/09/logo-4e2656.png','logo.png','image/png','image',897,300,300,'Example logo',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL),(5,'2026/09/notes-d6c9f3.txt','notes.txt','text/plain','document',14,NULL,NULL,'Example notes',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL);
/*!40000 ALTER TABLE `dp_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_media_aud`
--

DROP TABLE IF EXISTS `dp_media_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_media_aud` (
  `id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `category` varchar(20) NOT NULL DEFAULT 'other',
  `size` int(11) NOT NULL DEFAULT 0,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `alt` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `caption` longtext DEFAULT NULL,
  `uploaded_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`id`,`rev_id`),
  KEY `idx_category` (`category`),
  KEY `idx_uploaded_by` (`uploaded_by`),
  KEY `idx_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_media_aud`
--

LOCK TABLES `dp_media_aud` WRITE;
/*!40000 ALTER TABLE `dp_media_aud` DISABLE KEYS */;
INSERT INTO `dp_media_aud` VALUES (1,'2026/09/fox-892cd6.mp4','Fox.mp4','video/mp4','video',575872,NULL,NULL,'Example Fox',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL,2,'add'),(2,'2026/09/sunset-photo-cedbb3.jpg','Sunset Photo.jpg','image/jpeg','image',24991,1200,800,'Example Sunset Photo',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL,2,'add'),(3,'2026/09/icon-2b1f51.svg','icon.svg','image/svg+xml','image',113,NULL,NULL,'Example icon',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL,2,'add'),(4,'2026/09/logo-4e2656.png','logo.png','image/png','image',897,300,300,'Example logo',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL,2,'add'),(5,'2026/09/notes-d6c9f3.txt','notes.txt','text/plain','document',14,NULL,NULL,'Example notes',NULL,NULL,1,'2026-09-12 11:14:50','2026-09-12 11:14:50',NULL,2,'add');
/*!40000 ALTER TABLE `dp_media_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_menu`
--

DROP TABLE IF EXISTS `dp_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `place` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_place` (`place`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_menu`
--

LOCK TABLES `dp_menu` WRITE;
/*!40000 ALTER TABLE `dp_menu` DISABLE KEYS */;
INSERT INTO `dp_menu` VALUES (1,'Main','main');
/*!40000 ALTER TABLE `dp_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_menu_item`
--

DROP TABLE IF EXISTS `dp_menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_menu_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `label` varchar(100) NOT NULL,
  `target_type` varchar(20) NOT NULL DEFAULT 'content',
  `target_id` int(11) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_menu_id` (`menu_id`),
  KEY `idx_parent_id` (`parent_id`),
  CONSTRAINT `dp_menu_item_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `dp_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_menu_item`
--

LOCK TABLES `dp_menu_item` WRITE;
/*!40000 ALTER TABLE `dp_menu_item` DISABLE KEYS */;
INSERT INTO `dp_menu_item` VALUES (1,1,NULL,'Home','home',NULL,NULL,0),(2,1,NULL,'About','content',5,NULL,1),(3,1,NULL,'News','category',1,NULL,2);
/*!40000 ALTER TABLE `dp_menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_migration_history`
--

DROP TABLE IF EXISTS `dp_migration_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_migration_history` (
  `version` varchar(191) NOT NULL,
  `applied_at` datetime NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_migration_history`
--

LOCK TABLES `dp_migration_history` WRITE;
/*!40000 ALTER TABLE `dp_migration_history` DISABLE KEYS */;
INSERT INTO `dp_migration_history` VALUES ('0001_create_schema','2026-09-12 11:14:50');
/*!40000 ALTER TABLE `dp_migration_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_refresh_token`
--

DROP TABLE IF EXISTS `dp_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_refresh_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `revoked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_token_hash` (`token_hash`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_expires_at` (`expires_at`),
  CONSTRAINT `dp_refresh_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_refresh_token`
--

LOCK TABLES `dp_refresh_token` WRITE;
/*!40000 ALTER TABLE `dp_refresh_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `dp_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_revision`
--

DROP TABLE IF EXISTS `dp_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_revision` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_revision`
--

LOCK TABLES `dp_revision` WRITE;
/*!40000 ALTER TABLE `dp_revision` DISABLE KEYS */;
INSERT INTO `dp_revision` VALUES (1,'2026-09-12 11:14:49',NULL),(2,'2026-09-12 11:14:50',NULL),(3,'2026-09-12 11:14:51','2');
/*!40000 ALTER TABLE `dp_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_role`
--

DROP TABLE IF EXISTS `dp_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `label` varchar(100) NOT NULL,
  `removable` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_role`
--

LOCK TABLES `dp_role` WRITE;
/*!40000 ALTER TABLE `dp_role` DISABLE KEYS */;
INSERT INTO `dp_role` VALUES (1,'admin','Administrator',0),(2,'reader','Reader',1),(3,'editor','Editor',1);
/*!40000 ALTER TABLE `dp_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_role_aud`
--

DROP TABLE IF EXISTS `dp_role_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_role_aud` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `label` varchar(100) NOT NULL,
  `removable` tinyint(1) NOT NULL DEFAULT 1,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`id`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_role_aud`
--

LOCK TABLES `dp_role_aud` WRITE;
/*!40000 ALTER TABLE `dp_role_aud` DISABLE KEYS */;
INSERT INTO `dp_role_aud` VALUES (1,'admin','Administrator',0,1,'add'),(2,'reader','Reader',1,1,'add'),(3,'editor','Editor',1,1,'add');
/*!40000 ALTER TABLE `dp_role_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_role_permission`
--

DROP TABLE IF EXISTS `dp_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_role_permission` (
  `role_id` int(11) NOT NULL,
  `permission` varchar(100) NOT NULL,
  PRIMARY KEY (`role_id`,`permission`),
  CONSTRAINT `dp_role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `dp_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_role_permission`
--

LOCK TABLES `dp_role_permission` WRITE;
/*!40000 ALTER TABLE `dp_role_permission` DISABLE KEYS */;
INSERT INTO `dp_role_permission` VALUES (3,'block.update'),(3,'block.view'),(3,'category.create'),(3,'category.update'),(3,'category.view'),(3,'content.history'),(3,'media.create'),(3,'media.delete'),(3,'media.update'),(3,'media.view'),(3,'menu.update'),(3,'menu.view'),(3,'page.update'),(3,'page.view'),(3,'post.create'),(3,'post.delete'),(3,'post.publish'),(3,'post.update'),(3,'post.view'),(3,'setting.view'),(3,'tag.create'),(3,'tag.delete'),(3,'tag.update'),(3,'tag.view'),(3,'user.view');
/*!40000 ALTER TABLE `dp_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_role_permission_aud`
--

DROP TABLE IF EXISTS `dp_role_permission_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_role_permission_aud` (
  `role_id` int(11) NOT NULL,
  `permission` varchar(100) NOT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`role_id`,`permission`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_role_permission_aud`
--

LOCK TABLES `dp_role_permission_aud` WRITE;
/*!40000 ALTER TABLE `dp_role_permission_aud` DISABLE KEYS */;
INSERT INTO `dp_role_permission_aud` VALUES (3,'block.update',1,'add'),(3,'block.view',1,'add'),(3,'category.create',1,'add'),(3,'category.update',1,'add'),(3,'category.view',1,'add'),(3,'content.history',1,'add'),(3,'media.create',1,'add'),(3,'media.delete',1,'add'),(3,'media.update',1,'add'),(3,'media.view',1,'add'),(3,'menu.update',1,'add'),(3,'menu.view',1,'add'),(3,'page.update',1,'add'),(3,'page.view',1,'add'),(3,'post.create',1,'add'),(3,'post.delete',1,'add'),(3,'post.publish',1,'add'),(3,'post.update',1,'add'),(3,'post.view',1,'add'),(3,'setting.view',1,'add'),(3,'tag.create',1,'add'),(3,'tag.delete',1,'add'),(3,'tag.update',1,'add'),(3,'tag.view',1,'add'),(3,'user.view',1,'add');
/*!40000 ALTER TABLE `dp_role_permission_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_setting`
--

DROP TABLE IF EXISTS `dp_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_setting` (
  `name` varchar(100) NOT NULL,
  `value` longtext DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_setting`
--

LOCK TABLES `dp_setting` WRITE;
/*!40000 ALTER TABLE `dp_setting` DISABLE KEYS */;
INSERT INTO `dp_setting` VALUES ('content_rendered_for','http://localhost/dynart-dpress-app/public','2026-09-12 11:14:50'),('registration_open','1','2026-09-12 11:14:51'),('site_icon','/favicon.png','2026-09-12 11:14:51'),('site_logo','/static/dpress-logo.svg','2026-09-12 11:14:51'),('site_name','dpress dev','2026-09-12 11:14:51');
/*!40000 ALTER TABLE `dp_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_setting_aud`
--

DROP TABLE IF EXISTS `dp_setting_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_setting_aud` (
  `name` varchar(100) NOT NULL,
  `value` longtext DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`name`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_setting_aud`
--

LOCK TABLES `dp_setting_aud` WRITE;
/*!40000 ALTER TABLE `dp_setting_aud` DISABLE KEYS */;
INSERT INTO `dp_setting_aud` VALUES ('content_rendered_for','http://localhost/dynart-dpress-app/public','2026-09-12 11:14:50',1,'add'),('registration_open','1','2026-09-12 11:14:51',2,'add'),('site_icon','/favicon.png','2026-09-12 11:14:51',2,'add'),('site_logo','/static/dpress-logo.svg','2026-09-12 11:14:51',2,'add'),('site_name','dpress dev','2026-09-12 11:14:51',2,'add');
/*!40000 ALTER TABLE `dp_setting_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_tag`
--

DROP TABLE IF EXISTS `dp_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_tag`
--

LOCK TABLES `dp_tag` WRITE;
/*!40000 ALTER TABLE `dp_tag` DISABLE KEYS */;
INSERT INTO `dp_tag` VALUES (1,'dpress','dpress'),(2,'markdown','markdown'),(3,'getting started','getting-started'),(4,'featured','featured');
/*!40000 ALTER TABLE `dp_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_tag_aud`
--

DROP TABLE IF EXISTS `dp_tag_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_tag_aud` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`id`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_tag_aud`
--

LOCK TABLES `dp_tag_aud` WRITE;
/*!40000 ALTER TABLE `dp_tag_aud` DISABLE KEYS */;
INSERT INTO `dp_tag_aud` VALUES (1,'dpress','dpress',2,'add'),(2,'markdown','markdown',2,'add'),(3,'getting started','getting-started',2,'add'),(4,'featured','featured',2,'add');
/*!40000 ALTER TABLE `dp_tag_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_user`
--

DROP TABLE IF EXISTS `dp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_email` (`email`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_user`
--

LOCK TABLES `dp_user` WRITE;
/*!40000 ALTER TABLE `dp_user` DISABLE KEYS */;
INSERT INTO `dp_user` VALUES (1,'admin@example.com','$2y$10$yHw1Jd08hO5oZAG0nWCSOumxyg5LIFgd1z46mC9UoM9TUdMu3YAZ6','Site Admin','active','2026-09-12 11:14:50','2026-09-12 11:14:50'),(2,'editor@example.com','$2y$10$CnXi/Lx0Um3sMJ1vBBCHY.u4m5GwEJ8yRQ4LtOprTJVZ430kGgKRq','Edit Everything','active','2026-09-12 11:14:50','2026-09-12 11:14:50'),(3,'reader@example.com','$2y$10$Oe5EaLURHTdCwQXg1ym5FOShK06zsF6csdT9WSoj6GhQXqmq/ceZC','Ray Reader','active','2026-09-12 11:14:50','2026-09-12 11:14:50'),(4,'pending@example.com','$2y$10$N9CFKjGqdT3.uPadwIVTHeAgRBHMOGRU9998LbwlSfhZQCkb.aw7m','Penny Pending','pending','2026-09-12 11:14:50','2026-09-12 11:14:50');
/*!40000 ALTER TABLE `dp_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_user_aud`
--

DROP TABLE IF EXISTS `dp_user_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_user_aud` (
  `id` int(11) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`id`,`rev_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_user_aud`
--

LOCK TABLES `dp_user_aud` WRITE;
/*!40000 ALTER TABLE `dp_user_aud` DISABLE KEYS */;
INSERT INTO `dp_user_aud` VALUES (1,'admin@example.com','$2y$10$yHw1Jd08hO5oZAG0nWCSOumxyg5LIFgd1z46mC9UoM9TUdMu3YAZ6','Site Admin','active','2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add'),(2,'editor@example.com','$2y$10$CnXi/Lx0Um3sMJ1vBBCHY.u4m5GwEJ8yRQ4LtOprTJVZ430kGgKRq','Edit Everything','active','2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add'),(3,'reader@example.com','$2y$10$Oe5EaLURHTdCwQXg1ym5FOShK06zsF6csdT9WSoj6GhQXqmq/ceZC','Ray Reader','active','2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add'),(4,'pending@example.com','$2y$10$N9CFKjGqdT3.uPadwIVTHeAgRBHMOGRU9998LbwlSfhZQCkb.aw7m','Penny Pending','pending','2026-09-12 11:14:50','2026-09-12 11:14:50',2,'add');
/*!40000 ALTER TABLE `dp_user_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_user_role`
--

DROP TABLE IF EXISTS `dp_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `dp_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dp_user` (`id`),
  CONSTRAINT `dp_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `dp_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_user_role`
--

LOCK TABLES `dp_user_role` WRITE;
/*!40000 ALTER TABLE `dp_user_role` DISABLE KEYS */;
INSERT INTO `dp_user_role` VALUES (1,1),(2,3),(3,2),(4,2);
/*!40000 ALTER TABLE `dp_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_user_role_aud`
--

DROP TABLE IF EXISTS `dp_user_role_aud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_user_role_aud` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `rev_id` bigint(20) NOT NULL,
  `rev_type` char(3) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`,`rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_user_role_aud`
--

LOCK TABLES `dp_user_role_aud` WRITE;
/*!40000 ALTER TABLE `dp_user_role_aud` DISABLE KEYS */;
INSERT INTO `dp_user_role_aud` VALUES (1,1,2,'add'),(2,3,2,'add'),(3,2,2,'add'),(4,2,2,'add');
/*!40000 ALTER TABLE `dp_user_role_aud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dp_user_token`
--

DROP TABLE IF EXISTS `dp_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dp_user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` varchar(32) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_token_hash` (`token_hash`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_type` (`type`),
  CONSTRAINT `dp_user_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dp_user_token`
--

LOCK TABLES `dp_user_token` WRITE;
/*!40000 ALTER TABLE `dp_user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `dp_user_token` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
