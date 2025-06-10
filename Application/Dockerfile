# Use OpenJDK as the base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the Java source file
COPY HelloWorld.java .

# Compile the Java program
RUN javac HelloWorld.java

# Command to run the program
CMD ["java", "HelloWorld"] 