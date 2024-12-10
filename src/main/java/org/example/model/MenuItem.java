package org.example.model;

import java.time.LocalDateTime;

public record MenuItem(
        int menuItemId,
        int categoryId,
        String name,
        String description,
        double price,
        boolean isVegetarian,
        boolean isGlutenFree,
        String allergens, // JSON formatted allergen info in DB e.g. {"Eggs": true, "Milk": true, "Gluten": true}
        SpiceLevel spiceLevel, // Could be an enum
        double calories,
        boolean isActive,
        String tags, // JSON formatted extra information related to menuItem e.g. {"PromotionText": "Chef Special"}
        int displayOrder,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    enum SpiceLevel {
        Mild, Medium, Spicy, ExtraSpicy;
    }
}
