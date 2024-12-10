package org.example.model;


import java.time.LocalDateTime;

public record AuditLog(
        int auditLogId,
        int userId,
        String action,
        String tableName,
        ActionType actionType, // enum for INSERT, UPDATE, DELETE
        LocalDateTime createdAt
) {
    enum ActionType {
        INSERT, UPDATE, DELETE
    }
}
