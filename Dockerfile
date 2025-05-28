# Use a Maven base image for building the project
FROM maven:latest AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY . /app

# Run Maven commands to clean, package, and build the application
RUN mvn clean package -Pb2b

# Use a lightweight JDK image for running the application
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.war Subscription_Serives_Automation-0.0.1-SNAPSHOT.war

# Expose the application port
EXPOSE 8081

# Set the default command to run the Spring Boot application
CMD ["java", "-jar", "Subscription_Serives_Automation-0.0.1-SNAPSHOT.war"]

