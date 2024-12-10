package org.example.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;


public class JsonWriter {
    /**
     * Writes a Java object as a pretty-printed JSON to a file.
     *
     * @param data     The object to be written.
     * @param filePath The name of the file to write to.
     * @throws IOException If an error occurs while writing to the file.
     */
    public static void writePrettyJsonToFile(Object data, String filePath) throws IOException {
        // Create an ObjectMapper instance for JSON serialization
        ObjectMapper objectMapper = new ObjectMapper();

        // Ensure the file path is correct
        File file = new File(filePath);

        // Create a pretty writer with default pretty printer
        ObjectWriter writer = objectMapper.writerWithDefaultPrettyPrinter();

        // Create the file and ensure output stream is available
        try (FileOutputStream fileOutputStream = new FileOutputStream(filePath)) {
            // Write the object to the file
            writer.writeValue(fileOutputStream, data);

            // Flush the stream to ensure it's written immediately
            fileOutputStream.flush();

            // Confirm file has been written
            System.out.println("File has been written successfully: " + file.getAbsolutePath());
        } catch (IOException e) {
            System.out.println("Error occurred while writing the file: " + e.getMessage());
            e.printStackTrace();
        }

    }
}
