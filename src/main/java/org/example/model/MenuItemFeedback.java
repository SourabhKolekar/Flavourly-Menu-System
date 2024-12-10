package org.example.model;

import java.time.LocalDateTime;

public record MenuItemFeedback(
        int feedbackId,
        int menuItemId,
        int userId,
        int rating, // Must be between 1 and 5
        String comments,
        LocalDateTime feedbackDate
) {}
