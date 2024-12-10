package unit;

import org.example.model.response.MenuResponse;
import org.example.utils.MenuBuilder;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class MenuBuilderTest {

    @Test
    void testBuildMenuResponse() throws SQLException {
        ResultSet resultSet = mock(ResultSet.class);

        // Mock result set behavior
        when(resultSet.next()).thenReturn(true).thenReturn(false);
        when(resultSet.getString("restaurant_name")).thenReturn("Test Restaurant");
        when(resultSet.getString("menu_name")).thenReturn("Test Menu");
        when(resultSet.getString("category_name")).thenReturn("Test Category");
        when(resultSet.getString("item_name")).thenReturn("Test Item");
        when(resultSet.getBigDecimal("item_price")).thenReturn(BigDecimal.valueOf(10.0));

        // Run the method and verify the result
        MenuResponse result = MenuBuilder.buildMenuResponse(resultSet);

        assertNotNull(result);
        assertEquals("Test Restaurant", result.RestaurantName());
        assertEquals(1, result.menu().size());
    }
}
