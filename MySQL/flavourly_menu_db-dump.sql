-- MySQL dump 10.13  Distrib 8.4.3, for macos14 (arm64)
--
-- Host: 127.0.0.1    Database: flavourly_menu_db
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Audit_Log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Audit_Log` (
  `audit_log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action` text,
  `table_name` varchar(255) DEFAULT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_log_id`),
  KEY `idx_table_name_audit_log` (`table_name`),
  KEY `idx_user_audit_log` (`user_id`),
  CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Audit_Log`
--

INSERT INTO `Audit_Log` (`audit_log_id`, `user_id`, `action`, `table_name`, `action_type`, `created_at`) VALUES (1,1,'Inserted a new restaurant: La Bella Cucina','Restaurant','INSERT','2024-12-08 15:53:47'),(2,1,'Updated restaurant hours for \"Spice Haven\"','Restaurant_Hours','UPDATE','2024-12-08 15:53:47'),(3,1,'Deleted a menu item: Alfredo Sauce Pasta','Menu_Item','DELETE','2024-12-08 15:53:47');

--
-- Table structure for table `Menu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `display_order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`menu_id`),
  KEY `Menu_Restaurant_restaurant_id_fk` (`restaurant_id`),
  CONSTRAINT `Menu_Restaurant_restaurant_id_fk` FOREIGN KEY (`restaurant_id`) REFERENCES `Restaurant` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Menu`
--

