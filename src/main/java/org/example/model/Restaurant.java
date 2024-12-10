package org.example.model;

import java.time.LocalDateTime;
import java.util.List;

public record Restaurant(
        int restaurantId,
        String name,
        String address,
        String phoneNumber,
        String email,
        String websiteUrl,
        CuisineType cuisineType,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        List<Menu> menus,
        List<RestaurantHours> hours
) {
    public enum CuisineType {
        ITALIAN, MEXICAN, INDIAN, OTHER
    }
}