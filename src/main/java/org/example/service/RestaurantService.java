package org.example.service;

import org.example.dao.RestaurantInterface;
import org.example.model.response.MenuResponse;

public class RestaurantService {
    private final RestaurantInterface restaurantInterface;

    public RestaurantService(RestaurantInterface restaurantInterface) {
        this.restaurantInterface = restaurantInterface;
    }

    public MenuResponse getMenu(int restaurantId) {

        boolean isActiveRestaurant = restaurantInterface.findRestaurantById(restaurantId).isPresent();

        // if there is an active restaurant, return the menu otherwise throw an exception
        if (isActiveRestaurant) {
            return restaurantInterface.getMenuByRestaurantId(restaurantId)
                    .orElseThrow(() -> new RuntimeException("No menu found for restaurant ID " + restaurantId));
        } else {
            throw new RuntimeException("No active restaurant found for the given id " + restaurantId);
        }
    }
}