package org.example.dao;

import org.example.model.response.MenuResponse;
import org.example.model.response.RestaurantResponse;

import java.util.Optional;

/**
 * Data Access Object interface for Restaurant operations.
 * Defines contract for database interactions with Restaurant entities.
 */
public interface RestaurantInterface {
    /**
     * Retrieves a restaurant by its unique identifier.
     *
     * @param restaurantId Unique identifier for the restaurant
     * @return Optional containing the Restaurant if found
     */
    Optional<RestaurantResponse> findRestaurantById(int restaurantId);

    /**
     * Retrieves a restaurant menu by its unique identifier.
     *
     * @param restaurantId Unique identifier for the restaurant
     * @return Optional containing the Restaurant menu
     */
    Optional<MenuResponse> getMenuByRestaurantId(int restaurantId);
}