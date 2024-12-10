package unit;

import org.example.dao.RestaurantInterfaceImpl;
import org.example.model.response.Menu;
import org.example.model.response.MenuResponse;
import org.example.utils.DatabaseUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.anyString;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class RestaurantInterfaceImplTest {

    private RestaurantInterfaceImpl restaurantInterface;

    @Mock
    private Connection connection;
    @Mock
    private PreparedStatement statement;
    @Mock
    private ResultSet resultSet;

    @BeforeEach
    void setUp() {
        restaurantInterface = new RestaurantInterfaceImpl();
    }

    @Test
    void testGetMenuByRestaurantIdWhenMenuExists() throws Exception {
        try (MockedStatic<DatabaseUtil> mockedStatic = mockStatic(DatabaseUtil.class)) {
            // Mock static method
            mockedStatic.when(DatabaseUtil::getConnection).thenReturn(connection);

            // Mock the SQL result
            when(connection.prepareStatement(anyString())).thenReturn(statement);
            when(statement.executeQuery()).thenReturn(resultSet);

            // Mock the result set to return valid data for the menu
            when(resultSet.next()).thenReturn(true).thenReturn(false);  // First call returns true, second returns false (end of result)
            when(resultSet.getString("restaurant_name")).thenReturn("Test Restaurant");
            when(resultSet.getString("menu_name")).thenReturn("Lunch Menu");
            when(resultSet.getString("category_name")).thenReturn("Starters");
            when(resultSet.getString("item_name")).thenReturn("Spring Rolls");
            when(resultSet.getString("item_description")).thenReturn("Crispy spring rolls filled with vegetables");
            when(resultSet.getDouble("item_price")).thenReturn(5.99);
            when(resultSet.getBoolean("item_is_vegetarian")).thenReturn(true);
            when(resultSet.getBoolean("item_is_gluten_free")).thenReturn(false);
            when(resultSet.getString("item_allergens")).thenReturn("None");
            when(resultSet.getString("item_spice_level")).thenReturn("Mild");
            when(resultSet.getDouble("item_calories")).thenReturn(150.0);
            when(resultSet.getString("item_tags")).thenReturn("Vegan Friendly");

            // Call the method to retrieve the menu
            Optional<MenuResponse> menuResponse = restaurantInterface.getMenuByRestaurantId(1);

            // Assertions
            assertTrue(menuResponse.isPresent());
            MenuResponse menu = menuResponse.get();
            Menu firstMenu = menu.menu().get(0);
            assertEquals("Lunch Menu", firstMenu.name());
            assertEquals(1, firstMenu.categories().size());  // Assuming 1 category in the mocked result
            assertEquals("Starters", firstMenu.categories().get(0).name());
            assertEquals(1, firstMenu.categories().get(0).items().size());  // 1 item in the category
            assertEquals("Spring Rolls", firstMenu.categories().get(0).items().get(0).name());
            assertEquals(5.99, firstMenu.categories().get(0).items().get(0).price(), String.valueOf(0.01));
            assertTrue(firstMenu.categories().get(0).items().get(0).isVegetarian());
        }
    }

    @Test
    void testGetMenuByRestaurantIdWhenMenuDoesNotExist() throws Exception {
        try (MockedStatic<DatabaseUtil> mockedStatic = mockStatic(DatabaseUtil.class)) {
            // Mock static method
            mockedStatic.when(DatabaseUtil::getConnection).thenReturn(connection);

            // Mock the SQL result to simulate no menu data found
            when(connection.prepareStatement(anyString())).thenReturn(statement);
            when(statement.executeQuery()).thenReturn(resultSet);
            when(resultSet.next()).thenReturn(false);  // No rows returned

            // Call the method to retrieve the menu
            Optional<MenuResponse> menuResponse = restaurantInterface.getMenuByRestaurantId(1);

            // Assertions
            assertTrue(menuResponse.isPresent());
        }
    }

    @Test
    void testGetMenuByRestaurantIdThrowsExceptionOnSQLFailure() throws Exception {
        try (MockedStatic<DatabaseUtil> mockedStatic = mockStatic(DatabaseUtil.class)) {
            // Mock static method
            mockedStatic.when(DatabaseUtil::getConnection).thenReturn(connection);

            // Simulate an SQL exception while preparing the statement
            when(connection.prepareStatement(anyString())).thenThrow(new RuntimeException("Database error"));

            // Call the method and assert it throws an exception
            RuntimeException thrown = assertThrows(RuntimeException.class, () -> {
                restaurantInterface.getMenuByRestaurantId(1);
            });

            assertEquals("Error retrieving menu", thrown.getMessage());
        }
    }
}
