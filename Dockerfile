# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw mvnw.cmd pom.xml ./
COPY .mvn .mvn

# Give execute permission to Maven wrapper
RUN chmod +x mvnw

# Download dependencies (improves build speed on future runs)
RUN ./mvnw dependency:go-offline

# Copy the project source code
COPY src src

# Build the application
RUN ./mvnw package -DskipTests

# Second stage - runtime container
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
