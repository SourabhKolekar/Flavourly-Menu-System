package org.example.dao;

import org.example.model.response.MenuResponse;
import org.example.model.response.RestaurantResponse;
import org.example.utils.DatabaseUtil;
import org.example.utils.MenuBuilder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Optional;

public class RestaurantInterfaceImpl implements RestaurantInterface {

    @Override
    public Optional<RestaurantResponse> findRestaurantById(int restaurantId) {
        String query = """
                    SELECT r.name AS restaurant_name
                    FROM Restaurant r 
                    JOIN Restaurant_Hours rh ON r.restaurant_id = rh.restaurant_id
                    WHERE r.restaurant_id = ?
                        AND r.is_active = 1
                        AND LOWER(rh.day_of_week) = DAYNAME(CURDATE())
                        AND rh.opens_at < CURTIME()
                        AND rh.closes_at > CURTIME()
                """;

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String restaurantName = resultSet.getString("restaurant_name");
                    return Optional.of(new RestaurantResponse(restaurantName));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving restaurant details", e);
        }

        return Optional.empty();
    }

    @Override
    public Optional<MenuResponse> getMenuByRestaurantId(int restaurantId) {
        String query = """
                    SELECT
                        r.name AS restaurant_name,
                        m.name AS menu_name,
                        mc.name AS category_name,
                        mi.name AS item_name,
                        mi.description AS item_description,
                        mi.price AS item_price,
                        mi.is_vegetarian AS item_is_vegetarian,
                        mi.is_gluten_free AS item_is_gluten_free,
                        mi.allergens AS item_allergens,
                        mi.spice_level AS item_spice_level,
                        mi.calories AS item_calories,
                        mi.tags AS item_tags
                    FROM
                        Restaurant r
                    JOIN
                        Menu m ON r.restaurant_id = m.restaurant_id
                    JOIN
                        Menu_Category mc ON m.menu_id = mc.menu_id
                    JOIN
                        Menu_Item mi ON mc.category_id = mi.category_id
                    WHERE
                        r.restaurant_id = ? AND mi.is_active = 1
                    ORDER BY
                        m.display_order, mc.display_order, mi.display_order;
                """;

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {
                // Delegate the menu-building process to the helper class
                return Optional.of(MenuBuilder.buildMenuResponse(resultSet));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving menu", e);
        }
    }
}
