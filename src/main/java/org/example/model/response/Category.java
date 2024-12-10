package org.example.model.response;

import java.util.List;

public record Category(String name, List<MenuItem> items) {
}
