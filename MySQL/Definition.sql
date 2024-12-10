-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS flavourly_menu_db;

-- Use the created database
USE flavourly_menu_db;

-- Restaurant table: Stores basic information about restaurants
CREATE TABLE IF NOT EXISTS Restaurant (
                                          restaurant_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each restaurant
                                          name VARCHAR(255) NOT NULL, -- Name of the restaurant
                                          address TEXT NULL, -- Address details of the restaurant
                                          phone_number VARCHAR(20) NULL, -- Contact number
                                          email VARCHAR(255) NULL, -- Email address for communication
                                          website_url VARCHAR(255) NULL, -- Website link
                                          cuisine_type ENUM ('ITALIAN', 'MEXICAN', 'INDIAN', 'OTHER') NOT NULL, -- Type of cuisine served
                                          is_active TINYINT(1) DEFAULT 1 NULL, -- Indicates if the restaurant is operational
                                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, 
                                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
);

-- Menu table: Stores details of menus offered by restaurants
CREATE TABLE IF NOT EXISTS Menu (
                                    menu_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each menu
                                    restaurant_id INT NULL, -- Foreign key linking to the restaurant
                                    name VARCHAR(255) NOT NULL, -- Name of the menu
                                    description TEXT NULL, -- Brief description of the menu
                                    is_active TINYINT(1) DEFAULT 1 NULL, -- Indicates if the menu is currently active
                                    display_order INT NULL, -- Order of display in the UI
                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, 
                                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
                                    CONSTRAINT Menu_Restaurant_restaurant_id_fk FOREIGN KEY (restaurant_id) REFERENCES Restaurant (restaurant_id)
);

-- Menu_Category table: Represents categories within a menu
CREATE TABLE IF NOT EXISTS Menu_Category (
                                             category_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each category
                                             menu_id INT NULL, -- Foreign key linking to the menu
                                             name VARCHAR(255) NOT NULL, -- Name of the category
                                             display_order INT NOT NULL, -- Order of display within the menu
                                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, 
                                             updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
                                             CONSTRAINT menu_category_ibfk_2 FOREIGN KEY (menu_id) REFERENCES Menu (menu_id) ON DELETE CASCADE -- Cascade deletion to maintain referential integrity
);

-- Add index to optimize menu_id-based queries
CREATE INDEX menu_id ON Menu_Category (menu_id);

-- Menu_Item table: Stores individual menu items
CREATE TABLE IF NOT EXISTS Menu_Item (
                                         menu_item_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each menu item
                                         category_id INT NULL, -- Foreign key linking to the category
                                         name VARCHAR(255) NOT NULL, -- Name of the item
                                         description TEXT NULL, -- Description of the item
                                         price DECIMAL(10, 2) NOT NULL, -- Price of the item
                                         is_vegetarian TINYINT(1) DEFAULT 0 NULL, -- Indicates if the item is vegetarian
                                         is_gluten_free TINYINT(1) DEFAULT 0 NULL, -- Indicates if the item is gluten-free
                                         allergens JSON NULL, -- List of allergens in JSON format
                                         spice_level ENUM ('MILD', 'MEDIUM', 'HOT', 'VERY_HOT') DEFAULT 'MEDIUM' NULL, -- Spice level of the item
                                         calories DECIMAL(5, 2) NULL, -- Caloric content of the item
                                         is_active TINYINT(1) DEFAULT 1 NULL, -- Indicates if the item is currently active
                                         tags JSON NULL, -- Tags or additional metadata in JSON format
                                         display_order INT NOT NULL, -- Order of display within the category
                                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, 
                                         updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
                                         CONSTRAINT menu_item_ibfk_1 FOREIGN KEY (category_id) REFERENCES Menu_Category (category_id) ON DELETE CASCADE
);

-- Restaurant_Hours table: Stores opening and closing hours of restaurants
CREATE TABLE IF NOT EXISTS Restaurant_Hours (
                                                restaurant_hours_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for restaurant hours
                                                restaurant_id INT NULL, -- Foreign key linking to the restaurant
                                                day_of_week ENUM ('SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY') NULL, -- Day of the week
                                                opens_at TIME NULL, -- Opening time
                                                closes_at TIME NULL, -- Closing time
                                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, 
                                                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
                                                CONSTRAINT restaurant_hours_ibfk_1 FOREIGN KEY (restaurant_id) REFERENCES Restaurant (restaurant_id) ON DELETE CASCADE
);

-- User table: Stores user details and credentials
CREATE TABLE IF NOT EXISTS User (
                                    user_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for users
                                    username VARCHAR(255) NOT NULL, -- User's display name
                                    email VARCHAR(255) NOT NULL UNIQUE, -- Email used for login
                                    password_hash VARCHAR(255) NOT NULL, -- Hashed password for secure authentication
                                    role ENUM ('USER', 'ADMIN') DEFAULT 'USER' NULL, -- Role of the user
                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, 
                                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
);

-- Audit_Log table: Logs actions performed by users for auditing
CREATE TABLE IF NOT EXISTS Audit_Log (
                                         audit_log_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each log entry
                                         user_id INT NULL, -- Foreign key linking to the user who performed the action
                                         action TEXT NULL, -- Description of the action
                                         table_name VARCHAR(255) NULL, -- Table on which the action was performed
                                         action_type ENUM ('INSERT', 'UPDATE', 'DELETE') NULL, -- Type of action
                                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, 
                                         CONSTRAINT audit_log_ibfk_1 FOREIGN KEY (user_id) REFERENCES User (user_id) ON DELETE CASCADE
);

-- Menu_Item_Feedback table: Stores feedback for menu items
CREATE TABLE IF NOT EXISTS Menu_Item_Feedback (
                                                  feedback_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each feedback
                                                  menu_item_id INT NOT NULL, -- Foreign key linking to the menu item
                                                  user_id INT NOT NULL, -- Foreign key linking to the user
                                                  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- Rating with a constraint of 1 to 5
                                                  comments TEXT NULL, -- Additional comments by the user
                                                  feedback_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, -- Timestamp of feedback submission
                                                  CONSTRAINT menu_item_feedback_ibfk_1 FOREIGN KEY (menu_item_id) REFERENCES Menu_Item (menu_item_id) ON DELETE CASCADE,
                                                  CONSTRAINT menu_item_feedback_ibfk_2 FOREIGN KEY (user_id) REFERENCES User (user_id) ON DELETE CASCADE
);

-- Index to optimize category_id-based queries
CREATE INDEX idx_category_id ON Menu_Item (category_id);

-- Index to optimize restaurant_id-based queries
CREATE INDEX restaurant_id ON Restaurant_Hours (restaurant_id);

-- Indexes for optimizing feedback queries
CREATE INDEX idx_menu_item_id ON Menu_Item_Feedback (menu_item_id);
CREATE INDEX idx_user_id ON Menu_Item_Feedback (user_id);
