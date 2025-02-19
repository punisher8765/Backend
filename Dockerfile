# Use the official OpenJDK 17 image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the target directory to the container
COPY target/*.jar app.jar

# Expose the application port (Render assigns it dynamically)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
