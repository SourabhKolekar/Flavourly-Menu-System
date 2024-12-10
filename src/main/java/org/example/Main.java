package org.example;

import org.example.dao.RestaurantInterfaceImpl;
import org.example.dao.RestaurantInterface;
import org.example.model.response.MenuResponse;
import org.example.service.RestaurantService;
import org.example.utils.JsonWriter;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        RestaurantInterface restaurantInterface = new RestaurantInterfaceImpl();

        RestaurantService restaurantService = new RestaurantService(restaurantInterface);

        Scanner scanner = new Scanner(System.in);
        int userChoice;

        while (true) {
            System.out.println("Welcome to the Flavourly Menu System!");
            System.out.println("Please enter the id of the restaurant you would like to get menu:");
            System.out.println("1. Bella Italia");
            System.out.println("2. Taco Fiesta");
            System.out.println("3. Curry Delight");
            System.out.println("4. Exit");

            // Get the user's input choice
            userChoice = scanner.nextInt();
            switch (userChoice) {
                case 1, 2, 3 -> {
                    generateRestaurantMenu(restaurantService, userChoice);
                }
                case 4 -> {
                    System.out.println("Exiting the application...");
                    scanner.close();
                    return; // Exits the program gracefully
                }
                default -> System.out.println("Invalid user choice. Try again.");
            }
        }
    }

    /**
     * This method is responsible for fetching the menu of a specific restaurant and saving it to a JSON file.
     *
     * @param restaurantService The service that handles the restaurant data.
     * @param restaurantId      The ID of the restaurant to fetch the menu for.
     */
    private static void generateRestaurantMenu(RestaurantService restaurantService, int restaurantId) {
        try {
            // Fetch the menu of the specified restaurant
            MenuResponse restaurantMenu = restaurantService.getMenu(restaurantId);

            // Writing to a file
            JsonWriter.writePrettyJsonToFile(restaurantMenu, "restaurantMenu_id_" + restaurantId + ".json");

            System.out.println("Restaurant menu generated successfully and Saved in restaurantMenu_id_" + restaurantId + ".json file!");


        } catch (Exception exception) {
            // Handle exceptions and print stack trace for debugging
            System.out.println("Error occurred while generating menu: " + exception);
        }
    }
}