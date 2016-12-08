# Dockerized Eureka Server

Run this project as a Spring Boot app (e.g. import into IDE and run
main method, or use gradle bootRun or ./gradlew bootRun"). It will start up on port
8761 and serve the Eureka API from "/eureka".

## Resources

| Path             | Description  |
|------------------|--------------|
| /                        | Home page (HTML UI) listing service registrations          |
| /eureka/apps         | Raw registration metadata |

## Docker Container

There is a Dockerfile to generate the docker image.
