package unit;

import org.example.dao.RestaurantInterface;
import org.example.model.response.MenuResponse;
import org.example.model.response.RestaurantResponse;
import org.example.service.RestaurantService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class RestaurantServiceTest {

    private RestaurantInterface restaurantInterface;
    private RestaurantService restaurantService;

    @BeforeEach
    void setUp() {
        restaurantInterface = mock(RestaurantInterface.class);
        restaurantService = new RestaurantService(restaurantInterface);
    }

    @Test
    void testGetMenuWhenRestaurantIsActive() {
        int restaurantId = 1;

        // Mock the restaurant as active
        RestaurantResponse restaurantResponse = new RestaurantResponse("Test Restaurant");
        when(restaurantInterface.findRestaurantById(restaurantId)).thenReturn(Optional.of(restaurantResponse));

        // Mock the menu retrieval
        MenuResponse menuResponse = new MenuResponse("Test Restaurant", null);
        when(restaurantInterface.getMenuByRestaurantId(restaurantId)).thenReturn(Optional.of(menuResponse));

        // Execute and verify
        MenuResponse result = restaurantService.getMenu(restaurantId);
        assertNotNull(result);
        assertEquals("Test Restaurant", result.RestaurantName());
    }

    @Test
    void testGetMenuWhenRestaurantIsNotActive() {
        int restaurantId = 1;

        // Mock the restaurant as not active
        when(restaurantInterface.findRestaurantById(restaurantId)).thenReturn(Optional.empty());

        // Execute and verify
        RuntimeException exception = assertThrows(RuntimeException.class, () -> restaurantService.getMenu(restaurantId));
        assertEquals("No active restaurant found for the given id " + restaurantId, exception.getMessage());
    }
}
