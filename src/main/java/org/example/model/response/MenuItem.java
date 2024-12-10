package org.example.model.response;

public record MenuItem(
        String name,
        String description,
        Double price,
        boolean isVegetarian,
        boolean isGlutenFree,
        String allergens,
        String spiceLevel,
        Double calories,
        String tags
) {
}