INSERT INTO `Menu` (`menu_id`, `restaurant_id`, `name`, `description`, `is_active`, `display_order`, `created_at`, `updated_at`) VALUES (1,1,'Breakfast Menu','Start your day with Italian delights.',1,1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(2,1,'Lunch Menu','Hearty Italian meals for the afternoon.',1,2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(3,1,'Dinner Menu','Elegant Italian dinners to end your day.',1,3,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(4,2,'Breakfast Menu','Spice up your morning with Mexican flavors.',1,1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(5,2,'Lunch Menu','Zesty Mexican dishes for your afternoon.',1,2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(6,2,'Dinner Menu','Mexican feasts for dinner.',1,3,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(7,3,'Breakfast Menu','Traditional Indian breakfasts to start your day.',1,1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(8,3,'Lunch Menu','Authentic Indian meals for lunch.',1,2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(9,3,'Dinner Menu','Rich and flavorful Indian dinners.',1,3,'2024-12-08 15:40:19','2024-12-08 15:40:19');

--
-- Table structure for table `Menu_Category`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Menu_Category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `menu_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `display_order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `menu_category_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `Menu` (`menu_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Menu_Category`
--

INSERT INTO `Menu_Category` (`category_id`, `menu_id`, `name`, `display_order`, `created_at`, `updated_at`) VALUES (1,1,'Hot Beverages',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(2,1,'Pastries',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(3,2,'Appetizers',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(4,2,'Main Course',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(5,3,'Starters',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(6,3,'Pastas',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(7,4,'Mexican Drinks',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(8,4,'Morning Bites',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(9,5,'Starters',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(10,5,'Tacos',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(11,6,'Nachos & More',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(12,6,'Sizzlers',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(13,7,'Indian Drinks',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(14,7,'Traditional Bites',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(15,8,'Appetizers',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(16,8,'Curries',2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(17,9,'Tandoori',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(18,9,'Desserts',2,'2024-12-08 15:40:19','2024-12-08 15:40:19');

--
-- Table structure for table `Menu_Item`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Menu_Item` (
  `menu_item_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `is_vegetarian` tinyint(1) DEFAULT '0',
  `is_gluten_free` tinyint(1) DEFAULT '0',
  `allergens` json DEFAULT NULL,
  `spice_level` enum('MILD','MEDIUM','HOT','VERY_HOT') DEFAULT 'MEDIUM',
  `calories` decimal(5,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `tags` json DEFAULT NULL,
  `display_order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`menu_item_id`),
  KEY `idx_category_id` (`category_id`),
  CONSTRAINT `menu_item_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Menu_Category` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Menu_Item`
--

INSERT INTO `Menu_Item` (`menu_item_id`, `category_id`, `name`, `description`, `price`, `is_vegetarian`, `is_gluten_free`, `allergens`, `spice_level`, `calories`, `is_active`, `tags`, `display_order`, `created_at`, `updated_at`) VALUES (1,1,'Cappuccino','Rich and creamy Italian coffee.',4.50,1,1,'{\"Milk\": true}','MILD',120.00,1,'{\"Recommended\": true}',1,'2024-12-08 15:40:19','2024-12-09 05:06:00'),(2,1,'Espresso','A shot of strong Italian coffee.',3.00,1,1,'{}','MILD',10.00,1,NULL,2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(3,1,'Latte','Smooth coffee with steamed milk.',4.00,1,1,'{\"Milk\": true}','MILD',150.00,1,NULL,3,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(4,2,'Croissant','Flaky and buttery pastry.',3.50,1,0,'{\"Gluten\": true}','MILD',150.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(5,3,'Cannoli','Sweet pastry with creamy filling.',4.00,1,0,'{\"Milk\": true, \"Gluten\": true}','MILD',200.00,1,NULL,2,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(6,4,'Panettone','Italian sweet bread with dried fruits.',5.50,1,0,'{\"Eggs\": true, \"Gluten\": true}','MILD',250.00,1,NULL,3,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(7,4,'Bruschetta','Toasted bread with fresh tomato topping.',6.00,1,0,'{\"Gluten\": true}','MILD',180.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(8,5,'Caprese Salad','Fresh tomatoes, mozzarella, and basil.',7.00,1,1,'{\"Milk\": true}','MILD',150.00,1,'{\"Recommended\": true}',2,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(9,6,'Spaghetti Carbonara','Classic pasta with creamy sauce.',12.00,0,0,'{\"Eggs\": true, \"Milk\": true, \"Gluten\": true}','MILD',400.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(10,4,'Margherita Pizza','Wood-fired pizza with tomato and basil.',10.00,1,0,'{\"Milk\": true, \"Gluten\": true}','MILD',500.00,1,NULL,2,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(11,4,'Lasagna','Layered pasta with meat and cheese.',14.00,0,0,'{\"Milk\": true, \"Gluten\": true}','MEDIUM',600.00,1,NULL,3,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(12,4,'Horchata','Sweet rice drink with cinnamon.',3.50,1,1,'{\"Nuts\": true}','MILD',200.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(13,7,'Mexican Hot Chocolate','Rich chocolate with spices.',4.00,1,1,'{\"Milk\": true}','MEDIUM',250.00,1,'{\"New\": true}',2,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(14,8,'Breakfast Burrito','Eggs, cheese, and beans in a tortilla.',7.50,1,0,'{\"Eggs\": true, \"Gluten\": true}','MEDIUM',300.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(15,9,'Huevos Rancheros','Eggs with salsa and tortillas.',8.00,1,0,'{\"Eggs\": true}','HOT',350.00,1,NULL,2,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(16,10,'Chilaquiles','Tortilla chips with green or red sauce.',9.00,1,0,'{\"Gluten\": true}','HOT',400.00,1,NULL,3,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(17,11,'Enchiladas','Corn tortillas stuffed and covered in sauce.',12.00,0,0,'{\"Gluten\": true}','HOT',400.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(18,12,'Fajita Platter','Sizzling grilled meat with vegetables.',14.50,0,1,'{\"Beef\": true}','HOT',600.00,1,NULL,2,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(19,12,'Churros','Fried dough with cinnamon and sugar.',5.00,1,0,'{\"Milk\": true, \"Gluten\": true}','MILD',350.00,1,NULL,3,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(20,13,'Masala Chai','Indian spiced tea.',2.50,1,1,'{\"Milk\": true}','MILD',80.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(21,14,'Aloo Paratha','Stuffed flatbread with potatoes.',5.00,1,0,'{\"Gluten\": true}','MEDIUM',300.00,1,'{\"Special\": true}',2,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(22,15,'Idli Sambar','Steamed rice cakes with lentil soup.',6.00,1,1,'{}','MILD',250.00,1,NULL,3,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(23,16,'Butter Chicken','Rich tomato-based chicken curry.',11.00,0,0,'{\"Milk\": true, \"Chicken\": true}','MEDIUM',400.00,1,NULL,1,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(24,16,'Dal Makhani','Creamy lentils cooked with spices.',8.00,1,0,'{\"Milk\": true}','MEDIUM',350.00,1,NULL,2,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(25,16,'Paneer Butter Masala','Soft cottage cheese in creamy tomato sauce.',9.00,1,0,'{\"Milk\": true}','MILD',300.00,1,NULL,3,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(26,17,'Tandoori Roti','Indian bread cooked in tandoor.',1.50,1,1,'{\"Gluten\": true}','MILD',100.00,1,'{\"Special\": true}',1,'2024-12-08 15:40:19','2024-12-10 04:20:08'),(27,18,'Gulab Jamun','Sweet dumplings soaked in syrup.',4.00,1,1,'{\"Milk\": true}','MILD',200.00,1,NULL,2,'2024-12-08 15:40:19','2024-12-10 04:20:08');

--
-- Table structure for table `Menu_Item_Feedback`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Menu_Item_Feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `menu_item_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int NOT NULL,
  `comments` text,
  `feedback_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  KEY `idx_menu_item_id` (`menu_item_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `menu_item_feedback_ibfk_1` FOREIGN KEY (`menu_item_id`) REFERENCES `Menu_Item` (`menu_item_id`) ON DELETE CASCADE,
  CONSTRAINT `menu_item_feedback_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_rating` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Menu_Item_Feedback`
--

INSERT INTO `Menu_Item_Feedback` (`feedback_id`, `menu_item_id`, `user_id`, `rating`, `comments`, `feedback_date`) VALUES (1,1,2,5,'Absolutely loved the Spaghetti Carbonara! Perfect balance of flavors.','2024-12-01 03:30:00'),(2,4,2,4,'The Tacos were good but could use a bit more spice.','2024-12-02 07:45:00'),(3,7,3,3,'The Butter Chicken was decent, but I expected more richness in the gravy.','2024-12-03 08:15:00'),(4,9,3,5,'Masala Dosa was crispy and flavorful, highly recommend!','2024-12-04 01:20:00');

--
-- Table structure for table `Restaurant`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Restaurant` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` text,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `cuisine_type` enum('ITALIAN','MEXICAN','INDIAN','OTHER') NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restaurant`
--

INSERT INTO `Restaurant` (`restaurant_id`, `name`, `address`, `phone_number`, `email`, `website_url`, `cuisine_type`, `is_active`, `created_at`, `updated_at`) VALUES (1,'Bella Italia','123 Main St, Melbourne','123456789','contact@bellaitalia.com','http://bellaitalia.com','ITALIAN',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(2,'Taco Fiesta','456 Elm St, Sydney','987654321','info@tacofiesta.com','http://tacofiesta.com','MEXICAN',1,'2024-12-08 15:40:19','2024-12-08 15:40:19'),(3,'Curry Delight','789 Maple St, Brisbane','456789123','hello@currydelight.com','http://currydelight.com','INDIAN',1,'2024-12-08 15:40:19','2024-12-08 15:40:19');

--
-- Table structure for table `Restaurant_Hours`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Restaurant_Hours` (
  `restaurant_hours_id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int DEFAULT NULL,
  `day_of_week` enum('SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY') DEFAULT NULL,
  `opens_at` time DEFAULT NULL,
  `closes_at` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`restaurant_hours_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `restaurant_hours_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `Restaurant` (`restaurant_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restaurant_Hours`
--

INSERT INTO `Restaurant_Hours` (`restaurant_hours_id`, `restaurant_id`, `day_of_week`, `opens_at`, `closes_at`, `created_at`, `updated_at`) VALUES (1,1,'MONDAY','10:00:00','22:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(2,1,'TUESDAY','02:00:00','22:00:00','2024-12-08 16:01:52','2024-12-09 15:23:57'),(3,1,'WEDNESDAY','10:00:00','22:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(4,1,'THURSDAY','10:00:00','22:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(5,1,'FRIDAY','10:00:00','23:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(6,1,'SATURDAY','09:00:00','23:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(7,1,'SUNDAY','09:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(8,2,'MONDAY','16:00:00','21:00:00','2024-12-08 16:01:52','2024-12-09 04:33:23'),(9,2,'TUESDAY','11:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(10,2,'WEDNESDAY','11:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(11,2,'THURSDAY','11:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(12,2,'FRIDAY','11:00:00','22:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(13,2,'SATURDAY','10:00:00','22:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(14,2,'SUNDAY','10:00:00','20:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(15,3,'MONDAY','09:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(16,3,'TUESDAY','09:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(17,3,'WEDNESDAY','09:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(18,3,'THURSDAY','09:00:00','21:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(19,3,'FRIDAY','09:00:00','22:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(20,3,'SATURDAY','09:00:00','22:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52'),(21,3,'SUNDAY','10:00:00','20:00:00','2024-12-08 16:01:52','2024-12-08 16:01:52');

--
-- Table structure for table `User`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('USER','ADMIN') DEFAULT 'USER',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`user_id`, `username`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (1,'admin_user','admin@example.com','hashed_admin_password','ADMIN','2024-12-08 15:53:47','2024-12-08 15:53:47'),(2,'john_doe','john.doe@example.com','hashed_password1','USER','2024-12-08 15:53:47','2024-12-08 15:53:47'),(3,'alex_chef','alex.chef@example.com','hashed_password2','USER','2024-12-08 15:53:47','2024-12-08 15:53:47');
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-10 15:39:13
