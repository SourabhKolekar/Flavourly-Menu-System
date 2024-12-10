package org.example.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

public record RestaurantHours(
        int restaurantHoursId,
        int restaurantId,
        DayOfWeek dayOfWeek,
        LocalTime opensAt,
        LocalTime closesAt,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    enum DayOfWeek {
        SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY
    }
}
