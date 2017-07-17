/*
SQLyog Enterprise - MySQL GUI v8.12 
MySQL - 5.5.5-10.1.21-MariaDB : Database - property
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`property` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `property`;

/*Table structure for table `agents` */

DROP TABLE IF EXISTS `agents`;

CREATE TABLE `agents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `found_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `agents_name_unique` (`name`),
  KEY `agents_found_by_foreign` (`found_by`),
  CONSTRAINT `agents_found_by_foreign` FOREIGN KEY (`found_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `agents` */

insert  into `agents`(`id`,`name`,`address`,`phone`,`found_by`,`created_at`,`updated_at`) values (1,'Proper Local, E14','Proper Local, E14','020 3858 2655',1,'2017-05-25 07:36:28','2017-05-25 07:36:28');

/*Table structure for table `domains` */

DROP TABLE IF EXISTS `domains`;

CREATE TABLE `domains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domains_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `domains` */

insert  into `domains`(`id`,`name`,`created_at`,`updated_at`) values (1,'rightmove.co.uk','2017-05-25 07:36:28','2017-05-25 07:36:28');

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`migration`,`batch`) values ('2014_10_12_000000_create_users_table',1),('2014_10_12_100000_create_password_resets_table',1),('2017_05_06_185549_create_domains_table',1),('2017_05_24_004853_create_agent_table',1),('2017_05_24_005741_create_properties_table',1),('2017_05_24_011143_create_property_histories_table',1);

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `properties` */

DROP TABLE IF EXISTS `properties`;

CREATE TABLE `properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL,
  `ref` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `properties_domain_id_foreign` (`domain_id`),
  KEY `properties_created_by_foreign` (`created_by`),
  KEY `properties_updated_by_foreign` (`updated_by`),
  CONSTRAINT `properties_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `properties_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`),
  CONSTRAINT `properties_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `properties` */

insert  into `properties`(`id`,`domain_id`,`ref`,`created_by`,`updated_by`,`created_at`,`updated_at`) values (1,1,'59024290',1,1,'2017-05-25 07:36:28','2017-05-25 07:36:28');

/*Table structure for table `property_histories` */

DROP TABLE IF EXISTS `property_histories`;

CREATE TABLE `property_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` int(10) unsigned NOT NULL,
  `agent_id` int(10) unsigned NOT NULL,
  `price` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `currency` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `price_data` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address/subtitle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `features` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `property_histories_property_id_foreign` (`property_id`),
  KEY `property_histories_agent_id_foreign` (`agent_id`),
  KEY `property_histories_created_by_foreign` (`created_by`),
  KEY `property_histories_updated_by_foreign` (`updated_by`),
  CONSTRAINT `property_histories_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`),
  CONSTRAINT `property_histories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `property_histories_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `property_histories_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `property_histories` */

