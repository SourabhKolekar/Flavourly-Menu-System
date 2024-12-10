package org.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.dao.RestaurantInterface;
import org.example.dao.RestaurantInterfaceImpl;
import org.example.model.response.MenuResponse;
import org.example.service.RestaurantService;

import java.util.HashMap;
import java.util.Map;

public class RestaurantMenuHandler implements RequestHandler<Map<String, Integer>, Map<String, Object>> {

    private final RestaurantService restaurantService;
    private final ObjectMapper objectMapper;

    public RestaurantMenuHandler() {
        RestaurantInterface restaurantInterface = new RestaurantInterfaceImpl();
        this.restaurantService = new RestaurantService(restaurantInterface);
        this.objectMapper = new ObjectMapper();
    }

    @Override
    public Map<String, Object> handleRequest(Map<String, Integer> event, Context context) {
        Map<String, Object> response = new HashMap<>();
        try {
            // Extract and validate restaurantId
            Integer restaurantId = event.get("restaurantId");
            if (restaurantId == null || restaurantId <= 0) {
                context.getLogger().log("Invalid restaurant ID provided: " + restaurantId);
                response.put("statusCode", 400);
                response.put("body", "Invalid restaurant ID.");
                return response;
            }

            // Fetch menu
            MenuResponse menuResponse = restaurantService.getMenu(restaurantId);

            // Serialize response to JSON
            String responseBody = objectMapper.writeValueAsString(menuResponse);

            // Return success response
            response.put("statusCode", 200);
            response.put("body", responseBody);
        } catch (Exception exception) {
            context.getLogger().log("Error fetching menu: " + exception.getMessage());

            // Return error response
            response.put("statusCode", 500);
            response.put("body", "Unable to fetch the menu. Please try again later.");
        }
        return response;
    }
}
