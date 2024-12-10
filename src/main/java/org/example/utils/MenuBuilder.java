package org.example.utils;

import org.example.model.response.Category;
import org.example.model.response.Menu;
import org.example.model.response.MenuItem;
import org.example.model.response.MenuResponse;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuBuilder {

    /**
     * Builds a MenuResponse object from the result set of menu data.
     *
     * @param resultSet The result set containing menu data.
     * @return A MenuResponse object.
     * @throws SQLException If an error occurs while processing the result set.
     */
    public static MenuResponse buildMenuResponse(ResultSet resultSet) throws SQLException {

        List<Menu> menus = new ArrayList<>();
        List<Category> categories = new ArrayList<>();
        List<MenuItem> items = new ArrayList<>();

        String restaurantName = null;
        String currentMenu = null;
        String currentCategory = null;

        // Iterate through the result set and build the menu structure
        while (resultSet.next()) {
            restaurantName = resultSet.getString("restaurant_name");
            String menuName = resultSet.getString("menu_name");
            String categoryName = resultSet.getString("category_name");

            // If a new menu is encountered, finalize the previous menu
            if (!menuName.equals(currentMenu)) {
                if (currentMenu != null) {
                    finalizeCategoryAndMenu(categories, items, currentCategory, menus, currentMenu);
                    currentCategory = null;
                }
                currentMenu = menuName;
            }

            // Check if the category has changed, finalize the current category
            if (!categoryName.equals(currentCategory)) {
                if (currentCategory != null) {
                    finalizeCategory(categories, items, currentCategory);
                }
                currentCategory = categoryName;
            }

            // Add the current menu item
            items.add(new MenuItem(
                    resultSet.getString("item_name"),
                    resultSet.getString("item_description"),
                    resultSet.getDouble("item_price"),
                    resultSet.getBoolean("item_is_vegetarian"),
                    resultSet.getBoolean("item_is_gluten_free"),
                    resultSet.getString("item_allergens"),
                    resultSet.getString("item_spice_level"),
                    resultSet.getDouble("item_calories"),
                    resultSet.getString("item_tags")
            ));
        }

        // Finalize the last category and menu after the loop
        if (currentCategory != null) finalizeCategory(categories, items, currentCategory);
        if (currentMenu != null) finalizeMenu(menus, categories, currentMenu);

        // return the final menu
        return new MenuResponse(restaurantName, menus);
    }

    /**
     * Finalize a category and add it to the list of categories.
     */
    private static void finalizeCategory(List<Category> categories, List<MenuItem> items, String categoryName) {
        categories.add(new Category(categoryName, List.copyOf(items)));
        items.clear();
    }

    /**
     * Finalize a menu and add it to the list of menu.
     */
    private static void finalizeMenu(List<Menu> menus, List<Category> categories, String menuName) {
        menus.add(new Menu(menuName, List.copyOf(categories)));
        categories.clear();
    }

    /**
     * Finalize the current category and menu before transitioning to a new one.
     */
    private static void finalizeCategoryAndMenu(
            List<Category> categories,
            List<MenuItem> items,
            String currentCategory,
            List<Menu> menus,
            String currentMenu
    ) {
        finalizeCategory(categories, items, currentCategory);
        finalizeMenu(menus, categories, currentMenu);
    }
}
