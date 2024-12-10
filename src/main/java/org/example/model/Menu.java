package org.example.model;

import java.time.LocalDateTime;
import java.util.List;

public record Menu(
        int menuId,
        int restaurantId,
        String name,
        String description,
        boolean isActive,
        int displayOrder,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        List<MenuCategory> categories
) {
}
