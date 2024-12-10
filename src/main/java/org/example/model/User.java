package org.example.model;

import java.time.LocalDateTime;

public record User(
        int userId,
        String username,
        String email,
        String passwordHash,
        UserRole role,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    enum UserRole {
        Admin, User
    }
}
