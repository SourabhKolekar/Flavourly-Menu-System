package org.example.model.response;

import java.util.List;

public record MenuResponse(String RestaurantName, List<Menu> menu) {}

