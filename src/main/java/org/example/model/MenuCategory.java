package org.example.model;

import java.time.LocalDateTime;
import java.util.ArrayList;

public record MenuCategory(
        int categoryId,
        int menuId,
        String name,
        int displayOrder,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        ArrayList<MenuItem> items
) {
}
