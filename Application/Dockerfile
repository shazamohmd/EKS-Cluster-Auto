
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY HelloWorld.java .
RUN javac HelloWorld.java
EXPOSE 3000
CMD ["java", "HelloWorld"] 