insert  into `property_histories`(`id`,`property_id`,`agent_id`,`price`,`currency`,`price_data`,`title`,`address/subtitle`,`features`,`description`,`status`,`created_by`,`updated_by`,`created_at`,`updated_at`) values (1,1,1,'£664,000','','','1 bedroom flat for sales','London City Island,','One bedroom\n548 sq ft\n10th floor, east facing\nOff-plan sale\nWater views\nOn-site grocer and residents\' lounge\nGym, pool and 24 hour concierge\nCompletion Q4 2018-Q1 2019','Full description\n	An off-plan one bedroom apartment at London City Island - the Capital\'s mini Manhattan.\n\nSituated on the 10th floor of Dawsonne House, this east-facing apartment will benefit from great views over the River Lea towards the Thames. Arranged over 548 sq ft, accommodation comprises reception room with floor-to-ceiling windows, open-plan to a stylish kitchen, one double bedroom and a bathroom with Jack and Jill doors. A balcony runs from the reception.\n\nAll of the Island\'s residents become members of the City Island Arts Club, including the use of a 24 hour concierge and extensive clubhouse with pool table, gymnasium, spa, treatment rooms, swimming pool, on-site grocer & deli. On completion London City Island will also be home to English National Ballet and the London Film School.\n\nLondon City Island connects directly to Canning Town station via a newly-built footbridge and opens up the capital - east, central and west - via the DLR or Jubilee line. Directly-accessible destinations include Canary Wharf (4 mins), London Bridge (10 mins), Westminster (15 mins), Bond Street (20 mins), Stratford (7 mins) and London City Airport (7 mins).\n\nCompletion Q4 2018 - Q1 2019.\n\nPhotos shown are an indication of specification only.\n\nPredicted EPC: B','',1,1,'2017-05-25 07:36:28','2017-05-25 07:36:28'),(2,1,1,'£650,000','','','1 bedroom flat for sale','London City','One bedroom\n548 sq ft\n10th floor, east facing\nOff-plan sale\nWater views\nOn-site grocer and residents\' lounge\nGym, pool and 24 hour concierge\nCompletion Q4 2018-Q1 2019','Full description\n	An off-plan one bedroom apartment at London City Island - the Capital\'s mini Manhattan.\n\nSituated on the 10th floor of Dawsonne House, this east-facing apartment will benefit from great views over the River Lea towards the Thames. Arranged over 548 sq ft, accommodation comprises reception room with floor-to-ceiling windows, open-plan to a stylish kitchen, one double bedroom and a bathroom with Jack and Jill doors. A balcony runs from the reception.\n\nAll of the Island\'s residents become members of the City Island Arts Club, including the use of a 24 hour concierge and extensive clubhouse with pool table, gymnasium, spa, treatment rooms, swimming pool, on-site grocer & deli. On completion London City Island will also be home to English National Ballet and the London Film School.\n\nLondon City Island connects directly to Canning Town station via a newly-built footbridge and opens up the capital - east, central and west - via the DLR or Jubilee line. Directly-accessible destinations include Canary Wharf (4 mins), London Bridge (10 mins), Westminster (15 mins), Bond Street (20 mins), Stratford (7 mins) and London City Airport (7 mins).\n\nCompletion Q4 2018 - Q1 2019.\n\nPhotos shown are an indication of specification only.\n\nPredicted EPC: B','',1,1,'2017-05-25 07:38:57','2017-05-25 07:38:57'),(3,1,1,'£500,000','','','1 bedroom flat for sale','London City Island,','One bedroom\n548 sq ft\n10th floor, east facing\nOff-plan sale\nWater views\nOn-site grocer and residents\' lounge\nGym, pool and 24 hour concierge\nCompletion Q4 2018-Q1 2019','Full description\n	An off-plan one bedroom apartment at London City Island - the Capital\'s mini Manhattan.\n\nSituated on the 10th floor of Dawsonne House, this east-facing apartment will benefit from great views over the River Lea towards the Thames. Arranged over 548 sq ft, accommodation comprises reception room with floor-to-ceiling windows, open-plan to a stylish kitchen, one double bedroom and a bathroom with Jack and Jill doors. A balcony runs from the reception.\n\nAll of the Island\'s residents become members of the City Island Arts Club, including the use of a 24 hour concierge and extensive clubhouse with pool table, gymnasium, spa, treatment rooms, swimming pool, on-site grocer & deli. On completion London City Island will also be home to English National Ballet and the London Film School.\n\nLondon City Island connects directly to Canning Town station via a newly-built footbridge and opens up the capital - east, central and west - via the DLR or Jubilee line. Directly-accessible destinations include Canary Wharf (4 mins), London Bridge (10 mins), Westminster (15 mins), Bond Street (20 mins), Stratford (7 mins) and London City Airport (7 mins).\n\nCompletion Q4 2018 - Q1 2019.\n\nPhotos shown are an indication of specification only.\n\nPredicted EPC: B','',2,2,'2017-05-25 07:44:01','2017-05-25 07:44:01');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`password`,`remember_token`,`created_at`,`updated_at`) values (1,'Test User','test@test.com','$2y$10$m4jAMQPLuOlpy.2aibGVpOjiY7h7doEevXUAw/0OTEubFc9Ds/Nqy',NULL,'2017-05-25 07:36:04','2017-05-25 07:36:04'),(2,'Alex Richard','ecmascript.guru@gmail.com','$2y$10$RYla5pAQ063cHE4M9Za41uQGxK2jqheQ6Bggjrh0iUydF2L0DDYWe',NULL,'2017-05-25 07:43:14','2017-05-25 07:43:14');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
