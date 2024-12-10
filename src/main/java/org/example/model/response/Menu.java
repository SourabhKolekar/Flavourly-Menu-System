package org.example.model.response;

import java.util.List;

public record Menu(String name, List<Category> categories) {
}
