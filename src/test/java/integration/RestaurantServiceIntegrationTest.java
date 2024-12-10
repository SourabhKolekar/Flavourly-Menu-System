package integration;

import org.example.dao.RestaurantInterfaceImpl;
import org.example.dao.RestaurantInterface;
import org.example.model.response.MenuResponse;
import org.example.service.RestaurantService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class RestaurantServiceIntegrationTest {

    private RestaurantService restaurantService;

    @BeforeEach
    void setUp() {
        RestaurantInterface restaurantInterface = new RestaurantInterfaceImpl();
        restaurantService = new RestaurantService(restaurantInterface);
    }

    @Test
    void testGetMenuIntegration() {
        int restaurantId = 1; // Use an actual restaurant ID from the test database

        MenuResponse result = restaurantService.getMenu(restaurantId);

        assertNotNull(result);
        assertFalse(result.menu().isEmpty());
    }
}
